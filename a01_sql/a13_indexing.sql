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





-- creating table 
CREATE TABLE test.student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    email VARCHAR(150),
    course VARCHAR(100)
);

-- use below insert query to insert the sample data into table


-- Retriving table
select * from test.student;


-- creating index using student_id primary key coloumn so it is primary BTREE index
create INDEX IF NOT EXISTS inx_studentTbl_studentId on test.student using BTREE(student_id);


select * from test.student where student_id<10;


-- viewing index
select * from pg_indexes where tablename='student';


-- deleting index
drop INDEX if exists inx_studentTbl_studentId;


-- note - postgres automatically create BTREE index on primary key column


-- creating index on email id column
create INDEX IF NOT EXISTS inx_studentTbl_email on test.student using BTREE(lower(email));


-- viewing/selecting index
select * from pg_indexes where tablename='student';


-- test
select * from test.student where email like ('%joshi%');





-- sample insert statement
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (1, 'Rahul Sharma', 21, 'rahul.sharma@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (2, 'Amit Verma', 22, 'amit.verma@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (3, 'Priya Singh', 20, 'priya.singh@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (4, 'Neha Gupta', 23, 'neha.gupta@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (5, 'Rohit Kumar', 21, 'rohit.kumar@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (6, 'Anjali Mehta', 22, 'anjali.mehta@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (7, 'Vikas Yadav', 20, 'vikas.yadav@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (8, 'Sneha Patel', 21, 'sneha.patel@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (9, 'Karan Joshi', 24, 'karan.joshi@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (10, 'Pooja Agarwal', 22, 'pooja.agarwal@gmail.com', 'Data Science');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (11, 'Arjun Malhotra', 23, 'arjun.malhotra@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (12, 'Simran Kaur', 21, 'simran.kaur@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (13, 'Nikhil Jain', 20, 'nikhil.jain@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (14, 'Riya Kapoor', 22, 'riya.kapoor@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (15, 'Saurabh Mishra', 24, 'saurabh.mishra@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (16, 'Kavya Reddy', 21, 'kavya.reddy@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (17, 'Aditya Tiwari', 23, 'aditya.tiwari@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (18, 'Shreya Nair', 20, 'shreya.nair@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (19, 'Manish Gupta', 22, 'manish.gupta@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (20, 'Divya Shah', 21, 'divya.shah@gmail.com', 'Information Technology');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (21, 'Varun Saxena', 24, 'varun.saxena@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (22, 'Nandini Rao', 22, 'nandini.rao@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (23, 'Akash Bansal', 20, 'akash.bansal@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (24, 'Isha Sinha', 21, 'isha.sinha@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (25, 'Mohit Arora', 23, 'mohit.arora@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (26, 'Ayesha Khan', 22, 'ayesha.khan@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (27, 'Rajat Pandey', 21, 'rajat.pandey@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (28, 'Muskan Verma', 20, 'muskan.verma@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (29, 'Deepak Singh', 24, 'deepak.singh@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (30, 'Tanvi Joshi', 22, 'tanvi.joshi@gmail.com', 'Information Technology');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (31, 'Harsh Vardhan', 23, 'harsh.vardhan@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (32, 'Megha Iyer', 21, 'megha.iyer@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (33, 'Yash Thakur', 20, 'yash.thakur@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (34, 'Pallavi Das', 22, 'pallavi.das@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (35, 'Abhishek Roy', 24, 'abhishek.roy@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (36, 'Komal Gupta', 21, 'komal.gupta@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (37, 'Rakesh Kumar', 23, 'rakesh.kumar@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (38, 'Sakshi Jain', 20, 'sakshi.jain@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (39, 'Gaurav Agarwal', 22, 'gaurav.agarwal@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (40, 'Priti Sharma', 21, 'priti.sharma@gmail.com', 'Data Science');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (41, 'Rohan Mehta', 24, 'rohan.mehta@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (42, 'Aditi Kapoor', 22, 'aditi.kapoor@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (43, 'Tarun Yadav', 20, 'tarun.yadav@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (44, 'Shivani Reddy', 21, 'shivani.reddy@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (45, 'Naveen Kumar', 23, 'naveen.kumar@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (46, 'Mansi Patel', 22, 'mansi.patel@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (47, 'Vivek Mishra', 21, 'vivek.mishra@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (48, 'Ananya Bose', 20, 'ananya.bose@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (49, 'Pranav Shah', 24, 'pranav.shah@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (50, 'Nisha Nair', 22, 'nisha.nair@gmail.com', 'Information Technology');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (51, 'Siddharth Jain', 23, 'siddharth.jain@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (52, 'Poonam Verma', 21, 'poonam.verma@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (53, 'Ashish Tiwari', 20, 'ashish.tiwari@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (54, 'Ritika Singh', 22, 'ritika.singh@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (55, 'Manoj Gupta', 24, 'manoj.gupta@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (56, 'Swati Agarwal', 21, 'swati.agarwal@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (57, 'Varun Joshi', 23, 'varun.joshi@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (58, 'Preeti Kumari', 20, 'preeti.kumari@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (59, 'Lokesh Sharma', 22, 'lokesh.sharma@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (60, 'Shalini Rao', 21, 'shalini.rao@gmail.com', 'Information Technology');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (61, 'Kunal Bhatia', 24, 'kunal.bhatia@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (62, 'Reena Das', 22, 'reena.das@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (63, 'Suresh Patel', 20, 'suresh.patel@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (64, 'Monika Shah', 21, 'monika.shah@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (65, 'Vishal Kumar', 23, 'vishal.kumar@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (66, 'Rashmi Nair', 22, 'rashmi.nair@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (67, 'Sameer Khan', 21, 'sameer.khan@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (68, 'Kriti Mehta', 20, 'kriti.mehta@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (69, 'Aman Yadav', 24, 'aman.yadav@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (70, 'Jyoti Singh', 22, 'jyoti.singh@gmail.com', 'Data Science');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (71, 'Ravi Mishra', 23, 'ravi.mishra@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (72, 'Sonia Kapoor', 21, 'sonia.kapoor@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (73, 'Nitin Sharma', 20, 'nitin.sharma@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (74, 'Pankaj Gupta', 22, 'pankaj.gupta@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (75, 'Meenal Jain', 24, 'meenal.jain@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (76, 'Rohini Verma', 21, 'rohini.verma@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (77, 'Sanjay Roy', 23, 'sanjay.roy@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (78, 'Garima Sinha', 20, 'garima.sinha@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (79, 'Devendra Singh', 22, 'devendra.singh@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (80, 'Payal Arora', 21, 'payal.arora@gmail.com', 'Information Technology');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (81, 'Chirag Bansal', 24, 'chirag.bansal@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (82, 'Ritu Sharma', 22, 'ritu.sharma@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (83, 'Hemant Joshi', 20, 'hemant.joshi@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (84, 'Kiran Patel', 21, 'kiran.patel@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (85, 'Rajesh Kumar', 23, 'rajesh.kumar@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (86, 'Poonam Singh', 22, 'poonam.singh@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (87, 'Ankit Verma', 21, 'ankit.verma@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (88, 'Kajal Gupta', 20, 'kajal.gupta@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (89, 'Vivek Sharma', 24, 'vivek.sharma@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (90, 'Alka Mehta', 22, 'alka.mehta@gmail.com', 'Information Technology');

-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (91, 'Ramesh Yadav', 23, 'ramesh.yadav@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (92, 'Sunita Rao', 21, 'sunita.rao@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (93, 'Dinesh Patel', 20, 'dinesh.patel@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (94, 'Bhavna Shah', 22, 'bhavna.shah@gmail.com', 'Mechanical Engineering');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (95, 'Yogesh Jain', 24, 'yogesh.jain@gmail.com', 'Information Technology');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (96, 'Suman Kumari', 21, 'suman.kumari@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (97, 'Naveen Sharma', 23, 'naveen.sharma@gmail.com', 'Computer Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (98, 'Rekha Gupta', 20, 'rekha.gupta@gmail.com', 'Electronics');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (99, 'Ajay Singh', 22, 'ajay.singh@gmail.com', 'Data Science');
-- INSERT INTO student (student_id, student_name, age, email, course) VALUES (100, 'Anu Verma', 21, 'anu.verma@gmail.com', 'Information Technology');
