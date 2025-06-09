# Left Join

### Basic left join

- Left join will get all the records from the table on the left.

**_users_**

| id<sup>PK</sup> | name   |
| --------------- | ------ |
| 1               | Mira   |
| 2               | Sofia  |
| 3               | Ivan   |
| 4               | Metodi |
| 5               | Marina |

**_images_**

| id<sup>PK</sup> | url         | user_id<sup>FK</sup> |
| --------------- | ----------- | -------------------- |
| 1               | image-1.png | 1                    |
| 2               | image-2.png | 1                    |
| 3               | image-3.png | 2                    |
| 4               | image-4.png | 2                    |
| 5               | image-5.png | 3                    |

```sql
SELECT u.id AS uid, name, i.id AS iid, url, user_id
FROM users AS u LEFT JOIN images AS i ON u.id = i.user_id;
```

| uid | name   | iid  | url         | user_id |
| --- | ------ | ---- | ----------- | ------- |
| 1   | Mira   | 1    | image-1.png | 1       |
| 1   | Mira   | 2    | image-2.png | 1       |
| 2   | Sofia  | 3    | image-3.png | 2       |
| 2   | Sofia  | 4    | image-4.png | 2       |
| 3   | Ivan   | 5    | image-5.png | 3       |
| 4   | Metodi | null | null        | null    |
| 5   | Marina | null | null        | null    |

---

### Multiple joins

**_users_**

| id<sup>PK</sup> | name |
| --------------- | ---- |
| 1               | Mira |
| 2               | Iva  |
| 3               | John |

**_orders_**

| id<sup>PK</sup> | total | user_id<sup>FK</sup> |
| --------------- | ----- | -------------------- |
| 1               | 100   | 1                    |
| 2               | 80    | 1                    |
| 3               | 50    | 2                    |

**_cities_**

| id<sup>PK</sup> | city    | user_id<sup>FK</sup> |
| --------------- | ------- | -------------------- |
| 1               | Sofia   | 1                    |
| 2               | Plovidv | 2                    |

```sql
SELECT u.name, c.city, o.total AS order_total
FROM users u
LEFT JOIN cities c ON u.id = c.user_id
LEFT JOIN orders o ON u.id = o.user_id;
```

| name | city    | order_total |
| ---- | ------- | ----------- |
| Mira | Sofia   | 100         |
| Mira | Sofia   | 80          |
| Iva  | Plovidv | 50          |
| John | NULL    | NULL        |

---
