# Performance

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
