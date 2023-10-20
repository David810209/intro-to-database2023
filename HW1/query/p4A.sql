SELECT s.name sets_name,t.name themes_name
FROM sets s,themes t
WHERE t.id = s.theme_id AND s.year = 2017
