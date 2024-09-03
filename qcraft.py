import mysql.connector, subprocess
from prompt_toolkit import prompt

instructions : str = """
### Instructions: Your task is to convert a question into a one-line SQL query, given a MYSQL database schema. Adhere to these rules:
- **Deliberately go through the question and database schema word by word** to appropriately answer the question
- **Use Table Aliases** to prevent ambiguity. For example, `SELECT table1.col1, table2.col1 FROM table1 JOIN table2 ON table1.id = table2.id`.
- When creating a ratio, give it as a float and not an integer
- Break down questions individual steps/columns
- Never create more than 2 columns to answer a question
- Always join and label the columns being returned
- Do not use any of the following functions: quarter, weekofyear, time_format, dayname, time_format'
Use the following examples of different ways to solve questions as reference:
Example Schema-
CREATE TABLE author (
    aid BIGINT NOT NULL,
    homepage TEXT,
    name TEXT, 
    oid BIGINT
);


CREATE TABLE cite (
    cited BIGINT,
    citing BIGINT
);


CREATE TABLE conference (
    cid BIGINT NOT NULL,
    homepage TEXT,
    name TEXT
);


CREATE TABLE domain (
    did BIGINT NOT NULL,
    name TEXT
);

CREATE TABLE domain_author (
    aid BIGINT NOT NULL,
    did BIGINT NOT NULL
);


CREATE TABLE domain_conference (
    cid BIGINT NOT NULL,
    did BIGINT NOT NULL
);


CREATE TABLE domain_journal (
    did BIGINT NOT NULL,
    jid BIGINT NOT NULL
);


CREATE TABLE domain_keyword (
    did BIGINT NOT NULL,
    kid BIGINT NOT NULL
);


CREATE TABLE domain_publication (
    did BIGINT NOT NULL,
    pid BIGINT NOT NULL
);



CREATE TABLE journal (
    homepage TEXT,
    jid BIGINT NOT NULL,
    name TEXT
);


CREATE TABLE keyword (
    keyword TEXT,
    kid BIGINT NOT NULL
);


CREATE TABLE organization (
    continent TEXT,
    homepage TEXT,
    name TEXT,
    oid BIGINT NOT NULL
);


CREATE TABLE publication (
    abstract TEXT,
    cid BIGINT,
    citation_num BIGINT,
    jid BIGINT,
    pid BIGINT NOT NULL,
    reference_num BIGINT,
    title TEXT,
    year BIGINT
);


CREATE TABLE publication_keyword (
    pid BIGINT NOT NULL,
    kid BIGINT NOT NULL
);



CREATE TABLE writes (
    aid BIGINT NOT NULL,
    pid BIGINT NOT NULL
);
Example Questions-
Example #1, A group-by question: What is the total number of citations received by each author?, break it into the following steps:
Step 1: Identify the publications written by each author SELECT aid, pid  FROM writes;
Step 2: Determine the number of citations received by each publication- SELECT pid, citation_num  FROM publication;
Step 3: Combine the author and citation data- SELECT w.aid, p.citation_num  FROM writes w JOIN publication p ON w.pid = p.pid;
Step 4: Sum the total number of citations for each author- SELECT aid, SUM(citation_num) AS total_citations FROM (
SELECT w.aid, p.citation_num  FROM writes w JOIN publication p ON w.pid = p.pid
) AS author_citations GROUP BY aid; GROUP BY aid;
Step 5: Join with the author table to display names - SELECT a.name, ac.total_citations FROM (SELECT aid, SUM(citation_num) AS total_citations 
FROM (SELECT w.aid, p.citation_num FROM writes w JOIN publication p ON w.pid = p.pid) AS author_citations GROUP BY aid) AS ac
JOIN author a ON ac.aid = a.aid;
Example #2, An order-by question: What is the average number of references cited by publications in each domain name?
Step 1: Identify the publications associated with each domain- SELECT did, pid  FROM domain_publication;
Step 2: Calculate the number of references cited by each publication- SELECT pid, reference_num  FROM publication;
Step 3: Combine the domain and reference data- SELECT dp.did, p.reference_num  FROM domain_publication dp JOIN publication p ON dp.pid = p.pid;
Step 4: Calculate the average number of references cited by publications for each domain- SELECT did, AVG(reference_num) AS avg_references
FROM (SELECT dp.did, p.reference_num  FROM domain_publication dp JOIN publication p ON dp.pid = p.pid) AS domain_references
GROUP BY did;
Example #3, a ratio question: Which author had the most publications in the year 2021 and how many publications did he/she have that year?
Step 1: Identify the publications made in the year 2021- SELECT pid  FROM publication WHERE year = 2021;
Step 2: Identify the authors of these publications- SELECT w.aid, w.pid FROM writes w JOIN publication p ON w.pid = p.pid WHERE p.year = 2021;
Step 3: Count the number of publications for each author- SELECT aid, COUNT(pid) AS publication_count FROM (SELECT w.aid, w.pid FROM writes w
JOIN publication p ON w.pid = p.pid WHERE p.year = 2021) AS author_publications GROUP BY aid;
Step 4: Find the author with the most publications- SELECT aid, publication_count FROM (SELECT aid, COUNT(pid) AS publication_count
FROM (SELECT w.aid, w.pid FROM writes w JOIN publication p ON w.pid = p.pid WHERE p.year = 2021) AS author_publications GROUP BY aid
) AS publication_counts ORDER BY publication_count DESC LIMIT 1;
Example #4, a table join question: Which author had the most publications in the year 2021 and how many publications did he/she have that year?
Step 1: Identify publications made in 2021- SELECT pid FROM publication WHERE year = 2021;
Step 2: Identify the authors of these publications- SELECT w.aid, w.pid FROM writes w JOIN publication p ON w.pid = p.pid
WHERE p.year = 2021;
Step 3: Count the number of publications for each author- SELECT aid, COUNT(pid) AS publication_count FROM (
SELECT w.aid, w.pid FROM writes w JOIN publication p ON w.pid = p.pid WHERE p.year = 2021
) AS author_publications GROUP BY aid;
Step 4: Find the author with the most publications- SELECT aid, publication_count FROM (SELECT aid, COUNT(pid) AS publication_count
FROM (SELECT w.aid, w.pid FROM writes w JOIN publication p ON w.pid = p.pid WHERE p.year = 2021) AS author_publications GROUP BY aid
) AS publication_counts ORDER BY publication_count DESC LIMIT 1;
With these examples in mind, given a MYSQL schema, create a query that answers the question, ONLY RETURN THE SQL QUERY and this query should be enclosed in "<" and ">"\n
"""
def craft_query(question: str, schema : str) -> str:
    prompt = instructions + "###Schema: \n" + schema + "\n ###Quesition to answer: \n" + question
    result = subprocess.run(['ollama', 'run', 'llama3.1'], input=prompt, stdout=subprocess.PIPE, text=True)
    output = result.stdout
    query = None
    start = output.find('<')
    end = output.find('>', start)
    if start != -1 and end != -1:
        query = output[start+1:end].strip()
    else:
        raise ValueError("Llama generated no query or the query was not wrapped in '<>'")
    return query

