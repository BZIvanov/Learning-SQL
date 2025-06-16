# Indexes and perofrmance

Contains examples for how to optimize queries

Common keywords: `EXPLAIN`, `ANALYZE`, `BTREE`, `GIN`, `HASH`, `UNIQUE`, `INDEX`

## Data Pages

- Every **table**, **index**, or **TOAST** object consists of a series of these pages stored in heap files.
- PostgreSQL performs I/O in page units, not per row.

### Internal structure of a PostgreSQL page

Each 8KB page includes:

1. **Page Header** — Information like LSN (Log Sequence Number), checksums, and visibility.
2. **Item Identifiers** — Offsets/pointers to row data.
3. **Tuples (Rows)** — The actual rows inserted.
4. **Free space** — Leftover space used for updates/inserts to avoid moving rows around.

### Performance Implications

- Queries read data one **page at a time**. A sequential scan may read many pages in order, while an index scan might jump around.
- **HOT updates** (Heap-Only Tuples): Optimize updates by keeping modified versions within the same page.
- **VACUUM** and **autovacuum** reclaim dead tuples but also aim to reuse free space in pages.

### Indexes also use pages

- B-Tree, Hash, GIN, GiST indexes all use pages.
- **Index pages** come in types: internal (tree nodes) and leaf (actual pointers to heap tuples).

## Content of this section

- **indexes**
- **performance**
