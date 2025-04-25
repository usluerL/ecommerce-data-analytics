-- Task 5: List total sales revenue per month.

-- For each month, calculate: -
--•	  the total revenue (sum of unit_price * quantity) from all orders


WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR FROM o.order_date) AS year,
        EXTRACT(MONTH FROM o.order_date) AS month,
        od.unit_price,
        od.quantity
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
)
SELECT
    year,
    month,
    ROUND(SUM(unit_price * quantity)::numeric, 2) AS total_amount
FROM monthly_sales
GROUP BY year, month
ORDER BY year, month;

