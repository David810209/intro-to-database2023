WITH themes_set(name, total_set) AS(
        SELECT t.name , COUNT(s.name)
        FROM sets s, themes t
        WHERE t.id = s.theme_id
        GROUP BY t.id)
SELECT name, total_set as max_set
FROM themes_set
WHERE total_set = (
        SELECT MAX(total_set)
        FROM themes_set
    );
