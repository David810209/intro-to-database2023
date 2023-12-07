

create view Country_and_Continent AS(
	SELECT
		Country.Country_Code,
		Country.Country_Name,
		Continent.Continent_Code,
		Continent.Continent_Name
	FROM
		Country NATURAL JOIN Country_Continent NATURAL JOIN Continent
	)

create view indices_continentcode
as select *
from Indices JOIN Country_Continent on indices.countrycode = country_continent.country_code


WITH max_min(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT
		Date,
		Continent_Code,
		MAX(StringencyIndex_Average_ForDisplay),
		Min(StringencyIndex_Average_ForDisplay)
	FROM indices_continentcode
	WHERE 
		Date in( '2022-04-01','2021-04-01 ','2020-04-01 ')
	GROUP BY
		Date, Continent_Code
	),
	get_code AS(
	SELECT 
		mm.Date,
		mm.Continent_Code,
		Maxcc.Country_Code AS Max_CountryCode,
		mm.Maximum,
		
		Mincc.Country_Code AS Min_CountryCode,
		mm.Minimum
	FROM
		max_min AS mm
		LEFT JOIN indices_continentcode AS Maxcc
			ON (mm.Maximum = Maxcc.StringencyIndex_Average_ForDisplay 
				AND mm.Date = Maxcc.Date
			   	AND mm.Continent_Code = Maxcc.Continent_Code)
		LEFT JOIN indices_continentcode AS Mincc
			ON (mm.Minimum = Mincc.StringencyIndex_Average_ForDisplay 
				AND mm.Date = Mincc.Date
			   	AND mm.Continent_Code = Mincc.Continent_Code)
	ORDER BY
		mm.Date,mm.Continent_Code
	)
SELECT
	g.Date,
	Ma.Continent_Name,
	
	Ma.Country_Name AS Max_Country_Name,
	g.Maximum AS Max_Stringency_Index, 
	
	Mi.Country_Name AS Min_Country_Name,
	g.Minimum AS Min_Stringency_Index
FROM
	get_code AS g
	LEFT JOIN Country_and_Continent AS Ma
		ON (g.Max_CountryCode = Ma.Country_Code
			AND g.Continent_Code = Ma.Continent_Code)
	LEFT JOIN Country_and_Continent AS Mi
		ON (g.Min_CountryCode = Mi.Country_Code
			AND g.Continent_Code = Mi.Continent_Code)
ORDER BY
	g.Date, Ma.Continent_Name
