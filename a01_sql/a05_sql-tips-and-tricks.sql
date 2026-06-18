-- CREATING THE TEMP TABLE
CREATE TEMP TABLE emp_compensation AS
SELECT *
FROM (
    VALUES
        (1, 'salary', 10000),
        (1, 'bonus', 5000),
        (1, 'hike_percent', 10),
        (2, 'salary', 15000),
        (2, 'bonus', 7000),
        (2, 'hike_percent', 8),
        (3, 'salary', 12000),
        (3, 'bonus', 6000),
        (3, 'hike_percent', 7)
) AS t(emp_id, salary_component_type, val);

SELECT * FROM emp_compensation;


-- PIVOTING(ROW TO COLUMN)
select
emp_id,
sum(case when salary_component_type='salary' then val end) as salary,
sum(case when salary_component_type='bonus' then val end) as bonus,
sum(case when salary_component_type='hike_percent' then val end) as hike_percentage
from emp_compensation
group by emp_id;




-- CREATING PIVOT TABLE USING ABOVE QUERY
create temp table emp_compensation_pivot as 
select
emp_id,
sum(case when salary_component_type='salary' then val end) as salary,
sum(case when salary_component_type='bonus' then val end) as bonus,
sum(case when salary_component_type='hike_percent' then val end) as hike_percentage
from emp_compensation
group by emp_id;

select * from emp_compensation_pivot;


-- UNPIVOTING => converting column to row
select emp_id, 'salary' as salary_component_type, salary as val	from emp_compensation_pivot
union all
select emp_id, 'bonus' as salary_component_type, bonus as val	from emp_compensation_pivot
union all
select emp_id, 'hike_percentage' as salary_component_type, hike_percentage as val	from emp_compensation_pivot;
--**********************--









-- TOP 10 SQL INTERVIEW QUESTIONS
-- Create the temporary table
CREATE TEMP TABLE temp_employees (
    emp_id INTEGER,
    emp_name VARCHAR(100),
    department_id INTEGER,
    salary INTEGER,
    manager_id INTEGER
);

-- Insert the records
INSERT INTO temp_employees (emp_id, emp_name, department_id, salary, manager_id)
VALUES 
    (1, 'Ankit', 100, 10000, 4),
    (2, 'Mohit', 100, 15000, 5),
    (3, 'Vikas', 100, 10000, 4),
    (4, 'Rohit', 100, 5000, 2),
    (5, 'Mudit', 200, 12000, 6),
    (6, 'Agam', 200, 12000, 2),
    (7, 'Sanjay', 200, 9000, 2),
    (8, 'Ashish', 200, 5000, 2),
    (1, 'Saurabh', 900, 12000, 2);

-- Verify the data
SELECT * FROM temp_employees;

-- creating dept table
create temp table temp_dept as
select * from
(values(100, 'Analitics'),
(300, 'It')
) as t(dept_id, dept_name);

-- varify the records
select * from temp_dept;

-- create order table
create temp table orders as 
select * from 
(VALUES
('Shilpa', '2020-01-01', 10000, 'Male'),
('Rahul',  '2020-01-02', 12000, 'Female'),
('SHILPA', '2020-01-02', 12000, 'Male'),
('Rohit',  '2020-01-03', 15000, 'Female'),
('shilpa', '2020-01-03', 14000, 'Male'))
as t(customer_name, order_date, order_amount, customer_gender);


-- QUE01: HOW TO FIND THE DUPLICATE IN THE GIVEN TABLE
-- finding the duplicate based on the emp_id column
select count(*), emp_id
from temp_employees
group by emp_id
having count(*)>1;


-- QUE02: How to delete the duplicate
-- step 1: take backup
create table temp_emp_bkp as select * from temp_employees;
-- step 2: truncate the main table
truncate table temp_employees;
-- step 3: insert the unique records from backup table
with cte as(select *, 
			row_number() over(partition by emp_id order by emp_id) as rn 
			from temp_emp_bkp)
insert into temp_employees
select  emp_id, emp_name, department_id, salary, manager_id from cte where rn=1;

-- testing
select * from temp_employees

--QUE03: Diff between union and union all
--* **UNION**
--  * Combines the result sets of two or more `SELECT` queries.
--  * Removes duplicate rows from the final result.
--  * Internally performs a distinct operation, so it is comparatively slower.
--  * Use when you want only unique records in the output.

select * from temp_employees
union 
select * from temp_emp_bkp;

