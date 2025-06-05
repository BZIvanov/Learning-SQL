# Views

Contains examples about views.

---

### View of a query

- VIEW is a virtual table
- The view is not physically materialized. Instead, the query is run every time the view is referenced in a query
- In pgAdmin you can find your views under Schemas then public then Views
- In case % sign is what we want to search for, we have to use '\' to escape it.

| name   | city    | income |
| ------ | ------- | ------ |
| Mira   | Sofia   | 5200   |
| Iva    | Plovdiv | 5100   |
| Sonia  | Sofia   | 5500   |
| Martin | Sofia   | 4900   |
| Toni   | Plovdiv | 5000   |

```sql
CREATE VIEW my_friends AS SELECT name, city, income FROM persons WHERE name LIKE '%n%';
```

Now, let's use our newly created view.

```sql
SELECT * FROM my_friends;
```

| name   | city    | income |
| ------ | ------- | ------ |
| Sonia  | Sofia   | 5500   |
| Martin | Sofia   | 4900   |
| Toni   | Plovdiv | 5000   |

We can further narrow the results by applying additional filters to our view.

```sql
SELECT * FROM my_friends WHERE name LIKE '%in%';
```

| name   | city  | income |
| ------ | ----- | ------ |
| Martin | Sofia | 4900   |

---

### Delete a view

- Because views are stored in the database, this is how we can delete one of them

```sql
DROP VIEW my_friends;
```

---

### Materialized view

- Materialized view will store the results, so we will need to refresh it in case data was added, updated or removed from the table after we created the materialized view.

| name   | city    | income |
| ------ | ------- | ------ |
| Mira   | Sofia   | 5200   |
| Iva    | Plovdiv | 5100   |
| Sonia  | Sofia   | 5500   |
| Martin | Sofia   | 4900   |
| Toni   | Plovdiv | 5000   |

```sql
CREATE MATERIALIZED VIEW my_friends AS SELECT name, city, income FROM persons WHERE name LIKE '%n%';
```

Now, let's use our newly created materialized view.

```sql
SELECT * FROM my_friends;
```

Now if more data is added, updated or removed, we will get outdated results with our materialized view. We can refresh it by running additional query.

```sql
REFRESH MATERIALIZED VIEW my_friends;
```
