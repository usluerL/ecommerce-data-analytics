--  Task 1: List each order with its total amount.

select o.order_id,  round(sum(unit_price * quantity)::numeric,2) as total_amount
from orders o
         join order_details od on o.order_id = od.order_id
group by o.order_id
order by order_id