--* **UNION ALL**
--  * Combines the result sets of two or more `SELECT` queries.
--  * Keeps all rows, including duplicates.
--  * Faster than `UNION` because it does not remove duplicates.
--  * Use when duplicates are acceptable or when performance is important.

select * from temp_employees
union all
select * from temp_emp_bkp;

--**Common points**
--* Each `SELECT` must have the same number of columns.
--* Corresponding columns must have compatible data types.
--* Column names in the result come from the first `SELECT`.



--QUE04: Diff between row_number, rank and dens_rank


--QUE05: employees who are not present in department table
-- option01:
select * from temp_employees emp where department_id not in (select dept_id from temp_dept);

--option02: using left join - mostly asked in interview
select emp.* from temp_employees emp
left join temp_dept dept
on emp.department_id=dept.dept_id
where dept.dept_id is null;


--QUE06: second highest salary in each dept
with cte as (select *,
dense_rank() over(partition by department_id order by salary desc) as rn
from temp_employees)
select * from cte where rn=2;


--QUE07: find all transaction done by Shilpa
select * from orders where upper(customer_name)='SHILPA';


--QUE08: find all emp whose salary is greater than manager salary
select emp.* from temp_employees emp
left join temp_employees mgr on emp.manager_id=mgr.emp_id
where emp.salary>mgr.salary;


--QUE09: all join and its diff


--QUE10: update query to swap gender
-- select statement
select customer_name,
order_date,
order_amount,
case 
	when(lower(customer_gender)='male') then 'Female'
	when(lower(customer_gender)='female') then 'Male' end as gender
from orders;

-- update statement with case when clause(as if we will just update everything will be same either male or female so we need to use case when)
update orders
set customer_gender=(case when(lower(customer_gender)='male') then 'Female'
	when(lower(customer_gender)='female') then 'Male' end)

-- varify the records
select * from orders;
--**********************--










-- CROSS JOIN
-- * A CROSS JOIN returns the Cartesian product of two tables.
-- * Each row from the first table is combined with every row from the second table.
-- * No join condition is used.

-- 1. Create the Products table
CREATE temp TABLE if not exists products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

-- 2. Create the Stores table
CREATE temp TABLE if not exists  stores (
    store_id INT PRIMARY KEY,
    location VARCHAR(50)
);

-- 3. Create the Inventory table (Only logs existing stock)
CREATE temp TABLE if not exists  inventory (
    product_id INT,
    store_id INT,
    quantity INT,
    PRIMARY KEY (product_id, store_id)
);

-- Insert Data
INSERT INTO products VALUES 
(1, 'Laptop'),
(2, 'Mouse'),
(3, 'Keyboard');

INSERT INTO stores VALUES 
(101, 'New York'),
(102, 'London');

-- Note: Not every product is in every store!
INSERT INTO inventory VALUES 
(1, 101, 50), -- Laptop in NY
(2, 101, 20), -- Mouse in NY
(2, 102, 30), -- Mouse in London
(3, 102, 15); -- Keyboard in London

/*
Write a query that returns:
	* store_location
	* product_name
	* stock_quantity
Requirements:
	* The result must include 6 rows (3 Products × 2 Stores).
	* If the product is not found in the inventory table for that store, the stock_quantity should display 0 (not NULL).
*/
select * from products;
select * from stores;
select * from inventory;

-- solution
select
	s.location as store_location,
	p.product_name,
	coalesce(inv.quantity, 0) as store_quantity
from
	products p
cross join stores s
left join inventory inv on
	p.product_id = inv.product_id
	and s.store_id = inv.store_id;
--**********************--










--MOST ASKED SQL JOIN BASED INTERVIEW QUESTION
-- creating table t01
create temp table t01 as
select * from
(values
(1),
(1),
(null)
)as t(id);


-- creating table t02
create temp table t02 as
select * from
(values
(1),
(1),
(1),
(2),
(null)
) as t(id);


--varify the data 
select * from t01;
select * from t02;

--QUES01: what is the output of inner join (6 records)
select * from t01
inner join t02 on t01.id=t02.id;
-- got 6 records - matching from both table. Note: null in sql is unique value so it is not going to join.


--QUES02: what is the output of left join (6+1)
select * from t01
left join t02 on t01.id=t02.id;

--QUES03: what is the output of right join (6+2)
select * from t01
right join t02 on t01.id=t02.id;

