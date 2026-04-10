-- Get all customers
select * from customer_info;


-- Get all products with sale price > 50
select product_name, sale_price
from product_info
where sale_price>50;


-- Get all orders with order date
select order_id, order_date
from sales_fact;

-- Get all stores in a specific city >> 'Mumbai'
select store_name, city 
from branch_details
where city = 'Mumbai';

-- Get products from 'Milk' category
select product_name
from product_info
where product_category = 'milk';

-- Get customer name with their orders
select s.order_id, c.first_name, c.last_name 
from sales_fact as s  join customer_info as c
on s.customer_id= c.customer_id ;

-- Get product names with quantity ordered
select p.product_name, sum(o.quantity_ordered) as quantity_ordered
from product_info as p join order_product_mapping as o
on p.product_id = o.product_id
group by p.product_name;

-- Get store-wise orders
select s.order_id, b.store_name
from sales_fact s  join branch_details b
on s.store_id = b.store_id;

-- Get full order details (customer + product)
select sf.order_id, ci.first_name, ci.last_name, pi.product_name, op.quantity_ordered
from customer_info ci 
join sales_fact sf on ci.customer_id = sf.customer_id  
join order_product_mapping op on sf.order_id = op.order_id
join product_info pi on op.product_id = pi.product_id;

-- Calculate total amount per order line

select sf.order_id, pi.product_name, op.quantity_ordered, pi.sale_price, op.quantity_ordered * pi.sale_price as tot_amt
from 
sales_fact sf 
join order_product_mapping op on sf.order_id = op.order_id
join product_info pi on op.product_id = pi.product_id;


-- -------------------------------------------------------
-- Total revenue per customer
select ci.customer_id, ci.first_name, sum(op.quantity_ordered * pi.sale_price) as tot_revenue
from customer_info ci 
join sales_fact sf on ci.customer_id = sf.customer_id  
join order_product_mapping op on sf.order_id = op.order_id
join product_info pi on op.product_id = pi.product_id
GROUP BY ci.customer_id, ci.first_name;

-- Top 3 selling products (by quantity)
select op.product_id, pi.product_name, sum(op.quantity_ordered) as total_quantity
from order_product_mapping op 
join product_info pi on op.product_id = pi.product_id
group by op.product_id, pi.product_name
order by total_quantity desc
limit 3;

-- Store-wise total revenue
select bd.store_id, bd.store_name, sum(quantity_ordered*sale_price) as revenue
from branch_details bd 
join sales_fact sf on bd.store_id = sf.store_id
join order_product_mapping op on sf.order_id = op.order_id
join product_info pi on op.product_id = pi.product_id
group by bd.store_id, bd.store_name;

-- Customers who never placed any order
select ci.first_name, ci.last_name
from customer_info ci 
left join sales_fact sf on ci.customer_id = sf.customer_id
where sf.order_id is null;

-- Most profitable product (highest revenue)
select op.product_id, pi.product_name, sum(op.quantity_ordered*sale_price) as total_profit
from order_product_mapping op 
join product_info pi on op.product_id = pi.product_id
group by op.product_id, pi.product_name
order by total_profit desc
limit 1;

-- Daily revenue trend
select DATE(sf.order_date) as Day_Details, sum(op.quantity_ordered*pi.sale_price)
from sales_fact sf 
join order_product_mapping op on sf.order_id = op.order_id
join product_info pi on op.product_id = pi.product_id
group by Day_Details
order by Day_Details;




