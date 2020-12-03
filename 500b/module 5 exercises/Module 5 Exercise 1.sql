/** 
	ASSIGNMENT FOR MODULE 5 PART 1
	FILIPP KRASOVSKY, UNIVERSITY OF SAN DIEGO 
	FILE CREATED: 11-27-2020
**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 1.1 How many countries became independent in the twentieth century? (10 points) */
SELECT 
	COUNT(*) 
FROM 
	country 
WHERE 
	IndepYear >= 1900 and 
	IndepYear <= 1999;
	
/*
+----------+
| COUNT(*) |
+----------+
|      149 |
+----------+
*/
 
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 1.2 How many people in the world are expected to live for 75 years or more? (10 points) */
SELECT
	SUM(Population)
FROM 
	country 
WHERE 
	LifeExpectancy >= 75;

/*
+-----------------+
| SUM(Population) |
+-----------------+
|       982470200 |
+-----------------+
*/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/* 1.3 List the 10 most populated countries in the world with their populations as a
	percentage of the world population. [Hint: You can first find the population for the world
	and then use it for percentage for countries, so something like: select
	Population/5000000000 from Country ....] (10 points) */
	
/* to reduce the number of transactions, we will calculate the global population inside of a stored procedure. */
DROP PROCEDURE IF EXISTS MOST_POP_LIST;
DELIMITER $$ 
CREATE PROCEDURE MOST_POP_LIST()
	BEGIN
		declare WPOP BIGINT default (SELECT SUM(Population) FROM country);
		select
			Name,
			Population / (WPOP * 1.0) as perc_of_world_pop
		from 
			country
		order by 
			perc_of_world_pop desc 
		limit 10;
	END $$
DELIMITER ;
call MOST_POP_LIST();

/*
+--------------------+-------------------+
| Name               | perc_of_world_pop |
+--------------------+-------------------+
| China              |            0.2102 |
| India              |            0.1668 |
| United States      |            0.0458 |
| Indonesia          |            0.0349 |
| Brazil             |            0.0280 |
| Pakistan           |            0.0257 |
| Russian Federation |            0.0242 |
| Bangladesh         |            0.0212 |
| Japan              |            0.0208 |
| Nigeria            |            0.0183 |
+--------------------+-------------------+
**/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 	1.4 List the top 10 countries with the highest population density. [Hint: For population
	density, you can try something like: select Population/SurfaceArea from Country
	where....] (10 points) */
	
SELECT
	Name,
	Population/SurfaceArea as pop_density
FROM 
	country 
ORDER BY 
	pop_density desc
LIMIT 10;

/*
+-------------------------------+--------------+
| Name                          | pop_density  |
+-------------------------------+--------------+
| Macao                         | 26277.777778 |
| Monaco                        | 22666.666667 |
| Hong Kong                     |  6308.837209 |
| Singapore                     |  5771.844660 |
| Gibraltar                     |  4166.666667 |
| Holy See (Vatican City State) |  2499.999963 |
| Bermuda                       |  1226.415094 |
| Malta                         |  1203.164557 |
| Maldives                      |   959.731544 |
| Bangladesh                    |   896.922179 |
+-------------------------------+--------------+
*/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	
/*	1.5 How many countries are there in each “Region” ? Write a SQL query that produces a
	list of regions with a column for country counts for each region and order the count
	descending. (10 points)*/
	
SELECT 
	Region,
	COUNT(Name) as num_countries
FROM 
	country 
GROUP BY 
	Region
ORDER BY 
	num_countries desc;
	
	
/*
+---------------------------+---------------+
| Region                    | num_countries |
+---------------------------+---------------+
| Caribbean                 |            24 |
| Eastern Africa            |            20 |
| Middle East               |            18 |
| Western Africa            |            17 |
| Southern Europe           |            15 |
| Southern and Central Asia |            14 |
| South America             |            14 |
| Southeast Asia            |            11 |
| Polynesia                 |            10 |
| Eastern Europe            |            10 |
| Central Africa            |             9 |
| Western Europe            |             9 |
| Central America           |             8 |
| Eastern Asia              |             8 |
| Nordic Countries          |             7 |
| Northern Africa           |             7 |
| Micronesia                |             7 |
| Antarctica                |             5 |
| Australia and New Zealand |             5 |
| North America             |             5 |
| Southern Africa           |             5 |
| Melanesia                 |             5 |
| Baltic Countries          |             3 |
| British Islands           |             2 |
| Micronesia/Caribbean      |             1 |
+---------------------------+---------------+
*/
	
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*
	1.6 What countries have more than 10 languages represented? Write a SQL query,
	using the "HAVING" clause, that produces the list of countries that have greater than 10
	languages. Group by "CountryCode" and order by language count descending. (10
	points)
*/

SELECT 
	country.Name ,
	COUNT(Language) as num_languages
FROM 
	countryLanguage 
	INNER JOIN country ON country.Code = countryLanguage.CountryCode 
GROUP BY 
	CountryCode 
HAVING 
	COUNT(Language) > 10
ORDER BY 
	num_languages desc ;
	
/**
+--------------------+---------------+
| Name               | num_languages |
+--------------------+---------------+
| Canada             |            12 |
| China              |            12 |
| India              |            12 |
| Russian Federation |            12 |
| United States      |            12 |
| Tanzania           |            11 |
| South Africa       |            11 |
+--------------------+---------------+
**/