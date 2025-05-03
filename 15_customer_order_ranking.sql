/*
For each customer, list their orders ranked by total order amount (highest first).
For each order, show:
	•	the row number
	•	the rank
	•	the dense rank
according to total order amount within that customer.
*/

SELECT o.customer_id,
       o.order_id,
       ROUND(SUM(unit_price * quantity)::numeric, 4) AS total_amount,
       rank() OVER(PARTITION BY o.customer_id ORDER BY SUM(unit_price * quantity)  ) as total_order_rank,
       dense_rank() OVER(PARTITION BY o.customer_id ORDER BY SUM(unit_price * quantity) ) as total_order_dense_rank
FROM orders o
         JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.customer_id, o.order_id;



WITH order_totals AS (
    SELECT o.customer_id,
           o.order_id,
           ROUND(SUM(unit_price * quantity)::numeric, 4) AS total_amount
    FROM orders o
             JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.customer_id, o.order_id
)

SELECT customer_id,
       order_id,
       total_amount,
       ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY total_amount DESC) AS row_number,
       RANK() OVER(PARTITION BY customer_id ORDER BY total_amount DESC) AS total_order_rank,
       DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY total_amount DESC) AS total_order_dense_rank
FROM order_totals;