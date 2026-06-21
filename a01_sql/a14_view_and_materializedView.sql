/*
In PostgreSQL, a view is **a virtual table representing the result of a predefined SQL query**. It does not store physical data itself, but dynamically fetches data from the underlying tables whenever you query it.

PostgreSQL supports four main types of views.
## Types of Views

## 1. Standard Views (Regular Views)

- Definition: A virtual table created using a `SELECT` statement.
- Storage: Stores only the query definition, not the actual data.
- Performance: Re-runs the underlying query every time the view is called.
- Syntax:
 
```sql
CREATE VIEW active_users AS 
SELECT id, name FROM users WHERE status = 'active';
```

## 2. Updatable Views

- Definition: A standard view that allows you to run `INSERT`, `UPDATE`, and `DELETE` operations directly on it. 
- **Rules:**
    - Must reference exactly one table or updatable view in the `FROM` clause.
    - Cannot contain `GROUP BY`, `HAVING`, `LIMIT`, `OFFSET`, `DISTINCT`, `WITH`, `UNION`, `INTERSECT`, or `EXCEPT` at the top level. 

- Function: PostgreSQL automatically passes the data modifications down to the base table. 

## 3. Materialized Views

- Definition: A view that physically stores the query result on disk like a real table.
- Performance: Fast to query because data is pre-computed, making it ideal for heavy aggregations or complex joins.
- Data Freshness: Data becomes stale when the base tables change. You must manually refresh it.
- Syntax:
 
```sql
CREATE MATERIALIZED VIEW sales_summary AS 
SELECT region, SUM(amount) FROM sales GROUP BY region;
    
-- To update the data:
REFRESH MATERIALIZED VIEW sales_summary;
```

## 4. Recursive Views

- Definition: A specialized view that references itself to handle hierarchical or tree-structured data.
- Use Case: Ideal for querying organizational charts, family trees, or network routing paths.
- Syntax: Built using the `CREATE RECURSIVE VIEW` syntax, which internally uses a `WITH RECURSIVE` common table expression (CTE).

*/


-- 1. Departments and Employees (Hierarchical Data)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT REFERENCES employees(employee_id)
);

-- 2. Products and Sales (Transactional Data)
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price NUMERIC(10,2),
    is_discontinued BOOLEAN DEFAULT FALSE
);

CREATE TABLE sales_transactions (
    transaction_id INT PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity_sold INT,
    sale_date DATE
);

-- Insert Sample Data
INSERT INTO employees VALUES 
(1, 'Alice (CEO)', NULL),
(2, 'Bob (VP of Sales)', 1),
(3, 'Charlie (Sales Manager)', 2),
(4, 'David (Sales Rep)', 3);

INSERT INTO products VALUES 
(101, 'Wireless Mouse', 25.00, FALSE),
(102, 'Mechanical Keyboard', 80.00, FALSE),
(103, 'Old Laptop Stand', 45.00, TRUE);

INSERT INTO sales_transactions VALUES 
(1, 101, 10, '2026-06-18'),
(2, 102, 5, '2026-06-19'),
(3, 101, 2, '2026-06-20');

/*
Problem 1: Standard View

Problem: The frontend application needs a clean list of products that are active and available for sale. It should not see discontinued items.

Solution: Create a standard view to filter out discontinued items dynamically.
*/

create view active_product as
select product_id, product_name, price
from products where is_discontinued=False;

select * from active_product;


/*
Problem 2: Updatable View

Problem: Inventory managers want to change product prices, but you want to restrict them from modifying sensitive internal flags like is_discontinued.

Solution: Expose only the price and name fields through an updatable view. Updating the view updates the base table.
*/

create view updatable_view as
select product_id, product_name, price 
from products;

select * from updatable_view;
select * from products;

update updatable_view
set price = 200.00
where product_id=101;

-- # RULES:
--     - Must reference exactly one table or updatable view in the `FROM` clause.
--     - Cannot contain `GROUP BY`, `HAVING`, `LIMIT`, `OFFSET`, `DISTINCT`, `WITH`, `UNION`, `INTERSECT`, or `EXCEPT` at the top level. 


/*
Problem 3: Materialized View

Problem: Your sales reporting dashboard is running slow because it calculates total revenue by joining large tables and performing math operations on every page load.

Solution: Pre-compute and cache the sales data using a Materialized View to get instant query speeds.
*/

create MATERIALIZED VIEW mv_sales_performance as
select p.product_name, 
sum(st.quantity_sold) as total_unit_Sold,
sum(st.quantity_sold * p.price) as total_revenue
from sales_transactions st
join products p on st.product_id = p.product_id
group by p.product_id;


select * from mv_sales_performance;

-- now if you want to insert or delete the data int product table the view will automatically not refresh. we have to do it manually as it is materiliased view.

update products
set price = 200.00
where product_id=101;

select * from mv_sales_performance; -- no changes in revenue. we need to refresh it manually

REFRESH MATERIALIZED VIEW mv_sales_performance;

select * from mv_sales_performance; -- changes is now reflecting after refresh


/*
Problem 4: Recursive View

Problem: HR needs to generate a report showing the complete reporting hierarchy (the management chain) for David (Sales Rep), showing who reports to whom up to the CEO.

Solution: Use a recursive view to walk up or down the organizational tree structure.
*/

-- Create the Recursive View
CREATE RECURSIVE VIEW org_hierarchy(employee_id, name, manager_id, management_level) AS (
    -- Anchor Member: Start with the top manager (CEO)
    SELECT employee_id, name, manager_id, 1
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive Member: Join the table back to the view to find direct reports
    SELECT e.employee_id, e.name, e.manager_id, oh.management_level + 1
    FROM employees e
    JOIN org_hierarchy oh ON e.manager_id = oh.employee_id
);

-- Test the View to see the full chain
SELECT * FROM org_hierarchy ORDER BY management_level;
