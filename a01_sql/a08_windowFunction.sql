/*
# Window function
	- Perform calculation across a set of table rows
	- It will not grouped the rows into single row
	- Rows will retain separate identities based on defined window function.
	- It should always contain over clause
	- The over clause determines how rows of query are split up for processing by the window function.
	- Any user defined or built in function can be used as window function


# Window Specification
	- partition by : create group based on defined column
	- order by : defines the ordering within partition. Used for ranking or cumulative calculations
	- rows between : defines the frame boundaries. Used for running total


# Common Window Functions
1. ROW_NUMBER()
	- Assigns a unique sequential number.

2. RANK()
	- Same rank for ties, skips numbers.

3. DENSE_RANK()
	- Same rank for ties, no gaps.

4. LEAD()
	- Access next row value.

5. LAG()
	- Access previous row value.

### Syntax
```sql
SELECT coulmn_name1, 
window_function(cloumn_name2)
OVER([PARTITION BY column_name1] [ORDER BY column_name3]) AS new_column
FROM table_name;
```
*/


-- Create table
-- DROP TABLE IF EXISTS test.employee;

-- CREATE TABLE IF NOT EXISTS test.employee
-- ( emp_ID int
-- , emp_NAME varchar(50)
-- , DEPT_NAME varchar(50)
-- , SALARY int);
--
--
-- INSERT INTO test.employee VALUES
-- (101, 'Mohan', 'Admin', 4000),
-- (102, 'Sohan', 'HR', 4500),
-- (103, 'Rohan', 'IT', 6000),
-- (104, 'Kiran', 'Finance', 5500),
-- (105, 'Asha', 'Admin', 4200),
-- (106, 'Vikram', 'Sales', 4700),
-- (107, 'Deepa', 'HR', 4900),
-- (108, 'Nitin', 'IT', 6100),
-- (109, 'Sneha', 'Finance', 5300),
-- (110, 'Ravi', 'Admin', 4100),
-- (111, 'Komal', 'Sales', 4800),
-- (112, 'Manoj', 'HR', 4550),
-- (113, 'Divya', 'IT', 6250),
-- (114, 'Arjun', 'Finance', 5400),
-- (115, 'Radha', 'Admin', 4050),
-- (116, 'Kunal', 'Sales', 4650),
-- (117, 'Priya', 'HR', 4950),
-- (118, 'Suresh', 'IT', 6200),
-- (119, 'Meena', 'Finance', 5600),
-- (120, 'Harsha', 'Admin', 4150),
-- (121, 'Anil', 'Sales', 4700),
-- (122, 'Bhavna', 'HR', 4600),
-- (123, 'Neeraj', 'IT', 6350),
-- (124, 'Jyoti', 'Finance', 5700),
-- (125, 'Raj', 'Admin', 4300),
-- (126, 'Geeta', 'Sales', 4900),
-- (127, 'Kishore', 'HR', 4500),
-- (128, 'Anita', 'IT', 6400),
-- (129, 'Tushar', 'Finance', 5800),
-- (130, 'Lata', 'Admin', 4000),
-- (131, 'Irfan', 'Sales', 4600),
-- (132, 'Sonal', 'HR', 4700),
-- (133, 'Mahesh', 'IT', 6500),
-- (134, 'Namrata', 'Finance', 5900),
-- (135, 'Vikas', 'Admin', 4200),
-- (136, 'Trisha', 'Sales', 5000),
-- (137, 'Tarun', 'HR', 4650),
-- (138, 'Zara', 'IT', 6600),
-- (139, 'Yogesh', 'Finance', 6000),
-- (140, 'Preeti', 'Admin', 4400),
-- (141, 'Ritesh', 'Sales', 5100),
-- (142, 'Chitra', 'HR', 4550),
-- (143, 'Lokesh', 'IT', 6700),
-- (144, 'Pooja', 'Finance', 6100),
-- (145, 'Ajay', 'Admin', 4350),
-- (146, 'Bharti', 'Sales', 4800),
-- (147, 'Dev', 'HR', 4750),
-- (148, 'Snehal', 'IT', 6800),
-- (149, 'Kavita', 'Finance', 6200),
-- (150, 'Varun', 'Admin', 4500),
-- (151, 'Rekha', 'Sales', 4950),
-- (152, 'Nikhil', 'HR', 4600),
-- (153, 'Tanvi', 'IT', 6900),
-- (154, 'Umesh', 'Finance', 6300),
-- (155, 'Roma', 'Admin', 4250),
-- (156, 'Gaurav', 'Sales', 5000),
-- (157, 'Shalini', 'HR', 4700),
-- (158, 'Farhan', 'IT', 7000),
-- (159, 'Kanika', 'Finance', 6400),
-- (160, 'Raghav', 'Admin', 4300),
-- (161, 'Alka', 'Sales', 5100),
-- (162, 'Naina', 'HR', 4750),
-- (163, 'Sameer', 'IT', 7100),
-- (164, 'Heena', 'Finance', 6500),
-- (165, 'Kabir', 'Admin', 4450),
-- (166, 'Simran', 'Sales', 5200),
-- (167, 'Ritu', 'HR', 4800),
-- (168, 'Aditya', 'IT', 7200),
-- (169, 'Vidya', 'Finance', 6600),
-- (170, 'Pranav', 'Admin', 4600),
-- (171, 'Aarti', 'Sales', 5300),
-- (172, 'Shyam', 'HR', 4900),
-- (173, 'Payal', 'IT', 7300),
-- (174, 'Imran', 'Finance', 6700),
-- (175, 'Neha', 'Admin', 4700),
-- (176, 'Avinash', 'Sales', 5400),
-- (177, 'Isha', 'HR', 4950),
-- (178, 'Suraj', 'IT', 7400),
-- (179, 'Tina', 'Finance', 6800),
-- (180, 'Dinesh', 'Admin', 4800),
-- (181, 'Juhi', 'Sales', 5500),
-- (182, 'Rajeev', 'HR', 5000),
-- (183, 'Lavina', 'IT', 7500),
-- (184, 'Rahul', 'Finance', 6900),
-- (185, 'Sana', 'Admin', 4850),
-- (186, 'Omkar', 'Sales', 5600),
-- (187, 'Diya', 'HR', 5100),
-- (188, 'Aman', 'IT', 7600),
-- (189, 'Pinki', 'Finance', 7000),
-- (190, 'Vimal', 'Admin', 4900),
-- (191, 'Zoya', 'Sales', 5700),
-- (192, 'Nilesh', 'HR', 5200),
-- (193, 'Sheetal', 'IT', 7700),
-- (194, 'Yusuf', 'Finance', 7100),
-- (195, 'Swati', 'Admin', 4950),
-- (196, 'Karan', 'Sales', 5800),
-- (197, 'Mira', 'HR', 5300),
-- (198, 'Rakesh', 'IT', 7800),
-- (199, 'Divakar', 'Finance', 7200),
-- (200, 'Bhumi', 'Admin', 5000);
--


