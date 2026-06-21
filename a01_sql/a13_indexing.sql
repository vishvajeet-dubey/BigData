/*
# IDEXING IN POSTGRES
- Indexing is a technique used to speed up data retrieval from table.  
Think of an index like the index at the back of a textbook:
- **Without an index**: PostgresSQl scans every row in a table (sequential/full scan)
- **With an index** - PostgresSQL can jump directly to the matching row much faster.

# Common Type of indexes in PostgresSQL
1. B-Tree Index(default)
- Most commonly used.
- Good for 
	- =
	- <, >
	- ORDER BY
```sql
CREATE INDEX idx_age
ON users(age);
```

2. Hash Index
- Optimized for equality comparisons
```sql
CREATE INDEX idx_email_hash
ON users USING HASH(email);
```

3. GIN Index
- Generalized Inverted Index
- Used for 
	- JSONB
	- Arrays
	- full text search
```sql
CREATE INDEX idx_data
ON products USING GIN(tags);
```

4. GiST Index
- Generalized Search Tree
- Used for 
	- geometric data
	- network address
	- range type

# Benefits of Indexing
- Faster `SELECT` queries
- Faster searching and sorting
- Improves joins

# Drawbacks
- Indexes are not free: 
	- Take extra disk space
	- slow down `INSERT`, `UPDATE`, `DELETE` because indexes must also be updated.

# Best Practice
- Index columns that are:
	- Frequently searched
	- Used for `WHERE`
	- Used for `JOIN`
	- Used for `ORDER BY`

# Avoid Indexing:
- very small tables
- columns with low uniqueness
- Every column unnecessarily
*/


-- CREATING INDEXING IN EMPLOYEE TABLE BASED ON EMP ID
CREATE INDEX inx_employee_empId on test.employee using BTREE(emp_id);

SELECT * FROM test.employee where emp_id>10;