--QUES04: what is the output of cross join (3*5)
select * from t01
cross join t02;

--QUES04: what is the output of full join (6+1+2)
select * from t01
full join t02 on t01.id=t02.id;
--**********************--









--How to Calculate Mode in SQL | How to Find Most Frequent Value in a column
create temp table mode as 
select * from (values (1),(1),(1),(12),(2),(2),(2),(2),(2),(4),(4),(4),(4),(4),(5),(5),(5),(5),(3),(3),(3),(6))as t(id);

-- varify records
select * from mode;

-- finding mode using subquery
with freq_cte as (select count(*) as freq,id from mode group by id)
select * from freq_cte where freq=(select max(freq) from freq_cte);

--finding using cte and rank
with freq_cte as(select count(*) as freq,id from mode group by id)
, mode_cte as (select *, rank() over(order by freq desc) as rn from freq_cte)
select id, freq from mode_cte where rn=1;










-- SQL Interview Question Based on Full Outer Join
/* Full outer join
 * 	- Union of the left and right join.
 *	- It includes the Inner Join results (matching rows), plus all rows from the left table with NULLs for the right-side columns, and all rows from the right table with NULLs for the left-side columns.
 */

-- creating the emp_2020 table
create temp table emp_2020 as
select * from(
	VALUES 
    (1, 'Trainee'),
    (2, 'Developer'),
    (3, 'Senior Developer'),
    (4, 'Manager')) as col(emp_id, designation);
   
-- creating the emp_2021 table
create temp table emp_2021 as
select * from(
	VALUES 
    (1, 'Developer'),
    (2, 'Developer'),
    (3, 'Manager'),
    (5, 'Trainee')) as col(emp_id, designation);

select * from emp_2020;
select * from emp_2021;

--Que: Return the employees whose designation has changed. 
--If the designation remains the same, do not return the record. 
--If an employee is present in the current table but missing from the next year's table, return their status as 'Resigned'.

select coalesce(e21.emp_id, e20.emp_id) as emp_id, coalesce(e21.designation, e20.designation) as current_designation,
case when e20.designation<>e21.designation then 'Promoted'
when(e21.designation is null) then 'Resigned'
when(e20.designation is null) then 'New'
end as Status
from emp_2020 e20
full outer join emp_2021 e21
on e20.emp_id=e21.emp_id
where coalesce(e20.designation,'x')<>coalesce(e21.designation, 'y');















-- SQL Challenge: Identifying and Labeling Duplicates

-- Scenario: 
--		You are given a table named List with a single column id. Some IDs appear multiple times (duplicates), while others appear only once (unique).
-- The Goal: 
--		Write a query to generate an output that:
--		1. Identifies groups of duplicate IDs.
--		2. Assigns a label to each duplicate group in the format 'DUP' + a sequential number (e.g., the first set of duplicates found is DUP1, the second is DUP2).
--		3. Returns NULL for any ID that appears only once in the table.
--		4. Ensures the row count of the output matches the row count of the input (keep all original rows).

create temp table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');

select * from list;

-- solution
with dups as(select count(*), id from list group by id having count(*)>1)
, dups_rank as(select *, rank() over(order by id asc)  as rn from dups)
select l.id as input,
case when (dr.rn is not null) then 'DUP' || dr.rn end as output
from list l
left join dups_rank dr
on l.id=dr.id;














-- MASTER UPDATE STATEMENT
--------------------------------------------
-- emp temp(only for session)
-- drop table if exists emp;
CREATE TEMP TABLE emp AS
SELECT * FROM (
    VALUES 
        (1, 'Ankit', 100, 10000, 4, 39),
        (2, 'Mohit', 100, 15000, 5, 48),
        (3, 'Vikas', 100, 10000, 4, 37),
        (4, 'Rohit', 100, 5000, 2, 16),
        (5, 'Mudit', 200, 12000, 6, 55),
        (6, 'Agam', 200, 12000, 2, 14),
        (7, 'Sanjay', 200, 9000, 2, 13),
        (8, 'Ashish', 200, 5000, 2, 12),
        (9, 'Mukesh', 300, 6000, 6, 51),
        (10, 'Rakesh', 300, 7000, 6, 50),
        (11, 'Akhil', 500, 3000, 1, 31)
) AS t(emp_id, emp_name, dept_id, salary, manager_id, emp_age);

