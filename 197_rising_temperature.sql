WITH temp_diff AS (SELECT id,
                          recorddate,
                          temperature,
                          LAG(temperature) OVER (ORDER BY recorddate) AS prev_temp,
                          LAG(recorddate) OVER (ORDER BY recorddate)  AS prev_date


                   FROM weather w)
SELECT ID
FROM temp_diff
WHERE recorddate - prev_date = 1
  AND temperature > prev_temp


