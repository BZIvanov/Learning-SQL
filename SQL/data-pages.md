# Data Pages

## What are Data Pages?

In relational database systems (like SQL Server, PostgreSQL, Oracle, MySQL), **data pages** (sometimes called blocks or disk pages) are the **fundamental unit of storage**.

- **Definition**: A data page is a fixed-size chunk of disk space used to store rows of a table or index entries.
- **Size**: Varies by database system — for example:
  - PostgreSQL: 8 KB (default)
  - MySQL (InnoDB): Configurable

## Why use Data Pages?

- Disk I/O is expensive. Databases read/write **entire pages**, not individual rows, to optimize performance.
- Helps manage **buffer caches, locking, and concurrency** efficiently.
- All row operations (inserts, updates, deletes, selects) ultimately interact with these pages.

## Page Structure (in general terms)

A typical data page contains:

- **Header**: Metadata (e.g., page ID, version info).
- **Row directory**: Pointers to row locations in the page.
- **Row data**: The actual stored tuples (records).
- **Free space**: Space reserved for updates or inserts.
