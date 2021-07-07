## Stored programs

Stored programs include: stored procedures, stored functions, events and triggers.

### Stored procedures

You can see your stored procedures for the database in workbench if you expand the database and they will be listed under 'Stored Procedures'.

#### demo - create, use and delete stored procedure

1. First we will setup the database and creating simple table, use the code below.

```sql
CREATE DATABASE food;
USE food;
CREATE TABLE fruit (
    name VARCHAR(20)
);
INSERT INTO fruit (name) VALUES ('apple'), ('orange'), ('plum');
```

2. Now we will create our procedure.

```sql
-- change the default ';' delimiter to '//'
DELIMITER //
CREATE PROCEDURE GetFruits()
BEGIN
	SELECT * FROM fruit;
END //
-- set again delimiter to be ';'
DELIMITER ;
```

3. And here is example how we can call/use our procedure.

```sql
CALL GetFruits();
```

4. And here is example how we delete our procedures if we don't need them anymore.

```sql
DROP PROCEDURE GetFruits;
```

#### demo - create procedure with parameters

1. Setup the database and table.

```sql
CREATE DATABASE food;
USE food;
CREATE TABLE fruit (
    name VARCHAR(20)
);
INSERT INTO fruit (name) VALUES ('apple'), ('orange'), ('plum');
```

2. Now we will create our procedure.

```sql
-- change the default ';' delimiter to '//'
DELIMITER //
CREATE PROCEDURE InsertFruit(FruitName VARCHAR(20))
BEGIN
	INSERT INTO fruit(name) VALUES (FruitName);
END //
-- set again delimiter to be ';'
DELIMITER ;
```

3. Call the procedure and get the final table.

```sql
CALL InsertFruit('strawberry');
CALL InsertFruit('cherry');

SELECT * FROM fruit;
```
