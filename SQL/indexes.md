# Indexes

An **index** in SQL is a special data structure used to **speed up data retrieval**.

Think of an index like the **table of contents in a book** — instead of reading every page to find something, you jump straight to the page number.

---

## Why use indexes?

Without indexes, SQL databases **scan every row** in a table to find the matching data — this is called a **full table scan**, and it gets slower as your table grows.

Indexes allow the database to **quickly locate rows** by looking them up in a sorted, efficient structure (often a B-tree).

---

## Benefits

- **Faster SELECT queries**, especially with:
  - `WHERE` conditions
  - `JOIN` operations
  - `ORDER BY` clauses
- Can enforce **uniqueness** with `UNIQUE` indexes

---

## How to create an index?

```sql
-- Create a basic index on one column
CREATE INDEX idx_users_email ON users(email);

-- Create a unique index (no duplicates allowed)
CREATE UNIQUE INDEX idx_users_username ON users(username);
```

---

## Notes

- You can add indexes to **one or more columns** (multi-column indexes).
- Naming convention: `idx_<table>_<column>`

---

## Things to watch out for

- Indexes **speed up reads**, but **slow down writes** (`INSERT`, `UPDATE`, `DELETE`)
- Too many indexes can **waste disk space** and reduce performance
- Always **analyze your queries** before adding indexes blindly

---

## When to use an index?

- The column is frequently used in `WHERE`, `JOIN`, or `ORDER BY`
- You need to enforce uniqueness (use `UNIQUE`)
- The table is large and performance is an issue

---

## Pro Tip: use `EXPLAIN`

You can use the `EXPLAIN` keyword before your query to **see how the database executes it**, and whether it's using an index:

```sql
EXPLAIN SELECT * FROM users WHERE email = 'example@test.com';
```
