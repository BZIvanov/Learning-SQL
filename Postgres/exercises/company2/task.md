With the setup file produce the below result. The goal is to group the departments and print unique row globally and per department

| employee | salary | department | global_row | department_row |
| -------- | ------ | ---------- | ---------- | -------------- |
| Evgeni   | 4450   | Dev        | 1          | 1              |
| Georgi   | 3890   | Dev        | 2          | 2              |
| Ivan     | 5100   | Dev        | 3          | 3              |
| Miro     | 4200   | Dev        | 4          | 4              |
| Toni     | 4500   | Dev        | 5          | 5              |
| Elena    | 3550   | Finance    | 6          | 1              |
| Eli      | 2850   | Finance    | 7          | 2              |
| Hristo   | 2500   | HR         | 8          | 1              |
| Iva      | 3900   | HR         | 9          | 2              |

_Use the setup.sql file to create the table._