-- dept temp table(only for session)
create temporary table dept as
select * from (
VALUES 
    (100, 'Analytics'),
    (200, 'IT'),
    (300, 'HR'),
    (400, 'Text Analytics')) as t(dept_id, dept_name);

-- Verify the data
select * from emp;
SELECT * FROM dept;

-- update syntax for single value update
update emp set salary=1200; -- this will update everything to 1200

-- update with where clause
update emp set salary=12000 where emp_age>30;

-- update the multiple value
update emp set salary=12000, dept_id=200 where emp_id=2;

-- update column with constant value and derivations(col calculation/case when)
update emp set salary=salary*1.1; -- incrementing salary by 10%

-- udpate using case when condition
update emp
set salary=case when dept_id=100 then salary*1.1 
when dept_id=200 then salary*1.2 else salary end;

-- ading column dept_name in the emp table
alter table emp add dept_name varchar(20);

-- update using join(will not work in postgres)
update emp
set dept_name=d.dept_name
from emp e
inner join dept d on e.dept_id=d.dept_id;

-- update using join(for postgres)
update emp
set dept_name=dept.dept_name
from dept where emp.dept_id=dept.dept_id;

-- add the column called gender;
alter table emp add gender varchar(20);
update emp set gender = case when dept_id=100 then 'male' else 'female' end;

-- swap the gender(if we will swap using where condition eveything will be the same gender)
update emp set gender = case when gender='male' then 'female' else 'male' end;











-- Slowly Changing Dimensions IN Data warehousing
---------------------------------------------------











-- Difference Between SQL View vs Materialized Views
/* 
Features                | Normal View                                       | Materialized View
1. Storage              | Does not store data physically                    | Stores data physically
2. Data Freshness       | Always up to date                                 | can become stale; require refresh
3. Performance          | Slower for complex queries, Depends on base table | faster for read operations; data is precomputed
4. Usage                | Simplifies complex queries provides abstraction   | Improves performance for expensive queries, stores aggregate data
5. Refresh              | No refresh needed                                 | Needed manual query or automatic refresh
6. Data Access          | Fatches data dynamically from base table          | Refresh precomputed data.

What is View:
* A view in a database is a virtual table that is based on the result set of an SQL query.
* View are used to simplify complex queries, enhance security, and present data in a specifc format.
*/

-- creating normal view
-- create schema if not exists test;

create table test.products as
SELECT * FROM (VALUES
        (1, 'Laptop', 1200.00, 'Electronics'),
        (2, 'Mouse', 25.00, 'Electronics'),
        (3, 'Keyboard', 45.00, 'Electronics'),
        (4, 'Monitor', 200.00, 'Electronics'),
        (5, 'Desk Chair', 150.00, 'Furniture'),
        (6, 'Desk Lamp', 30.00, 'Furniture'),
        (7, 'Notebook', 5.00, 'Stationery'),
        (8, 'Pen Set', 12.00, 'Stationery')
    ) AS p(product_id, product_name, price, category);
    

create table test.orders as
SELECT * FROM (VALUES
        (101, 1, '2026-01-01', 1),
        (102, 2, '2026-01-02', 3),
        (103, 3, '2026-01-02', 1),
        (104, 1, '2026-01-03', 1),
        (105, 5, '2026-01-04', 2),
        (106, 2, '2026-01-05', 10),
        (107, 4, '2026-01-05', 1),
        (108, 8, '2026-01-06', 5),
        (109, 7, '2026-01-07', 2),
        (110, 1, '2026-01-08', 1),
        (111, 6, '2026-01-08', 1),
        (112, 2, '2026-01-09', 4),
        (113, 3, '2026-01-10', 2),
        (114, 5, '2026-01-10', 1),
        (115, 4, '2026-01-11', 2),
        (116, 1, '2026-01-12', 1),
        (117, 8, '2026-01-13', 1),
        (118, 7, '2026-01-14', 10),
        (119, 2, '2026-01-15', 2),
        (120, 5, '2026-01-15', 1)
    ) AS o(order_id, product_id, order_date, quantity);
    

select * from test.orders;
select * from test.products;


-- creating view on total sales as per date on category.
create view test.total_sales_view as 
select sum(p.price*o.quantity) as total_sales, p.category, o.order_date from test.orders o
left join test.products p on o.product_id=p.product_id
group by  p.category, o.order_date order by o.order_date desc;


-- validating the view
select * from test.total_sales_view;