def send_query(host, port, user, password, database, query) -> str:
    try:
        result = subprocess.run(["mysql",
            "-Nr", 
            "-h", host,
            "-P", port,
            "-u" + user,
            "-p" + password,
            "-D", database], input = query, stdout=subprocess.PIPE, text=True)
        if result.returncode or result.stderr:
            return None
        else:
            return result.stdout.strip()
    except Exception as e:
        print(f'Error : {e}')
        return None

def main():
    print("Make sure you have llama3.1 installed, and your sql server is running")
    print("The program will need details about the database and its schema to work")
    host = prompt("Enter the host of your SQL database: ")
    port = prompt("Enter the port of your SQL database: ")
    user = prompt("Enter your MYSQL username: ")
    password = prompt("Enter your MYSQL password: ", is_password=True)
    database = prompt("What database are you using?: ")
    schema = prompt("Paste the schema of your datbase: ")
    while 1:
        question = prompt("What is your quesiton about the database? ")
        query = craft_query(question, schema)
        print("Your Query: ")
        print(query)
        if query[-1] != ";":
            query += ";"
        print("Sending Query to SQL Database")
        result = send_query(host, port, user, password, database, query)
        if isinstance(result, str):
            result = subprocess.run(['ollama', 'run', 'llama3.1'], input= "I got an error: " + result,
                stdout=subprocess.PIPE, text=True)
            if isinstance(result, str):
                print("Error: ", result)
            else:
                print(result)
        else:
            print(result)
            
if __name__ == "__main__":
    main()
