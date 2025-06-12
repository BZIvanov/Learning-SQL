# Aggregations

Contains examples for aggregating data.

Common keywords: `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `OVER`, `PARTITION BY`, `ROWS BETWEEN`

---

### Sum values

- `SUM` is aggregate function which will aggregate all rows in a sum.

| name  | income |
| ----- | ------ |
| Mira  | 3500   |
| Iva   | 3700   |
| Mitko | 3900   |

```sql
SELECT SUM(income) AS total FROM people;
```

| total |
| ----- |
| 11100 |

---

### Grouping data

- `GROUP BY` is creating multiple subtables based on what we group by and executing aggregate functions on those subtables.
- After the select we can only have columns which appear after group by or aggreagte functions
- `GROUP BY` is usually not used on its own, because behind the scenes it creates groups of rows, but if display it, we will see only the first row of each group. So basically `GROUP BY` will create multiple tables based on the different cities and the `SELECT` will operate for each individual table. `GROUP BY` is usually used with some aggregate functions so we can see meaningful results instead of just the first rows of our subtables.
- All mentioned columns after `SELECT` should be either used in some aggregation or provided to `GROUP BY`

| name   | city    | income |
| ------ | ------- | ------ |
| Mira   | Sofia   | 5200   |
| Mitko  | Sofia   | 4000   |
| Iva    | Plovdiv | 3800   |
| Toni   | Plovdiv | 5000   |
| Polina | Varna   | 4500   |

```sql
SELECT city, AVG(income) AS average_income FROM people
GROUP BY city;
```

| city    | average_income |
| ------- | -------------- |
| Sofia   | 4600.00000     |
| Varna   | 4500.00000     |
| Plovdiv | 4400.00000     |

---

### Grouping data with having

- `WHERE` will filter first some of the rows, then `GROUP BY` will create subgroups and `HAVING` will filter the subgroups.
- Based on the above text, `WHERE` is filtering based on individual rows and `HAVING` on whole groups. Or in other words `WHERE` is filtering before the aggregation and `HAVING` is filtering after the aggregation.

| name     | city    | income |
| -------- | ------- | ------ |
| Angelina | Sofia   | 5000   |
| Valeria  | Sofia   | 5200   |
| Evgeni   | Plovdiv | 4250   |
| Traqn    | Plovdiv | 4900   |
| Eli      | Varna   | 4990   |

```sql
SELECT city, AVG(income) AS average_income FROM people
WHERE income <= 5000
GROUP BY city
HAVING COUNT(*) > 1;
```

| city    | average_income |
| ------- | -------------- |
| Plovdiv | 4575.00000     |

---

### Select unique values

- We will count all unique values, without `COUNT` we would get once Sofia and once Plovdiv.
- `COUNT` function will check for count of something we need.

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

---

### Window Over

- `OVER (PARTITION BY employee)` means "calculate the sum per employee"
- Without `OVER`, `SUM(amount)` would return **just one total** for the whole table
- This keeps row-level detail and adds a per-group summary

| employee | amount |
| -------- | ------ |
| John     | 100    |
| Jane     | 150    |
| John     | 200    |
| Jane     | 300    |

```sql
SELECT
    employee,
    amount,
    SUM(amount) OVER () AS total_all
    SUM(amount) OVER (PARTITION BY employee) AS total_per_employee
FROM sales;
```

| employee | amount | total_all | total_per_employee |
| -------- | ------ | --------- | ------------------ |
| Jane     | 150    | 750       | 450                |
| Jane     | 300    | 750       | 450                |
| John     | 100    | 750       | 300                |
| John     | 200    | 750       | 300                |

---

### Window rows

- `ROWS BETWEEN 3 PRECEDING AND CURRENT ROW` - it means for the partitiion (season) sum starting from the 3 previous rows to the current row. If there are no previous rows, the sum will be initially equal to the current row for the respective season.

| id  | month | season | spendings |
| --- | ----- | ------ | --------- |
| 1   | Jan   | Winter | 100       |
| 2   | Feb   | Winter | 120       |
| 3   | Mar   | Spring | 110       |
| 4   | Apr   | Spring | 90        |
| 5   | May   | Spring | 95        |
| 6   | Jun   | Summer | 85        |
| 7   | Jul   | Summer | 100       |
| 8   | Aug   | Summer | 105       |
| 9   | Sep   | Autumn | 120       |
| 10  | Oct   | Autumn | 95        |
| 11  | Nov   | Autumn | 90        |
| 12  | Dec   | Winter | 110       |

```sql
SELECT
    month,
    season,
    spendings,
    SUM(spendings) OVER () AS total_all
    SUM(spendings) OVER (
        PARTITION BY season
        ORDER BY id
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
    ) AS last_three_months_for_season
FROM sales;
```

| month | season | spendings | total_all | last_three_months_for_season |
| ----- | ------ | --------- | --------- | ---------------------------- |
| Sep   | Autumn | 120       | 1220      | 120                          |
| Oct   | Autumn | 95        | 1220      | 215                          |
| Nov   | Autumn | 90        | 1220      | 305                          |
| Mar   | Spring | 110       | 1220      | 110                          |
| Aor   | Spring | 90        | 1220      | 200                          |
| May   | Spring | 95        | 1220      | 295                          |
| Jun   | Summer | 85        | 1220      | 85                           |
| Jul   | Summer | 100       | 1220      | 185                          |
| Aug   | Summer | 105       | 1220      | 290                          |
| Jan   | Winter | 100       | 1220      | 100                          |
| Feb   | Winter | 120       | 1220      | 220                          |
| Dec   | Winter | 110       | 1220      | 330                          |
