# Schema and datatypes

Contains examples for how to handle schemas and data types.

Common keywords: `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `NOT NULL`

---

### Modify column of existing table

- We can modify the columns settings of already exisiting tables.
- Similarly we can add Unique or Check constraints.

```sql
ALTER TABLE people ALTER COLUMN name SET NOT NULL;
```

| id<sup>PK</sup> | name |
| --------------- | ---- |
