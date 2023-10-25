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

##### Between value or in array of values

- This is how we can filter results.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT name, city FROM people
WHERE monthly_income BETWEEN 5000 AND 7000 AND city IN ('Sofia', 'Varna');
```

| name | city  |
| ---- | ----- |
| Mira | Sofia |

---

##### Update value

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

##### Update value conditionally

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

##### Delete row/rows

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

### Joining tables

##### Inner Join

- Inner join will return result which are match in both tables.

**_users_**

| id<sup>PK</sup> | name   |
| --------------- | ------ |
| 1               | Mira   |
| 2               | Sofia  |
| 3               | Ivan   |
| 4               | Metodi |
| 5               | Marina |

**_images_**

| id<sup>PK</sup> | url         | user_id<sup>FK</sup> |
| --------------- | ----------- | -------------------- |
| 1               | image-1.png | 1                    |
| 2               | image-2.png | 1                    |
| 3               | image-3.png | 2                    |
| 4               | image-4.png | 2                    |
| 5               | image-5.png | 3                    |

```sql
SELECT u.id AS uid, name, i.id AS iid, url, user_id
FROM users AS u INNER JOIN images AS i ON u.id = i.user_id;
```

| uid | name  | iid | url         | user_id |
| --- | ----- | --- | ----------- | ------- |
| 1   | Mira  | 1   | image-1.png | 1       |
| 1   | Mira  | 2   | image-2.png | 1       |
| 2   | Sofia | 3   | image-3.png | 2       |
| 2   | Sofia | 4   | image-4.png | 2       |
| 3   | Ivan  | 5   | image-5.png | 3       |

---

##### Left Join

- Left join will get all the records from the table on the left.

**_users_**

| id<sup>PK</sup> | name   |
| --------------- | ------ |
| 1               | Mira   |
| 2               | Sofia  |
| 3               | Ivan   |
| 4               | Metodi |
| 5               | Marina |

**_images_**

| id<sup>PK</sup> | url         | user_id<sup>FK</sup> |
| --------------- | ----------- | -------------------- |
| 1               | image-1.png | 1                    |
| 2               | image-2.png | 1                    |
| 3               | image-3.png | 2                    |
| 4               | image-4.png | 2                    |
| 5               | image-5.png | 3                    |

```sql
SELECT u.id AS uid, name, i.id AS iid, url, user_id
FROM users AS u LEFT JOIN images AS i ON u.id = i.user_id;
```

| uid | name   | iid  | url         | user_id |
| --- | ------ | ---- | ----------- | ------- |
| 1   | Mira   | 1    | image-1.png | 1       |
| 1   | Mira   | 2    | image-2.png | 1       |
| 2   | Sofia  | 3    | image-3.png | 2       |
| 2   | Sofia  | 4    | image-4.png | 2       |
| 3   | Ivan   | 5    | image-5.png | 3       |
| 4   | Metodi | null | null        | null    |
| 5   | Marina | null | null        | null    |

---

##### Join with condition

- Display only users who commented on their own pics.

**_users_**

| id<sup>PK</sup> | name   |
| --------------- | ------ |
| 1               | Mira   |
| 2               | Sofia  |
| 3               | Ivan   |
| 4               | Metodi |
| 5               | Marina |

**_images_**

| id<sup>PK</sup> | url         | user_id<sup>FK</sup> |
| --------------- | ----------- | -------------------- |
| 1               | image-1.png | 1                    |
| 2               | image-2.png | 1                    |
| 3               | image-3.png | 2                    |
| 4               | image-4.png | 2                    |
| 5               | image-5.png | 3                    |

**_comments_**

| id<sup>PK</sup> | body            | user_id<sup>FK</sup> | image_id<sup>FK</sup> |
| --------------- | --------------- | -------------------- | --------------------- |
| 1               | Pic of me       | 1                    | 3                     |
| 2               | My best picture | 2                    | 5                     |
| 3               | Nature picture  | 3                    | 2                     |

```sql
SELECT body, url, i.user_id AS img_user_id, c.user_id AS com_user_id, c.image_id AS com_img_id
FROM comments AS c INNER JOIN images AS i ON c.image_id = i.id
WHERE c.user_id = i.user_id;
```

| body      | url         | img_user_id | com_user_id | com_img_id |
| --------- | ----------- | ----------- | ----------- | ---------- |
| Pic of me | image-3.png | 2           | 2           | 3          |

---

##### Join on generated table

- Except directly selecting a table we can also use generated by union two tables

**_users_**

| id<sup>PK</sup> | name |
| --------------- | ---- |
| 1               | Eli  |
| 2               | Mira |
| 3               | Iva  |

**_charities_**

| id<sup>PK</sup> | amount | user_id<sup>FK</sup> |
| --------------- | ------ | -------------------- |
| 1               | 150    | 1                    |
| 2               | 235    | 1                    |
| 3               | 118    | 2                    |
| 4               | 211    | 3                    |
| 5               | 98     | 3                    |

**_spendings_**

| id<sup>PK</sup> | amount | user_id<sup>FK</sup> |
| --------------- | ------ | -------------------- |
| 1               | 250    | 1                    |
| 2               | 118    | 2                    |
| 3               | 57     | 2                    |
| 4               | 305    | 2                    |
| 5               | 24     | 3                    |

```sql
SELECT name, activities.amount FROM users
INNER JOIN (
  SELECT user_id, amount FROM charities
  UNION ALL
  SELECT user_id, amount FROM spendings
) AS activities ON activities.user_id = users.id;
```

or alternative syntax using common table expression

```sql
WITH activities AS (
  SELECT user_id, amount FROM charities
  UNION ALL
  SELECT user_id, amount FROM spendings
)
SELECT name, activities.amount FROM users
INNER JOIN activities AS activities ON activities.user_id = users.id;
```

| name | amount |
| ---- | ------ |
| Eli  | 150    |
| Eli  | 235    |
| Mira | 118    |
| Iva  | 211    |
| Iva  | 98     |
| Eli  | 250    |
| Mira | 118    |
| Mira | 57     |
| Mira | 305    |
| Iva  | 24     |

---

##### Grouping data

- Group by is creating multiple subtables based on what we group by and executing aggregate functions on those subtables.
- After the select we can only have columns which appear after group by or aggreagte functions

| name   | city    | income |
| ------ | ------- | ------ |
| Mira   | Sofia   | 5200   |
| Mitko  | Sofia   | 4000   |
| Iva    | Plovdiv | 3800   |
| Toni   | Plovdiv | 5000   |
| Polina | Varna   | 4500   |

```sql
SELECT city, avg(income) AS average_income FROM people
GROUP BY city;
```

| city    | average_income |
| ------- | -------------- |
| Sofia   | 4600.00000     |
| Varna   | 4500.00000     |
| Plovdiv | 4400.00000     |

---

##### Grouping data with having

- WHERE will filter first some of the rows, then GROU BY will create subgroups and HAVING will filter the subgroups.
- Based on the above text, WHERE is filtering based on individual rows and HAVING on whole groups.

| name     | city    | income |
| -------- | ------- | ------ |
| Angelina | Sofia   | 5000   |
| Valeria  | Sofia   | 5200   |
| Evgeni   | Plovdiv | 4250   |
| Traqn    | Plovdiv | 4900   |
| Eli      | Varna   | 4990   |

```sql
SELECT city, avg(income) AS average_income FROM people
WHERE income <= 5000
GROUP BY city
HAVING COUNT(*) > 1;
```

| city    | average_income |
| ------- | -------------- |
| Plovdiv | 4575.00000     |

---

##### Sorting data

- We will first sort by city ascending, then equal cities will be sorted by price descending and last by name.
- Ascending is by default so no need to specify it.

| name     | city    | income |
| -------- | ------- | ------ |
| Angelina | Sofia   | 5000   |
| Valeria  | Sofia   | 5200   |
| Evgeni   | Plovdiv | 4250   |
| Traqn    | Plovdiv | 4900   |
| Eli      | Varna   | 4990   |
| Eli      | Sofia   | 5100   |
| Mira     | Plovdiv | 4900   |

```sql
SELECT * FROM people
ORDER BY city, income DESC, name;
```

| name     | city    | income |
| -------- | ------- | ------ |
| Mira     | Plovdiv | 4900   |
| Traqn    | Plovdiv | 4900   |
| Evgeni   | Plovdiv | 4250   |
| Valeria  | Sofia   | 5200   |
| Eli      | Sofia   | 5100   |
| Angelina | Sofia   | 5000   |
| Eli      | Varna   | 4900   |

---

##### Skip and limit results

- Useful for example for pagination.

| name     | city    | income |
| -------- | ------- | ------ |
| Angelina | Sofia   | 5000   |
| Valeria  | Sofia   | 5200   |
| Evgeni   | Plovdiv | 4250   |
| Traqn    | Plovdiv | 4900   |
| Eli      | Varna   | 4990   |

```sql
SELECT * FROM people ORDER BY income LIMIT 2 OFFSET 2;
```

| name     | city  | income |
| -------- | ----- | ------ |
| Eli      | Varna | 4990   |
| Angelina | Sofia | 5000   |

---

##### Union results

- Useful for combining the result of different queries.
- Both queries must produce similar column structure.
- Without union all, just union we would get 3 results, because duplicates are ignored.
- If we use INTERSECT instead of UNION we would get only common results for both queries.
- If we use EXCEPT instead of UNION we would get the results from the first query except the results returned from the second query. Basically everything present in the first query except the second.

| name     | income | taxes  |
| -------- | ------ | ------ |
| Angelina | 5000   | 350.50 |
| Valeria  | 5200   | 220    |
| Evgeni   | 4250   | 160    |
| Traqn    | 4900   | 190    |
| Eli      | 4990   | 90     |

```sql
(SELECT * FROM people ORDER BY income DESC LIMIT 2)
UNION ALL
(SELECT * FROM people ORDER BY income - taxes DESC LIMIT 2);
```

| name     | income | taxes  |
| -------- | ------ | ------ |
| Valeria  | 5200   | 220    |
| Angelina | 5000   | 350.50 |
| Valeria  | 5200   | 220    |
| Eli      | 4990   | 90     |

---

##### Sub queries

- With sub queries we can use the result of one query in another.
- Very important note here is to understand the returned type of the subquery. It is not table with one or many columns and rows. It is scalar type, single value which we can reuse. Basically, because the result is one column and one row.

| name     | income |
| -------- | ------ |
| Angelina | 5000   |
| Valeria  | 5200   |
| Evgeni   | 4250   |

```sql
SELECT * FROM people WHERE income > (
  SELECT income FROM people WHERE name = 'Angelina'
);
```

| name    | income |
| ------- | ------ |
| Valeria | 5200   |

---

##### Sub queries in the select clause

- For our custom column we will have value calculated with the scalar result returned by the subquery.

| name     | income |
| -------- | ------ |
| Angelina | 5000   |
| Valeria  | 5200   |
| Evgeni   | 4250   |

```sql
SELECT name, income, income / (SELECT max(income) FROM people) AS ratio
FROM people ORDER BY income DESC;
```

| name     | income | ratio                  |
| -------- | ------ | ---------------------- |
| Valeria  | 5200   | 1.00000000000000000000 |
| Angelina | 5000   | 0.96153846153846153846 |
| Evgeni   | 4250   | 0.81730769230769230769 |

---

##### Sub queries in the from clause

- We are required to use alias AS c even if we don't use it.
- Outside the subquery, we can only use columns from the subquery.

| name | city    | income |
| ---- | ------- | ------ |
| Mira | Sofia   | 4500   |
| Iva  | Plovdiv | 5100   |
| Tina | Plovdiv | 4750   |
| Ivan | Sofia   | 5500   |
| Deni | Sofia   | 4900   |

```sql
SELECT avg(c.cities_count)
FROM (
  SELECT city, COUNT(*) AS cities_count FROM people GROUP BY city
) AS c;
```

| avg                |
| ------------------ |
| 2.5000000000000000 |

---

##### Sub queries with join

- We will get users who purchased rice

**_users_**

| id<sup>PK</sup> | name  |
| --------------- | ----- |
| 1               | Mira  |
| 2               | Iva   |
| 3               | Tanq  |
| 4               | Misho |

**_products_**

| id<sup>PK</sup> | product_name |
| --------------- | ------------ |
| 1               | Sugar        |
| 2               | Rice         |
| 3               | Milk         |

**_purchases_**

| id<sup>PK</sup> | user_id<sup>FK</sup> | product_id<sup>FK</sup> |
| --------------- | -------------------- | ----------------------- |
| 1               | 1                    | 1                       |
| 2               | 1                    | 3                       |
| 3               | 2                    | 2                       |
| 4               | 3                    | 1                       |
| 5               | 3                    | 2                       |

```sql
SELECT name FROM users
INNER JOIN (
  SELECT user_id FROM purchases WHERE product_id = 2
) AS p ON p.user_id = users.id;
```

| name |
| ---- |
| Iva  |
| Tanq |

---

##### Sub queries in where clause

- Inner select will return 1 column only so we can use it as array of values.

**_users_**

| id<sup>PK</sup> | name  | income | taxes |
| --------------- | ----- | ------ | ----- |
| 1               | Mira  | 5200   | 700   |
| 2               | Iva   | 5100   | 900   |
| 3               | Tanq  | 5500   | 1100  |
| 4               | Misho | 4900   | 900   |

**_purchases_**

| id<sup>PK</sup> | user_id<sup>FK</sup> | product_id<sup>FK</sup> |
| --------------- | -------------------- | ----------------------- |
| 1               | 1                    | 1                       |
| 2               | 1                    | 3                       |
| 3               | 2                    | 2                       |
| 4               | 3                    | 1                       |
| 5               | 3                    | 2                       |

```sql
SELECT id FROM purchases WHERE user_id IN (
  SELECT id FROM users WHERE income - taxes > 4300
);
```

| id  |
| --- |
| 1   |
| 2   |
| 4   |
| 5   |

---

##### Another subquery example

- With ALL we will select onlyy users which have income higher than anyone from Plovdiv.
- With similar syntax with using SOME we can also achieve filtering behaviour.

| name  | city    | income |
| ----- | ------- | ------ |
| Mira  | Sofia   | 5200   |
| Iva   | Plovdiv | 5100   |
| Tanq  | Sofia   | 5500   |
| Misho | Sofia   | 4900   |
| Zaro  | Plovdiv | 5000   |

```sql
SELECT * FROM users WHERE income > ALL (
  SELECT income FROM users WHERE city = 'Plovdiv'
);
```

| name | city  | income |
| ---- | ----- | ------ |
| Mira | Sofia | 5200   |
| Tanq | Sofia | 5500   |

---

##### Select unique values

- We will count all unique values, without count we would get once Sofia and once Plovdiv.

| name | city    |
| ---- | ------- |
| Mira | Sofia   |
| Iva  | Plovdiv |
| Tanq | Sofia   |

```sql
SELECT COUNT(DISTINCT city) FROM users;
```

| count |
| ----- |
| 2     |

---

##### Switch case

- With Case we can get conditional value.

| name  | city    | income |
| ----- | ------- | ------ |
| Mira  | Sofia   | 5200   |
| Iva   | Plovdiv | 5100   |
| Tanq  | Sofia   | 5500   |
| Misho | Sofia   | 4900   |
| Zaro  | Plovdiv | 5000   |

```sql
SELECT name,
  CASE
    WHEN income < 5000 THEN 'low'
    WHEN income < 5500 THEN 'average'
    ELSE 'high'
  END AS formatted_income
