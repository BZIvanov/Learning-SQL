# Common Table Expressions (CTEs)

Common keywords: `WITH`, `RECURSIVE`

---

### Basic CTE

**_departments_**

| id  | name        |
| --- | ----------- |
| 1   | Sales       |
| 2   | Marketing   |
| 3   | Engineering |

**_employees_**

| id  | name  | department_id |
| --- | ----- | ------------- |
| 1   | Alice | 1             |
| 2   | Bob   | 2             |
| 3   | Carol | 1             |
| 4   | Dave  | 3             |
| 5   | Eve   | 2             |

```sql
WITH sales_dept AS (
    SELECT id
    FROM departments
    WHERE name = 'Sales'
)
SELECT e.name
FROM employees e
JOIN sales_dept sd ON e.department_id = sd.id;
```

| name  |
| ----- |
| Alice |
| Carol |

---

### Recursive CTE

```sql
WITH RECURSIVE counter(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM counter WHERE n < 10
)
SELECT * FROM counter;
```

| n   |
| --- |
| 1   |
| 2   |
| 3   |
| 4   |
| 5   |
| 6   |
| 7   |
| 8   |
| 9   |
| 10  |

---
