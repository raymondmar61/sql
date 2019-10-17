#https://sqlzoo.net/wiki/Tutorial_Quizzes

#https://sqlzoo.net/wiki/SELECT_Quiz
#1. Select the code which produces this table
/*
name	population
Bahrain	1234571
Swaziland	1220000
Timor-Leste	1066409
*/
select name, population
from world
where population between 1000000 and 1250000;

#2. Pick the result you would obtain from this code:
select name, population
from world
where name like 'al%';
/*
Table-E
Albania	3200000
Algeria	32900000
*/

#3. Select the code which shows the countries that end in A or L
select name
from world
where name like '%a' or name like '%l';

#4. Pick the result from the query
select name,length(name)
from world
where length(name)=5 and region='europe';
/*
name	length(name)
Italy	5
Malta	5
Spain	5
*/

#5. Pick the result you would obtain from this code:
/*
name	region	area	population	gdp
Afghanistan	South Asia	652225	26000000	
Albania	Europe	28728	3200000	6656000000
Algeria	Middle East	2400000	32900000	75012000000
Andorra	Europe	468	64000	
*/
select name, area*2
from world
where population = 64000;
/*
Andorra	936
*/

#6. Select the code that would show the countries with an area larger than 50000 and a population smaller than 10000000
select name, area, population
from world
where area > 50000 and population < 10000000;

#7. Select the code that shows the population density of China, Australia, Nigeria and France
select name, population/area
from world
where name in ('china', 'nigeria', 'france', 'australia');

#https://sqlzoo.net/wiki/BBC_QUIZ
#1. Select the code which gives the name of countries beginning with U
select name
from world
where name like 'u%';

#2. Select the code which shows just the population of United Kingdom?
select population
from world
where name = 'united kingdom';

#3. Select the answer which shows the problem with this SQL code - the intended result should be the continent of France:
select continent 
from world 
where 'name' = 'france';
#'name' should be name

#4. Select the result that would be obtained from the following code:
select name, population / 10 
from world 
where population < 10000;
/*
Nauru	990
*/

#5. Select the code which would reveal the name and population of countries in Europe and Asia
select name, population
from world
where continent in ('europe', 'asia');

#6. Select the code which would give two rows
select name from world
where name in ('cuba', 'togo');

#7. Select the result that would be obtained from this code:
select name from world
where continent = 'south america'
and population > 40000000
/*
Brazil
Colombia
*/