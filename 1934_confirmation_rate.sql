SELECT s.user_id,
       ROUND(
           CASE WHEN COUNT(c.action) = 0 THEN 0
           ELSE SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END)::DECIMAL / COUNT(c.action)
           END,
           2
       ) AS confirmation_rate
FROM signups s
LEFT JOIN confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;