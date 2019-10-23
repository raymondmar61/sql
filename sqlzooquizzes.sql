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

#https://sqlzoo.net/wiki/Nobel_Quiz
#1. Pick the code which shows the name of winner's names beginning with C and ending in n
select winner
from nobel
where winner like 'c%'
and winner like '%n';

#2. Select the code that shows how many Chemistry awards were given between 1950 and 1960
select count(subject)
from nobel
where subject = 'chemistry'
and yr between 1950 and 1960;

#3. Pick the code that shows the amount of years where no Medicine awards were given
select count(distinct yr)
from nobel
where yr not in (
	select distinct yr
	from nobel
	where subject = 'medicine');

#4. Select the result that would be obtained from the following code
select subject, winner
from nobel
where winner like 'sir%' and yr like '196%';
/*
Medicine	Sir John Eccles
Medicine	Sir Frank Macfarlane Burnet
*/

#5. Select the code which would show the year when neither a Physics or Chemistry award was given
select yr 
from nobel
where yr not in (
	select yr 
	from nobel
	where subject in ('chemistry','physics'));

#6. Select the code which shows the years when a Medicine award was given but no Peace or Literature award was  #RM:  should be "or" instead of "and" at "and yr not in (""
select distinct yr
from nobel
where subject = 'medicine' 
and yr not in (
	select yr
	from nobel 
	where subject = 'literature')
and yr not in (
	select yr
	from nobel
	where subject = 'peace');

#7. Pick the result that would be obtained from the following code:
select subject, count(subject) 
from nobel 
where yr = '1960' 
group by subject;
/*
Chemistry	1
Literature	1
Medicine	2
Peace	1
Physics	1
*/

#https://sqlzoo.net/wiki/Nested_SELECT_Quiz
#1. Select the code that shows the name, region and population of the smallest country in each region
select region, name, population
from bbc x
where population <= all (
	select population
	from bbc y
	where y.region = x.region
	and population > 0);

#2. Select the code that shows the countries belonging to regions with all populations over 50000
select name, region, population
from bbc x where 50000 < all (
	select population
	from bbc y
	where x.region = y.region and y.population > 0);
#RM:  isn't the correct answer below?
select name, region, population
from bbc x where 50000 > all (
	select population
	from bbc y
	where x.region = y.region and y.population > 0);

#3. Select the code that shows the countries with a less than a third of the population of the countries around it
select name, region
from bbc x
where population < all (
	select population/3
	from bbc y
	where y.region = x.region
	and y.name != x.name);

#4. Select the result that would be obtained from the following code:  #RM:  Turkey is in the same region as United Kingdom?
select name from bbc
where population > (
	select population
	from bbc
	where name = 'united kingdom')
and region in (
	select region
	from bbc
	where name = 'united kingdom');
/*
Table-D
France
Germany
Russia
Turkey
*/

#5. Select the code that would show the countries with a greater GDP than any country in Africa (some countries may have NULL gdp values).
select name
from bbc
where gdp > (
	select max(gdp)
	from bbc
	where region = 'africa');

#6. Select the code that shows the countries with population smaller than Russia but bigger than Denmark
select name
from bbc
where population < (
	select population
	from bbc
	where name = 'russia')
and population > (
	select population
	from bbc
	where name = 'denmark');

#7. >Select the result that would be obtained from the following code:  #RM:  China is not in South Asia region.
select name
from bbc
where population > all (
	select max(population)
	from bbc
	where region = 'europe')
and region = 'south asia';
/*
Table-B
Bangladesh
India
Pakistan
*/

#https://sqlzoo.net/wiki/SUM_and_COUNT_Quiz
#1. Select the statement that shows the sum of population of all countries in 'Europe'
select sum(population)
from bbc
where region = 'europe';

#2. Select the statement that shows the number of countries with population smaller than 150000
select count(name)
from bbc
where population < 150000;

#3. Select the list of core SQL aggregate functions
/* AVG(), COUNT(), MAX(), MIN(), SUM() */

#4. Select the result that would be obtained from the following code:
select region, sum(area)
from bbc 
where sum(area) > 15000000 
group by region
/* No result due to invalid use of the WHERE function */


#5. Select the statement that shows the average population of 'Poland', 'Germany' and 'Denmark'
select avg(population)
from bbc
where name in ('poland', 'germany', 'denmark');

#6. Select the statement that shows the medium population density of each region
select region, sum(population)/sum(area) as density
from bbc
group by region;

#7. Select the statement that shows the name and population density of the country with the largest population
select name, population/area as density
from bbc
where population = (
	select max(population)
	from bbc);

#8. Pick the result that would be obtained from the following code:
select region, sum(area)
from bbc
group by region
having sum(area)<= 20000000;
/*
Table-D
Americas	732240
Middle East	13403102
South America	17740392
South Asia	9437710
*/

#https://sqlzoo.net/wiki/JOIN_Quiz
#1. You want to find the stadium where player 'Dimitris Salpingidis' scored. Select the JOIN condition to use:
/*
game join goal
on (id = matchid)
*/

#2. You JOIN the tables goal and eteam in an SQL statement. Indicate the list of column names that may be used in the SELECT line:
/* matchid, teamid, player, gtime, id, teamname, coach */

#3. Select the code which shows players, their team and the amount of goals they scored against Greece(GRE).
select player, teamid, count(*)
from game join goal
on matchid = id
where (team1 = "gre" or team2 = "gre")
and teamid != 'gre'
group by player, teamid;

#4. Select the result that would be obtained from this code:
select distinct teamid, mdate
from goal join game
on (matchid = id)
where mdate = '9 june 2012';
/*
DEN	9 June 2012
GER	9 June 2012
*/

