--  Task 4: List categories by total revenue.
--For each product category, calculate:
-- the total revenue from all its products (based on order details)

with po_revenue as
         (select product_id,
                 (unit_price * quantity) as total_revenue
          from order_details
          group by product_id, order_id)

select c.category_id, category_name, round(sum(po_revenue.total_revenue)::numeric, 2) as total_revenue
from categories c
         join products p on c.category_id = p.category_id
         join po_revenue on po_revenue.product_id = p.product_id
group by c.category_id, category_name
order by total_revenue DESC;