SELECT * FROM test.employee;


-- WINDOW FUNCTION
-- calculate the average salary from each department
-- using window aggregate function will not reduce the row and return all rows
SELECT emp_id, emp_name, dept_name, salary,
avg(salary) OVER(PARTITION BY dept_name) AS avg_salary
FROM test.employee;

-- using non-window aggregate function will reduce the row and return single for one group
SELECT avg(salary), dept_name FROM test.employee
GROUP BY 2;



-- Write a SQL query to find the top 3 highest-paid employees in each department.
-- using dense_rank it will return the top 3 emp salary from each dep having salary ties
WITH emp AS (SELECT emp_id, emp_name, dept_name, salary, 
DENSE_RANK() over(PARTITION BY dept_name ORDER BY salary DESC) AS sal_rank 
FROM test.employee e )
SELECT * FROM emp
WHERE sal_rank <=3;


-- using row_number, it will return the top only 3 emp salary from each dep without salary ties
WITH emp AS (SELECT emp_id, emp_name, dept_name, salary, 
ROW_NUMBER() over(PARTITION BY dept_name ORDER BY salary DESC) AS sal_rank 
FROM test.employee e )
SELECT * FROM emp
WHERE sal_rank <=3;


-- Find the 2nd highest salary in each department.
-- ties not allowed
WITH emp AS (SELECT emp_id, emp_name, dept_name, salary, 
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rn
FROM test.employee e 
) SELECT emp_id, emp_name, dept_name, salary FROM emp
WHERE rn=2;