#5. Select the code which would show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.
select distinct player, teamid 
from game join goal
on matchid = id 
where stadium = 'national stadium, warsaw'
and (team1 = 'pol' or team2 = 'pol')
and teamid != 'pol';

#6. Select the code which shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA).
select distinct player, teamid, gtime
from game join goal
on matchid = id
where stadium = 'stadion miejski (wroclaw)'
and (( teamid = team2 and team1 != 'ita') 
or (teamid = team1 and team2 != 'ita'));

#7. Select the result that would be obtained from this code:
select teamname, count(*)
from eteam join goal on teamid = id
group by teamname
having count(*) < 3
/*
Netherlands	2
Poland	2
Republic of Ireland	1
Ukraine	2
*/

#https://sqlzoo.net/wiki/JOIN_Quiz_2
#1. Select the statement which lists the unfortunate directors of the movies which have caused financial loses (gross < budget).  #RM:  actor is the table?
select name
from actor inner join movie 
on actor.id = director
where gross < budget;

#2. Select the correct example of JOINing three tables
select *
from actor join casting
on actor.id = actorid
join movie on movie.id = movieid;

#3. Select the statement that shows the list of actors called 'John' by order of number of movies in which they acted
select name, count(movieid)
from casting join actor
on actorid = actor.id
where name like 'john %'
group by name
order by 2 desc;

#4. Select the result that would be obtained from the following code:
select title 
from movie join casting 
on (movieid = movie.id)
join actor
on (actorid = actor.id)
where name = 'paul hogan' and ord = 1;
/*
Table-B
"Crocodile" Dundee
Crocodile Dundee in Los Angeles
Flipper
Lightning Jack
*/

#5. Select the statement that lists all the actors that starred in movies directed by Ridley Scott who has id 351
select name
from movie join casting
on movie.id = movieid
join actor
on actor.id = actorid
where ord = 1
and director = 351;

#6. There are two sensible ways to connect movie and actor. They are:
/*
link the director column in movies with the primary key in actor
connect the primary keys of movie and actor via the casting table
*/

#7. Select the result that would be obtained from the following code:
select title, yr 
from movie, casting, actor 
where name='robert de niro'
and movieid = movie.id
and actorid = actor.id
and ord = 3;
/*
Table-B
A Bronx Tale	1993
Bang the Drum Slowly	1973
Limitless	2011
*/

#https://sqlzoo.net/wiki/Using_Null_Quiz
#1. Select the code which uses an outer join correctly.
select teacher.name, dept.name
from teacher left outer join dept
on (teacher.dept = dept.id);

#2. Select the correct statement that shows the name of department which employs Cutflower -
select dept.name
from teacher join dept
on (dept.id = teacher.dept)
where teacher.name = 'cutflower';

#3. Select out of following the code which uses a JOIN to show a list of all the departments and number of employed teachers
select dept.name, count(teacher.name)
from teacher right join dept
on dept.id = teacher.dept
group by dept.name;

#4. Using SELECT name, dept, COALESCE(dept, 0) AS result FROM teacher on teacher table will:
/*
COALESCE takes any number of arguments and returns the first value that is not null.
COALESCE(x,y,z) returns x if x is not NULL
COALESCE(x,y,z) returns y if x is NULL and y is not NULL
COALESCE(x,y,z) returns z if x and y are NULL but z is not NULL
COALESCE(x,y,z) returns NULL if x and y and z are all NULL
*/
#display 0 in result column for all teachers without department

#5. Query: SELECT name, CASE WHEN phone = 2752 THEN 'two' WHEN phone = 2753 THEN 'three' WHEN phone = 2754 THEN 'four' END AS digit FROM teacher shows following 'digit':
/*
teacher
id	dept	name	phone
101	1	Shrivell	2753
102	1	Throd	2754
103	1	Splint	
104		Spiregrain	
105	2	Cutflower	3212
106		Deadyawn
*/
#'four' for Throd

#6. Select the result that would be obtained from the following code: SELECT name, CASE WHEN dept IN (1) THEN 'Computing' ELSE 'Other' END FROM teacher
/*
dept
id	name
1	Computing
2	Design
3	Engineering
*/
/*
Table-A
Shrivell	Computing
Throd	Computing
Splint	Computing
Spiregrain	Other
Cutflower	Other
Deadyawn	Other
*/

#https://sqlzoo.net/wiki/Self_join_Quiz
/*
SELF JOIN quiz  Two tables STOPS and ROUTE
STOPS
id
name
ROUTE
num
company
pos
stop
*/
#1. Select the code that would show it is possible to get from Craiglockhart to Haymarket
select distinct a.name, b.name
from stops a join route z
on a.id=z.stop
join route y
on y.num = z.num
join stops b
on y.stop=b.id
where a.name='craiglockhart' and b.name ='haymarket';

#2. Select the code that shows the stops that are on route.num '2A' which can be reached with one bus from Haymarket?
select s2.id, s2.name, r2.company, r2.num
from stops s1, stops s2, route r1, route r2
where s1.name='haymarket'
and s1.id = r1.stop
and r1.company = r2.company
and r1.num = r2.num
and r2.stop = s2.id
and r2.num = '2a';

#3. Select the code that shows the services available from Tollcross?
select a.company, a.num, stopa.name, stopb.name
from route a join route b
on (a.company = b.company and a.num = b.num)
join stops stopa
on (a.stop = stopa.id)
join stops stopb
on (b.stop = stopb.id)
where stopa.name='tollcross';