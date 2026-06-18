 /* what is the output of the left, right and inner join of the below tableA and tableB */
 
 
-- Table A
--create table if not exists tableA (
--	id int
--);
--
--insert into tableA(id) values
--(1),
--(1),
--(1);


 
--tableB
--create table if not exists tableB (id int);
--
--insert into tableB(id) values
--(1),
--(1),
--(1),
--(1);


 
--Inner join
select a.id, b.id from tablea a
inner join tableb b
on a.id = b.id;
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
-- it will return the 1 1, 12 times as every 1 from tableA will match 4 times in tableB as 1 present 4 times in tableB.
-- so the final result will be 1 1, 12 timess


--Left join 
select a.id, b.id from tablea a
left join tableb b
on a.id = b.id;
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
-- it will return the 1 1, 12 times as every 1 from tableA will match 4 times in tableB and 
-- there are no any aditional values present in tableA which not matching with tableB.
-- so the final result will be 1 1, 12 timess



--Right join
select a.id, b.id from tablea a
right join tableb b
on a.id = b.id;
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
--1	1
-- it will return the 1 1, 12 times as every 1 from tableB will match 3 times in tableA and 
-- there are no any aditional values present in tableB which not matching with tableA.
-- so the final result will be 4 * 3 which are 1 1, 12 timess
