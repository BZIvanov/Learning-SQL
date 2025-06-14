# Common Table Expressions (CTEs)

Common keywords: `WITH`

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
