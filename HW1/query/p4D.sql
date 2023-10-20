WITH themes_avg(name, part) AS(
	SELECT t.name,AVG(s.num_parts)
	FROM sets s, themes t
	WHERE t.id = s.theme_id
	GROUP BY t.name)

SELECT name theme_name, part avg_num
FROM themes_avg
ORDER BY avg_num
