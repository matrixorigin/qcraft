# Parse CSV Files into JSON format
import csv, json, requests, mysql.connector, psycopg2, pandas as pd
from flask import Flask, request, jsonify

app = Flask(__name__)

"""
Parses a .csv file into individual tests containing tests, prompts, and databases as a list of dictionaries
Can also optionally print results or filter for a specific database
"""
def parse_tests(path: str, print_results: bool, filter_for = None) -> dict:
    if filter_for and not isinstance(filter_for, (str, list)):
         raise ValueError("For the parse_tests filter, please give a string, list of strings, or None")
    tests_as_json = []
    with open(path, mode='r', encoding='utf-8') as csv_file:
      csv_reader = csv.DictReader(csv_file)
      for row in csv_reader:
            tests_as_json.append(row)
      results = []
      for test in tests_as_json:
            if not filter_for or filter_for == test.get('db_name') or test.get('db_name') in filter_for:
                  results.append({'Prompt' : test.get('question'), 
                                  'Query' : test.get('query'),
                                  'Database' : test.get('db_name')})
      if print_results:
            for result in results:
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
           set_db(test.get('Database'), database_type)
           current_db = test.get('Database')
      payload = {
            "api_key": None,
            "previous_context": [],
            "question": test['Prompt']
      }
      response = requests.post('http://localhost:1235/query', json=payload)
      print("\n Sending Prompt : ", test['Prompt'])
      if response.status_code == 200 and response.json().get('ran_successfully'):
            print("Response went through :", response.json().get('query_generated'))
            generated_queries.append(response.json().get('query_generated'))
      else:
            print(response.text, response.status_code, response)
            generated_queries.append(None)
            continue
      print('\n')
    return generated_queries

def set_db(database : str, db_type : str) -> None:
      print("SETTING DATABASE TO : ", database)
      database_parameters = {
           "database" : database,
           "db_type" : db_type,
           "host" : "localhost",
           "password" : 'postgres',
           "port" : '5432',
           "user" : "postgres"
      }
      payload = {"db_creds" : database_parameters,
                 "db_type" : db_type}
      response = requests.post('http://localhost:1235/integration/generate_tables', json=payload)
      if response.status_code == 200:
           print("Database change was successful")
      else:
           print(response.text, response.status_code)
"""
NOTE: db_parameters = {    'dbname': 'your_database',
            'user': 'your_username',
            'password': 'your_password',
            'host': 'your_host',
            'port': 'your_port'}
"""
def test_queries(tests : list[dict[str, str, str]], generated_queries : list, db_type : str, db_parameters : dict) -> dict:
      # Each test has the format : {"Prompt" : str, "Query" : str, "Database" : str}
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
                                    conn = psycopg2.connector.connect(**db_parameters)
                              else:
                                    raise ValueError("Database type is not supported (try postgre or mysql)")
                        except Exception as error:
                              print("Error connecting to database : ", error)
                  try:
                        generated_sql = pd.read_sql_query(generated_queries[i])
                        gold_sql = pd.read_sql_query(tests[i].get("Query"))
                        if not generated_sql or not isinstance(generated_sql, str) or 'I do not know' in generated_sql:
                              results['Bad'] += 1
                        elif generated_sql == gold_sql:
                              results['Perfect'] += 1
                        elif set(generated_sql.columns) == set(gold_sql.columns) and generated_sql.shape[0] <= gold_sql.shape[0] and all(generated_sql.isin(gold_sql.all())):
                              results['Good'] += 1
                        else:
                              results['Bad'] += 1
                  except Exception as error:
                        results['Bad'] += 1
                        print("Error: ", error, "with queries", generated_sql, "and", gold_sql)
      finally:
            if conn:
                  conn.close()
      print(results)
      return results

if __name__ == '__main__':
    tests = parse_tests('sql-eval/data/questions_gen_snowflake.csv', True, None)
    tests.reverse()
    generated_queries = send_queries_to_sqlcoder(tests, 'postgres')
    database_parameters = {
      'dbname': tests[0].get('Database'),
      'user': 'postgres',
      'password': 'postgres',
      'host': 'localhost',
      'port': '5432'
    }
    results = test_queries(tests, generated_queries, 'postgre')
    app.run(port=1234)


