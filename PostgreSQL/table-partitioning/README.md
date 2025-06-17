# Table Partitioning

Partitioning splits a large table into smaller, more manageable pieces — called partitions — while letting you query them as a single table.

PostgreSQL supports:

- `RANGE` partitioning (e.g., by date)
- `LIST` partitioning (e.g., by country)
- `HASH` partitioning (e.g., for even distribution)

Use it for:

- Large datasets (e.g., logs, sales)
- Performance gains (query pruning)
- Easier maintenance (drop/archive partitions)

## Content of this section

- **partitioning**
