/************************
 * 
 * Assignment 3
 * Meag Tessmann
 * u1120583
 * IS 6420 Database Design and Theory
 * Submitted 3-14-2021
 *
 *************************/


-- 1: List the ID, name, and price for all products with a price greater than the average product price.

select product_id, product_name , product_price 
from product
where product_price::numeric > 
	(select avg(product_price::numeric) from product p2 )
;


-- 2: For each product, list its ID and total quantity ordered. Products should be listed in ascending order of the product ID.

select p.product_id , sum(ol.quantity) as total_quantity_ordered
from order_line ol 
inner join product p 
on p.product_id = ol.product_id 
group by p.product_id 
order by product_id 
;

-- 3: For each product, list its ID and total quantity ordered. Products should be listed in descending order of total quantity ordered.

select p.product_id , sum(ol.quantity) as total_quantity_ordered
from order_line ol 
inner join product p 
on p.product_id = ol.product_id 
group by p.product_id 
order by sum(ol.quantity) desc
;

-- 4: For each product, list its ID, name and total quantity ordered. Products should be listed in ascending order of the product name.

select p.product_id, p.product_name , sum(ol.quantity) as total_quantity_ordered
from order_line ol 
inner join product p 
on p.product_id = ol.product_id 
group by p.product_id 
order by p.product_name 
;

-- 5: List the name for all customers, who have placed 20 or more orders. Each customer name should appear exactly once. Customer names should be sorted in ascending alphabetical order.

select c.customer_name, count(oh.order_id)
from order_header oh 
inner join customer c 
on c.customer_id  = oh.customer_id 
group by c.customer_name 
having count(oh.order_id) > 19
order by count(oh.order_id) desc
;

-- 6: Implement the previous query using a subquery and IN adding the requirement that the customers’ orders have been placed after October 23, 2019.

select c.customer_name, count(oh.order_id)
from order_header oh 
inner join customer c 
on c.customer_id  = oh.customer_id 
where oh.customer_id in (select customer_id from order_header where order_date > '10-23-2019')
group by c.customer_name 
having count(oh.order_id) > 19
order by count(oh.order_id) desc
;

------- checking that dates are actually being filtered
/*
select c.customer_name, count(oh.order_id)
from order_header oh 
inner join customer c 
on c.customer_id  = oh.customer_id 
where oh.customer_id in (select customer_id from order_header where order_date > '10-23-2020')
group by c.customer_name 
having count(oh.order_id) > 19
order by count(oh.order_id) desc;
*/


-- 7:For each city, list the number of customers from that city, who have placed 5 or more orders. Cities are listed in ascending alphabetical order.


drop view if exists cust_with_over_5_orders;
CREATE VIEW cust_with_over_5_orders AS
SELECT customer_id, count(order_id) as number_orders
FROM order_header
group by customer_id 
;
-- select * from cust_with_over_5_orders;

select c3.city, count(*)
from customer c3
join cust_with_over_5_orders co
using (customer_id)
where co.number_orders > 5
group by c3.city 
order by c3.city
;



-- 8: Implement the previous using a subquery and IN.

select city, count(*)
from customer c 
where customer_id in (
	select customer_id 
	from order_header oh
	group by customer_id 
	having count(order_id) > 5
	)
group by city
order by city
;
	
	
-- 9: List the ID for all products, which have NOT been ordered since October 28, 2019. Sort your results by the product id in ascending order.  Use EXCEPT for this query.

select p.product_id 
from product p
except
select p2.product_id 
from product p2 
inner join order_line ol 
on ol.product_id = p2.product_id 
inner join order_header oh
on ol.order_id = oh.order_id 
where order_date > '10-28-2019'
group by p2.product_id 
order by product_id 
;

----- a quick double check on when each product was last ordered shows each product has been ordered in 2021
/*
select p.product_id,  max(order_date) as last_ordered
from order_header oh 
inner join order_line ol 
using (order_id)
inner join product p 
on ol.product_id  = p.product_id 
group by p.product_id 
order by p.product_id 
;
 */

--10: List the ID for all Arizona customers, who have placed one or more orders since October 28, 2019. Sort the results by the customer id in ascending order.  Use Intersect for this query.


select customer_id 
from customer c 
where lower(c.state_province) in ('az', 'arizona')
intersect 
select customer_id
from order_header oh 
where order_date > '10-28-2019'
order by customer_id 
;

-- 11: Implement the previous query using a subquery and IN.

select customer_id 
from customer c 
where lower(c.state_province) in ('az', 'arizona')
and customer_id  in (
	select customer_id
	from order_header oh 
	where order_date > '10-28-2019'
	)
order by customer_id 
;

-- 12: List the IDs for all California customers along with all customers (regardless where they are from) who have placed one or more order(s) since October 28, 2019. Sort the results by the customer id in ascending order.  Use union for this query.
-- NOTE: it's unclear whether the question was specifying the date filtering for all customers or for californian cusotmers, too. I'm assuming (all california customers) & (all customers since oct 28, 2019)

select customer_id 
from customer c 
where lower(c.state_province) in ('ca', 'california')
union 
select customer_id 
from customer c2 
where customer_id in (
	select customer_id  
	from order_header oh 
	where order_date > '10-28-2019'
	)
order by customer_id asc 
;

-- 13: List the ID, name and total quantity ordered for all products with total quantity ordered greater than 10.

select c.customer_id , c.customer_name , sum(ol.quantity) as total_quantity
from customer c 
inner join order_header oh 
using (customer_id)
inner join order_line ol 
on oh.order_id = ol.order_id 
group by c.customer_id, c.customer_name 
having sum(ol.quantity) > 10
order by total_quantity
;

-- 14: List the ID, name and total quantity ordered for all products with total quantity ordered greater than 4 and were placed by Utah customers.

select c.customer_id , c.customer_name , sum(ol.quantity) as total_quantity
from customer c 
inner join order_header oh 
using (customer_id)
inner join order_line ol 
on oh.order_id = ol.order_id 
where lower(c.state_province) in ('ut', 'utah')
group by c.customer_id, c.customer_name 
having sum(ol.quantity) > 4
order by total_quantity
;














