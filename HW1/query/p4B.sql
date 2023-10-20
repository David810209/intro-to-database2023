SELECT COUNT(s) num_of_sets,year
FROM sets s
WHERE year <= 2017 AND year >= 1950
GROUP BY year
ORDER BY num_of_sets DESC
