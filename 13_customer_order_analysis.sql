/* Analyze the relationship between customers and their orders using different types of JOINs.
**/

-- List all customers and their orders.
-- If a customer has no orders, still show the customer.

SELECT c.customer_id, company_name, o.order_id
FROM customers c
         LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY company_name;

--E

SELECT c.customer_id, o.order_id FROM orders o
LEFT JOIN  customers c on o.customer_id = c.customer_id
WHERE c.customer_id is NULL

UNION

SELECT c.customer_id, order_id FROM customers c
LEFT JOIN orders o on c.customer_id = o.customer_id
WHERE o.order_id is NULL;