-- ties allowed
WITH emp AS (SELECT emp_id, emp_name, dept_name, salary, 
DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rn
FROM test.employee e 
) SELECT emp_id, emp_name, dept_name, salary FROM emp
WHERE rn=2;


-- Show all employees with their department and rank by salary
SELECT emp_id, emp_name, dept_name, salary, 
DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rn
FROM test.employee e;


-- lead()
-- Looks forward to a following row
-- Compare with next employee's salary
SELECT emp_id, emp_name, dept_name, salary,
LEAD(salary) over(PARTITION BY dept_name ORDER BY salary) AS Next_sal 
FROM test.employee e;


-- Lag()
-- Looks backward to a previous row
-- Compare with previous month's sales
SELECT emp_id, emp_name, dept_name, salary,
LAG(salary) over(PARTITION BY dept_name ORDER BY salary) AS prev_sal
FROM test.employee e;


-- Find Employees Who Earn More Than the Previous One in Same Department
WITH emp AS (SELECT emp_id, emp_name, dept_name, salary,
lag(salary) over(PARTITION BY dept_name ORDER BY salary) AS prev_sal
FROM test.employee e )
SELECT * FROM emp WHERE prev_sal < salary;


-- Next Employee in Same Department
SELECT emp_id, emp_name, dept_name, salary,
LEAD(salary) over(PARTITION BY dept_name ORDER BY salary) AS Next_sal 
FROM test.employee e;


-- Running Total of Salary by Department using window fundtion and using aggregate function
WITH emp AS (SELECT emp_id, emp_name, dept_name, salary,
sum(salary) over(PARTITION BY dept_name) AS total_sal
FROM test.employee e 
) SELECT DISTINCT dept_name, total_sal FROM emp;

-- using aggregate function
SELECT sum(salary), dept_name FROM test.employee
GROUP BY dept_name;



-- Average Salary in Each Department
SELECT emp_id, emp_name, dept_name, salary, round(avg_sal, 2) FROM (
SELECT emp_id, emp_name, dept_name, salary,
avg(salary) over(PARTITION BY dept_name) AS avg_sal
FROM test.employee ) a;


-- Find First Employee in Each Department
WITH emp AS (SELECT emp_id, emp_name, dept_name, salary,
row_number() over(PARTITION BY dept_name ORDER BY emp_id ASC) AS rn
FROM test.employee
) SELECT * FROM emp WHERE rn = 1;




--==========================================================
-- Problem 1: Find the 3rd Highest Salary in Each Department
--==========================================================
select emp_id,
	emp_name,
	dept_name,
	salary from (select emp_id,
	emp_name,
	dept_name,
	salary,
	dense_rank() over(PARTITION BY dept_name order by salary DESC) as rnk
from test.employee
) where rnk = 3;


--==========================================================
-- Problem 2: Employees Earning More Than Department Average
--==========================================================
with avgDptSal as (select emp_id,
	emp_name,
	dept_name,
	salary,
	AVG(salary) over(PARTITION BY dept_name) as dep_average_sal
from test.employee)
select emp_id,
	emp_name,
	dept_name,
	salary
from avgDptSal WHERE salary > dep_average_sal;


--==========================================================
-- Problem 4: Top 20% Earners in Every Department
-- Find employees who belong to the top 20% of salaries within their department.
--==========================================================
select * from (select emp_id,
emp_name,
dept_name,
salary,
dense_rank() OVER(PARTITION BY dept_name ORDER BY salary DESC) sal_rank,
count(*) over(PARTITION BY dept_name) as dept_count
from test.employee)
where sal_rank <= ceil(0.2 * dept_count);


