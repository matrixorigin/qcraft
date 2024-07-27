# Parse CSV Files into JSON format
import csv, json, mysql.connector
from flask import Flask, request, jsonify
import requests

app = Flask(__name__)
# Prompts to be fed into the SQL Coder
prompts = []
# Gold Queries that the SQL Coder return should match
queries = []

def parse_tests(path : str, print_results : bool, prompts : list, queries : list):
    tests_as_json = []
    with open(path, mode ='r', encoding='utf-8') as csv_file:
      csv_reader = csv.DictReader(csv_file)
      for row in csv_reader:
            tests_as_json.append(row)
      for test in tests_as_json:
            prompts.append(test.get('question'))
            queries.append(test.get('query'))
      if print_results:
            for i in range(len(queries)):
                  print ('Prompt: \n', prompts[i], '\n Query: \n', queries[i])

@app.route('/send_query', methods=['POST'])
def send_to_sqlcoder(prompts : list[str]) -> list[str]:
      print ("SENDING TO SQL CODER")
      generated_queries = []
      for prompt in prompts:
            payload = {
            "api_key": None,
            "previous_context": [],
            "question": prompt
            }
            response = requests.post('http://localhost:1235/query', json=payload)
            print ("Going through responses")
            if response.status_code == 200:
                  print ("Response went through")
                  generated_queries.append(response.json())
            else:
                  raise TimeoutError("Error : ", response.text, prompt)
      return generated_queries

def test_accuracy(prompts : list[str], queries : list[str]) -> dict:
      results = {"Perfect" : 0, "Good" : 0, "Bad" : 0}
      for i in range(len(prompts)):
            if "error" in queries[i].lower() or not queries[i]:
                results["Bad"] += 1
      return



tests : list[list] = parse_tests('sql-eval\data\questions_gen_snowflake.csv', True, prompts, queries)




