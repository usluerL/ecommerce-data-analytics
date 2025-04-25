/*

Task 8: List customers who have a total spending above the average customer spending.

For each customer:
	•	Calculate their total spending (SUM of unit_price * quantity across all their orders)
	•	Find the average spending of all customers
	•	Only list customers whose total spending is greater than that average.

*/

WITH customer_spending AS
         (SELECT c.customer_id, company_name, SUM(unit_price * quantity) AS total_amount
          FROM customers c
                   JOIN orders o ON c.customer_id = o.customer_id
                   JOIN order_details od ON od.order_id = o.order_id
          GROUP BY c.customer_id, company_name),
     avg_spent_by_customer AS (select avg(total_amount) avg_spent
                               FROM customer_spending
                               )
SELECT cs.customer_id, company_name, round(total_amount::numeric,2) as total_spent from customer_spending cs
CROSS JOIN avg_spent_by_customer
WHERE total_amount > avg_spent