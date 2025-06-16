# Indexes

**In PostgreSQL all indexes are Non-Clustered (by default)**

In **pgAdmin** you can see the indexes for a given table after you expand the table and then `Indexes`

## Unique index

A unique index ensures that the values in one or more columns are **distinct** across all rows in a table.

- PostgreSQL automatically creates a unique index when you define a `UNIQUE` constraint.
- You can also **create a unique index manually**, which is useful when adding constraints later or for partial uniqueness.

### Why use unique indexes?

- Enforce **data integrity** (e.g., no two users with the same email).
- Improve **query performance** just like regular indexes.
- Enable efficient lookups and constraint checking.

## Filtered index

A filtered index is an index that only includes rows **matching a condition**.

- In PostgreSQL, this is called a **partial index**.
- It's useful for optimizing queries that only target a **subset of data**.
- It also saves space and reduces maintenance overhead compared to full-table indexes.

### Why use filtered indexes?

- Improve performance for queries that repeatedly use the same filter condition.
- Reduce index size — only relevant rows are indexed.
- Enforce conditional uniqueness (e.g., only for active rows).

## Fragmentation

**Index fragmentation** occurs when an index becomes **inefficiently organized**.

Fragmentation can lead to:

- Wasted disk space
- Slower index scans
- Poor cache usage (more pages to read, fewer fitting in memory)

---

### Create index

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

CREATE INDEX users_name_idx ON users(name);
```

| id<sup>PK</sup> | name |
| --------------- | ---- |

---

### Unique index

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(50)
);

CREATE UNIQUE INDEX idx_unique_email ON users(email);
```

---

### Filtered index

```sql
CREATE INDEX idx_active_users_email ON users(email)
WHERE is_active = true;
```
