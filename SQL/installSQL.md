# Installation process

1. Run in the terminal:
```bash
sudo apt update && upgrade
sudo apt install mysql-server
exit
```

2. Reopen the terminal and type:
```bash
sudo mysql
```
in the mysql terminal enter the following commands:
```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;
exit
```

3. Now in the terminal type
```bash
mysql -u root -p
```
You will be asked for password, which is the password you have used when typing the ALTER USER command after BY.

4. Now in the sql terminal to check if everything is done correctly type:
```sql
show databases;
```

and you should see something like:
```sql
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```
