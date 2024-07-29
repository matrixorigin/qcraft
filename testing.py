# Parse CSV Files into JSON format
import csv, json, requests, mysql.connector, pandas as pd
from flask import Flask, request, jsonify

app = Flask(__name__)
# Prompts to be fed into the SQL Coder
prompts = []
# Gold Queries that the SQL Coder return should match
queries = []

def parse_tests(path: str, print_results: bool, prompts: list, queries: list):
    tests_as_json = []
    with open(path, mode='r', encoding='utf-8') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        for row in csv_reader:
            tests_as_json.append(row)
        for test in tests_as_json:
            prompts.append(test.get('question'))
            queries.append(test.get('query'))
      if print_results:
            for i in range(len(queries)-1,-1, -1):
                  print ('Prompt: \n', prompts[i], '\n Query: \n', queries[i])

def send_queries_to_sqlcoder(prompts: list[str]) -> list[str]:
    print("SENDING TO SQL CODER")
    generated_queries = []
    for prompt in prompts:
        payload = {
            "api_key": None,
            "previous_context": [],
            "question": prompt
        }
        response = requests.post('http://localhost:1235/query', json=payload)
        print("Going through responses")
        if response.status_code == 200:
            if response.json().get('ran_successfully'):
                  print("Response went through")
                  generated_queries.append(response.json().get('query_generated'))
        else:
            print(response.text, response.status_code, response, prompt)
            continue
    return generated_queries

@app.route('/send_query', methods=['POST'])
def send_to_sqlcoder_route():
    data = request.json
    prompts = data['prompts']
    generated_queries = send_queries_to_sqlcoder(prompts)
    return jsonify(generated_queries)

if __name__ == '__main__':
    parse_tests('sql-eval/data/questions_gen_snowflake.csv', True, prompts, queries)
    results = send_queries_to_sqlcoder(prompts)
    print(results)
    app.run(port=1234, debug=False)


