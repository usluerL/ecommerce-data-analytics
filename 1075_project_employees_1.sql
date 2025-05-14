SELECT  p.project_id, round(sum(experience_years)/count(e.employee_id)::numeric,2) as average_years
FROM employee e
         JOIN project p ON e.employee_id = p.employee_id
GROUP BY  p.project_id;



