# Querying data

Contains examples for how to query data.

Common keywords: `SELECT`, `FROM`, `WHERE`, `LIMIT`, `OFFSET`, `ORDER BY`, `DISTINCT`, `AS`, `BETWEEN`

---

### Get database users

- Aliases will not affect the actual data, but with them we can display columns with changed names in case we want that

```sql
SELECT usename AS username FROM pg_user;
```

| usename     | usesysid | usecreatedb | usesuper | userepl | usebypassrls | passwd           | valuntil               | useconfig |
| ----------- | -------- | ----------- | -------- | ------- | ------------ | ---------------- | ---------------------- | --------- |
| postgres    | 10       | true        | true     | true    | true         | \*\*\*\*\*\*\*\* |                        |           |
| my_new_user | 16389    | false       | false    | false   | false        | \*\*\*\*\*\*\*\* | 2024-07-01 00:00:00+00 |           |

---

### Read all columns from the table

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200.50          |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT * FROM people;
```

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200.50          |
| Iva  | Plovdiv | 7200           | 1900             |

---

### Select specific columns

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200.50          |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT city, name FROM people;
```

| city    | name |
| ------- | ---- |
| Sofia   | Mira |
| Plovdiv | Iva  |

---

### Read and transform data

- We can use math operators with different columns values.
- With `AS` we can get meaningful column names using aliases.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT name, monthly_income - travel_spendings AS net, travel_spendings / monthly_income * 100 AS perc
FROM people;
```

| name | net     | perc                    |
| ---- | ------- | ----------------------- |
| Mira | 3599.50 | 37.93965517241379310300 |
| Iva  | 5300    | 26.38888888888888888900 |

---

### Filter results

- This is how we can filter results.
- If working with date and time it is recommended to cast them.

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT name, city FROM people WHERE monthly_income >= 7000 AND city = 'Plovdiv';
```

| name | city    |
| ---- | ------- |
| Iva  | Plovdiv |

---

### Between value or in array of values

| name | city    | monthly_income | travel_spendings |
| ---- | ------- | -------------- | ---------------- |
| Mira | Sofia   | 5800           | 2200             |
| Iva  | Plovdiv | 7200           | 1900             |

```sql
SELECT name, city FROM people
WHERE monthly_income BETWEEN 5000 AND 7000 AND city IN ('Sofia', 'Varna');
```

| name | city  |
| ---- | ----- |
| Mira | Sofia |

---

### Unique values

| name | city    |
| ---- | ------- |
| Mira | Sofia   |
| Iva  | Plovdiv |
| Sam  | Sofia   |

```sql
SELECT DISTINCT city FROM people;
```

| city    |
| ------- |
| Sofia   |
| Plovdiv |

---

### Sorting data

- We will first sort by city ascending, then equal cities will be sorted by price descending and last by name.
- Ascending is by default so no need to specify it.

| name     | city    | income |
| -------- | ------- | ------ |
| Angelina | Sofia   | 5000   |
| Valeria  | Sofia   | 5200   |
| Evgeni   | Plovdiv | 4250   |
| Traqn    | Plovdiv | 4900   |
| Eli      | Varna   | 4990   |
| Eli      | Sofia   | 5100   |
| Mira     | Plovdiv | 4900   |

```sql
SELECT * FROM people
ORDER BY city, income DESC, name;
```

| name     | city    | income |
| -------- | ------- | ------ |
| Mira     | Plovdiv | 4900   |
| Traqn    | Plovdiv | 4900   |
| Evgeni   | Plovdiv | 4250   |
| Valeria  | Sofia   | 5200   |
| Eli      | Sofia   | 5100   |
| Angelina | Sofia   | 5000   |
| Eli      | Varna   | 4900   |

---

### Skip and limit results

- Useful for example for pagination.

| name     | city    | income |
| -------- | ------- | ------ |
| Angelina | Sofia   | 5000   |
| Valeria  | Sofia   | 5200   |
| Evgeni   | Plovdiv | 4250   |
| Traqn    | Plovdiv | 4900   |
| Eli      | Varna   | 4990   |

```sql
SELECT * FROM people ORDER BY income LIMIT 2 OFFSET 2;
```

| name     | city  | income |
| -------- | ----- | ------ |
| Eli      | Varna | 4990   |
| Angelina | Sofia | 5000   |
