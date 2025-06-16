# Stored functions

Common keywords: `CREATE FUNCTION`, `RETURNS`, `BEGIN`, `END`

---

### Custom sum function

```sql
CREATE FUNCTION add_numbers(a INT, b INT)
RETURNS INT AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;
```

```sql
SELECT add_numbers(2, 3);
```

| add_numbers |
| ----------- |
| 5           |

---

### Control flow

```sql
CREATE FUNCTION grade_score(score INT)
RETURNS TEXT AS $$
BEGIN
    IF score >= 90 THEN
        RETURN 'A';
    ELSIF score >= 80 THEN
        RETURN 'B';
    ELSE
        RETURN 'C or below';
    END IF;
END;
$$ LANGUAGE plpgsql;
```

```sql
SELECT grade_score(87);
```

| grade_score |
| ----------- |
| B           |

---
