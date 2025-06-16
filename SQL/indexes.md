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

## Clustered vs Non-Clustered Index

### Clustered Index

- A clustered index determines the **physical order of data** in a table.
- The table rows are **stored on disk in the same order as the index**.
- There can be **only one clustered index per table**, because the rows can only be sorted one way physically.

**Benefits**

- Faster range queries and sorting.
- Ideal for columns often used in `ORDER BY`, `BETWEEN`, or range filters.

**Drawbacks**

- Slower for random inserts into the middle of the index.
- Only one per table.

### Non-Clustered Index

- A non-clustered index is a separate structure from the data.
- It contains **pointers** (called row locators) to the actual rows.
- You can have **multiple non-clustered indexes** on a table.

**Benefits**

- Flexible: multiple indexes for different query patterns.
- Useful when queries target different columns.

**Drawbacks**

- Slightly slower than clustered indexes for retrieval (needs to follow a pointer).
- Takes more space.

---

## Pro Tip: use `EXPLAIN`

You can use the `EXPLAIN` keyword before your query to **see how the database executes it**, and whether it's using an index:

```sql
EXPLAIN SELECT * FROM users WHERE email = 'example@test.com';
```
