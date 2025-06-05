# Aggregations

Contains examples for aggregating data.

---

### Grouping data

- Group by is creating multiple subtables based on what we group by and executing aggregate functions on those subtables.
- After the select we can only have columns which appear after group by or aggreagte functions
- Group by is usually not used on its own, because behind the scenes it creates groups of rows, but if display it, we will see only the first row of each group. So basically GROUP BY will create multiple tables based on the different cities and the SELECT will operate for each individual table. GROUP BY is usually used with some aggregate functions so we can see meaningful results instead of just the first rows of our subtables.

| name   | city    | income |
| ------ | ------- | ------ |
| Mira   | Sofia   | 5200   |
| Mitko  | Sofia   | 4000   |
| Iva    | Plovdiv | 3800   |
| Toni   | Plovdiv | 5000   |
| Polina | Varna   | 4500   |

```sql
SELECT city, avg(income) AS average_income FROM people
GROUP BY city;
```

| city    | average_income |
| ------- | -------------- |
| Sofia   | 4600.00000     |
| Varna   | 4500.00000     |
| Plovdiv | 4400.00000     |

---

### Grouping data with having

- WHERE will filter first some of the rows, then GROU BY will create subgroups and HAVING will filter the subgroups.
- Based on the above text, WHERE is filtering based on individual rows and HAVING on whole groups.

| name     | city    | income |
| -------- | ------- | ------ |
| Angelina | Sofia   | 5000   |
| Valeria  | Sofia   | 5200   |
| Evgeni   | Plovdiv | 4250   |
| Traqn    | Plovdiv | 4900   |
| Eli      | Varna   | 4990   |

```sql
SELECT city, avg(income) AS average_income FROM people
WHERE income <= 5000
GROUP BY city
HAVING COUNT(*) > 1;
```

| city    | average_income |
| ------- | -------------- |
| Plovdiv | 4575.00000     |

---

### Select unique values

- We will count all unique values, without count we would get once Sofia and once Plovdiv.
- COUNT function will check for count of something we need.

| name | city    |
| ---- | ------- |
| Mira | Sofia   |
| Iva  | Plovdiv |
| Tanq | Sofia   |

```sql
SELECT COUNT(DISTINCT city) FROM users;
```

| count |
| ----- |
| 2     |
