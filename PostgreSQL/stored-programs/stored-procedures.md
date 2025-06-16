# Stored procedures

Common keywords: `CREATE PROCEDURE`, `CALL`, `BEGIN`, `END`

---

### Insert data

```sql
CREATE PROCEDURE log_message(msg TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO logs (message, created_at) VALUES (msg, NOW());
END;
$$;
```

```sql
CALL log_message('System initialized');
```

---
