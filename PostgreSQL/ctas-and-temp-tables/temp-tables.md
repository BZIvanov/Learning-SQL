# Temporary tables

Common keywords: `TEMP`

---

### Basic temp table

| id  | name  | total | order_date |
| --- | ----- | ----- | ---------- |
| 1   | Alice | 100   | 2025-05-30 |
| 2   | Alice | 200   | 2025-04-25 |
| 3   | Bob   | 150   | 2025-05-26 |

```sql
CREATE TEMP TABLE recent_orders AS
SELECT * FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';
```

| id  | name  | total | order_date |
| --- | ----- | ----- | ---------- |
| 1   | Alice | 100   | 2025-05-30 |
| 3   | Bob   | 150   | 2025-05-26 |
