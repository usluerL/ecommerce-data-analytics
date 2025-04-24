-- 🟡 Task 3: List customers by their total spending.
-- For each customer, calculate their total amount spent (sum of all their orders).

with co as (select c.customer_id, order_id, company_name
            from customers c
                     join orders o on c.customer_id = o.customer_id)

select customer_id, co.company_name, round(sum(o.unit_price * quantity)::numeric, 2) total_spent
from order_details o
join co on co.order_id = o.order_id
group by  co.customer_id, co.company_name
order by customer_id, total_spent desc
