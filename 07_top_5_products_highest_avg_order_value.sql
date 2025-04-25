-- /*--Task 7: Find the top 5 products with the highest average order value.
--
-- For each product, calculate:
-- 	•	the average revenue per order (unit_price * quantity)
-- 	•	list the top 5 products with the highest average per order*/


SELECT  od.product_id, product_name,  round(avg(quantity * od.unit_price)::numeric,2) as avg_order_value
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY  od.product_id, product_name
ORDER BY avg_order_value DESC
LIMIT 5

