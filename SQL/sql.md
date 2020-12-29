# About SQL

sql is the database itself and the language to use the database. Mysql, Postresql and some others are so called DBMS database management systems which make using the database easier.

# SQL Datatypes

To review the datatypes click [here](https://www.w3schools.com/sql/sql_datatypes.asp).

---

# Working with Databases and Tables

1. Will show all the databases we have:

```sql
show databases;
```

2. Will create a new database:

```sql
CREATE DATABASE some_name;
```

3. Will delete the specified database:

```sql
DROP DATABASE some_name;
```

4. In a sql server we can have more than one databases and to work with a specific one we can start using it by running the following command:

```sql
USE some_name;
```

and we can check which database we are currently using with the following command:

```sql
SELECT database();
```

In Workbench the currently used table will be also with bold text.

5. Creating table:

We specify the name of the columns and the data type of the respective column. This is a very simple example, not very close to real scenario.

```sql
CREATE TABLE people
    (
        name VARCHAR(25),
        age INT
    );
```

if we want some value to be always required we can do the following:

```sql
CREATE TABLE people
    (
        name VARCHAR(25) NOT NULL,
        age INT NOT NULL
    );
```

and in case if value is still not provided we can set to be default value

```sql
CREATE TABLE people
    (
        name VARCHAR(25) DEFAULT 'nameless',
        age INT DEFAULT 18
    );
```

6. Will show all the tables existing for the selected database:

```sql
SHOW TABLES;
```

7. Will show detailed information about the columns of a specific table

```sql
SHOW COLUMNS FROM people;
```

or similar to above:

```sql
DESC people;
```

8. Will delete specific table from the selected database:

```sql
DROP TABLE people;
```

9. In same cases we might get warnings, for example if we provide too long text. In Workbench we can easily see them, but we can also use a command to display them:

```sql
SHOW warnings;
```

---

# Primary key

Primary key is a column of unique values to make all rows unique.
In the primary key we provide as argument which column we want to be the primary key.
If we have Auto increment added, we don't need to provide an id every time we add new row to the table.

```sql
CREATE TABLE students (
    student_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    grade INT,
    PRIMARY KEY (student_id)
);
```

---

# Working with files

Instead typing everything in terminal or something we can store our source code in a file. In that file for example we can create a table and add records to it. We can use files the following way:

```sql
source my_file.sql;
```

---

# Working with tables data

1. Will insert 2 rows of data in the specific table, the order of parameters must match

```sql
INSERT INTO students(name, grade)
VALUES ("Ina", 5), ("Ani", 8);
```

2. Get all data from a table, all the columns

```sql
SELECT * FROM students;
```

3. Get only specific columns

```sql
SELECT name, grade FROM students;
```

4. Filtering only specific data we want:

```sql
SELECT * FROM students WHERE grade = 3;
```

5. Using aliases for column names:

aliases will not affect the actual data, but with them we can display columns with changed names in case we want that

```sql
SELECT student_id AS id FROM students;
```

6. Update data:

```sql
UPDATE students SET grade = 3 WHERE status = 'completed';
```

7. Delete data:

```sql
DELETE FROM students WHERE grade < 3;
```

---

# String functions

When getting data we will often want to transform it in some way. For example concatenate the content of two columns. And for that we can use string functions.
You can find more about it [here](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html).

For more complex operations we can nest different functions.

Here is example of CONCAT:

```sql
SELECT CONCAT(first_name, ' ', last_name) AS 'full name'
FROM students;
```

and example of SUBSTRING, which will return the last 3 symbols for each row in the table:

```sql
SELECT SUBSTRING(title, -3) FROM books;
```

we can also nest the different functions:

```sql
SELECT CONCAT(SUBSTRING(title, 1, 5), '...') AS 'short title' FROM books;
```

---

# Refining data

1. Getting only unique values from a column or multiple columns.

When getting data from more than one column the records we get will be unique for the columns together not just individually for a column. Meaning that equal last names will be still obtained if the first name is unique.

```sql
SELECT DISTINCT first_name, last_name FROM students;
```

2. Sort data.

The default sort order is ascending for numbers and strings. If we sort by more than one column the columns are sorted one after another in the order we specified, for example first by grade and equal grades by name.

```sql
SELECT name, grade FROM students ORDER BY name;
SELECT name, grade FROM students ORDER BY grade DESC;
SELECT name, grade FROM students ORDER BY grade, name;
```

In the below example 2 means by grade, because that is the second column we specified.

```sql
SELECT name, grade FROM students ORDER BY 2;
```

3. Get only specific number of rows of data.

With 2 parameters we can get only at specific range. For example starting at 10th and getting only 5 rows.

```sql
SELECT * FROM students ORDER BY grade DESC LIMIT 5;
SELECT * FROM students ORDER BY grade DESC LIMIT 10, 5;
```

4. Search for something.

LIKE will search for matches in the specified column. It is case insensitive. The percent sign means it might there is something before or after what we search for. If we skip the first percent sign it means must not have anything before what we search for, the same applies for also the second percent sign.

```sql
SELECT title FROM movies WHERE title LIKE '%super%';
SELECT title FROM movies WHERE title NOT LIKE '%super%';
```

In case % sign is what we want to search for, we have to use '\' to escape it.

# Aggregate functions

These functions allow us to manipulate the data in different ways. You can read more about them [here](https://dev.mysql.com/doc/refman/8.0/en/functions.html).

1. Count function will check for count of something we need.

```sql
SELECT COUNT(DISTINCT first_name) FROM students;
```

2. Group by function can group data based on some condition.

This function is usually not used on its own, because behind the scenes it creates groups of rows, but if display it we will see only the first row of each group. In the below example COUNT will count for each group.
So basically GROUP BY will create multiple tables based on the different grades and the SELECT will operate for each individual table.

```sql
SELECT grades, COUNT(*) AS count FROM students GROUP BY grades;
```

3. Minimum value.

```sql
SELECT MIN(grade) FROM students;
```

If we are selecting multiple columns we might want to do subselection, because the columns after select are independant and the min value is not necessary to be the same student. Without subqueries we would get the min value, but the student name would be the first in the table and with subquery we assure all columns will be for the same row.
This is just an example, of course in terms of performance it would be better to use order by and get the first result, because using select twice is bad for performance.

```sql
SELECT name, grade FROM students WHERE grade = (SELECT MIN(grade) FROM students)
```

---

# Working with date and time

Check this documentations for more [info](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html).

---

# Logical operators

Check this documentations for more [info](https://dev.mysql.com/doc/refman/8.0/en/logical-operators.html).

If working with date and time it is recommended to cast them.

1. Logical AND and OR

```sql
SELECT name, grades FROM students WHERE name = 'Ema' AND grades >= 5;
```

```sql
SELECT name, grades FROM students WHERE name = 'Ema' OR grades != 5;
```

2. IN and NOT IN operator

```sql
SELECT name, grades FROM students WHERE name IN ('Ema', 'Toni', 'Miro');
```

3. Switch case

here we will get 3 columns: name, grades and result. Result for each row will have value depending on the grade for each row.

```sql
SELECT name, grades,
    CASE
        WHEN grades >= 5 THEN 'Excellent'
        WHEN grades >= 4 THEN 'Good'
        WHEN grades BETWEEN 2.5 AND 4 THEN 'Bad'
        ELSE 'Study more'
    END AS result
FROM students;
```
