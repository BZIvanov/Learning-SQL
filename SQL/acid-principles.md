# ACID Principles

Read more [here](https://en.wikipedia.org/wiki/ACID)

- Atomicity - indivisible and irreducible series of database operations. Basically it represents a transaction. It means that when running a transaction either all operations in the transaction should succeed or all should be reverted if one of the operations fail (all or nothing).
- Consistency - changes to the database allowed from on valid state to another. It means that the data should be consistent after the transaction is completed.
- Isolation - when and how the changes we made become visible to the others. It means that transactions should be kept from each other until they are finished.
- Durability - committed changes become permanent. It means that the database is guaranteed to keep track of pending changes in such a way, that the server can recover from an abnormal termination.
