# Parse CSV Files into JSON format
import csv, json, subprocess, argparse, requests, mysql.connector, psycopg2, pandas as pd
from flask import Flask, request, jsonify

app = Flask(__name__)

"""
Parses a .csv file into individual tests containing tests, prompts, and databases as a list of dictionaries
"""
def parse_tests(path: str, print_results: bool, filter_for = None) -> dict:
    tests_as_json = []
    with open(path, mode='r', encoding='utf-8') as csv_file:
      csv_reader = csv.DictReader(csv_file)
      for row in csv_reader:
            tests_as_json.append(row)
      results = []
      for test in tests_as_json:
            result : dict = {'Prompt' : test.get('question'), 
                              'Query' : test.get('query'),
                              'Database' : test.get('db_name'),
                              'Instructions' : ''}
            # Add specific instructions if there are any
            if test.get('instructions'):
                  results['Instructions' : test.get('instructions')]
            results.append(result)
      if print_results:
            prev_db = ""
            for result in results:
                  if prev_db != result.get('Database'):
                        prev_db = result.get('Database')
                        print("------------------ \n", prev_db, "\n------------------")
                  print('Prompt: \n', result['Prompt'], '\n Query: \n', result['Query'])
      return results
    
"""
Given a set of tests, send each prompt to the link for SQL Coder
"""
def send_queries_to_sqlcoder(tests: list[str], database_type : str) -> list[str]:
      generated_queries : list = []
      current_db : str = ""
      for test in tests:
            if not isinstance(test, dict):
                  raise ValueError("All tests must be dictionaries, instead got: ", test)
            if test.get('Database') != current_db:
                  schema : str = set_db(test.get('Database'))
            payload = {
                  "instructions" : "- if the question cannot be answered given the database schema, return \"I do not know\"\n- recall that the current date in YYYY-MM-DD format is 2024-08-01",
                  "quesiton" : test.get('Prompt'),
                  "schema" : schema,
                  "token" : ""
            }
            response = requests.post('http://defog.ai/sqlcoder-demo', json=payload)
            if response.status_code == 200 and response.json().get('ran_successfully'):
                  if not "not know" in response.json().get('query_generated'):
                        print("\n Sending Prompt : ", test['Prompt'])
                        print("Response went through :", response.json().get('query_generated'))
                        generated_queries.append(response.json().get('query_generated'))
                  else:
                        print("Query Failed, SQL Coder does not know")
            else:
                  print("Query Failed:", response.text, response.status_code, response)
                  generated_queries.append(None)
                  continue
      return generated_queries

def set_db(database : str) -> None:
      print("SETTING DATABASE TO : ", database)
      with open('/defog-data/defog_data/' + database + '/' + database + '.sql', 'r') as file:
            sql_str : str = file.read()
      return sql_str
"""
NOTE: db_parameters = {'dbname': 'your_database',
            'user': 'your_username',
            'password': 'your_password',
            'host': 'your_host',
            'port': 'your_port'}
"""
def test_queries(tests : list[dict[str, str, str]], generated_queries : list, db_type : str, db_parameters : dict) -> dict:
      # Each test has the format : {"Prompt" : str, "Query" : str, "Database" : str}
      print("Testing Queries")
      results = {"Perfect" : 0, "Good" : 0, "Bad" : 0}
      current_db = ""
      conn = None
      try:
            for i in range(len(tests)):
                  if not isinstance(tests[i], dict):
                        raise ValueError("All tests must be dictionaries, instead got: ", tests[i])
                  if tests[i].get('Database') != current_db:
                        print ("Switching Database from ", current_db, "to", tests[i].get('Database'))
                        if conn:
                              conn.close()
                        try:
                              db_parameters['dbname'] = tests[i].get('Database')
                              if db_type.lower() == "postgres":
                                    conn = psycopg2.connect(**db_parameters)
                              elif db_type.lower() == "mysql":
                                    conn = mysql.connector.connect(**db_parameters)
                              else:
                                    raise ValueError("Database type is not supported (try postgre or mysql)")
                        except Exception as error:
                              print("Error connecting to database : ", error)
                  try:
                        generated_sql = pd.read_sql_query(generated_queries[i], conn)
                        gold_sql = pd.read_sql_query(tests[i].get("Query"), conn)
                        if not generated_sql or not isinstance(generated_sql, str):
                              results['Bad'] += 1
                        elif generated_sql == gold_sql:
                              results['Perfect'] += 1
                        elif set(generated_sql.columns) == set(gold_sql.columns) and generated_sql.shape[0] <= gold_sql.shape[0] and all(generated_sql.isin(gold_sql.all())):
                              results['Good'] += 1
                        else:
                              results['Bad'] += 1
                  except Exception as error:
                        results['Bad'] += 1
                        print("Error: ", error)
      finally:
            if conn:
                  conn.close()
      print(results)
      return results

if __name__ == '__main__':
    tests = parse_tests('sql-eval/data/questions_gen_postgres.csv', True, None)
    generated_queries = send_queries_to_sqlcoder(reversed(tests), 'postgres')
    database_parameters = {
      'dbname': tests[0].get('Database'),
      'user': 'postgres',
      'password': 'postgres',
      'host': 'localhost',
      'port': '5432'
    }
    results = test_queries(tests, generated_queries, 'postgres', database_parameters)
    app.run(port=1234)


