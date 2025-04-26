/*

Find customers who have a total spending greater than 5000.
	•	Calculate each customer’s total spending (unit_price * quantity).
	•	Label them as ‘VIP’ if their total spending > 5000, otherwise ‘Regular’.
	•	Only show VIP customers (use HAVING).

Show:
	•	customer_id
	•	company_name
	•	total_spending
	•	customer_status (VIP or Regular)

*/
SELECT *
FROM order_details;
SELECT *
FROM orders;
SELECT *
FROM customers;

WITH customer_total_spending AS (SELECT o.customer_id,
                                        cu.company_name,
                                        ROUND(SUM(unit_price * quantity)::numeric, 2) total_amount

                                 FROM orders o
                                          JOIN order_details od ON o.order_id = od.order_id
                                          JOIN customers cu ON cu.customer_id = o.customer_id
                                 GROUP BY o.customer_id, company_name)
SELECT customer_id,
       company_name,
       total_amount,
       CASE
           WHEN total_amount > 30000 THEN 'PLATINUM VIP'
           WHEN total_amount > 20000 THEN 'GOLD VIP'
           WHEN total_amount > 10000 THEN 'SILVER VIP'

           ELSE 'REGULAR' END AS customer_status
FROM customer_total_spending
WHERE total_amount > 5000
ORDER BY total_amount DESC

