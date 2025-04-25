-- Task 6: List top 5 customers by total revenue in the last full year.
-- For the most recent full year (e.g., 1997 if today is 1998), list the top 5 customers who spent the most.


WITH month_year AS (SELECT EXTRACT(YEAR FROM order_date) AS order_year,
                                    COUNT(DISTINCT EXTRACT(MONTH FROM order_date)) AS month_count
                    FROM orders
                    GROUP BY order_year),
     last_full_year AS (SELECT MAX(order_year) AS order_year
                        FROM month_year
                        WHERE month_count = 12),
     order_revenue AS
         (SELECT o.customer_id,
                 o.order_id,
                 ROUND(SUM(unit_price * quantity)::numeric, 2) AS total_revenue,
                 EXTRACT(YEAR FROM order_date) AS order_year
          FROM orders o
                   JOIN order_details od ON o.order_id = od.order_id
          GROUP BY o.customer_id, o.order_id, o.order_date)
SELECT c.customer_id,
       c.company_name,
       SUM(orrev.total_revenue) AS total_spent
FROM order_revenue  orrev
         JOIN customers c ON orrev.customer_id = c.customer_id
         JOIN last_full_year ON orrev.order_year = last_full_year.order_year
GROUP BY c.customer_id, c.company_name
ORDER BY total_spent DESC
LIMIT 5
