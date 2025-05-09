WITH avg_process AS (SELECT machine_id,
                            process_id,
                            MAX(CASE WHEN activity_type = 'end' THEN timestamp END) -
                            MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS process_time
                     FROM activity
                     GROUP BY machine_id, process_id)

SELECT machine_id, round(AVG(process_time)::numeric,3) as processing_time
FROM avg_process
GROUP BY machine_id
ORDER BY machine_id
