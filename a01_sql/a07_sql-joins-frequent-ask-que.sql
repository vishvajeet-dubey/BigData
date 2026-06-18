/*
SCENARIO 1

------------------
TABLE 1
------------------
1
1
1
2
3
3
3
------------------

------------------
TABLE 2
------------------
1
1
2
2
4
null
------------------


Que 1. What is the output of the inner join ?
Que 2. What is the output of the left join ?
Que 3. Waht is the output of the right join ?
Que 4. Waht is the output of the full join ?
Que 5. Waht is the output of the cross join ?
Que 6. Waht is the output of the natural join ?

*/

-- create table
create table if not exists test.table1(id int);
create table if not exists test.table2(id int);

-- insert the above data into both tables
insert into test.table1(id) values
(1),
(1),
(1),
(2),
(3),
(3),
(3);


insert into test.table2(id) values
(1),
(1),
(2),
(2),
(4),
(null);
--------------
select * from test.table1;
select * from test.table2;


-- Que 1. What is the output of the inner join ?
/*
Ans 1:
inner join = matching record from both table
Below is the table data
T1   T2
1    1
1    1
1    2
2    2
3    4
3    null
3

after applying inner join sql will be going to perform internally like below
T1
1 --> 1 present twice in T2 
1 --> 1 present twice in T2  
1 --> 1 present twice in T2 
2 --> 2 present twice in T2 
3 --> 3 not present in T2
3 --> 3 not present in T2
3 --> 3 not present in T2

so final output will be
1 1
1 1
1 1
1 1
1 1
1 1
2 2
2 2
*/


select * from test.table1 t1
inner join test.table2 t2
on t1.id = t2.id;

/* OUTPUT
1	1
1	1
1	1
1	1
1	1
1	1
2	2
2	2
*/


--Que 2. What is the output of the left join ?
--ANS 2:
--left join = inner join + any additional record from left table which is not present in right.

select * from test.table1 t1
left join test.table2 t2
on t1.id = t2.id;

/* OUTPUT
1	1
1	1
1	1
1	1
1	1
1	1
2	2
2	2
3	null
3	null
3	null
*/



--Que 3. Waht is the output of the right join ?
--ANS 3:
--right join = inner join + any additional record from right table which is not present into the left table.

select * from test.table1 t1
right join test.table2 t2
on t1.id = t2.id;

/* OUTPUT
1		1
1		1
1		1
1		1
1		1
1		1
2		2
2		2
null	4
null	null
*/


--Que 4. Waht is the output of the full join ?
--ANS 4: 
--full join = inner join
--			+ any additional record from left table which is not present in right table
--			+ any additional record from right table which is not present in left table.
--	

select * from test.table1 t1
full join test.table2 t2
on t1.id = t2.id;

/* OUTPUT
1		1
1		1
1		1
1		1
1		1
1		1
2		2
2		2
3		null
3		null
3		null
null	4
null	null
*/



--Que 5. Waht is the output of the cross join ?
--ANS 5: 
--Cartesian product, where every record from the left table joins with every record from the right table
--if table1 7 and table2 6 then final output is 42
--No joining condition is required.

select * from test.table1 t1 
cross join test.table2 t2;




--Que 6. Waht is the output of the natural join ?
--ANS 6: 
--natural join = 
--	if same column name present in left and right table then inner join
--	else same column name not present in left and right table then cross join
-- No joining condition is required.

select * from test.table1 t1
natural join test.table2 t2
-- will return the inner join result as same name id column present in both table.


--lets create table3 with diff column name which is `id_new`
create table if not exists test.table3 as select * from test.table2;


-- change the id column from table3 to `id_new`
alter table test.table3 rename column id to id_new;


-- fetch table3
select * from test.table3 t3;

-- since column names are not matching between both table, cross join will perform
select * from test.table1 t1
natural join test.table3 t3


