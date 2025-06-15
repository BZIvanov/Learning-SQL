# CTAS (CREATE TABLE AS SELECT)

---

### Basic CTAS

| id  | name  | total |
| --- | ----- | ----- |
| 1   | Alice | 600   |
| 2   | Alice | 700   |
| 3   | Bob   | 500   |
| 4   | Carol | 200   |
| 5   | Carol | 300   |

```sql
CREATE TABLE top_customers AS
SELECT name, SUM(total) AS total_spent
FROM orders
GROUP BY name
HAVING SUM(total) > 1000;
```

| name  | total |
| ----- | ----- |
| Alice | 1300  |
