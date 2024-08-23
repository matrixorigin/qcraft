"""
This program is intended to access the accuracy of a generated query by comparing it its gold query
EXAMPLE TABLE:
+------------------+------+--------------------+
| name             | did  | average_references |
+------------------+------+--------------------+
| Sociology        |    4 |                  0 |
| Natural Sciences |    2 |                  1 |
| Data Science     |    1 |                  2 |
| Computer Science |    3 |                  3 |
| Machine Learning |    5 |                  4 |
+------------------+------+--------------------+
"""
example_table = [["Sociology", 4, 0], ["Natural Sciences", 2, 1], ["Data Sciences", 2, 1],
                ["Computer Science", 3, 3], ["Machine Learning", 5, 4]]
example_titles = ["name", "did", "average_references"]
def eval_accuracy(question : str, generated : list[list], gold : list[list], generated_titles: list[str],
                  gold_titles: list[str]) -> str:
    if "ordered" in question:
        if example_table == example_titles:
            return "Perfect"
        elif example_table in example_titles or example_titles in example_table:
            return "Good"
        else:
            return "Bad"
    else:
        if set(example_table) == set(example_titles):
            return "Perfect"
        elif example_table in example_titles or example_titles in example_table:
            return "Good"
        else:
            return "Bad"
