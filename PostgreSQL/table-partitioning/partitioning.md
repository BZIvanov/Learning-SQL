# Partitioning

---

### Range partitioning

**Step 1: Create a Partitioned Table**

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer TEXT,
    order_date DATE,
    total NUMERIC
) PARTITION BY RANGE (order_date);
```

**Step 2: Create Partitions**

```sql
CREATE TABLE orders_2023 PARTITION OF orders
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE orders_2024 PARTITION OF orders
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
```

**Step 3: Insert Data**

```sql
INSERT INTO orders (customer, order_date, total) VALUES
('Mira', '2023-05-10', 250),
('Iva',  '2024-03-22', 400);
```

**Step 4: Query Data (transparent access)**

```sql
SELECT * FROM orders;
```

| id  | customer | order_date | total |
| --- | -------- | ---------- | ----- |
| 1   | Alice    | 2023-05-10 | 250   |
| 2   | Bob      | 2024-03-22 | 400   |

PostgreSQL automatically routes queries and inserts to the correct partition.
