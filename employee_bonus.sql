SELECT name, bonus FROM employee e
LEFT JOIN  bonus b on e.empid = b.empid
WHERE coalesce(bonus, -1) < 1000

