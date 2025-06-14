# Subqueries and CTEs

Contains examples for subqueries and Common Table Expressions (CTEs).

Common keywords: `SELECT`, `WITH`

---

### Subqueries

- With sub queries we can use the result of one query in another.
- Very important note here is to understand the returned type of the subquery. It is not table with one or many columns and rows. It is scalar type, single value which we can reuse. Basically, because the result is one column and one row.

| name     | income |
| -------- | ------ |
| Angelina | 5000   |
| Valeria  | 5200   |
| Evgeni   | 4250   |

```sql
SELECT * FROM people WHERE income > (
  SELECT income FROM people WHERE name = 'Angelina'
);
```

| name    | income |
| ------- | ------ |
| Valeria | 5200   |

---

### Sub queries in the select clause

- For our custom column we will have value calculated with the scalar result returned by the subquery.

| name     | income |
| -------- | ------ |
| Angelina | 5000   |
| Valeria  | 5200   |
| Evgeni   | 4250   |

```sql
SELECT name, income, income / (SELECT MAX(income) FROM people) AS ratio
FROM people ORDER BY income DESC;
```

| name     | income | ratio                  |
| -------- | ------ | ---------------------- |
| Valeria  | 5200   | 1.00000000000000000000 |
| Angelina | 5000   | 0.96153846153846153846 |
| Evgeni   | 4250   | 0.81730769230769230769 |

---

### Sub queries in the from clause

- We are required to use alias AS c even if we don't use it.
- Outside the subquery, we can only use columns from the subquery.

| name | city    | income |
| ---- | ------- | ------ |
| Mira | Sofia   | 4500   |
| Iva  | Plovdiv | 5100   |
| Tina | Plovdiv | 4750   |
| Ivan | Sofia   | 5500   |
| Deni | Sofia   | 4900   |

```sql
SELECT AVG(c.cities_count)
FROM (
  SELECT city, COUNT(*) AS cities_count FROM people GROUP BY city
) AS c;
```

| avg                |
| ------------------ |
| 2.5000000000000000 |

---

### Sub queries with join

- We will get users who purchased rice

**_users_**

| id<sup>PK</sup> | name  |
| --------------- | ----- |
| 1               | Mira  |
| 2               | Iva   |
| 3               | Tanq  |
| 4               | Misho |

**_products_**

| id<sup>PK</sup> | product_name |
| --------------- | ------------ |
| 1               | Sugar        |
| 2               | Rice         |
| 3               | Milk         |

**_purchases_**

| id<sup>PK</sup> | user_id<sup>FK</sup> | product_id<sup>FK</sup> |
| --------------- | -------------------- | ----------------------- |
| 1               | 1                    | 1                       |
| 2               | 1                    | 3                       |
| 3               | 2                    | 2                       |
| 4               | 3                    | 1                       |
| 5               | 3                    | 2                       |

```sql
SELECT name FROM users
INNER JOIN (
  SELECT user_id FROM purchases WHERE product_id = 2
) AS p ON p.user_id = users.id;
```

| name |
| ---- |
| Iva  |
| Tanq |

---

### Sub queries in where clause

- Inner select will return 1 column only so we can use it as array of values.

**_users_**

| id<sup>PK</sup> | name  | income | taxes |
| --------------- | ----- | ------ | ----- |
| 1               | Mira  | 5200   | 700   |
| 2               | Iva   | 5100   | 900   |
| 3               | Tanq  | 5500   | 1100  |
| 4               | Misho | 4900   | 900   |

**_purchases_**

| id<sup>PK</sup> | user_id<sup>FK</sup> | product_id<sup>FK</sup> |
| --------------- | -------------------- | ----------------------- |
| 1               | 1                    | 1                       |
| 2               | 1                    | 3                       |
| 3               | 2                    | 2                       |
| 4               | 3                    | 1                       |
| 5               | 3                    | 2                       |

```sql
SELECT id FROM purchases WHERE user_id IN (
  SELECT id FROM users WHERE income - taxes > 4300
);
```

| id  |
| --- |
| 1   |
| 2   |
| 4   |
| 5   |

---

### Another subquery example

- With ALL we will select onlyy users which have income higher than anyone from Plovdiv.
- With similar syntax with using SOME we can also achieve filtering behaviour.

| name  | city    | income |
| ----- | ------- | ------ |
| Mira  | Sofia   | 5200   |
| Iva   | Plovdiv | 5100   |
| Tanq  | Sofia   | 5500   |
| Misho | Sofia   | 4900   |
| Zaro  | Plovdiv | 5000   |

```sql
SELECT * FROM users WHERE income > ALL (
  SELECT income FROM users WHERE city = 'Plovdiv'
);
```

| name | city  | income |
| ---- | ----- | ------ |
| Mira | Sofia | 5200   |
| Tanq | Sofia | 5500   |
