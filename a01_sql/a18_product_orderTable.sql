-- dropping the table if it already exists
drop table if exists products;
drop table if exists orders;




-- product table 
create table if not exists products
(
    product_id int primary KEY,
    name VARCHAR not null,
    rate_per_unit DECIMAL(10,2) not null
);





-- order table 
create table if not exists orders 
(
    order_id int PRIMARY KEY,
    order_date DATE,
    product_id int,
    quantity int, 
    CONSTRAINT fk_orders_product
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
)






-- truncating the tables
TRUNCATE table products CASCADE;
TRUNCATE table orders CASCADE;






-- Additional Products
INSERT INTO products (product_id, name, rate_per_unit)
VALUES
    (1, 'Laptop', 55000.00),
    (2, 'Mouse', 800.00),
    (3, 'Keyboard', 1500.00),
    (4, 'Monitor', 12000.00),
    (5, 'Headphones', 2500.00),
    (6, 'Webcam', 3500.00),
    (7, 'Printer', 8500.00),
    (8, 'USB Cable', 450.00),
    (9, 'External Hard Drive', 6500.00),
    (10, 'SSD 1TB', 7500.00),
    (11, 'Tablet', 22000.00),
    (12, 'Smartphone', 28000.00),
    (13, 'Power Bank', 1800.00),
    (14, 'Router', 3200.00),
    (15, 'Speakers', 4200.00);






-- Additional Orders
INSERT INTO orders (order_id, order_date, product_id, quantity)
VALUES
    (106, '2026-09-01', 5, 4),
    (107, '2026-09-01', 6, 2),
    (108, '2026-09-02', 1, 1),
    (109, '2026-09-02', 2, 10),
    (110, '2026-09-02', 7, 2),
    (111, '2026-09-03', 8, 15),
    (112, '2026-09-03', 9, 3),
    (113, '2026-09-04', 10, 5),
    (114, '2026-09-04', 11, 2),
    (115, '2026-09-04', 12, 3),
    (116, '2026-09-05', 13, 8),
    (117, '2026-09-05', 14, 4),
    (118, '2026-09-05', 15, 6),
    (119, '2026-09-06', 1, 2),
    (120, '2026-09-06', 5, 3),
    (121, '2026-09-06', 9, 1),
    (122, '2026-09-07', 10, 4),
    (123, '2026-09-07', 12, 2),
    (124, '2026-09-07', 3, 7),
    (125, '2026-09-08', 4, 3),
    (126, '2026-09-08', 6, 5),
    (127, '2026-09-08', 7, 1),
    (128, '2026-09-09', 8, 20),
    (129, '2026-09-09', 11, 3),
    (130, '2026-09-09', 13, 10);



select * from products;
select * from orders;




-- 1. Get the product details with highest sales_value (order.quantity * product.rate_per_unit) in below field format.
-- 	- product_id, name, sales_value
-- option 1
with highest_Sales_value as (
    select p.product_id,
    p.name,
    sum(o.quantity * p.rate_per_unit) as sales_value
    from products p
    inner join orders o
    on p.product_id = o.product_id
    group by p.product_id, p.name
)
select product_id,
name,
sales_value from(
select product_id,
name,
sales_value,
dense_rank() over(order by sales_value DESC) as rnk
from highest_Sales_value
) subQuery where rnk=1;

-- option2
select p.product_id,
p.name,
sum(o.quantity * p.rate_per_unit) as sales_value
from products p
inner join orders o
on p.product_id = o.product_id
group by p.product_id, p.name
order by sum(o.quantity * p.rate_per_unit) desc limit 1;




 
-- 2. For each order date,
-- 	2.1 - Get the Highest Product sold in terms of number of units sold
-- 	2.2 - Get the total sales amount on the day
-- 	- order_date, highest_sold_product_name, total_sales_amount
with total_sales_per_day as
    (select p.product_id,
            p.name,
            o.order_date,
            sum(o.quantity) as unit_sold,
            sum(o.quantity * p.rate_per_unit) as total_sales_for_product
     from products p
     inner join orders o on p.product_id = o.product_id
     group by p.product_id,
              p.name,
              o.order_date)
select order_date,
       name as highest_sold_product_name,
       total_sales_amount
from
    (select order_date,
            name,
            sum(total_sales_for_product) over(partition by order_date) as total_sales_amount,
            dense_rank() over(partition by order_date
                              order by unit_sold desc) as rnk
     from total_sales_per_day) subQry
where rnk=1;







-- 3. For each order date,
-- 	3.1 - Get the Highest Product sold in terms of greatest sales amount for the product for that day
-- 	3.2 - Get the total sales amount on the day
-- 	- order_date, highest_sold_product_name, total_sales_amount_for_day
with total_sp_product_per_Day_CTE as
    (select p.product_id,
            p.name,
            o.order_date,
            sum(p.rate_per_unit*o.quantity) as total_sp_product
     from products p
     inner join orders o on p.product_id = o.product_id
     group by p.product_id,
              p.name,
              o.order_date)
select order_date,
       name,
       total_sales_amount_for_day
from
    (select order_date,
            name,
            sum(total_sp_product) over(partition by order_Date) total_sales_amount_for_day,
                                  dense_rank() over(partition by order_date
                                                    order by total_sp_product desc) as rnk
     from total_sp_product_per_Day_CTE) subQuery
where rnk=1;