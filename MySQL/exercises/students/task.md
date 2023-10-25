From the following 2 tables:

**students**

| id  | first_name |
| --- | ---------- |
| 1   | Caleb      |
| 2   | Samantha   |
| 3   | Raj        |
| 4   | Carlos     |
| 5   | Lisa       |

**papers**

| title                                 | grade | student_id |
| ------------------------------------- | ----- | ---------- |
| My First Book Report                  | 60    | 1          |
| My Second Book Report                 | 75    | 1          |
| Russian Lit Through The Ages          | 94    | 2          |
| De Montaigne and The Art of The Essay | 98    | 2          |
| Borges and Magical Realism            | 89    | 4          |

produce the following results:

| first_name | average | passing_status |
| ---------- | ------- | -------------- |
| Samantha   | 96.0000 | PASSING        |
| Carlos     | 89.0000 | PASSING        |
| Caleb      | 67.5000 | FAILING        |
| Raj        | 0.0000  | FAILING        |
| Lisa       | 0.0000  | FAILING        |

_Use the setup.sql file to create the table._
