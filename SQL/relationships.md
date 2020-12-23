# Relationships

## One to One

One row from one table is related to only one row from another table.

For example User table where one user takes only one row and UserDetails table, where for one user there is only row of details.

---

## One to Many

One row from one table is related to many rows from another table.

For example Recipes table where recipe takes only one row and RecipeComments table, where for one recipe from the Recipes table are related many comments in the RecipeComments table.

---

## Many to Many

Many rows from one table are related to many rows from another table.

For example Books table can have multiple authors from another Authors table if more than one author is contributing to a specific book. And one author can have more than one book.

---

## Foreign key

It is a column of id's for example which point to another table's primary keys. In that way they are related.

```sql
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);
```

This way when we add record to the orders table we have to provide valid id which exists in the customers table, otherwise we get error.

---

## Joins

### Cross join

It will join both tables in a way, where for each row from the first tables all the rows from the second table will be joined. For example first table first row joined with second table first row; then first table first row joined with second table second row and so on for all rows from second table, and then for all other rows from first table.

```sql
SELECT * FROM customers, orders;
```

### Inner join

```sql
SELECT * FROM customers
JOIN orders ON customers.id = orders.customer_id;
```

### Left join

```sql
SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;
```
