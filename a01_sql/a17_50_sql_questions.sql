-- CREATING DDL
-- ============================================
-- CREATE TABLE
-- ============================================

CREATE TABLE students (
    student_id      INT PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    gpa             NUMERIC(3,2),
    enrollment_date TIMESTAMP,
    major           VARCHAR(100)
);


-- ============================================
-- INSERT 50 SAMPLE RECORDS
-- ============================================

INSERT INTO students
    (student_id, first_name, last_name, gpa, enrollment_date, major)
VALUES
    (201, 'Jack', 'Smith', 8.79, '2021-09-01 09:30:00', 'Computer Science'),
    (202, 'Ryan', 'Brown', 8.44, '2021-09-01 08:30:00', 'Mathematics'),
    (203, 'Ethan', 'Davis', 5.60, '2021-09-01 10:00:00', 'Biology'),
    (204, 'Emma', 'Wilson', 9.20, '2021-09-01 12:45:00', 'Chemistry'),
    (205, 'Noah', 'Miller', 7.85, '2021-09-01 08:30:00', 'Physics'),
    (206, 'Liam', 'Taylor', 9.56, '2021-09-01 09:24:00', 'History'),
    (207, 'Ava', 'Moore', 9.78, '2021-09-01 02:30:00', 'English'),
    (208, 'Grace', 'Clark', 7.00, '2021-09-01 06:30:00', 'Mathematics'),

    (209, 'Oliver', 'Lewis', 7.00, '2021-09-02 09:15:00', 'Computer Science'),
    (210, 'Sophia', 'Walker', 9.35, '2021-09-02 10:30:00', 'Physics'),
    (211, 'James', 'Hall', 6.78, '2021-09-02 11:00:00', 'Biology'),
    (212, 'Mia', 'Allen', 8.25, '2021-09-02 08:45:00', 'Chemistry'),
    (213, 'William', 'Young', 7.92, '2021-09-02 09:30:00', 'History'),
    (214, 'Isabella', 'King', 9.67, '2021-09-02 01:15:00', 'English'),
    (215, 'Benjamin', 'Wright', 8.13, '2021-09-02 02:30:00', 'Mathematics'),
    (216, 'Charlotte', 'Scott', 9.01, '2021-09-02 03:45:00', 'Computer Science'),

    (217, 'Lucas', 'Green', 7.00, '2021-09-03 08:00:00', 'Physics'),
    (218, 'Amelia', 'Baker', 8.88, '2021-09-03 09:20:00', 'Chemistry'),
    (219, 'Henry', 'Adams', 6.95, '2021-09-03 10:15:00', 'Biology'),
    (220, 'Harper', 'Nelson', 9.42, '2021-09-03 11:30:00', 'Computer Science'),
    (221, 'Alexander', 'Carter', 8.76, '2021-09-03 12:00:00', 'Mathematics'),
    (222, 'Evelyn', 'Mitchell', 7.64, '2021-09-03 01:30:00', 'English'),
    (223, 'Daniel', 'Perez', 9.15, '2021-09-03 02:45:00', 'History'),
    (224, 'Ella', 'Roberts', 8.52, '2021-09-03 04:00:00', 'Physics'),

    (225, 'Michael', 'Turner', 8.88, '2021-09-04 08:30:00', 'Biology'),
    (226, 'Camila', 'Phillips', 9.73, '2021-09-04 09:45:00', 'Chemistry'),
    (227, 'Matthew', 'Campbell', 8.37, '2021-09-04 10:30:00', 'Computer Science'),
    (228, 'Luna', 'Parker', 8.88, '2021-09-04 11:15:00', 'Mathematics'),
    (229, 'Joseph', 'Evans', 6.52, '2021-09-04 12:30:00', 'History'),
    (230, 'Aria', 'Edwards', 8.95, '2021-09-04 01:00:00', 'English'),
    (231, 'David', 'Collins', 7.83, '2021-09-04 02:15:00', 'Physics'),
    (232, 'Scarlett', 'Stewart', 9.61, '2021-09-04 03:30:00', 'Computer Science'),

    (233, 'Andrew', 'Sanchez', 8.88, '2021-09-05 08:15:00', 'Chemistry'),
    (234, 'Victoria', 'Morris', 9.27, '2021-09-05 09:00:00', 'Biology'),
    (235, 'Christopher', 'Rogers', 7.56, '2021-09-05 10:45:00', 'Mathematics'),
    (236, 'Layla', 'Reed', 8.64, '2021-09-05 11:30:00', 'History'),
    (237, 'Joshua', 'Cook', 9.49, '2021-09-05 12:15:00', 'English'),
    (238, 'Nora', 'Morgan', 7.29, '2021-09-05 01:45:00', 'Physics'),
    (239, 'Ryan', 'Bell', 8.72, '2021-09-05 02:30:00', 'Computer Science'),
    (240, 'Lily', 'Murphy', 9.83, '2021-09-05 04:15:00', 'Chemistry'),

    (241, 'Nathan', 'Bailey', 7.29, '2021-09-06 08:30:00', 'Biology'),
    (242, 'Zoey', 'Rivera', 8.46, '2021-09-06 09:15:00', 'Mathematics'),
    (243, 'Samuel', 'Cooper', 7.91, '2021-09-06 10:00:00', 'History'),
    (244, 'Hannah', 'Richardson', 9.38, '2021-09-06 11:45:00', 'English'),
    (245, 'Anthony', 'Cox', 8.07, '2021-09-06 12:30:00', 'Physics'),
    (246, 'Chloe', 'Howard', 9.54, '2021-09-06 01:15:00', 'Computer Science'),
    (247, 'Dylan', 'Ward', 7.72, '2021-09-06 02:00:00', 'Chemistry'),
    (248, 'Sofia', 'Torres', 8.99, '2021-09-06 03:30:00', 'Biology'),
    (249, 'Isaac', 'Peterson', 6.43, '2021-09-06 04:15:00', 'Mathematics'),
    (250, 'Emily', 'Gray', 9.70, '2021-09-06 05:00:00', 'Computer Science');


    -- ============================================
