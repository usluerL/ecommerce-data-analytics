-- 🟡 Task 2: List total sales and quantity per product.
select p.product_id,
       product_name,
       round(sum(o.unit_price * quantity)::numeric, 2) total_revenue,
       sum(quantity)                                   total_quantity_sold
from products p
         join order_details o on p.product_id = o.product_id
group by p.product_id, product_name
order by total_revenue desc;