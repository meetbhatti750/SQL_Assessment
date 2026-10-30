**Answer:**

A database index is a data structure that helps the database find records faster without scanning the entire table.

**1. How does an index improve query performance?**

* It speeds up searching and finding matching rows.
* It makes JOIN operations faster by helping the database locate matching records.
* It can reduce the number of rows the database needs to scan before performing GROUP BY.
* It can reduce query execution time when the database can use the index effectively.

**2. Can adding an index hurt performance?**

Yes. Too many indexes can slow down INSERT, UPDATE, and DELETE operations because the database must also maintain the indexes. Indexes also consume additional storage space.

**3. What trade-off should be considered?**

Before indexing every column, we must balance **read performance against write performance and storage costs**. We should identify frequently used JOIN, WHERE, and GROUP BY columns and create indexes where they provide measurable benefits.

**Conclusion:** An appropriate index can significantly improve query performance, but indexes should be selected carefully to balance speed, storage, and data modification costs.