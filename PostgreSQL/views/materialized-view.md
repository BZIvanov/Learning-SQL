# Materialized View

Common keywords: `MATERIALIZED VIEW`

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
