/*For each customer, list their orders ranked by order date (oldest first).
Also include the total order amount (calculated by summing unit_price * quantity from order_details table for each order).
Only include orders where the total amount is greater than $1000.*/

SELECT o.order_id,
       o.customer_id,
       ROUND(SUM(unit_price * quantity)::numeric, 2) AS total_amount,
       o.order_date,
       row_number() OVER (PARTITION BY o.customer_id ORDER BY  order_date) as order_rank
FROM orders o
         JOIN order_details ON o.order_id = order_details.order_id
GROUP BY o.order_id, o.customer_id, o.order_date
HAVING SUM(unit_price * quantity) > 1000
ORDER BY total_amount DESC