-- if i will add the data in orders table then view will automatically update since it is pointing the table directly.
insert into test.orders 
values(121, 5, '2026-01-16', 5);


-- we could see the 16th dated orders in the view
select * from test.total_sales_view;


-- creating the materialized view using the same query.
create materialized view test.total_sales_mat_view as 
select sum(p.price*o.quantity) as total_sales, p.category, o.order_date from test.orders o
left join test.products p on o.product_id=p.product_id
group by  p.category, o.order_date order by o.order_date desc;


-- varifing the materialized view
select * from test.total_sales_mat_view;


-- lets suppose next day some customer orders the product. as we see above normal view will auto refresh and show that records but materialized view will not return until we refresh the view
-- since it storing the data.
insert into test.orders 
values(121, 5, '2026-01-17', 2);

-- materialized view
select * from test.total_sales_mat_view;

-- normal view
select * from test.total_sales_view;

-- so we can see the materialized view is not refreshing automatically we have to do it in order to see the latest data.
refresh materialized view test.total_sales_mat_view;

-- now if we select the mat view it will show the new added 17th dated records.
select * from test.total_sales_mat_view;


-- other way to create the materialized view (creating without data - it will not return any reocrds until refresh.)
-- drop materialized view test.total_sales_mat_view;
create materialized view test.total_sales_mat_view as 
select sum(p.price*o.quantity) as total_sales, p.category, o.order_date from test.orders o
left join test.products p on o.product_id=p.product_id
group by  p.category, o.order_date order by o.order_date desc
with no data;

-- now it i will try to fetch the view it will not show any records
select * from test.total_sales_mat_view;
refresh materialized view test.total_sales_mat_view;
select * from test.total_sales_mat_view;

-- Note: By defual the materialized view created with data.













-- custom sort tricks
CREATE TABLE test.hapiness_index (
    rank BIGINT,
    country VARCHAR(100),
    happiness_2021 VARCHAR(100),
    happiness_2020 VARCHAR(100),
    population_2022 VARCHAR(100)
);