-- CREATE TABLE
-- ============================================

CREATE TABLE programs (
    student_ref_id     INT,
    program_name       VARCHAR(100) NOT NULL,
    program_start_date TIMESTAMP NOT NULL
);


-- ============================================
-- INSERT 50 SAMPLE RECORDS
-- ============================================

INSERT INTO programs
    (student_ref_id, program_name, program_start_date)
VALUES
    -- Records from the image
    (201, 'Computer Science', '2021-09-01 00:00:00'),
    (202, 'Mathematics',      '2021-09-01 00:00:00'),
    (208, 'Mathematics',      '2021-09-01 00:00:00'),
    (205, 'Physics',          '2021-09-01 00:00:00'),
    (204, 'Chemistry',        '2021-09-01 00:00:00'),
    (207, 'Psychology',       '2021-09-01 00:00:00'),
    (206, 'History',          '2021-09-01 00:00:00'),
    (203, 'Biology',          '2021-09-01 00:00:00'),

    -- Additional records
    (209, 'Computer Science', '2021-09-02 00:00:00'),
    (210, 'Physics',          '2021-09-02 00:00:00'),
    (211, 'Biology',          '2021-09-02 00:00:00'),
    (212, 'Chemistry',        '2021-09-02 00:00:00'),
    (213, 'History',          '2021-09-02 00:00:00'),
    (214, 'English',          '2021-09-02 00:00:00'),
    (215, 'Mathematics',      '2021-09-02 00:00:00'),
    (216, 'Computer Science', '2021-09-02 00:00:00'),

    (217, 'Physics',          '2021-09-03 00:00:00'),
    (218, 'Chemistry',        '2021-09-03 00:00:00'),
    (219, 'Biology',          '2021-09-03 00:00:00'),
    (220, 'Computer Science', '2021-09-03 00:00:00'),
    (221, 'Mathematics',      '2021-09-03 00:00:00'),
    (222, 'English',          '2021-09-03 00:00:00'),
    (223, 'History',          '2021-09-03 00:00:00'),
    (224, 'Physics',          '2021-09-03 00:00:00'),

    (225, 'Biology',          '2021-09-04 00:00:00'),
    (226, 'Chemistry',        '2021-09-04 00:00:00'),
    (227, 'Computer Science', '2021-09-04 00:00:00'),
    (228, 'Mathematics',      '2021-09-04 00:00:00'),
    (229, 'History',          '2021-09-04 00:00:00'),
    (230, 'English',          '2021-09-04 00:00:00'),
    (231, 'Physics',          '2021-09-04 00:00:00'),
    (232, 'Computer Science', '2021-09-04 00:00:00'),

    (233, 'Chemistry',        '2021-09-05 00:00:00'),
    (234, 'Biology',          '2021-09-05 00:00:00'),
    (235, 'Mathematics',      '2021-09-05 00:00:00'),
    (236, 'History',          '2021-09-05 00:00:00'),
    (237, 'English',          '2021-09-05 00:00:00'),
    (238, 'Physics',          '2021-09-05 00:00:00'),
    (239, 'Computer Science', '2021-09-05 00:00:00'),
    (240, 'Chemistry',        '2021-09-05 00:00:00'),

    (241, 'Biology',          '2021-09-06 00:00:00'),
    (242, 'Mathematics',      '2021-09-06 00:00:00'),
    (243, 'History',          '2021-09-06 00:00:00'),
    (244, 'English',          '2021-09-06 00:00:00'),
    (245, 'Physics',          '2021-09-06 00:00:00'),
    (246, 'Computer Science', '2021-09-06 00:00:00'),
    (247, 'Chemistry',        '2021-09-06 00:00:00'),
    (248, 'Biology',          '2021-09-06 00:00:00'),
    (249, 'Mathematics',      '2021-09-06 00:00:00'),
    (250, 'Computer Science', '2021-09-06 00:00:00');