FROM users;
```

| name  | formatted_income |
| ----- | ---------------- |
| Mira  | average          |
| Iva   | average          |
| Tanq  | high             |
| Misho | low              |
| Zaro  | average          |

---

##### Insights

- With the following query we can get info of how our query was processed.
- For example we can see the execution time of our query.

| id  | name |
| --- | ---- |
| 1   | Eli  |
| 2   | Mira |
| 3   | Toni |

```sql
EXPLAIN SELECT * FROM users WHERE name = 'Eli';
```

| QUERY PLAN                                                              |
| ----------------------------------------------------------------------- |
| Bitmap Heap Scan on users (cost=4.18..12.64 rows=4 width=62)            |
| Recheck Cond: ((name)::text = 'Eli'::text)                              |
| -> Bitmap Index Scan on users_name_idx (cost=0.00..4.18 rows=4 width=0) |
| Index Cond: ((name)::text = 'Eli'::text)                                |

```sql
EXPLAIN ANALYZE SELECT * FROM users WHERE name = 'Eli';
```

| QUERY PLAN                                                                                                        |
| ----------------------------------------------------------------------------------------------------------------- |
| Bitmap Heap Scan on users (cost=4.18..12.64 rows=4 width=62) (actual time=0.016..0.016 rows=1 loops=1)            |
| Recheck Cond: ((name)::text = 'Eli'::text)                                                                        |
| Heap Blocks: exact=1                                                                                              |
| -> Bitmap Index Scan on users_name_idx (cost=0.00..4.18 rows=4 width=0) (actual time=0.012..0.012 rows=1 loops=1) |
| Index Cond: ((name)::text = 'Eli'::text)                                                                          |
| Planning Time: 0.049 ms                                                                                           |
| Execution Time: 0.031 ms                                                                                          |

---

##### Transaction

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

---
