/*
For each customer, list their orders along with the total amount of each order.
Additionally, show the total amount of the *previous order* for the same customer
and the difference between the current and previous order.

Columns:
- customer_id
- order_id
- total_amount
- previous_total_amount
- diff_with_previous

Hint:
Use LAG() over (PARTITION BY customer_id ORDER BY order_date).
*/

-- Your query here


WITH order_amount AS (SELECT o.customer_id,
                             o.order_id,
                             ROUND(SUM(unit_price * quantity)::NUMERIC, 2)         AS current_total,
                             LAG(ROUND(SUM(unit_price * quantity)::NUMERIC, 2))
                             OVER (PARTITION BY customer_id ORDER BY o.order_date) AS previous_total

                      FROM orders o
                               JOIN order_details od ON o.order_id = od.order_id
                      GROUP BY o.customer_id, o.order_id, o.order_date)
SELECT customer_id,
       order_id,
       current_total,
       previous_total,
       (current_total - previous_total) AS diff_with_prev
FROM order_amount

