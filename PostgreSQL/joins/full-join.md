# Full Join

### Basic full join

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
SELECT u.id AS uid, u.name, i.id AS iid, i.url, i.user_id
FROM users AS u
FULL JOIN images AS i ON u.id = i.user_id;
```

| uid | name   | iid  | url         | user_id |
| --- | ------ | ---- | ----------- | ------- |
| 1   | Mira   | 1    | image-1.png | 1       |
| 1   | Mira   | 2    | image-2.png | 1       |
| 2   | Sofia  | 3    | image-3.png | 2       |
| 2   | Sofia  | 4    | image-4.png | 2       |
| 3   | Ivan   | 5    | image-5.png | 3       |
| 4   | Metodi | NULL | NULL        | NULL    |
| 5   | Marina | NULL | NULL        | NULL    |

---
