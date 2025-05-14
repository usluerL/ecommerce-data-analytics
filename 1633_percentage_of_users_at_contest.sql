SELECT r.contest_id,
       ROUND(
               COUNT(DISTINCT r.user_id) * 100.0 /
               (SELECT COUNT(*) FROM users) ,
       2 ) AS percentage
FROM users u
    JOIN register r
ON u.user_id = r.user_id
GROUP BY r.contest_id
ORDER BY percentage DESC, contest_id