INSERT INTO test.hapiness_index
(rank, country, happiness_2021, happiness_2020, population_2022)
VALUES
(1,'Finland','7.842','7.809','5554960'),
(2,'Denmark','7.62','7.646','5834950'),
(3,'Switzerland','7.571','7.56','8773637'),
(4,'Iceland','7.554','7.504','345393'),
(5,'Netherlands','7.464','7.449','17211447'),
(6,'Norway','7.392','7.488','5511370'),
(7,'Sweden','7.363','7.353','10218971'),
(8,'Luxembourg','7.324','7.238','642371'),
(9,'New Zealand','7.277','7.3','4898203'),
(10,'Austria','7.268','7.294','9066710'),
(11,'Australia','7.183','7.223','26068792'),
(12,'Israel','7.157','7.129','8922892'),
(13,'Germany','7.155','7.076','83883596'),
(14,'Canada','7.103','7.232','38388419'),
(15,'Ireland','7.085','7.129','5020199'),
(16,'Costa Rica','7.069','7.121','5182354'),
(17,'United Kingdom','7.064','7.165','68497907'),
(18,'Czech Republic','6.965','6.911','10736784'),
(19,'United States','6.951','6.94','334805269'),
(20,'Belgium','6.834','6.864','11668278'),
(21,'France','6.69','6.664','65584518'),
(22,'Bahrain','6.647','6.227','1783983'),
(23,'Malta','6.602','6.773','444033'),
(24,'Taiwan','6.584','6.455','23888595'),
(25,'United Arab Emirates','6.561','6.791','10081785'),
(26,'Saudi Arabia','6.494','6.406','35844909'),
(27,'Spain','6.491','6.401','46719142'),
(28,'Italy','6.483','6.387','60262770'),
(29,'Slovenia','6.461','6.363','2078034'),
(30,'Guatemala','6.435','6.399','18584039'),
(31,'Uruguay','6.431','6.44','3496016'),
(32,'Singapore','6.377','6.377','5943546'),
(33,'Slovakia','6.331','6.281','5460193'),
(34,'Brazil','6.33','6.376','215353593'),
(35,'Mexico','6.317','6.465','131562772'),
(36,'Jamaica','6.309','5.89','2985094'),
(37,'Lithuania','6.255','6.215','2661708'),
(38,'Cyprus','6.223','6.159','1223387'),
(39,'Estonia','6.189','6.022','1321910'),
(40,'Panama','6.18','6.305','4446964'),
(41,'Uzbekistan','6.179','6.258','34382084'),
(42,'Chile','6.172','6.228','19250195'),
(43,'Poland','6.166','6.186','37739785'),
(44,'Kazakhstan','6.152','6.058','19205043'),
(45,'Romania','6.14','6.124','19031335'),
(46,'Kuwait','6.106','6.102','4380326'),
(47,'Serbia','6.078','5.778','8653016'),
(48,'El Salvador','6.061','6.348','6550389'),
(49,'Mauritius','6.049','6.101','1274727'),
(50,'Latvia','6.032','5.95','1848837'),
(51,'Colombia','6.012','6.163','51512762'),
(52,'Hungary','5.992','6','9606259'),
(53,'Thailand','5.985','5.999','70078203'),
(54,'Nicaragua','5.972','6.137','6779100'),
(55,'Japan','5.94','5.871','125584838'),
(56,'Argentina','5.929','5.975','46010234'),
(57,'Portugal','5.929','5.911','10140570'),
(58,'Honduras','5.919','5.953','10221247'),
(59,'Croatia','5.882','5.505','4059286'),
(60,'Philippines','5.88','6.006','112508994'),
(61,'South Korea','5.845','5.872','51329899'),
(62,'Peru','5.84','5.797','33684208'),
(63,'Bosnia And Herzegovina','5.813','5.674','3249317'),
(64,'Moldova','5.766','5.608','4013171'),
(65,'Ecuador','5.764','5.925','18113361'),
(66,'Kyrgyzstan','5.744','5.542','6728271'),
(67,'Greece','5.723','5.515','10316637'),
(68,'Bolivia','5.716','5.747','11992656'),
(69,'Mongolia','5.677','5.456','3378078'),
(70,'Paraguay','5.653','5.692','7305843'),
(71,'Montenegro','5.581','5.546','627950'),
(72,'Dominican Republic','5.545','5.689','11056370'),
(73,'Belarus','5.534','5.54','9432800'),
(74,'Russia','5.477','5.546','145805947'),
(75,'Hong Kong','5.477','5.51','7604299'),
(76,'Tajikistan','5.466','5.556','9957464'),
(77,'Vietnam','5.411','5.353','98953541'),
(78,'Libya','5.41','5.489','7040745'),
(79,'Malaysia','5.384','5.384','33181072'),
(80,'Indonesia','5.345','5.286','279134505'),
(81,'Republic of the Congo','5.342','5.194','5797805'),
(82,'China','5.339','5.124','1448471400'),
(83,'Ivory Coast','5.306','5.233','27742298'),
(84,'Armenia','5.283','4.677','2971966'),
(85,'Nepal','5.269','5.137','30225582'),
(86,'Bulgaria','5.266','5.102','6844597'),
(87,'Maldives','5.198','5.198','540985'),
(88,'Azerbaijan','5.171','5.165','10300205'),
(89,'Cameroon','5.142','5.085','27911548'),
(90,'Senegal','5.132','4.981','17653671'),
(91,'Albania','5.117','4.883','2866374'),
(92,'North Macedonia','5.101','5.16','2081304'),
(93,'Ghana','5.088','5.148','32395450'),
(94,'Niger','5.074','4.91','26083660'),
(95,'Turkmenistan','5.066','5.119','6201943'),
(96,'Gambia','5.051','4.751','2558482'),
(97,'Benin','5.045','5.216','12784726'),
(98,'Laos','5.03','4.889','7481023'),
(99,'Bangladesh','5.025','4.833','167885689'),
(100,'Guinea','4.984','4.949','13865691'),
(101,'South Africa','4.956','4.814','60756135'),
(102,'Turkey','4.948','5.132','85561976'),
(103,'Pakistan','4.934','5.693','229488994'),
(104,'Morocco','4.918','5.095','37772756'),
(105,'Venezuela','4.892','5.053','29266991'),
(106,'Georgia','4.891','4.673','3968738'),
(107,'Algeria','4.887','5.005','45350148'),
(108,'Ukraine','4.875','4.561','43192122'),
(109,'Iraq','4.854','4.785','42164965'),
(110,'Gabon','4.852','4.829','2331533'),
(111,'Burkina Faso','4.834','4.769','22102838'),
(112,'Cambodia','4.83','4.848','17168639'),
(113,'Mozambique','4.794','4.624','33089461'),
(114,'Nigeria','4.759','4.724','216746934'),
(115,'Mali','4.723','4.729','21473764'),
(116,'Iran','4.721','4.672','86022837'),
(117,'Uganda','4.636','4.432','48432863'),
(118,'Liberia','4.625','4.558','5305117'),
(119,'Kenya','4.607','4.583','56215221'),
(120,'Tunisia','4.596','4.392','12046656'),
(121,'Lebanon','4.584','4.772','6684849'),
(122,'Namibia','4.574','4.571','2633874'),
(123,'Myanmar','4.426','4.308','55227143'),
(124,'Jordan','4.395','4.633','10300869'),
(125,'Chad','4.355','4.423','17413580'),
(126,'Sri Lanka','4.325','4.327','21575842'),
(127,'Eswatini','4.308','4.308','1184817'),
(128,'Comoros','4.289','4.289','907419'),
(129,'Egypt','4.283','4.151','106156692'),
(130,'Ethiopia','4.275','4.186','120812698'),
(131,'Mauritania','4.227','4.375','4901981'),
(132,'Madagascar','4.208','4.166','29178077'),
(133,'Togo','4.107','4.187','8680837'),
(134,'Zambia','4.073','3.759','19470234'),
(135,'Sierra Leone','3.849','3.926','8306436'),
(136,'India','3.819','3.573','1406631776'),
(137,'Burundi','3.775','3.775','12624840'),
(138,'Yemen','3.658','3.527','31154867'),
(139,'Tanzania','3.623','3.476','63298550'),
(140,'Haiti','3.615','3.721','11680283'),
(141,'Malawi','3.6','3.538','20180839'),
(142,'Lesotho','3.512','3.653','2175699'),
(143,'Botswana','3.467','3.479','2441162'),
(144,'Rwanda','3.415','3.312','13600464'),
(145,'Zimbabwe','3.145','3.299','15331428'),
(146,'Afghanistan','2.523','2.567','40754388');


