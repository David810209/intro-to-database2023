
'''
pre_created:
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
'''

WITH Old_MovingAverage_Country AS(
		SELECT
			Date,
			CountryCode,
			ConfirmedCases,
			(ConfirmedCases - LAG(ConfirmedCases, 7) OVER (
				PARTITION BY 
                    CountryCode 
				ORDER BY 
                    Date 
			) ) / 7 AS Moving_Average
		FROM 
            cases
            
	),
    MovingAverage_Country AS(
        SELECT
            Date,
			CountryCode,
			case when Moving_Average = 0 then 0.1 else Moving_Average end as Moving_Average
	
        FROM 
            Old_MovingAverage_Country
			where date in ('2020-04-01','2021-04-01','2022-04-01')
		
    ),
	OverStringencyIndices AS(
		SELECT
			Ic.Date,
			Ic.CountryCode,
            iC.Continent_Code,
			Ic.StringencyIndex_Average_ForDisplay / M.Moving_Average AS OverStringencyIndex
		from  MovingAverage_Country as m left join indices_continentcode as ic
	on (m.countrycode = ic.country_code 
		and m.date = ic.date)
			
	),
    max_min_OverStringencyIndices(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT
		Date,
		Continent_Code,
		MAX(OverStringencyIndex),
		Min(OverStringencyIndex)
	FROM OverStringencyIndices
	GROUP BY
		Date, Continent_Code
	),get_code AS(
	SELECT 
		mm.Date,
		mm.Continent_Code,
		Maxcc.CountryCode AS Max_CountryCode,
		mm.Maximum,
		
		Mincc.CountryCode AS Min_CountryCode,
		mm.Minimum
	FROM
		max_min_OverStringencyIndices AS mm
		LEFT JOIN OverStringencyIndices AS Maxcc
			ON (mm.Maximum = Maxcc.OverStringencyIndex 
				AND mm.Date = Maxcc.Date
			   	AND mm.Continent_Code = Maxcc.Continent_Code)
		LEFT JOIN OverStringencyIndices AS Mincc
			ON (mm.Minimum = Mincc.OverStringencyIndex 
				AND mm.Date = Mincc.Date
			   	AND mm.Continent_Code = Mincc.Continent_Code)
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
		ON (g.Max_CountryCode = Ma.Country_Code)
	LEFT JOIN Country_and_Continent AS Mi
		ON (g.Min_CountryCode = Mi.Country_Code)
ORDER BY
	 g.Continent_code
	

    
