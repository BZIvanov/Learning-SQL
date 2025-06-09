# Combining queries

Contains rules for combining result sets (same number & type of columns)

Common keywords: `UNION`, `INTERSECT`, `EXCEPT`

---

### Union all results

- Useful for combining the result of different queries in a single table.
- Both queries must produce similar column structure. The number of columns selected in the first select must match with the second select.
- The columns in the result table will be named based on the first select.
- Without `UNION ALL`, just `UNIONS` we would get 3 results, because duplicates are ignored.
- If we use `INTERSECT` instead of `UNION`, we would get only common results for both queries.
- If we use `EXCEPT` instead of `UNION` we would get the results from the first query except the results returned from the second query. Basically everything present in the first query except the second.

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
