# Functions and expressions

Contains example for functions and expressions.

Common keywords: `CONCAT`, `UPPER`, `TRIM`, `SUBSTRING`, `CREATE FUNCTION`, `CASE`

---

### Using functions

- We can use functions to transform the output of a query.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT CONCAT(name, ' lives in ', UPPER(city), '.') AS sentence FROM people;
```

| sentence              |
| --------------------- |
| Mira lives in SOFIA.  |
| Iva lives in PLOVDIV. |

---

### Switch case

- With Case we can get conditional value.

| name  | city    | income |
| ----- | ------- | ------ |
| Mira  | Sofia   | 5200   |
| Iva   | Plovdiv | 5100   |
| Tanq  | Sofia   | 5500   |
| Misho | Sofia   | 4900   |
| Zaro  | Plovdiv | 5000   |

```sql
SELECT name,
  CASE
    WHEN income < 5000 THEN 'low'
    WHEN income < 5500 THEN 'average'
    ELSE 'high'
  END AS formatted_income
FROM users;
```

| name  | formatted_income |
| ----- | ---------------- |
| Mira  | average          |
| Iva   | average          |
| Tanq  | high             |
| Misho | low              |
| Zaro  | average          |
