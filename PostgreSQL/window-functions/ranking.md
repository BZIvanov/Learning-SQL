# Ranking

Contains examples for ranking data.

Common keywords: `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `PERCENT_RANK`, `NTILE`

---

### Rank values

| sales_amount |
| ------------ |
| 30           |
| 40           |
| 20           |
| 50           |
| 20           |
| 90           |
| 10           |

```sql
SELECT
    *,
    ROW_NUMBER() OVER (ORDER BY sales_amount DESC) sales_row_number,
    RANK() OVER (ORDER BY sales_amount DESC) sales_rank,
    DENSE_RANK() OVER (ORDER BY sales_amount DESC) sales_dense_rank,
    PERCENT_RANK() OVER (ORDER BY sales_amount DESC) sales_percent_rank
FROM sales;
```

| sales_amount | sales_row_number | sales_rank | sales_dense_rank | sales_percent_rank |
| ------------ | ---------------- | ---------- | ---------------- | ------------------ |
| 90           | 1                | 1          | 1                | 0                  |
| 50           | 2                | 2          | 2                | 0.166666666666666  |
| 40           | 3                | 3          | 3                | 0.33333333333333   |
| 30           | 4                | 4          | 4                | 0.5                |
| 20           | 5                | 5          | 5                | 0.66666666666666   |
| 20           | 6                | 5          | 5                | 0.66666666666666   |
| 10           | 7                | 7          | 6                | 1                  |

---
