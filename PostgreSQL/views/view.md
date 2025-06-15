# View

Common keywords: `VIEW`

---

### View of a query

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

- Because views are stored in the database, this is how we can delete a view

```sql
DROP VIEW my_friends;
```

---
