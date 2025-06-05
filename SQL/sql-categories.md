# SQL Categories

---

## DQL – Data Query Language

**Purpose**: Retrieve data from the database.

### Common DQL Commands:

- `SELECT` – fetches data from one or more tables

💡 DQL is used to **read or query** data, not change it.

---

## DML – Data Manipulation Language

**Purpose**: Modify data inside existing database tables.

### Common DML Commands:

- `INSERT` – adds new data
- `UPDATE` – changes existing data
- `DELETE` – removes data

💡 DML is used to **change the actual content** of the database.

---

## DDL – Data Definition Language

**Purpose**: Define or modify the structure of database objects like tables, schemas, indexes, etc.

### Common DDL Commands:

- `CREATE` – creates a new table or database
- `ALTER` – modifies an existing table
- `DROP` – deletes a table or database
- `TRUNCATE` – removes all rows from a table, but keeps its structure

💡 Think of DDL as the **blueprint** of the database.

---

## DTL / TCL – Data Transaction Language (often called Transaction Control Language)

**Purpose**: Manage database transactions — groups of operations that must be executed together.

### Common DTL/TCL Commands:

- `BEGIN` or `START TRANSACTION` – begins a transaction
- `COMMIT` – saves changes permanently
- `ROLLBACK` – undoes changes since the last commit

💡 DTL/TCL ensures **data integrity** by controlling how changes are saved or reverted.

---

## DCL – Data Control Language

**Purpose**: Manage permissions and access control.

### Common DCL Commands:

- `GRANT` – gives user permissions
- `REVOKE` – removes user permissions

💡 DCL is used for **security and access control** in the database.
