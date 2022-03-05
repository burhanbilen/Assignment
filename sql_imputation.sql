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

-- Firstly, find the countries with invalid records. If a country has all daily_vaccinations values as NaN, that means it has invalid records.
-- The query that is shown below finds the countries that has only NaN vaccination values. Then, updates the relevant cell with 0 value.
UPDATE mytable SET daily_vaccinations=0 WHERE country in (SELECT selected_country FROM (SELECT country AS selected_country, c FROM (SELECT country, count(country) AS c, daily_vaccinations FROM mytable GROUP BY country) WHERE c = (SELECT sum(CASE WHEN daily_vaccinations IS NULL then 1 ELSE 0 end) FROM mytable WHERE country = selected_country)));


-- Next, the following query uses 2 cases. First case works when the table's length is an odd number, and second case works when the table's length is an even number.
-- With the use of ROW_NUMBER function, after sorting the vaccination values, for case 1; the (N+1)/2th item gets found and then replace with NaN values.
-- However, for case 2, the Nth and (N+1)th items get found and their averages gets replaced with NaN values.
UPDATE mytable SET daily_vaccinations= CASE --Update with the case ...
WHEN (SELECT count(country) FROM mytable)%2=1 THEN (SELECT daily_vaccinations FROM (SELECT ROW_NUMBER() OVER (ORDER BY daily_vaccinations DESC) AS nth, daily_vaccinations FROM mytable) AS result WHERE nth = (SELECT count(daily_vaccinations)/2 FROM mytable)+1) --If the table has odd number of rows
WHEN (SELECT count(country) FROM mytable)%2=0 THEN (SELECT AVG(daily_vaccinations) FROM (SELECT daily_vaccinations FROM (SELECT ROW_NUMBER() OVER (ORDER BY daily_vaccinations DESC) AS nth, daily_vaccinations FROM mytable) AS result WHERE nth in ((SELECT count(daily_vaccinations) FROM mytable)/2+1, (SELECT count(daily_vaccinations) FROM mytable)/2))) --If the table has even number of rows
END
WHERE daily_vaccinations IS NULL; --Where the null vaccinations exist

SELECT * FROM mytable;
