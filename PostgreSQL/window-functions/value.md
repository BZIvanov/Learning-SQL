# Value

Contains examples for accessing value data.

Common keywords: `LEAD`, `LAG`, `FIRST_VALUE`, `LAST_VALUE`

---

### Row Values

| sales_date | sales_amount |
| ---------- | ------------ |
| 2025-01-01 | 30           |
| 2025-02-01 | 40           |
| 2025-03-01 | 20           |
| 2025-04-01 | 50           |
| 2025-05-01 | 20           |
| 2025-06-01 | 90           |
| 2025-07-01 | 10           |

```sql
SELECT
    *,
    LAG(sales_amount) OVER (ORDER BY sales_date) sales_prev,
    LEAD(sales_amount) OVER (ORDER BY sales_date) sales_next
FROM sales;
```

| sales_date | sales_amount | sales_prev | sales_next |
| ---------- | ------------ | ---------- | ---------- |
| 2025-01-01 | 30           | NULL       | 40         |
| 2025-02-01 | 40           | 30         | 20         |
| 2025-03-01 | 20           | 40         | 50         |
| 2025-04-01 | 50           | 20         | 20         |
| 2025-05-01 | 20           | 50         | 90         |
| 2025-06-01 | 90           | 20         | 10         |
| 2025-07-01 | 10           | 90         | NULL       |

---
