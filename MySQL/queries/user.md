# User queries

Queries related to database users.

## Create new database user

Optionally drop the user in case it already exists:

```sql
DROP USER if exists 'my_username'@'%' ;
```

Create new user:

```sql
CREATE USER 'my_username'@'%' IDENTIFIED BY 'my_password';
```

we are using `%` to connect from any host, not only localhost

Grant priviliges to the newly created user:

```sql
GRANT ALL PRIVILEGES ON * . * TO 'my_username'@'%';
```

Here we grant all priviliges to the user just for the demo.

Apply the changes:

```sql
FLUSH PRIVILEGES;
```

And to check the changes we made, we can run:

```sql
SHOW GRANTS FOR 'my_username'@'%';
```
