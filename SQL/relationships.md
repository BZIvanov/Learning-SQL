# Relationships

This guide explains the concept of relationships in relational databases using SQL. For DBMS-specific syntax (like PostgreSQL or MySQL), see the respective section.

---

## 🔑 Primary Key

A **primary key** is a column (or set of columns) that uniquely identifies each row in a table.

- Values must be **unique** and **not null**
- Automatically creates a **unique index**
- A table can have **one primary key**, which can consist of **multiple columns** (a **composite key**)

If the column is set to **auto-increment**, you don’t need to manually provide a value when inserting rows.

```sql
CREATE TABLE students (
    student_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    grade INT,
    PRIMARY KEY (student_id)
);
```

---

## Relationships types

### One-to-One

Each row in Table A relates to **one and only one** row in Table B.

Example: A `users` table and a `user_details` table where each user has one details record.

---

### One-to-Many

Each row in Table A can relate to **many rows** in Table B.

Example: A customer can have many orders.

In the Orders (many) table we will keep the id of the specific customer from the Customers (one) table.

**Customers**

| customer_id | name | email         |
| ----------- | ---- | ------------- |
| 1           | Ema  | ema@mail.com  |
| 2           | Ina  | ina@mail.com  |
| 3           | Toni | toni@mail.com |
| 4           | Tina | tina@mail.com |

**Orders**

| order_id | order_date | amount | customer_id |
| -------- | ---------- | ------ | ----------- |
| 1        | 2020-07-21 | 21.99  | 1           |
| 2        | 2020-08-11 | 12.00  | 1           |
| 3        | 2020-06-19 | 23.45  | 2           |
| 4        | 2020-11-09 | 9.50   | 3           |

Note: Column names don’t need to match across tables. You define the relationship using a **foreign key**.

---

### Many-to-Many

Rows in Table A can relate to **many rows** in Table B, and vice versa.

Example: Books can have multiple authors, and authors can write multiple books.

To model this, use a **junction table** (e.g., `book_authors`) with foreign keys to both related tables.

---

## 🔑 Foreign key

A foreign key is a column that links one table to another by referencing its primary key.

```sql
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);
```

This ensures that each order references a valid customer, otherwise we get error.

---

## Joins

### Cross join

Combines every row from the first table with every row from the second table (Cartesian product).

```sql
SELECT * FROM customers CROSS JOIN orders;
```

### Inner join

Returns only the rows with matching values in both tables.

```sql
SELECT * FROM customers
INNER JOIN orders ON customers.id = orders.customer_id;
```

For Inner Join `INNER` keyword is optional because it's the default.

### Outer join

#### Left join (left outer join)

Returns all rows from the left table, and matched rows from the right. If there’s no match, NULLs are returned.

```sql
SELECT * FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;
```

#### Right join (right outer join)

Returns all rows from the right table, and matched rows from the left. NULLs are returned if no match.

```sql
SELECT * FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;
```

#### Full outer join

Returns all rows from both tables. If there’s no match, NULLs are returned.

Not supported in MySQL directly, but can be simulated:

```sql
SELECT * FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
UNION
SELECT * FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;
```
