-- create the connect of country and continent to satisfy two question
CREATE VIEW Country_and_Continent
AS SELECT x.Country_Code,
	x.Country_Name,
	x.Continent_Name
FROM (Country NATURAL JOIN Country_Continent NATURAL JOIN Continent)AS x;

WITH max_min
AS (
	SELECT DATE,
		MAX(StringencyIndex_Average_ForDisplay) AS maximum,
		Min(StringencyIndex_Average_ForDisplay) AS Minimum
	FROM Indices
	WHERE DATE IN ('2022-12-01', '2022-04-01', '2021-04-01', '2020-04-01')
	GROUP BY DATE
	),
get_code
AS (
	SELECT m.DATE,
		Max_Code.CountryCode AS Max_Code,
		Min_Code.CountryCode AS Min_Code
	FROM max_min AS m
	LEFT JOIN Indices AS Max_Code
		ON (
				m.Maximum = Max_Code.StringencyIndex_Average_ForDisplay
				AND m.DATE = Max_Code.DATE
				)
	LEFT JOIN Indices AS Min_code
		ON (
				m.Minimum = Min_Code.StringencyIndex_Average_ForDisplay
				AND m.DATE = Min_Code.DATE
				)
	ORDER BY m.DATE
	)

SELECT
	g.Date,
	MaxName.Continent_Name AS Max_CountryName,
	MaxName.Country_Name AS Max_CotinentName,
	MinName.Continent_Name AS Min_CountryName,
	MinName.Country_Name AS Min_CotinentName
FROM
	get_code AS g
	LEFT JOIN Country_and_Continent AS MaxName
		ON g.Max_Code = MaxName.Country_Code
	LEFT JOIN Country_and_Continent AS MinName
		ON g.Min_Code = MinName.Country_Code
ORDER BY
	g.Date
