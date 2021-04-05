-- Meag Tessmann
-- u1120583
-- IS 6420 Database Design/Theory


-- Guided

-- List of IDs

select distinct product_id
from order_line ol 
order by product_id asc;

-- 2:  List IDs of customers that have placed orders after October 27, 2019.  One ID appears exactly one time. Order customer IDs in ascending order.

select distinct customer_id 
from order_header oh 
where order_date > '2019-10-27'
order by customer_id asc;

-- 3: List all customer names for customers who are from Salt Lake City and whose first name starts with the letter ‘J’.

select customer_name 
from customer c 
where lower(city ) = 'salt lake city'
and lower(customer_name) like 'j%';

-- 4: List the product name, product price and product price after 10% discount.

select product_name ,product_price , product_price *.9 as discount_price
from product p2;

-- 5: List the number of products with a price higher than $100. 

select count(*)
from product p 
where product_price >'$100';


--- 6: List name and price for all products that have been purchased on order 1001. Use a subquery and IN to implement this query.

select product_name , product_price 
from product p 
where product_id  in (select product_id
from order_line ol where order_id  = 1001);

-- 7: List the order id and the order date for each order from an Arizona customer.  Sort the result by the date descending.

select order_id , order_date 
from order_header oh 
where customer_id  in (select customer_id 
from customer c2 
where lower(state_province) in ('az', 'arizona')
)
order by order_date desc ;


---------
-- Challenge 1
---------


-- 1: Select all rows from the customer table, but add a column called is_vip_customer where 1 indicates customers who have placed at least 10 orders and 0 indicates customers who have placed 9 or less orders (Note: VIP = Very Important Person).  The result should have those who are VIP customers first, then those are not VIP.  Within these two groups, sort by state/province ascending, then city ascending.

select c.address_line_1, c.city, c.customer_id , c.customer_name , c.postal_code , c.state_province , (case when count(oh.customer_id)>10 then '1' else '0' end) as is_vip_customer
from customer c 
join order_header oh 
on c.customer_id = oh.customer_id 
group by c.customer_id 
order by is_vip_customer desc, c.state_province asc, c.city asc;

-- checks: 
-- select * from order_header oh  where customer_id = 652
-- select * from order_header oh  where customer_id = 273


-- 2: List the order id, date and total dollar amount for the top 10 orders by dollar amount.  Sort the result by the date ascending and then the total amount descending. (hint: you will need to join tables to get product price and quantity)

select * from (
	select oh2.order_id as order_id, oh2.order_date as order_date, sum(ol.quantity * p2.product_price) as total_amount
	from order_line ol 
	inner join order_header oh2 
	on oh2.order_id = ol.order_id 
	inner join product p2 
	on p2.product_id = ol.product_id 
	group by oh2.order_id 
	order by sum(ol.quantity * p2.product_price) desc , oh2.order_date asc
	limit 12) as foo
where total_amount is not null
order by order_date asc, total_amount desc;



----------
-- Challenge 2
----------

-- 1. 1.	Remove the customer “Pavia Vanyutin” from the database.

delete from order_line 
where order_id in (select order_id from order_header where customer_id = 18);

delete from order_header 
where customer_id in (select customer_id from customer where customer_name = 'Pavia Vanyutin');

delete from customer 
where customer_name = 'Pavia Vanyutin';



-- 2: 2.	Remove the customer “Rania Kyne” from the database using only three (3) separate delete statements, none of which can include the hard-coded value (i.e. 8) of Rania Kyne’s customer id

--  select * from customer limit 10;

delete from order_line 
where order_id in (select order_id from order_header where customer_id in (
	select customer_id from customer where customer_name = 'Rania Kyne')
	)
;

delete from order_header 
where customer_id in (
	select customer_id from customer where customer_name = 'Rania Kyne')
;

delete from customer 
where customer_name = 'Rania Kyne';



-- 3: 3.	Delete the customer “Allistir Rickett” from the customer table, followed by their order header records, followed by their order line records.

alter table order_line 
drop constraint order_line_fkey_order_id;

alter table order_header 
drop constraint order_fkey_customer_id;

delete from customer where customer_name = 'Allistir Rickett';


-- 4: Re-add any constraints that were dropped in order to meet the requirements for step 1.

INSERT INTO customer (customer_id, customer_name, address_line_1, city, state_province, postal_code)
    VALUES (1, 'Allistir Rickett', '21979 Crescent Oaks Parkway', 'Fort Worth', 'TX', '76198');

alter table order_line 
	add constraint order_line_fkey_order_id
	foreign key (order_id)
	references order_header (order_id)
	on delete cascade;

alter table order_header 
	add constraint order_header_fkey_customer_id
	foreign key (customer_id)
	references customer (customer_id)
	on delete cascade;

-- test
 delete from customer where customer_id =2;
 select * from order_header oh where customer_id =2;

