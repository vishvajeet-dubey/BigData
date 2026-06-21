-- create temp table orders (date_col date);

insert into orders VALUES('2026-01-23'),
('2023-09-12')

select to_char(date_col, 'YYYY') as years from orders


select concat(12,'|', 'asfd')