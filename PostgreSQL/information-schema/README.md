# Information Schema

Contains examples for Information Schema.

Common keywords: `SELECT`, `WITH`

---

### Check if a table exists

```sql
SELECT EXISTS (
  SELECT 1
  FROM information_schema.tables
  WHERE table_schema = 'public' AND table_name = 'sales'
);
```

| exists |
| ------ |
| true   |

---

### List all schemas in the database

```sql
SELECT schema_name FROM information_schema.schemata;
```

| schema_name        |
| ------------------ |
| public             |
| information_schema |
| pg_catalog         |
| pg_toast           |

---

### Get column names and data types for a specific table

- The below query is on assumption that you have `sales` table with the below columns

```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'sales';
```

| column_name  | data_type |
| ------------ | --------- |
| sales_date   | date      |
| sales_amount | integer   |
