/*
-------------------------------------------------------------------------------
SQL JOIN
-------------------------------------------------------------------------------
> A JOIN clause is used to combine rows from two or more tables, 
  based on a related column between them. **

> The join keyword merges two or more tables and creates a temporary image of 
  the merged table. Then according to the conditions provided, it extracts the 
  required data from the image table, and once data is fetched, the temporary 
  image of the merged tables is dumped.
-------------------------------------------------------------------------------


Create the sample employee database to uderstand the join(we are going to
create under emp schema)

-------------------------------------------------------------------------------
HOW TO CREATE SCHEMA
-------------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS schema_name AUTHORIZATION user_name; 
i.e: 
CREATE SCHEMA IF NOT EXISTS emp AUTHORIZATION postgres; 

--help
[user_name]=postgres
[schema_name]=emp
-------------------------------------------------------------------------------
*/




-------------------------------------------------------------------------------
-- creating employee table under emp schema
-------------------------------------------------------------------------------
drop table if exists emp.employee;
create table if not exists emp.employee
(
	emp_id			varchar(20),
	emp_name		varchar(50),
	salary			int,
	dept_id			varchar(20),
	manager_id		varchar(20)
);

-- sample records
insert into emp.employee values
('E1', 'Rahul', 15000, 'D1', 'M1'),
('E2', 'Manoj', 15000, 'D1', 'M1'),
('E3', 'James', 55000, 'D2', 'M2'),
('E4', 'Michael', 25000, 'D2', 'M2'),
('E5', 'Ali', 20000, 'D10', 'M3'),
('E6', 'Robin', 35000, 'D10', 'M3');


-------------------------------------------------------------------------------
-- Creating department table under emp schema
-------------------------------------------------------------------------------
drop table if exists emp.department;
create table if not exists emp.department
(
	dept_id			varchar(20),
	dept_name		varchar(50)
);

-- Sample records
insert into emp.department values
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');


-------------------------------------------------------------------------------
-- Creating manager table under emp schema
-------------------------------------------------------------------------------
drop table if exists emp.manager;
create table if not exists emp.manager
(
	manager_id			varchar(20),
	manager_name		varchar(50),
	dept_id				varchar(20)
);

-- Sample records
insert into emp.manager values
('M1', 'Prem', 'D3'),
('M2', 'Shripadh', 'D4'),
('M3', 'Nick', 'D1'),
('M4', 'Cory', 'D1');


-------------------------------------------------------------------------------
-- Creating product table under emp schema
-------------------------------------------------------------------------------
drop table if exists emp.projects;
create table if not exists emp.projects
(
	project_id			varchar(20),
	project_name		varchar(100),
	team_member_id		varchar(20)
);

-- Sample records
insert into emp.projects values
('P1', 'Data Migration', 'E1'),
('P1', 'Data Migration', 'E2'),
('P1', 'Data Migration', 'M3'),
('P2', 'ETL Tool', 'E1'),
('P2', 'ETL Tool', 'M4');


-------------------------------------------------------------------------------
-- below are the all table under emp shcema
-------------------------------------------------------------------------------
SELECT * FROM emp.employee;
SELECT * FROM emp.department;
SELECT * FROM emp.manager;
SELECT * FROM emp.projects;



/*
-------------------------------------------------------------------------------
FETCH THE EMPLOYEE NAME AND THE DEPARTMENT NAME THEY BELONG TO.
> inorder to fetch the employee name and department name we need to join the 
  tables{employee and department} to fetch these detail.

INNER JOIN / JOIN:
> It can represented by keyword "join" or "inner join" in any case.
> ON Condition: Column which present in both table. 
  Column name can be different but the value should be present in the table.
> only return the matching value from both the table. **
> with using inner join lets try to solve the above problem
-------------------------------------------------------------------------------
*/

SELECT 
emp_table.emp_name,
dep_table.dept_name
FROM emp.employee emp_table
INNER JOIN emp.department dep_table
ON emp_table.dept_id=dep_table.dept_id


/*
-------------------------------------------------------------------------------
FETCH THE ALL EMPLOYEE NAME AND THE DEPARTMENT NAME THEY BELONG TO.
> inorder to fetch the employee name and department name we need to join the 
  tables{employee and department} to fetch these detail.

LEFT JOIN:
> LEFT JOIN = INNER JOIN + any additional records in the left table. **
> in case of if any record present in left table but not present in right then
  we will get the Null as result.
> in case of join condition fail, it will retun the "null" for right table
  but from left table all the records will return.
> with using inner join lets try to solve the above problem
-------------------------------------------------------------------------------
*/

SELECT 
emp_table.emp_name,
dep_table.dept_name
FROM emp.employee emp_table
LEFT JOIN emp.department dep_table
ON emp_table.dept_id=dep_table.dept_id



/*
-------------------------------------------------------------------------------
RIGHT JOIN:
> RIGHT JOIN = INNER JOIN + any additional records in the right table. **
> in case of if any record present in right table but not present in left then
  we will get the Null as result.
> in case of join condition fail, it will retuns the "null" for left table
  but from right table all the records will return.
> with using inner join lets try to solve the above problem
-------------------------------------------------------------------------------
*/

SELECT 
emp_table.emp_name,
dep_table.dept_name
FROM emp.employee emp_table
RIGHT JOIN emp.department dep_table
ON emp_table.dept_id=dep_table.dept_id;



SELECT * FROM emp.employee;
SELECT * FROM emp.department;
SELECT * FROM emp.manager;
SELECT * FROM emp.projects;

-- Fetch details of all emp, their manager, their department and the 
-- projects they work on.
SELECT e.emp_name, m.manager_name, d.dept_name, p.project_name
FROM emp.employee e
JOIN emp.manager m ON m.manager_id = e.manager_id
LEFT JOIN emp.department d ON d.dept_id = e.dept_id
LEFT JOIN emp.projects p ON p.team_member_id=e.emp_id;

-- THE END
