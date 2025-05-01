-- List all suppliers and their corresponding products.
-- If a supplier has no products, still show the supplier.

SELECT * FROM suppliers s
LEFT JOIN products p on s.supplier_id = p.supplier_id;


SELECT * FROM suppliers s
RIGHT JOIN  products p on s.supplier_id = p.supplier_id;

SELECT * FROM suppliers s
FULL JOIN  products p on s.supplier_id = p.supplier_id;

SELECT * FROM suppliers s
CROSS JOIN  products p;


SELECT product_id, product_name, NULL as supplier_id FROM products p
LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.supplier_id is NULL;




with sp as (SELECT * FROM suppliers s
FULL JOIN   products p on s.supplier_id = p.supplier_id)
SELECT count(*) FROM sp

