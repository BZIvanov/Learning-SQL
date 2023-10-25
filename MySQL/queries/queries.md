##### Show all the databases we have

```sql
show databases;
```

---

##### Create database:

```sql
CREATE DATABASE some_name;
```

---

##### Delete specified database:

```sql
DROP DATABASE some_name;
```

---

##### Select a database to use

- In a sql server we can have more than one databases and to work with a specific one we can start using it by running the following command.

```sql
USE some_name;
```

- And we can check which database we are currently using with the following command.
- In Workbench the currently used table will be also with bold text.

```sql
SELECT database();
```

---

##### Create table

- We specify the name of the columns and the data type of the respective column. This is a very simple example, not very close to real scenario.

```sql
CREATE TABLE people
    (
        name VARCHAR(25),
        age INT
    );
```

- If we want some value to be always required we can do the following:

```sql
CREATE TABLE people
    (
        name VARCHAR(25) NOT NULL,
        age INT NOT NULL
    );
```

- And in case if value is still not provided we can set to be default value

```sql
CREATE TABLE people
    (
        name VARCHAR(25) DEFAULT 'nameless',
        age INT DEFAULT 18
    );
```

---

##### Show Tables

- Will show all the tables existing for the selected database.

```sql
SHOW TABLES;
```

---

##### Show columns info

- Will show detailed information about the columns of a specific table.

```sql
SHOW COLUMNS FROM people;
```

- Or similar to above:

```sql
DESC people;
```

---

##### Delete table

- Will delete specific table from the selected database.

```sql
DROP TABLE people;
```

---

##### Show warnings

- In same cases we might get warnings, for example if we provide too long text. In Workbench we can easily see them, but we can also use a command to display them.

```sql
SHOW warnings;
```

---

##### Working with files

- Instead typing everything in terminal or something we can store our source code in a file. In that file for example we can create a table and add records to it. We can use files the following way.

```sql
source my_file.sql;
```

---

##### Subselection

- If we are selecting multiple columns we might want to do subselection, because the columns after select are independant and the min value is not necessary to be the same student. Without subqueries we would get the min value, but the student name would be the first in the table and with subquery we assure all columns will be for the same row.
  This is just an example, of course in terms of performance it would be better to use order by and get the first result, because using select twice is bad for performance.

```sql
SELECT name, grade FROM students WHERE grade = (SELECT MIN(grade) FROM students)
```

---
