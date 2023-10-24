##### Create new database user

- This query will create new user with which we can access the database.
- When we create an user by default it has no privilegies. We can grant or revoke them additionally.
- In pgAdmin you can see the user under Login/Group Roles which is next to Databases.

```sql
CREATE USER my_new_user WITH PASSWORD '12345' VALID UNTIL 'Jul 1, 2024';
```

---

##### Get database users

```sql
SELECT usename AS username FROM pg_user;
```

| usename     | usesysid | usecreatedb | usesuper | userepl | usebypassrls | passwd           | valuntil               | useconfig |
| ----------- | -------- | ----------- | -------- | ------- | ------------ | ---------------- | ---------------------- | --------- |
| postgres    | 10       | true        | true     | true    | true         | \*\*\*\*\*\*\*\* |                        |           |
| my_new_user | 16389    | false       | false    | false   | false        | \*\*\*\*\*\*\*\* | 2024-07-01 00:00:00+00 |           |

---

##### Grant privilegies to an user

- This query will grant privilegies to an user to interact with the database.

```sql
GRANT SELECT, UPDATE, INSERT, DELETE ON my_table_name TO my_new_user;
```

---

##### Create table

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

##### Create table with foreign key

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

##### Create table with multi column null check

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

##### Delete table

- This query will delete specific table.

```sql
DROP TABLE people;
```

---

##### Create index

- Index is useful for search optimizations, especially, when operating on the entire tables
- But there is also downsides. It increase the size of the disk space we need. And is slowing operations like insert, update and delete.
- The convention for naming indexes is first that table name, column name, idx
- In pgAdmin you can see the indexes for a given table after you expand the table and then Indexes

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20)
);

CREATE INDEX users_name_idx ON users(name);
```

| id<sup>PK</sup> | name |
| --------------- | ---- |

---

##### Modify column of existing table

- We can modify the columns settings of already exisiting tables.
- Similarly we can add Unique or Check constraints.

```sql
ALTER TABLE people ALTER COLUMN name SET NOT NULL;
```

| id<sup>PK</sup> | name |
| --------------- | ---- |

---

##### Insert data into a table

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

##### Read data

- This way we will read all the table's data.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200.50          |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT * FROM people;
```

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200.50          |
| Iva  | Plovdiv | 7200           | 1900             |

---

##### Read partial data

- This way we will read only specific columns.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200.50          |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT name, city FROM people;
```

| name | city    |
| ---- | ------- |
| Mira | Sofia   |
| Iva  | Plovdiv |

---

##### Read and transform data

- We can use math operators with different columns values.
- With AS we can get meaningful column names.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT name, monthly_income - travel_spendings AS net, travel_spendings / monthly_income * 100 AS perc
FROM people;
```

| name | net     | perc                    |
| ---- | ------- | ----------------------- |
| Mira | 3599.50 | 37.93965517241379310300 |
| Iva  | 5300    | 26.38888888888888888900 |

---

##### Sum values

- Sum is aggregate function which will combine all rows in a sum.

| name  | income |
| ----- | ------ |
| Mira  | 3500   |
| Iva   | 3700   |
| Mitko | 3900   |

```sql
SELECT sum(income) AS total FROM people;
```

| total |
| ----- |
| 11100 |

---

##### Use functions

- We can use functions to transform the output.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT CONCAT (name, ' lives in ', UPPER(city), '.') AS sentence FROM people;
```

| sentence              |
| --------------------- |
| Mira lives in SOFIA.  |
| Iva lives in PLOVDIV. |

---

##### Filter results

- This is how we can filter results.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT name, city FROM people WHERE monthly_income >= 7000 AND city = 'Plovdiv';
```

| name | city    |
| ---- | ------- |
| Iva  | Plovdiv |

---