select * from test.hapiness_index;

--lets we want to sort the neghboring country of india in happiness index and want to show India on top.
select * from(
select *,
case when country='India' then 3
when country='Pakistan' then 2
when country='Sri Lanka' then 1
else 0 end as derived_country
from test.hapiness_index) h_index
order by derived_country desc; 

-- this can be done in where clause also to avoid the subquery
select *
from test.hapiness_index
order by case when country='India' then 3
when country='Pakistan' then 2
when country='Sri Lanka' then 1
else 0 end desc;

-- so inorder to create the custom sort we can use the case when and assign some value to sort it manually.











-- problem with running sum
select * from test.products;

insert into test.products
values(10, 'Cell', 200.00, 'Electronics');

-- calculate the running sum of price order by price in asc order
-- option01: in this way we can calculate the running sum but in case of duplicate value of price, running sum will be same for that duplicate value.
select *, sum(price) over(order by price asc) as running_sum
from test.products;

-- option02: to avoid the duplicate value for running sum we can use some unique column in order by
select *, sum(price) over(order by price asc, product_id asc) as running_sum
from test.products;

-- option03: we can use rows between unbounded preceeding and current row
select *, sum(price) over(order by price asc rows between unbounded preceding and current row) as running_sum
from test.products;












-- Difference Between count(*) ,count(0),count(-1),count(col),count('youtube')
-- Emp DDL
-- drop table if exists test.emp;
create table if not exists test.emp(
    emp_id varchar(100),
    emp_name varchar(100),
    salary varchar(100),
    manager_id varchar(100),
    emp_age varchar(100),
    dept_id varchar(100),
    dept_name varchar(100),
    gender varchar(20)
);

-- emp dataset
INSERT INTO test.emp
(emp_id, emp_name, salary, manager_id, emp_age, dept_id, dept_name, gender)
VALUES
(1, 'Ankit', 14300, 39, 100, 100, 'Analytics', 'Female'),
(2, 'Mohit', 15600, 4, 48, 200, 'IT', 'Male'),
(3, 'Vikas', 12100, 37, 37, 100, 'Analytics', 'Female'),
(4, 'Rohit', 7260, 2, 16, 100, 'Analytics', 'Female'),
(5, 'Mudit', 15600, 6, 55, 200, 'IT', 'Male'),
(6, 'Agam', 15600, 2, 14, 200, 'IT', 'Male'),
(7, 'Sanjay', 12000, 2, 13, 200, 'IT', 'Male'),
(8, 'Ashish', 7200, 2, 12, 200, 'IT', 'Male'),
(9, 'Mukesh', 7000, 6, 51, 300, 'HR', 'Male'),
(10, 'Rakesh', 8000, 6, 50, 300, 'HR', 'Male'),
(11, 'Akhil', 4000, 1, 31, 500, null, 'Male');

