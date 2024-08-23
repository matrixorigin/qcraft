import re


def convert_postgres_to_mysql(sql_file):
    with open(sql_file, 'r') as file:
        sql_content = file.read()
    conversions = {
        r'\bSERIAL\b': 'INT AUTO_INCREMENT',
        r'\bBYTEA\b': 'BLOB',
        r'\bBOOLEAN\b': 'TINYINT(1)',
        r'\bTEXT\b': 'TEXT',
        r'\bTIMESTAMP\b': 'DATETIME',
        r'\bVARCHAR\((\d+)\)\b': r'VARCHAR(\1)',
        r'\bINT\b': 'INT',
        r'\bINTEGER\b': 'INT',
        r'\bBIGINT\b': 'BIGINT',
        r'\bSMALLINT\b': 'SMALLINT',
        r'\bNUMERIC\((\d+),\s*(\d+)\)\b': r'DECIMAL(\1, \2)'
    }
    for pg_type, mysql_type in conversions.items():
        sql_content = re.sub(pg_type, mysql_type, sql_content, flags=re.IGNORECASE)
    sql_content = sql_content.replace('"', '`')
    sql_content = re.sub(r'\|\|', 'CONCAT', sql_content)
    sql_content = re.sub(r'\bDEFAULT\s+NOW\(\)', 'DEFAULT CURRENT_TIMESTAMP', sql_content, flags=re.IGNORECASE)
    sql_content = re.sub(r'CREATE\s+SEQUENCE\s+[^;]+;', '', sql_content, flags=re.IGNORECASE)
    sql_content = re.sub(r'ALTER\s+SEQUENCE\s+[^;]+;', '', sql_content, flags=re.IGNORECASE)
    sql_content = re.sub(r'::\w+', '', sql_content)
    mysql_file = sql_file.replace('.sql', '_mysql.sql')
    with open(mysql_file, 'w') as file:
        file.write(sql_content)

    print(f"Converted file saved as {mysql_file}")

"""
USAGE: Put the path for the postgres file you want to convert to mysql in file_to_convert
Will create a new file with "my_sql" in the name
"""
file_to_covert : str = "databases/atis.sql"
convert_postgres_to_mysql(file_to_covert)
