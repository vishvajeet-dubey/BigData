-- crate schema
create schema if not exists test;

-- DDL
CREATE TABLE test.orders (
    order_id      INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    product       VARCHAR(100),
    category      VARCHAR(50),
    amount        NUMERIC(10,2),
    order_date    DATE,
    region        VARCHAR(20),
    salesperson   VARCHAR(50)
);

--  INSERT SAMPLE RECORDS
INSERT INTO test.orders
(order_id, customer_name, product, category, amount, order_date, region, salesperson)
VALUES
(1001, 'Alice Johnson', 'Laptop', 'Electronics', 1250.50, '2026-01-05', 'East', 'Omar Siddiqui'),
(1002, 'Bob Smith', 'Keyboard', 'Electronics', 150.00, '2026-01-07', 'West', 'Priya Sharma'),
(1003, 'Charlie Brown', 'Office Chair', 'Furniture', 450.75, '2026-01-10', 'North', 'Nina Patel'),
(1004, 'David Miller', 'Laptop', 'Electronics', 1350.00, '2026-01-12', 'East', 'Omar Siddiqui'),
(1005, 'Emma Wilson', 'Desk', 'Furniture', 650.25, '2026-01-15', 'South', 'Rahul Verma'),

(1006, 'Frank Moore', 'Monitor', 'Electronics', 375.50, '2026-01-18', 'West', 'Priya Sharma'),
(1007, 'Grace Osei', 'Bluetooth Speaker', 'Premium Electronics', 159.30, '2026-02-02', 'East', 'Quentin Adams'),
(1008, 'Henry Davis', 'Desk', 'Furniture', 700.00, '2026-02-05', 'South', 'Rahul Verma'),
(1009, 'Irene Taylor', 'Headphones', 'Electronics', 210.99, '2026-02-07', 'North', 'Nina Patel'),
(1010, 'Jack Turner', 'Laptop', 'Electronics', 1450.00, '2026-02-15', 'East', 'Omar Siddiqui'),

(1011, 'Farhan Ali', 'Bluetooth Speaker', 'Premium Electronics', 152.38, '2026-02-10', 'West', 'Priya Sharma'),
(1012, 'Isabel Rossi', 'Webcam', 'Premium Electronics', 150.24, '2026-05-07', 'North', 'Nina Patel'),
(1013, 'Kevin Lee', 'Monitor', 'Electronics', 375.50, '2026-02-20', 'West', 'Priya Sharma'),
(1014, 'Laura Garcia', 'Office Chair', 'Furniture', 500.00, '2026-02-22', 'South', 'Rahul Verma'),
(1015, 'Mike Anderson', 'Laptop', 'Electronics', 1450.00, '2026-02-25', 'East', 'Omar Siddiqui'),

(1016, 'Nancy Thomas', 'Keyboard', 'Electronics', 150.00, '2026-03-01', 'North', 'Quentin Adams'),
(1017, 'Oliver White', 'Desk', 'Furniture', 720.50, '2026-03-05', 'South', 'Rahul Verma'),
(1018, 'Pam Harris', 'Headphones', 'Electronics', 225.75, '2026-03-08', 'East', 'Omar Siddiqui'),
(1019, 'Quentin Martin', 'Laptop', 'Electronics', 1600.00, '2026-03-12', 'West', 'Priya Sharma'),
(1020, 'Brian Lopez', 'Bluetooth Speaker', 'Premium Electronics', 161.09, '2026-03-17', 'North', 'Quentin Adams'),

(1021, 'Rachel Clark', 'Monitor', 'Electronics', 400.00, '2026-03-20', 'East', 'Omar Siddiqui'),
(1022, 'Sam Lewis', 'Office Chair', 'Furniture', 475.25, '2026-03-22', 'South', 'Rahul Verma'),
(1023, 'Tina Walker', 'Laptop', 'Electronics', 1550.00, '2026-03-25', 'West', 'Priya Sharma'),
(1024, 'Uma Hall', 'Webcam', 'Premium Electronics', 175.50, '2026-04-01', 'North', 'Nina Patel'),
(1025, 'Victor Allen', 'Desk', 'Furniture', 680.00, '2026-04-05', 'South', 'Rahul Verma'),

(1026, 'Wendy Young', 'Headphones', 'Electronics', 230.00, '2026-04-08', 'East', 'Omar Siddiqui'),
(1027, 'Xavier King', 'Laptop', 'Electronics', 1700.00, '2026-04-12', 'West', 'Priya Sharma'),
(1028, 'Yara Wright', 'Bluetooth Speaker', 'Premium Electronics', 145.75, '2026-04-15', 'North', 'Quentin Adams'),
(1029, 'Zack Scott', 'Monitor', 'Electronics', 425.00, '2026-04-20', 'East', 'Omar Siddiqui'),
(1030, 'Alice Johnson', 'Keyboard', 'Electronics', 175.00, '2026-04-25', 'East', 'Omar Siddiqui');


-- ==========================================================================================================
-- TRICK 1 - OFFSET
-- PROBLEM - Return the nth highest value without using window function or subquery
-- ==========================================================================================================
select * from test.orders;

-- find the 2nd highest amount
select * from test.orders order by amount desc OFFSET 1 limit 1;
-- offset 1 -> skipped 1 (one record got skipped)
-- records are already sorted from higthest to lowest so limit 1 return the 2nd highest one.



select * from test.orders order by amount desc; -- total records 30

-- offset 10 - skip first 10 records from output
select * from test.orders order by amount desc offset 10; -- total records 20


 

 -- ==========================================================================================================
-- TRICK 2 - DISTINCT ON
-- It returns one row per unique group.
-- It keeps the first row according to ORDER BY.
-- ORDER BY is therefore extremely important.
-- The DISTINCT ON columns must appear as the leftmost columns of ORDER BY.
-- PROBLEM - Return one row per group without using window functions
-- ==========================================================================================================


-- first the first customer name who purchage the product.
 select distinct on(product) 
 customer_name, order_date, product, amount
 from test.orders
 order by product, order_date DESC;




-- ==========================================================================================================
-- TRICK 3 - RETURNING
-- Return the modified data from DML operation
-- Retrieve data from rows modified by an INSERT, UPDATE, DELETE, or MERGE statement
-- ==========================================================================================================
 select * from test.orders;

-- return all records where update done
 update test.orders 
 set category='Premium Electronics'
 where product='Laptop'
 returning order_id, customer_name, product, category, amount, order_date;




-- ==========================================================================================================
-- TRICK 4: GENERATE SERIES
-- It generate series
-- PROBLEM - return the date with no order
-- ==========================================================================================================
select * from test.orders;


-- generating the date series
with date_series as (
    select generate_series('2026-01-01'::DATE, '2026-01-31'::DATE, '1 day':: INTERVAL) :: date as cal_date
)
select cal_date from test.orders o
RIGHT JOIN date_series ds 
on o.order_date = ds.cal_date
where o.order_date is null;
