import csv

first_cmd = ["ollama", "run", "sqlcoder"]
instructions: str = """### Instructions: Your task is to convert a question into a one-line SQL query, given a MYSQL database schema. Adhere to these rules:
- **Deliberately go through the question and database schema word by word** to appropriately answer the question
- **Use Table Aliases** to prevent ambiguity. For example, `SELECT table1.col1, table2.col1 FROM table1 JOIN table2 ON table1.id = table2.id`.
- When creating a ratio, always cast the numerator as float"""

def get_queries(input_path: str, output_path: str):
    output = open(output_path, 'w')
    with open(input_path, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        counter: int = 0
        for row in csv_reader:
            counter += 1
            output.write("Gold Query #" + str(counter) + "\n")
            output.write(row.get("query") + "\n")
    output.close()

def get_questions(input_path: str, output_path: str):
    output = open(output_path, 'w')
    with open(input_path, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        counter: int = 0
        for row in csv_reader:
            counter += 1
            output.write("Question #" + str(counter) + "\n")
            output.write(row.get("question") + "\n")
    output.close()

def create_testing_file(input_path : str, output_path : str):
    output = open(output_path, 'w')
    with open(input_path, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        counter = 0
        for row in csv_reader:
            counter += 1
            output.write("Test #" + str(counter) + "\n")
            output.write("Database : " + row.get("db_name") + "\n")
            output.write("-" * 15 + "\n")
            output.write('"""' + "\n")
            test : str= ""
            if row.get("instructions"):
                test += instructions + row.get("instructions")
            else:
                test += instructions
            test += "\n"
            test += "### Input: " + get_schema(row.get("db_name"))
            test += "\n"
            test += f'### Response : Based on your instructions, here is the SQL query I have generated to answer the question `{row.get("question")}`:'
            test += "\n"
            output.write(test + "\n")
            output.write('"""')
            output.write("\n\n")
    output.close()

# Given the name of a database, return that database's .sql file as a string
def get_schema(db_name: str) -> str:
    path: str = "../databases/" + db_name + "_mysql"+'.sql'
    sql_string : str = ''
    with open(path, encoding='utf-8', errors='ignore') as sql_file:
        for row in sql_file:
            if "INSERT" in row:
                break
            sql_string += row
    return sql_string

if __name__ == "__main__":
    create_testing_file("../testing-files/mysql_tests.csv", "../testing-files/tests.txt")