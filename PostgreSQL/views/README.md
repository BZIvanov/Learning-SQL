# Views

- A `VIEW` is a **virtual table** that represents the result of a SQL query.
- The view itself **does not store data**; the underlying query is executed **each time** the view is used.
- In **pgAdmin**, you can find your views under: `Schemas → public → Views`

## Types of Views

- **VIEW**:

  - Non-materialized (virtual)
  - Always reflects the latest data from base tables
  - Can be used like a table in `SELECT`, `JOIN`, etc.

- **MATERIALIZED VIEW**:
  - Stores the result of the query physically
  - Must be **refreshed manually or on schedule** to update
  - Useful for performance when working with expensive queries

## Use Cases

- **Simplifying complex queries**  
  Abstract joins, filters, or calculations behind a readable interface.

- **Data security and access control**  
  Expose only specific columns or rows (e.g., omit salaries or sensitive info).

- **Logical data separation**  
  Represent subsets of data (e.g., `active_users_view`, `top_customers_view`).

- **Report building**  
  Reuse common queries for analytics without repeating logic in every report.

- **Performance (materialized views only)**  
  Precompute and store results for expensive queries, improving read performance.

## Content of this section

- **view**
- **materialized-view**