-- ============================================
-- CREATE SCHOLARSHIP TABLE
-- ============================================

CREATE TABLE scholarship (
    student_ref_id      INT,
    scholarship_amount  NUMERIC(10,2),
    scholarship_date    TIMESTAMP
);


-- ============================================
-- INSERT 50 SAMPLE RECORDS
-- ============================================

INSERT INTO scholarship
    (student_ref_id, scholarship_amount, scholarship_date)
VALUES
    -- Records from the image
    (201, 5000, '2021-10-15 00:00:00'),
    (202, 4500, '2022-08-18 00:00:00'),
    (203, 3000, '2022-01-25 00:00:00'),
    (204, 4000, '2021-10-15 00:00:00'),

    -- Additional records
    (205, 3500, '2022-02-10 00:00:00'),
    (206, 5500, '2022-03-15 00:00:00'),
    (207, 6000, '2022-04-20 00:00:00'),
    (208, 2500, '2022-05-12 00:00:00'),
    (209, 4500, '2022-06-18 00:00:00'),
    (210, 5000, '2022-07-25 00:00:00'),
    (211, 3000, '2022-08-10 00:00:00'),
    (212, 4000, '2022-09-15 00:00:00'),


    (229, 5000, '2024-02-18 00:00:00'),
    (230, 2500, '2024-03-25 00:00:00'),
    (231, 6000, '2024-04-10 00:00:00'),
    (232, 3500, '2024-05-15 00:00:00'),
    (233, 4500, '2024-06-20 00:00:00'),
    (234, 5500, '2024-07-12 00:00:00'),
    (235, 3000, '2024-08-18 00:00:00'),
    (236, 6500, '2024-09-25 00:00:00'),

    (237, 4000, '2024-10-10 00:00:00'),
    (238, 5000, '2024-11-15 00:00:00'),
    (239, 3500, '2024-12-20 00:00:00'),
    (240, 7000, '2025-01-12 00:00:00'),
    (241, 4500, '2025-02-18 00:00:00'),
    (242, 3000, '2025-03-25 00:00:00'),
    (243, 6000, '2025-04-10 00:00:00'),
    (244, 2500, '2025-05-15 00:00:00'),

    (245, 5000, '2025-06-20 00:00:00'),
    (246, 5500, '2025-07-12 00:00:00'),
    (247, 4000, '2025-08-18 00:00:00'),
    (248, 6500, '2025-09-25 00:00:00'),
    (249, 3500, '2025-10-10 00:00:00'),
    (250, 7000, '2025-11-15 00:00:00');





-- SELECTING ALL TABLES
SELECT * from students;

select * from programs;

select * from scholarship;



