--create country table
CREATE TABLE PUBLIC.country (
	Country_Name VARCHAR(100),
	Country_Code VARCHAR(10) NOT NULL,
	Country_Number INTEGER,
	PRIMARY KEY (Country_Code)
	);
--import csv
\copy PUBLIC.country(Country_Name, Country_Code, Country_Number) FROM 'C:\Program Files\PostgreSQL\16\bin\country.csv' DELIMITER ',' CSV HEADER;
--delete the country name part after first ','
UPDATE country
SET Country_Name = SUBSTRING(Country_Name FROM 1 FOR POSITION(',' IN Country_Name) - 1)
WHERE POSITION(',' IN Country_Name) > 0;


--create continent table
CREATE TABLE PUBLIC.continent (
	Continent_Name VARCHAR(100),
	Continent_Code VARCHAR(10) NOT NULL,
	PRIMARY KEY (Continent_Code)
	);
--import csv
\copy PUBLIC.continent(Continent_Name, Continent_Code) FROM 'C:\Program Files\PostgreSQL\16\bin\continent.csv' DELIMITER ',' CSV HEADER;

--create country_continent table
CREATE TABLE PUBLIC.country_continent (
	Country_Code VARCHAR(10) NOT NULL,
	Continent_Code VARCHAR(10) NOT NULL,
	PRIMARY KEY (
		Country_Code,
		Continent_Code
		),
	 FOREIGN KEY (Country_Code) REFERENCES PUBLIC.country(Country_Code),
	FOREIGN KEY (Continent_Code) REFERENCES PUBLIC.continent(Continent_Code)
	);
--import csv
\copy PUBLIC.country_continent(Country_Code, Continent_Code) FROM 'C:\Program Files\PostgreSQL\16\bin\country_continent.csv' DELIMITER ',' CSV HEADER;

--create and import the big data csv
CREATE table public.o(
	CountryCode VARCHAR(10) NOT NULL,
	DATE date NOT NULL,
	C1M INTEGER,
	C1M_Flag INTEGER,
	C2M INTEGER,
	C2M_Flag INTEGER,
	C3M INTEGER,
	C3M_Flag INTEGER,
	C4M INTEGER,
	C4M_Flag INTEGER,
	C5M INTEGER,
	C5M_Flag INTEGER,
	C6M INTEGER,
	C6M_Flag INTEGER,
	C7M INTEGER,
	C7M_Flag INTEGER,
	C8EV INTEGER,
	E1 INTEGER,
	E1_Flag INTEGER,
	E2 INTEGER,
	E3 DOUBLE PRECISION,
	E4 NUMERIC,
	H1 INTEGER,
	H1_Flag INTEGER,
	H2 INTEGER,
	H3 INTEGER,
	H4 DOUBLE PRECISION,
	H5 DOUBLE PRECISION,
	H6M INTEGER,
	H6M_Flag INTEGER,
	H7 INTEGER,
	H7_Flag INTEGER,
	H8M INTEGER,
	H8M_Flag INTEGER,
	M1 TEXT,
	V1 INTEGER,
	V2A INTEGER,
	V2B VARCHAR(20),
	V2C VARCHAR(20),
	V2D INTEGER,
	V2E INTEGER,
	V2F INTEGER,
	V2G INTEGER,
	V3 INTEGER,
	V4 INTEGER,
	ConfirmedCases INTEGER,
	ConfirmedDeaths INTEGER,
	MajorityVaccinated VARCHAR(10),
	PopulationVaccinated DOUBLE PRECISION,
	StringencyIndex_Average DOUBLE PRECISION,
	StringencyIndex_Average_ForDisplay DOUBLE PRECISION,
	GovernmentResponseIndex_Average DOUBLE PRECISION,
	GovernmentResponseIndex_Average_ForDisplay DOUBLE PRECISION,
	ContainmentHealthIndex_Average DOUBLE PRECISION,
	ContainmentHealthIndex_Average_ForDisplay DOUBLE PRECISION,
	EconomicSupportIndex DOUBLE PRECISION,
	EconomicSupportIndex_ForDisplay DOUBLE PRECISION,
)
--import big data csv
\copy PUBLIC.o(CountryCode, DATE, C1M, C1M_Flag, C2Mg, C2M_Flag, C3M, C3M_Flag, C4M, C4M_Flag, C5M, C5M_Flag, C6M, C6M_Flag, C7M, C7M_Flag, C8EV, E1, E1_Flag, E2, E3, E4, H1, H1_Flag, H2, H3, H4, H5, H6M, H6M_Flag, H7, H7_Flag, H8M, H8M_Flag, M1, V1, V2A, V2B, V2C, V2D, V2E, V2F, V2G, V3, V4, ConfirmedCases, ConfirmedDeaths, MajorityVaccinated, PopulationVaccinated, StringencyIndex_Average, StringencyIndex_Average_ForDisplay, GovernmentResponseIndex_Average, GovernmentResponseIndex_Average_ForDisplay, ContainmentHealthIndex_Average, ContainmentHealthIndex_Average_ForDisplay, EconomicSupportIndex, EconomicSupportIndex_ForDisplay)from 'C:\Program Files\PostgreSQL\16\bin\o.csv' DELIMITER ',' CSV HEADER;

