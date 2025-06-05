# Indexes and perofrmance

Contains examples for how to optimize queries

Common keywords: `EXPLAIN`, `ANALYZE`, `BTREE`, `GIN`, `HASH`

---

### Create index

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

### Insights

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
