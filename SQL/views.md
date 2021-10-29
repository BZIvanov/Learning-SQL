## Views

View is a virtual table.

#### Basic usage

With the below queries we will setup the database and the tables

```sql
CREATE DATABASE food;
USE food;
CREATE TABLE fruit (name VARCHAR(20));
INSERT INTO fruit (name) VALUES ('Apple'), ('Orange'), ('Plum'), ('Avocado');
```

Now we will create our view. The views are stored in the database, with MySQL workbench you should see them next to the tables.

```sql
CREATE VIEW vw_MyFruits AS SELECT * FROM fruit WHERE name LIKE 'A%';
```

Now we will query data based on our view. In the second select you can see, that we can still narrow the results by applying conditions on the view.

```sql
SELECT * FROM vw_MyFruits;
SELECT * FROM vw_MyFruits WHERE name LIKE 'Av%';
```

Because the views are stored in our database if we want to delete them, this is the way

```sql
DROP VIEW vw_MyFruits;
```
