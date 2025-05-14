SELECT
  p.product_id,
  ROUND(
    CASE
      WHEN SUM(u.units) > 0 THEN SUM(p.price * u.units)::numeric / SUM(u.units)
      ELSE 0
    END,
    2
  ) AS average_price
FROM
  prices p
    LEFT JOIN unitssold u
ON
    p.product_id = u.product_id
    AND
    u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id


