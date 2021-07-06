# Relationships

## One to One

One row from one table is related to only one row from another table.

For example User table where one user takes only one row and UserDetails table, where for one user there is only row of details.

---

## One to Many

One row from one table is related to many rows from another table.

For example Customers table where customer takes only one row and Orders table, where for one customer from the Customers table are related many orders in the Orders table.

In the Orders (many) table we will keep the id of the specific customer from the Customers (one) table.

**Customers**

| customer_id | name | email         |
| ----------- | ---- | ------------- |
| 1           | Ema  | ema@mail.com  |
| 2           | Ina  | ina@mail.com  |
| 3           | Toni | toni@mail.com |
| 4           | Tina | tina@mail.com |

**Orders**

| order_id | order_date | amount | customer_id |
| -------- | ---------- | ------ | ----------- |
| 1        | 2020-07-21 | 21.99  | 1           |
| 2        | 2020-08-11 | 12.00  | 1           |
| 3        | 2020-06-19 | 23.45  | 2           |
| 4        | 2020-11-09 | 9.50   | 3           |

_Note: naming columns doesn't matter, not neccessary to be customer_id for both tables. We specify that reference when creating the table with foreign key._

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

or

```sql
SELECT * FROM customers CROSS JOIN orders;
```

### Inner join

With inner join we will get only the rows where we have a match between the 2 tables.

Inner join is the default one, so not neccessary to specify it.

```sql
SELECT * FROM customers
JOIN orders ON customers.id = orders.customer_id;
```

### Outer join

#### Left outer join (left join)

With left join we will get everything from the left table even if we don't have a match from the right table. In other words left outer join returns all the rows from the left table with the matching rows from the right table and if there are no columns matching in the right table it return NULL values.

```sql
SELECT * FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;
```

#### Right outer join (right join)

With right join we will get everything from the right table even if we don't have a match from the left table. Basically it is reversed on the left join.

```sql
SELECT * FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;
```

#### Full outer join

Full outer join is not supported by MySQL, but we can achieve it by using left join and right join with union.
