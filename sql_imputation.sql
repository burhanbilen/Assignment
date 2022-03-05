-- SAMPLE DATABASE TO PRACTISE

CREATE TABLE mytable(country VARCHAR, date DATE, daily_vaccinations FLOAT, vaccines VARCHAR);

INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Argentina','12/29/2020',NULL,'Sputnik V');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Argentina','12/30/2020',15656,'Sputnik V');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Argentina','12/31/2020',15656,'Sputnik V');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Argentina','1/24/2021',10342,'Sputnik V');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Argentina','1/25/2021',9046,'Sputnik V');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Austria','1/5/2021',NULL,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Austria','1/6/2021',3368,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Austria','1/7/2021',3368,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Austria','1/8/2021',7263,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Bahrain','1/19/2021',6546,'Pfizer/BioNTech, Sinopharm');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Bahrain','1/20/2021',6110,'Pfizer/BioNTech, Sinopharm');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','12/28/2020',NULL,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','12/29/2020',1,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','12/30/2020',234,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','12/31/2020',159,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','1/1/2021',122,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','1/2/2021',97,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','1/3/2021',81,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Belgium','1/4/2021',70,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Chile','1/24/2021',6020,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Chile','1/25/2021',4557,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('China','12/15/2020',NULL,'CNBG, Sinovac');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('China','12/16/2020',187500,'CNBG, Sinovac');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('China','12/17/2020',187500,'CNBG, Sinovac');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('China','12/18/2020',187500,'CNBG, Sinovac');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Costa Rica','12/24/2020',NULL,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Costa Rica','12/28/2020',240,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Russia','1/12/2021',18182,'Sputnik V');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Russia','1/13/2021',18182,'Sputnik V');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Saudi Arabia','1/6/2021',NULL,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Saudi Arabia','1/7/2021',37862,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Saudi Arabia','1/8/2021',23990,'Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('United Arab Emirates','1/25/2021',85653,'Pfizer/BioNTech, Sinopharm');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('United Kingdom','12/20/2020',NULL,'Oxford/AstraZeneca, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('United Kingdom','12/21/2020',46423,'Oxford/AstraZeneca, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('United States','1/24/2021',1122182,'Moderna, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Wales','12/13/2020',NULL,'Oxford/AstraZeneca, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Wales','12/13/2020',NULL,'Oxford/AstraZeneca, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Wales','12/13/2020',333,'Oxford/AstraZeneca, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Wales','12/13/2020',NULL,'Oxford/AstraZeneca, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Kuwait','12/13/2020',NULL,'Oxford/AstraZeneca, Pfizer/BioNTech');
INSERT INTO mytable(country,date,daily_vaccinations,vaccines) VALUES ('Wales','12/13/2020',NULL,'Oxford/AstraZeneca, Pfizer/BioNTech');

-- Firstly, find the countries with invalid records. If a country has all daily_vaccinations values as NaN/NULL, that means it has invalid records.
-- The query that is shown below compares the amount of records of the relevant country and the number of null records, so if these numbers are same, the country will be count as an invalid country.
-- The countries that is in the result of the query which is used with the WHERE clause will be updated by 0 value.
UPDATE mytable SET daily_vaccinations=0 WHERE country IN (SELECT country FROM mytable GROUP BY country HAVING sum(CASE WHEN daily_vaccinations IS NULL then 1 ELSE 0 end) = COUNT(country))

-- That is a function to extract an individual table for each country to find the median in an easier way. The "countryname" is variable for the country column.
-- The selected values are only country and daily_vaccinations since the rest is redundant. Finally, it returns the result when input matches the current country.
CREATE function finder (countryname varchar) 
	returns TABLE (
		new_country VARCHAR,
	    new_daily_vaccinations float
	) 
	language plpgsql
AS $$
BEGIN
	return query 
		SELECT
			country,
			daily_vaccinations
		FROM
			mytable
		WHERE
			country = countryname;
end;$$

-- Updating the table using percentile_cont (to sort and get the half of the chosen table) and the function "finder" to get the exact country's median and set it on where the NULL values exist.
UPDATE mytable
SET daily_vaccinations=(SELECT PERCENTILE_CONT(0.5)
WITHIN GROUP(ORDER BY new_daily_vaccinations)
FROM (SELECT * FROM finder(country)) AS results)
WHERE daily_vaccinations IS NULL
