# Mutating data

Contains examples for how to mutate data.

Common keywords: `INSERT INTO`, `UPDATE`, `DELETE`, `RETURNING`, `BEGIN`, `COMMIT`, `ROLLBACK`

---

### Create new database user

- This query will create new user with which we can access the database.
- When we create an user by default it has no privilegies. We can grant or revoke them additionally.
- In pgAdmin you can see the user under Login/Group Roles which is next to Databases.

```sql
CREATE USER my_new_user WITH PASSWORD '12345' VALID UNTIL 'Jul 1, 2024';
```

---

### Create table

- This query will create new table called people in our database.
- Serial is similar to integer, but starting from positive value.
- With Default we can specify default value if it is not provided, when creating a record.
- With Check for we can add validation for required value before insert. As you can see below we can add check for specific column or between columns.

```sql
CREATE TABLE people (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  city VARCHAR(20) DEFAULT 'Sofia',
  monthly_income DECIMAL CHECK (monthly_income > 0),
  travel_spendings DECIMAL,
  CHECK (monthly_income > travel_spendings)
);
```

| id<sup>PK</sup> | name | city | monthly_income | travel_spendings |
| --------------- | ---- | ---- | -------------- | ---------------- |

---

### Create table with foreign key

- This query will create new table using foreign key.
- With cascade delete if in table people user with the same id as the foreign key is deleted, the record in this table will be also deleted.

```sql
CREATE TABLE pets (
  id SERIAL PRIMARY KEY,
  pet VARCHAR(20),
  person_id INTEGER REFERENCES people(id) ON DELETE CASCADE
);
```

| id<sup>PK</sup> | pet | person_id<sup>FK</sup> |
| --------------- | --- | ---------------------- |

---

### Create table with multi column null check

- Coalesce will return the first not null value, if all values are null it will return null
- So in this case we require at least email or phone to be provided.
- For the second check we will cast the id to boolean and then the boolean to integer, so we will end up with 0 or 1 for each coalesce.

```sql
CREATE TABLE contact (
  id SERIAL PRIMARY KEY,
  email VARCHAR(20),
  phone VARCHAR(20),
  contact_book_id INTEGER REFERENCES contact_book(id) ON DELETE CASCADE,
  private_book_id INTEGER REFERENCES private_book(id) ON DELETE CASCADE,
  CHECK (COALESCE(email, phone) IS NOT NULL),
  CHECK (
    COALESCE((contact_book_id)::BOOLEAN::INTEGER, 0)
    +
    COALESCE((private_book_id)::BOOLEAN::INTEGER, 0)
    = 1
  )
);
```

| id<sup>PK</sup> | email | phone | contact_book_id<sup>FK</sup> | private_book_id<sup>FK</sup> |
| --------------- | ----- | ----- | ---------------------------- | ---------------------------- |

---

### Delete table

- This query will delete specific table.

```sql
DROP TABLE people;
```

---

### Insert data into a table

- Note that values are in single quotes.
- Provided values order should match the expected values.
- Here we assume, that Primary key was set.

```sql
INSERT INTO people(name, city, monthly_income, travel_spendings)
VALUES ('Mira', 'Sofia', 5800, 2200.50), ('Iva', 'Plovdiv', 7200, 1900);
```

| id<sup>PK</sup> | name | city    | monthly_income | travel_spendings |
| --------------- | ---- | ------- | -------------- | ---------------- |
| 1               | Mira | Sofia   | 5800           | 2200.50          |
| 2               | Iva  | Plovdiv | 7200           | 1900             |

---

### Update value

- We can update all values or some, based on condition.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
UPDATE people SET monthly_income = 6900 WHERE name = 'Mira' OR city = 'Sofia';
```

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 6900           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

---

### Update value conditionally

- Advanced update

**_people_**

| id<sup>PK</sup> | name | salary |
| --------------- | ---- | ------ |
| 1               | Mira | 2200   |
| 2               | Iva  | 1900   |
| 3               | Ivan | 2100   |

**_holidays_**

| id<sup>PK</sup> | person_id<sup>FK</sup> | start_date | end_date   |
| --------------- | ---------------------- | ---------- | ---------- |
| 1               | 1                      | 2021-12-02 | 2021-12-12 |
| 2               | 2                      | 2021-07-15 | 2021-07-25 |
| 3               | 3                      | 2021-09-11 | 2021-09-21 |

```sql
UPDATE holidays SET start_date = CASE
  WHEN people.salary <= 2100 THEN start_date - 1
  WHEN people.salary > 2100 THEN start_date + 1
END
FROM people
WHERE people.id = holidays.person_id AND (people.salary <= 2100 OR people.salary > 2200);
```

| id<sup>PK</sup> | person_id<sup>FK</sup> | start_date | end_date   |
| --------------- | ---------------------- | ---------- | ---------- |
| 1               | 1                      | 2021-12-02 | 2021-12-12 |
| 2               | 2                      | 2021-07-14 | 2021-07-25 |
| 3               | 3                      | 2021-09-10 | 2021-09-21 |

---

### Delete row/rows

- We can delete all rows or some, based on condition.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
DELETE FROM people WHERE name = 'Mira';
```

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Iva  | Plovdiv | 7200           | 1900             |

---

### Transaction

- Transaction are usefull for operations requiring multiple queries depending on each other. If one of the queries for example fail we might want to cancel all the other queries.
- BEGIN will begin the transaction duplicating imaginary database on which we can run commands and the changes will be applied once we commit them.
- In pgAdmin if you open 2 query windows and running transaction on the first window, in the 2nd window you will see the changes applied once commited.
- Because the point of transactions is to remove the effect of the queries in case of error, we do that with the key word ROLLBACK. It will revert all the queries in the transaction(remove our imaginary database).
- In terms of syntax we can use either BEGIN or BEGIN TRANSACTION

| id  | name | amount |
| --- | ---- | ------ |
| 1   | Eli  | 200    |
| 2   | Iva  | 100    |

```sql
BEGIN;
UPDATE people SET amount = amount - 50 WHERE name = 'Eli';
UPDATE people SET amount = amount + 50 WHERE name = 'Iva';
COMMIT;
```

| id  | name | amount |
| --- | ---- | ------ |
| 1   | Eli  | 150    |
| 2   | Iva  | 150    |
