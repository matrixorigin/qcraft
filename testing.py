import pytest
import psycopg2
import json

db_name = str(input("What is the name of the database?: "))
db_pswd = str(input("What is your db password?: "))
db_port = int(input("What is the port number? (5432 by default): "))
DB_PARAMETERS : dict = {"dbname" : db_name, "user" : "postgres", "password" : db_pswd, "host" : "localhost", "port" : db_port}

queries : list[dict] = [{"name" : "Name Here", "SQL" : "SELECT * FROM organization WHERE continent = 'Asia';", 
                          "Expected Output" : "Organization 1"}]

@pytest.fixture(scope='module')
def db_connection():
    conn = psycopg2.connect(**DB_PARAMETERS)
    yield conn
    conn.close()

@pytest.mark.parametrize("query", queries)
def test_sql_query(db_connection, query):
    with db_connection.cursor() as cursor:
        cursor.execute(query['sql'])
        result = cursor.fetchall()

        with open(query['expected_output'], 'r') as file:
            expected_output = json.load(file)

        # Convert result to a comparable format (list of dicts)
        colnames = [desc[0] for desc in cursor.description]
        result_dicts = [dict(zip(colnames, row)) for row in result]

        assert result_dicts == expected_output, f"Query {query['name']} failed"

if __name__ == "__main__":
    pytest.main()