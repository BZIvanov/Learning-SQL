# Roles and permissions

Contains examples for how to work with roles and permissions.

---

### Grant privilegies to an user

- This query will grant privilegies to an user to interact with the database.

```sql
GRANT SELECT, UPDATE, INSERT, DELETE ON my_table_name TO my_new_user;
```