-- ==========================================================================
-- 1. Write a SQL query to fetch "FIRST_NAME" from the Student table in upper case and use ALIAS name as STUDENT_NAME.
-- ==========================================================================
select upper(first_name) as STUDENT_NAME from students;



-- ==========================================================================
-- 2. Write a SQL query to fetch unique values of MAJOR Subjects from Student table.
-- ==========================================================================
select distinct MAJOR from students; 

-- or 
select major from students group by major;



-- ==========================================================================
-- 3. Write a SQL query to print the first 3 characters of FIRST_NAME from Student table.
-- ==========================================================================
select substring(first_name, 1, 3) from students;
-- SUBSTRING(column_name, start_value, lenght)



-- ==========================================================================
-- 4. Write a SQL query to find the position of alphabet ('a') int the first name column 'Grace' from Student table.
-- ==========================================================================
SELECT strpos(first_name, 'a') from students where upper(first_name)='GRACE'



-- ==========================================================================
-- 5. Write a SQL query that fetches the unique values of MAJOR Subjects from Student table and print its length.
-- ==========================================================================
select distinct major, length(major) from students;



-- ==========================================================================
-- 6. Write a SQL query to print FIRST_NAME from the Student table after replacing 'a' with 'A'.
-- ==========================================================================
select replace(first_name, 'a', 'A') as replacedFirstName from students;
-- Replaces 'a' with 'A' in FIRST_NAME.
-- Affects only names containing 'a'.



-- ==========================================================================
-- 7. Write a SQL query to print the FIRST_NAME and LAST_NAME from Student table into single column COMPLETE_NAME.
-- ==========================================================================
select concat_ws(' ', first_name, last_name) as complete_name from students;
-- CONCAT_WS(seperator, col1, col2, col3, ...)

select concat(first_name, ' ', last_name) as complete_name from students;



-- ==========================================================================
-- 8. Write a SQL query to print all Student details from Student table order by 
-- FIRST_NAME Ascending and MAJOR Subject descending .
-- ==========================================================================
SELECT * from students order by first_name asc, major desc;



-- ==========================================================================
-- 9. Write a SQL query to print details of the Students with the FIRST_NAME as 'Noah' and 'Ava' from Student table.
-- ==========================================================================
select * from students where first_name in ('Noah', 'Ava');



-- ==========================================================================
-- 10. Write a SQL query to print details of the Students excluding FIRST_NAME as 'Jack' and 'Liam' from Student table.
-- ==========================================================================
select * from students where first_name not in ('Jack', 'Liam');



-- ==========================================================================
-- 11. Write a SQL query to print details of the Students whose FIRST_NAME ends with 'a'.
-- ==========================================================================
select * from students where first_name like '%a';



-- ==========================================================================
-- 12. Write an SQL query to print details of the Students whose FIRST_NAME ends with ‘a’ and contains five alphabets.
-- ==========================================================================
select * from students where first_name like '%a' and length(first_name)=5;

-- or
select * from students where first_name like '____a';
-- `%` => zero or more characters
-- `-` => exactly one character
-- Searches for names with exactly 5 characters ending in 'a'.
-- No records match this condition, so the result is empty.



-- ==========================================================================
-- 13. Write an SQL query to print details of the Students whose GPA lies between 9.00 and 9.99.
-- ==========================================================================
select * from students where gpa BETWEEN 9.00 and 9.99;



-- ==========================================================================
-- 14. Write an SQL query to fetch the count of Students having Major Subject ‘Computer Science’.
-- ==========================================================================
select major, count(*) from students WHERE lower(major)='computer science' group by major;



-- ==========================================================================
-- 15. Write an SQL query to fetch Students full names with GPA >= 8.5 and <= 9.5.
-- ==========================================================================
select concat_ws(' ', first_name, last_name), gpa from students where gpa BETWEEN 8.5 and 9.5;



-- ==========================================================================
-- 16. Write an SQL query to fetch the no. of Students for each MAJOR subject in the descending order.
-- ==========================================================================
select major, count(*) as no_of_major_subject from students GROUP BY major order by 2 DESC;



