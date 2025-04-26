-- For each product category, find the customer who purchased the most total quantity of products.
-- 	•	Show category_id, category_name, customer_id, company_name, total_quantity.
-- 	•	If multiple customers tie, pick any.


--for each category total quantity
WITH customer_category_quantity AS (SELECT c.category_id,
                                           category_name,
                                           cu.company_name,
                                           o.customer_id,
                                           SUM(quantity) total_quantity
                                    FROM order_details od
                                             JOIN products p ON od.product_id = p.product_id
                                             JOIN categories c ON p.category_id = c.category_id
                                             JOIN orders o ON od.order_id = o.order_id
                                             JOIN customers cu ON cu.customer_id = o.customer_id
                                    GROUP BY c.category_id, category_name, o.customer_id, cu.company_name
                                    ORDER BY c.category_id),
-- For each category, find the maximum total quantity purchased.
      max_category AS (SELECT category_id,
                             category_name,
                             MAX(total_quantity) max_quantity
                      FROM customer_category_quantity ccq
                      GROUP BY category_id, category_name
                      ORDER BY category_id)
SELECT ccq.category_id,
       ccq.category_name,
       ccq.company_name,
       ccq.customer_id,
       ccq.total_quantity as total_max_quantity
FROM customer_category_quantity ccq
         JOIN max_category mc ON ccq.category_id = mc.category_id
    AND ccq.total_quantity = mc.max_quantity
ORDER BY category_id



