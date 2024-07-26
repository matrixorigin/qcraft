# Parse CSV Files into JSON format
import csv, json

def parse_tests(path : str, print_results : bool):
    tests_as_json = list()
    with open(path, mode ='r', encoding='utf-8') as csv_file:
      csv_reader = csv.DictReader(csv_file)
      for row in csv_reader:
            tests_as_json.append(row)
      # Prompts to be fed into the SQL Coder
      prompts = list()
      # Gold Queries that the SQL Coder return should match
      queries = list()
      for test in tests_as_json:
            prompts.append(test.get('k_shot_prompt'))
            queries.append(test.get('query'))
      if print_results:
            for i in range(len(queries)):
                  print ('Prompt: \n', prompts[i], 'Query: \n', queries[i])

def send_to_sqlcoder():
     return

parse_tests('sql-eval\data\questions_gen_snowflake.csv', True)