-- ==========================================================================
-- 17. Display the details of students who have received scholarships, including their names, 
-- scholarship amounts and scholarship dates.
-- ==========================================================================
select concat_ws(' ', st.first_name, st.last_name) as full_name,
scholarship_amount,
scholarship_date
from students st
join scholarship sc
on st.student_id = sc.student_ref_id;



-- ==========================================================================
-- 18. Write an SQL query to show only odd rows from Student table.
-- ==========================================================================
select * from students where (student_id%2)=1;



-- ==========================================================================
-- 19. Write an SQL query to show only even rows from Student table
-- ==========================================================================
select * from students where (student_id%2)=0;



-- ==========================================================================
-- 20. List all students and their scholarship amounts if they have received any. 
-- If a student has not received a scholarship, display NULL for the scholarship details.
-- ==========================================================================
select concat_ws(' ', st.first_name, st.last_name) as full_name,
coalesce(sc.scholarship_amount, 0) as amounts,
coalesce(sc.scholarship_date::TEXT, 'N/A') as SCdate
from students st
LEFT join scholarship sc
on st.student_id=sc.student_ref_id;



-- ==========================================================================
-- 21. Write an SQL query to show the top n (say 5) records of Student table order by descending GPA.
-- ==========================================================================
select * from students order by gpa DESC limit 5;



-- ==========================================================================
-- 22. Write an SQL query to determine the nth (say n=5) highest GPA from a table.
-- ==========================================================================
select * from students order by gpa desc OFFSET 4 limit 1;
-- offset 4 -> skipped 4 (four record got skipped)
-- records are already sorted from higthest to lowest so limit 1 return the 5th highest one.



-- ==========================================================================
-- 23. Write an SQL query to determine the 5th highest GPA without using LIMIT keyword.
-- ==========================================================================
select student_id, first_name, last_name, gpa, enrollment_date, major from (select *,
dense_rank() over(order by gpa desc) as rnk
from students) subQuery
where rnk=5;



-- ==========================================================================
-- 24. Write an SQL query to fetch the list of Students with the same GPA.
-- ==========================================================================
select * from students where gpa in (select gpa from students group by gpa HAVING count(*)>1);



-- ==========================================================================
-- 25. Write an SQL query to show the second highest GPA from a Student table using sub-query.
-- ==========================================================================
select max(gpa) as second_highest from students
where gpa not in (select max(gpa) from students);
-- remove the first highest using max
-- then take the max using subquery so we will get 2nd highest



-- ==========================================================================
-- 26. Write an SQL query to show one row twice in results from a table.
-- ==========================================================================
select * from students UNION all
select * from students order by student_id asc;



-- ==========================================================================
-- 27. Write an SQL query to list STUDENT_ID who does not get Scholarship.
-- ==========================================================================
select st.student_id, 
concat_ws(' ', st.first_name, st.last_name) as full_name,
coalesce(sc.scholarship_amount, 0) as amounts,
coalesce(sc.scholarship_date::TEXT, 'N/A') as SCdate
from students st
LEFT join scholarship sc
on st.student_id=sc.student_ref_id
where sc.scholarship_amount is null;

-- or
select student_id, concat_ws(' ', first_name, last_name) as full_name
from students where student_id not in (select student_ref_id from scholarship);



-- ==========================================================================
-- 28. Write an SQL query to fetch the first 50% records from a table.
-- ==========================================================================
select * from students limit (select count(*)/2 from students);



-- ==========================================================================
--  29. Write an SQL query to fetch the MAJOR subject that have less than 4 people in it.
-- ==========================================================================
select count(*), major from students 
group by 2 having count(*)<4;
-- no subject like that



-- ==========================================================================
-- 30. Write an SQL query to show all MAJOR subject along with the number of people in there.
-- ==========================================================================
select count(*) as count_of_major_sub, major as major_subject from students 
group by 2;




-- ==========================================================================
-- 31. Write an SQL query to show the last record from a table.
-- ==========================================================================
select * from students where student_id=(select max(student_id) from students);



-- ==========================================================================
-- 32. Write an SQL query to fetch the first row of a table.
-- ==========================================================================
select * from students where student_id=(select min(student_id) from students);




-- ==========================================================================
-- 33. Write an SQL query to fetch the last five records from a table.
-- ==========================================================================
select * from (select * from students order by student_id DESC limit 5) sub_query
order by student_id asc;