--create policy table
CREATE TABLE PUBLIC.policy (
	CountryCode VARCHAR(10) NOT NULL,
	DATE date NOT NULL,
	C1M INTEGER,
	C1M_Flag INTEGER,
	C2M INTEGER,
	C2M_Flag INTEGER,
	C3M INTEGER,
	C3M_Flag INTEGER,
	C4M INTEGER,
	C4M_Flag INTEGER,
	C5M INTEGER,
	C5M_Flag INTEGER,
	C6M INTEGER,
	C6M_Flag INTEGER,
	C7M INTEGER,
	C7M_Flag INTEGER,
	C8EV INTEGER,
	E1 INTEGER,
	E1_Flag INTEGER,
	E2 INTEGER,
	E3 DOUBLE PRECISION,
	E4 NUMERIC,
	H1 INTEGER,
	H1_Flag INTEGER,
	H2 INTEGER,
	H3 INTEGER,
	H4 DOUBLE PRECISION,
	H5 DOUBLE PRECISION,
	H6M INTEGER,
	H6M_Flag INTEGER,
	H7 INTEGER,
	H7_Flag INTEGER,
	H8M INTEGER,
	H8M_Flag INTEGER,
	M1 TEXT,
	V1 INTEGER,
	V2A INTEGER,
	V2B VARCHAR(20),
	V2C VARCHAR(20),
	V2D INTEGER,
	V2E INTEGER,
	V2F INTEGER,
	V2G INTEGER,
	V3 INTEGER,
	V4 INTEGER,
	PRIMARY KEY (
		CountryCode,
		DATE
		),
	FOREIGN KEY (CountryCode) REFERENCES PUBLIC.country(Country_Code)
	);
--select data from big csv
insert into policy
select distinct CountryCode, DATE, C1M, C1M_Flag, C2Mg, C2M_Flag, C3M, C3M_Flag, C4M, C4M_Flag, C5M, C5M_Flag, C6M, C6M_Flag, C7M, C7M_Flag, C8EV, E1, E1_Flag, E2, E3, E4, H1, H1_Flag, H2, H3, H4, H5, H6M, H6M_Flag, H7, H7_Flag, H8M, H8M_Flag, M1, V1, V2A, V2B, V2C, V2D, V2E, V2F, V2G, V3, V4
from o

--create indices table
CREATE TABLE PUBLIC.indices (
	CountryCode VARCHAR(10) NOT NULL,
	DATE date NOT NULL,
	StringencyIndex_Average DOUBLE PRECISION,
	StringencyIndex_Average_ForDisplay DOUBLE PRECISION,
	GovernmentResponseIndex_Average DOUBLE PRECISION,
	GovernmentResponseIndex_Average_ForDisplay DOUBLE PRECISION,
	ContainmentHealthIndex_Average DOUBLE PRECISION,
	ContainmentHealthIndex_Average_ForDisplay DOUBLE PRECISION,
	EconomicSupportIndex DOUBLE PRECISION,
	EconomicSupportIndex_ForDisplay DOUBLE PRECISION,
	PRIMARY KEY (
		CountryCode,
		DATE
		),
	FOREIGN KEY (CountryCode) REFERENCES PUBLIC.country(Country_Code)
	);
--select data from big csv
insert into indices 
select distinct CountryCode, DATE, StringencyIndex_Average, StringencyIndex_Average_ForDisplay, GovernmentResponseIndex_Average, GovernmentResponseIndex_Average_ForDisplay, ContainmentHealthIndex_Average, ContainmentHealthIndex_Average_ForDisplay, EconomicSupportIndex, EconomicSupportIndex_ForDisplay
from o

--create cases table
CREATE TABLE PUBLIC.cases (
	CountryCode VARCHAR(10) NOT NULL,
	DATE date NOT NULL,
	ConfirmedCases DOUBLE PRECISION,
	ConfirmedDeaths INTEGER,
	MajorityVaccinated VARCHAR(10),
	PopulationVaccinated DOUBLE PRECISION,
	PRIMARY KEY (
		CountryCode,
		DATE
		),
	FOREIGN KEY (CountryCode) REFERENCES PUBLIC.country(Country_Code)
	);
--select data from big csv
insert into cases
select distinct CountryCode,DATE, ConfirmedCases, ConfirmedDeaths, MajorityVaccinated, PopulationVaccinated
from o



