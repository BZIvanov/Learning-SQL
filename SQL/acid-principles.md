# ACID Principles

The ACID principles define the key properties that guarantee reliable and consistent database transactions.

🔗 [Read more on Wikipedia](https://en.wikipedia.org/wiki/ACID)

---

### 1. **Atomicity**

Indivisible and irreducible series of database operations.

- A transaction is **all or nothing**.
- If one part of the transaction fails, the entire transaction is rolled back.
- No partial updates are allowed.

💡 _Think of it like sending a message: either the whole message is delivered, or none of it is._

---

### 2. **Consistency**

Changes to the database allowed from on valid state to another.

- A transaction brings the database from **one valid state to another**.
- It ensures that data **respects all rules, constraints, and integrity checks**.

💡 _No transaction should leave the database in a broken or invalid state._

---

### 3. **Isolation**

When and how the changes we made become visible to the others.

- **Concurrent transactions** are kept separate until they're finished.
- This prevents them from interfering with each other or seeing partial updates.

💡 _What happens in one transaction stays in that transaction until it's done._

---

### 4. **Durability**

Committed changes become permanent.

- Once a transaction is **committed**, the data is permanently saved — even if the system crashes right after.
- The database uses logs and backups to recover the committed data.

💡 _If the system goes down, your committed changes won’t be lost._
