# Stored programs

Stored programs include: stored procedures, functions, events and triggers.

## Stored procedures

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

```sql
DROP PROCEDURE IF EXISTS GetFruits;
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

## Functions

You can see your functions for the database in workbench if you expand the database and they will be listed under 'Functions'.

#### demo - create, use and delete stored procedure

1. First we will setup the database and creating simple table, use the code below.

```sql
CREATE DATABASE food;
USE food;
CREATE TABLE fruit (id INT NOT NULL AUTO_INCREMENT, name VARCHAR(20), PRIMARY KEY (id));
INSERT INTO fruit (id, name) VALUES (1, 'Apple'), (2, 'Orange'), (3, 'Plum'), (4, 'Avocado');
```

2. Now we will create our function.

```sql
DELIMITER //
CREATE FUNCTION GetFavoriteFruit(fruit_id INT)
RETURNS VARCHAR(20)
BEGIN
	DECLARE FruitName VARCHAR(20);

    SELECT name INTO FruitName FROM fruit WHERE id = fruit_id;

    RETURN(FruitName);
END//
DELIMITER ;
```

3. And here is example how we can call/use our function.

```sql
-- Apple
SELECT GetFavoriteFruit(1);
-- Orange
SELECT GetFavoriteFruit(2);
```

4. And here is example how we delete our function if we don't need them anymore.

```sql
DROP FUNCTION GetFavoriteFruit;
```

## Events

Events are executed according to event scheduler.

## Triggers

Triggers are executed automatically, when DML operation like insert, update or delete is executed.

#### demo - create trigger, when inserting data

1. Setup the database and table.

```sql
CREATE DATABASE food;
USE food;
CREATE TABLE fruit (
    name VARCHAR(20)
);
INSERT INTO fruit (name) VALUES ('Apple'), ('Orange'), ('Plum');
```

2. Now we will create our trigger. What this trigger does is to change the first letter to be capital and rest of the letters to be lower case.

```sql
-- change the default ';' delimiter to '//'
DELIMITER //
CREATE TRIGGER Correct_Before_Insert
BEFORE INSERT ON fruit
FOR EACH ROW
BEGIN
	SET NEW.name = concat(upper(substring(NEW.name, 1, 1)), lower(substring(NEW.name FROM 2)));
END //
-- set again delimiter to be ';'
DELIMITER ;
```

3. Now after we insert some incorrect case data we expect to be corrected.

```sql
INSERT INTO fruit(name) VALUES ('cheRRy'), ('mANgO');

SELECT * FROM fruit;
```
