-- CASE STUDY QUESTIONS

-- -Problem 1.: Company sees drop in revenue last 3 months. Find reason.


-- Solution: First, need to verify the drop in revenue using the monthly trend, then need to identify which specific product declied there revenues and 
-- lastly at which location or store these declines exist. Though the above step we can reach the conclusion.

-- Monthly revenue
-- (Tasks: 1. Monthly revenue trend, 2. Top products decline, 3.Store-wise impact)
-- Monthly revenue trend
SELECT 
  DATE_TRUNC(sf.order_date, MONTH) AS month,
  SUM(op.quantity_ordered * p.sale_price) AS total_revenue
FROM sales_fact sf
JOIN order_product_mapping op 
  ON sf.order_id = op.order_id
JOIN product_info p 
  ON op.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Top Declining Products
-- Product wise monthly revenue
SELECT 
  p.product_name,
  DATE_TRUNC(sf.order_date, MONTH) AS month,
  SUM(op.quantity_ordered * p.sale_price) AS revenue
FROM sales_fact sf
JOIN order_product_mapping op 
  ON sf.order_id = op.order_id
JOIN product_info p 
  ON op.product_id = p.product_id
GROUP BY p.product_name, month
ORDER BY p.product_name, month;

-- Store wise Impact

-- Store-wise monthly revenue
SELECT 
  b.store_name,
  DATE_TRUNC(sf.order_date, MONTH) AS month,
  SUM(op.quantity_ordered * p.sale_price) AS revenue
FROM sales_fact sf
JOIN order_product_mapping op 
  ON sf.order_id = op.order_id
JOIN product_info p 
  ON op.product_id = p.product_id
JOIN branch_details b 
  ON sf.store_id = b.store_id
GROUP BY b.store_name, month
ORDER BY b.store_name, month;