insert into test.emp
values(null, null, null, null, null, null, null, null);

-- varifying the data
select * from test.emp;

-- count(*), count(1), count(num), count(string), count('vishva') ==> all are same and returns the count of all records
-- count(column) ==> will count the collumn value it will exclude the NULL value.
select count(*) as countStart, count(1) as count_1, count(emp_id) as CountCol from test.emp;













-- Occurance of char
drop table if exists test.strings;
create table if not exists test.strings (name varchar(50));

insert into test.strings values ('Ankit Bansal'),('Ram Kumar Verma'),('Akshay Kumar Ak k'),('Rahul');

-- varifying the result
select * from test.strings;

-- count of char(A) in column
select name,
length(name) - length(replace(upper(name), 'A', '')) as count_of_A from test.strings;

-- count of word(Kumar)
select name,
(length(name) - length(replace(upper(name), 'KUMAR', '')))/length('KUMAR') as count_of_word
from test.strings

-- total number of words
select name,
(length(name) -length(replace(upper(name), ' ', '')))+1 as count_of_total_word from test.strings;
















-- Aggregation functions => sum(), avg(), min(), max()
DROP TABLE IF EXISTS test.int_orders;

CREATE TABLE IF NOT EXISTS test.int_orders(
    order_number INT NOT NULL,
    order_date DATE NOT NULL,
    cust_id INT NOT NULL,
    salesperson_id INT NOT NULL,
    amount FLOAT NOT NULL
);

INSERT INTO test.int_orders
VALUES
(30, CAST(N'1995-07-14' AS DATE), 9, 1, 460),
(10, CAST(N'1996-08-02' AS DATE), 4, 2, 540),
(40, CAST(N'1998-01-29' AS DATE), 7, 2, 2400),
(50, CAST(N'1998-02-03' AS DATE), 6, 7, 600),
(60, CAST(N'1998-03-02' AS DATE), 6, 7, 720),
(70, CAST(N'1998-05-06' AS DATE), 9, 7, 150),
(20, CAST(N'1999-01-30' AS DATE), 4, 8, 1800);

-- Verifying the results
SELECT * FROM test.int_orders;

-- Total sales amount
SELECT SUM(amount) AS total_sales
FROM test.int_orders;

-- Total sales per salesperson
SELECT SUM(amount) AS sumOfSales, salesperson_id
FROM test.int_orders
GROUP BY 2
ORDER BY salesperson_id ASC;

-- Using GROUP BY, we cannot select all columns; to keep all rows, we use a window function
SELECT *, SUM(amount) OVER (PARTITION BY salesperson_id ORDER BY salesperson_id ASC) AS sumOfSales FROM test.int_orders;

-- If we remove PARTITION BY, a single window is created and the total sum is shown for all rows
SELECT *, SUM(amount) OVER () AS sumOfSales FROM test.int_orders;

-- Using ORDER BY without PARTITION BY calculates a running sum
SELECT *, SUM(amount) OVER (ORDER BY order_date) AS sumOfSales FROM test.int_orders;

-- Using both PARTITION BY and ORDER BY calculates a running sum within each partition
SELECT *, SUM(amount) OVER (PARTITION BY salesperson_id ORDER BY order_date) AS sumOfSales FROM test.int_orders;

-- Rolling sum of the last 2 rows including the current row based on order_date
SELECT *, SUM(amount) OVER (ORDER BY order_date ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_sum_2 FROM test.int_orders;

-- Sum of the previous 2 rows (excluding the current row)
SELECT *, SUM(amount) OVER (ORDER BY order_date ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS running_sum_last_2 FROM test.int_orders;

-- Running sum from all previous rows up to the current row
SELECT *,SUM(amount) OVER (ORDER BY order_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sum FROM test.int_orders;

-- Simulating LAG without using the LAG function (previous row value)
SELECT *, SUM(amount) OVER (ORDER BY order_date ASC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) FROM test.int_orders;

-- Simulating LEAD without using the LEAD function (next row value)
SELECT *, SUM(amount) OVER (ORDER BY order_date ASC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) FROM test.int_orders;
----




select * from test.products;






