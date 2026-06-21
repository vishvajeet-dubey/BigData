
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


-- running sum of salary based on dept wise
select emp_id,
emp_name,
dept_name,
salary,
SUM(salary) OVER(partition by dept_name order by salary rows between unbounded preceding and current row) running_sum
from test.employee;


/*
Salary Gap from Previous and Next Employee
Requirement

Within each department, order employees by salary and calculate:

- Previous employee salary
- Next employee salary
- Difference from previous salary
- Difference from next salary
*/
select emp_id,
emp_name,
dept_name,
salary,
lead(salary) over(partition by dept_name order by emp_id asc) Next_sal
from test.employee;



/*
Table: `Queue`

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |
+-------------+---------+
person_id column contains unique values.
This table has the information about all people waiting for a bus.
The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
weight is the weight of the person in kilograms.

There is a queue of people waiting to board a bus. However, the bus has a weight limit of `1000` **kilograms**, so there may be some people who cannot board.

Write a solution to find the `person_name` of the **last person** that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

**Note** that _only one_ person can board the bus at any given turn.

The result format is in the following example.

**Example 1:**

**Input:** 
Queue table:
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+
**Output:** 
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+
**Explanation:** The folowing table is ordered by the turn for simplicity.
+------+----+-----------+--------+--------------+
| Turn | ID | Name      | Weight | Total Weight |
+------+----+-----------+--------+--------------+
| 1    | 5  | Alice     | 250    | 250          |
| 2    | 3  | Alex      | 350    | 600          |
| 3    | 6  | John Cena | 400    | 1000         | (last person to board)
| 4    | 2  | Marie     | 200    | 1200         | (cannot board)
| 5    | 4  | Bob       | 175    | ___          |
| 6    | 1  | Winston   | 500    | ___          |
+------+----+-----------+--------+--------------+
*/

-- solution
-- Write your PostgreSQL query statement below
select person_name from (select person_name, turn, sum(weight) over(order by turn asc rows between unbounded preceding and current row) total_weight from queue
) where total_weight <= 1000 order by turn desc limit 1;





-- Question
/*
Table: `Customer`

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). `average_amount` should be **rounded to two decimal places**.

Return the result table ordered by `visited_on` **in ascending order**.

The result format is in the following example.

**Example 1:**

**Input:** 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
**Output:** 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
**Explanation:** 
1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86
*/



-- solution
-- Write your PostgreSQL query statement below
with min_date as
    (select (min(visited_on) + interval '6 days')::date as min_date
     from customer),
     agg_visit_on as
    (select visited_on,
            sum(amount) as amount
     from customer
     group by 1),
     total_amount as
    (select visited_on,
            sum(amount) over(
                             order by visited_on asc rows between 6 preceding and current row) amount
     from agg_visit_on)
select visited_on,
       amount,
       round(amount::numeric/7, 2) as average_amount
from total_amount
where visited_on>=
        (select *
         from min_date);

