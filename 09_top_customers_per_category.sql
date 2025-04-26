/*Task 9: List the customers who have the highest total spending per product category.

For each product category:
	•	Find the customer who has the highest total revenue (unit_price * quantity) for that category.
	•	If multiple customers tie, pick any.*/

/*
	•	products - category_id, product_id
	•	order_details order_id, product_id -- total price
	•	orders - order_id - customer-id
	•	customers
	-   categories. - category_id - category_name


*/

-- total customer revenue per category.

WITH customer_revenue_per_category AS
         (SELECT ca.category_id,
                 category_name,
                 c.customer_id,
                 company_name,
                 SUM(p.unit_price * quantity) AS total_revenue
          FROM categories ca
                   JOIN products p ON ca.category_id = p.category_id
                   JOIN order_details od ON p.product_id = od.product_id
                   JOIN orders o ON od.order_id = o.order_id
                   JOIN customers c ON c.customer_id = o.customer_id
          GROUP BY ca.category_id, category_name, c.customer_id, company_name
          ORDER BY category_id),
     category_max_revenue AS (SELECT category_id, MAX(total_revenue) AS max_amount
                              FROM customer_revenue_per_category
                              GROUP BY category_id)
SELECT crpc.category_id, category_name, company_name, customer_id, ROUND(crpc.total_revenue)
FROM customer_revenue_per_category crpc
         JOIN category_max_revenue cmr ON crpc.category_id = cmr.category_id
    AND crpc.total_revenue = cmr.max_amount
