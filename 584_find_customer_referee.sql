SELECT name from customer
WHERE coalesce(referee_id, -1) != 2;

SELECT name from customer
WHERE referee_id != 2
OR referee_id is NULL
