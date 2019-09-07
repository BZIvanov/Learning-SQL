## About SQL 

SQL is the database itself and the language to use the the database. MySQL, PostreSQL and some other are so called DBMS database management systems which make using the database easier.

### SQL Datatypes

To review the datatypes click [here](https://www.w3schools.com/sql/sql_datatypes.asp).

---

# Working with tables

1. Will show all the databases we have:
```SQL
show databases;
```

2. Will create a new database:
```SQL
CREATE DATABASE some_name;
```

3. Will delete the specified database:
```SQL
DROP DATABASE some_name;
```

4. In a SQL server we can have more than one databases and to work with a specific one we can start using it by running the following command:
```SQL
USE some_name;
```
and similarly we can chick which database we use the following use:
```SQL
SELECT database();
```

5. Creating table:
in here we specify the name of the columns and the data type of the respective column
```SQL
CREATE TABLE people
    (
        name VARCHAR(25),
        age INT
    );
```
if we want some value to be always required we can do the following:
```SQL
CREATE TABLE people
    (
        name VARCHAR(25) NOT NULL,
        age INT NOT NULL
    );
```
and in case if value is still not provided we can set to be default value
```SQL
CREATE TABLE people
    (
        name VARCHAR(25) DEFAULT 'nameless',
        age INT DEFAULT 18
    );
```

6. Will show all the tables:
```SQL
SHOW TABLES;
```

7. Will show detailed information about the columns of a specific table
```SQL
SHOW COLUMNS FROM people;
```
or similar to above:
```SQL
DESC people;
```

8. Will delete specific table:
```SQL
DROP TABLE people;
```

---

# Primary key

Primary key is a column of unique values to make all rows unique.
In the primary key we provide as argument which column we want to be the primary key.
If we have Auto increment added, we don't need to provide an id every time we add new row to the table.

```SQL
CREATE TABLE students (
    student_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    grade INT,
    PRIMARY KEY (student_id)
);
```

---

# Working with files
Instead typing everything in terminal or something we can store our source code in a file. In that file for example we can create a table and add records to it.
We can use files the following way:
```SQL
source my_file.sql;
```

---

# Working with tables data

1. Will insert 1 row of data in the specific table
the order of parameters must match
```SQL
INSERT INTO students(name, grade)
VALUES ("Ina", 5);
```

2. Get all data from a table, all the columns
```SQL
SELECT * FROM students;
```

3. Get only specific columns
```SQL
SELECT name, grade FROM students;
```

4. Filtering only specific  data we want:
```SQL
SELECT * FROM students WHERE grade=3;
```

5. Using aliases for column names:
aliases will not affect the actual data, but with them we can display columns with changed names in case we want that
```SQL
SELECT student_id AS id FROM students;
```
6. Update data:

```SQL
UPDATE students SET grade=3 WHERE status='completed';
```

7. Delete data:
```SQL
DELETE FROM students WHERE grade<3;
```

---

# String functions

When getting data we will often want to transform it in some way. For example concatenate the content of two columns. And for that we can use string functions.
You can find more about it [here](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html).

For more complex operations we can nest different functions.

Here is example of CONCAT:
```SQL
SELECT CONCAT(first_name, ' ', last_name) AS 'full name'
FROM students;
```

---

# Refining data

1. Getting only unique values from a column or multiple columns.

When getting data from more than one column the records we get will be unique for the columns together not just individually for a column. Meaning that equal last names will be still obtained if the first name is unique.
```SQL
SELECT DISTINCT first_name, last_name FROM students;
```

2. Sort data.
The default sort order is ascending for numbers and strings. If we sort by more than one column the columns are sorted one after another in the order we specified, for example first by grade and equal grades by name.

```SQL
SELECT name, grade FROM students ORDER BY name;
SELECT name, grade FROM students ORDER BY grade DESC;
SELECT name, grade FROM students ORDER BY grade, name;
```

3. Get only specific number of rows of data.
With 2 parameters we can get only at specific range. For example starting at 10th and getting only 5 rows.
```SQL
SELECT * FROM students ORDER BY grade DESC LIMIT 5;
SELECT * FROM students ORDER BY grade DESC LIMIT 10, 5;
```

4. Search for something.
LIKE will search for matches in the specified column. It is case insensitive. The percent sign means it might there is something before or after what we search for. If we skip the first percent sign it means must not have anything before what we search for, the same applies for also the second percent sign.

```SQL
SELECT title FROM movies WHERE title LIKE '%super%';
```
In case % sign is what we want to search for we have to use '\' to escape it.


# Aggregate functions

1. Count function will check for count of something we need.
```SQL
SELECT COUNT(first_name) FROM students;
```

