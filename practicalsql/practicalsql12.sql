#Chapter 12 Advanced Query Techniques (p 191)

#Subqueries is like the subquery returns multiple rows and treat the results as a table in the from clause of the main query.  A scalar subquery that returns a single value and use it as part of an expression to filter rows via where, in, and having clauses.  An update table query can be a subquery.

--use subquery in where clause
--find USA counties above 90th percentile or top 10% for population sorted by population p0010001 highest to lowest
select geo_name, state_us_abbreviation, p0010001
from us_counties_2010
where p0010001 >= (
	select percentile_cont(.9) within group (order by p0010001)
	from us_counties_2010)
order by p0010001 desc;  --the subquery returns 197444.6 which means all counties population greater than or equal to 197444.6

--create a top 10% population table
create table us_counties_2010_top10 as
	select *
	from us_counties_2010;
delete from us_counties_2010_top10
where p0010001 < (
	select percentile_cont(.9) within group (order by p0010001)
	from us_counties_2010_top10);  --the subquery returns 197444.6 which means all counties population less than 197444.6 are deleted
select *
from us_counties_2010_top10
order by p0010001 desc;
drop table us_counties_2010_top10;

--use subqery in from clause.  Give the subquery in from clause an alias derivedtable.  Derived table is a subquery returns rows and columns of data converted to a table by placing it in a from clause to run main query.
select avg(p0010001) as "average population 98232.751511294941", percentile_cont(.5) within group (order by p0010001)::numeric(10,1) as "median population 25857.0"
from us_counties_2010;  --returns 98232.751511294941 and 25857.0
select round(derivedtable."average population 98232.751511294941", 0) as "average 98233", derivedtable."median population 25857.0" as "median 25857.0", round(derivedtable."average population 98232.751511294941" - derivedtable."median population 25857.0", 0) as "subtract average population from median population 72367"
from (
     select avg(p0010001) as "average population 98232.751511294941", percentile_cont(.5) within group (order by p0010001)::numeric(10,1) as "median population 25857.0"
     from us_counties_2010)
as derivedtable;

--RM:  Begin page 195 Joining Derived Tables 06/18/18.
--joining derived tables or derived table.
select st, count(*) as plant_count
from meat_poultry_egg_inspect
group by st;  --number of plants per state
select state_us_abbreviation, sum(p0010001) as st_population
from us_counties_2010
group by state_us_abbreviation;  --total population per state
select census.state_us_abbreviation as st, census.st_population, plants.plant_count, round((plants.plant_count/census.st_population::numeric(10,2))*1000000,1) as plants_per_million
from
	(select st, count(*) as plant_count
	from meat_poultry_egg_inspect
	group by st) as plants  --number of plants per state
join
	(select state_us_abbreviation, sum(p0010001) as st_population
	from us_counties_2010
	group by state_us_abbreviation) as census  --total population per state
on plants.st = census.state_us_abbreviation
order by plants_per_million desc;

--place a subquery in the column list after select clause
select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010;  --return the median population 25857
select geo_name, state_us_abbreviation as st, p0010001 as total_pop, (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) as us_median
from us_counties_2010;  --lists population for each county and state and include the subquery column us_median comparing popuation for each county and state with usa median population 25857
select geo_name, state_us_abbreviation as st, p0010001 as total_pop, (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) as us_median, p0010001 - (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) as diff_from_median  --population for each county and state and subtracts from usa median population 25857
from us_counties_2010;
select geo_name, state_us_abbreviation as st, p0010001 as total_pop, (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) as us_median, p0010001 - (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) as diff_from_median  
from us_counties_2010
where p0010001 - (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) between -1000 and 1000;  --population for each county and state and subtracts from usa median population 25857 difference between -1000 and 1000

--use subqueries to filter rows by evaluating whether a condition evaluates as true or false.  Use subquery expressions to filter rows based on the existence of values in another table.  Instructor examines the syntax for two subquery expressions.  https://www.postgresql.org/docs/current/static/functions-subquery.html lists available subquery expressions.
select id
from retirees;  --retirees table doesn't exist; however, query returns all id in retirees table
select first_name, last_name
from employees
where id in (
	select id
	from retirees);  --find retired employees in employees table
--exists is a true/false test.  It returns true if the subquery in parantheses returns at least one row.  If it returns no rows, exists returns false.
select first_name, last_name
from employees
where exists (
	select id
	from retirees);
select first_name, last_name
from employees
where exists (
	select id
	from retirees
	where id = employees.id);
select first_name, last_name
from employees
where not exists (
	select id
	from retirees
	where id = employees.id);

--common table expression define one or more tables up from with subqueries.  Then you can query the table results as often as needed in a main query that follows.  Informally called a "with clause."
select geo_name, state_us_abbreviation, p0010001
from us_counties_2010
where p0010001 >= 100000;  --return counties and their state population 100,000 and greater
with
	temporarytablename_large_counties (geo_name, st, p0010001)
as
	(select geo_name, state_us_abbreviation, p0010001
	from us_counties_2010
	where p0010001 >= 100000)
select st, count(*)
from temporarytablename_large_counties
group by st
order by count(*) desc;  --count how many counties in each state have population 100,000 and greater from temporarytablename_large_counties table.  st column references state_us_abbreviation column.
--same as 
select state_us_abbreviation, count(*)
from us_counties_2010
where p0010001 >= 100000
group by state_us_abbreviation
order by count(*) desc;
/* common table expressions prestage subsets of data to feed into a larger query for more complex analysis.  You can reuse each table defined in multiple places in the main query which means you don't have to repeat the select query each time.  The code is more readable that if you performed the same operation with subqueries */
select census.state_us_abbreviation as st, census.st_population, plants.plant_count, round((plants.plant_count/census.st_population::numeric(10,2))*1000000,1) as plants_per_million
from
	(select st, count(*) as plant_count
	from meat_poultry_egg_inspect
	group by st) as plants  --number of plants per state
join
	(select state_us_abbreviation, sum(p0010001) as st_population
	from us_counties_2010
	group by state_us_abbreviation) as census  --total population per state
on plants.st = census.state_us_abbreviation
order by plants_per_million desc;
--same as with common table expressions
with
	temporarytablename_counties (st, population) as
	(select state_us_abbreviation, sum(population_count_100_percent)
	from us_counties_2010
	group by state_us_abbreviation),  --notice the comma separating the two temporary tables.  Populations for each state.
	temporarytablename_plants (st, plants) as
	(select st, count(*) as plants
	from meat_poultry_egg_inspect
	group by st)  --number of plants for each state.
select temporarytablename_counties.st, population, plants
from temporarytablename_counties join temporarytablename_plants
on temporarytablename_counties.st = temporarytablename_plants.st;  --returns total poulation and total number of plants for each state
WITH
    counties (st, population) AS
    (SELECT state_us_abbreviation, sum(population_count_100_percent)
     FROM us_counties_2010
     GROUP BY state_us_abbreviation),
    plants (st, plants) AS
    (SELECT st, count(*) AS plants
     FROM meat_poultry_egg_inspect
     GROUP BY st)
SELECT counties.st, population, plants, round((plants/population::numeric(10,1))*1000000, 1) AS per_million
FROM counties JOIN plants
ON counties.st = plants.st
ORDER BY per_million DESC;  --returns the number of plants per million population
select geo_name, state_us_abbreviation as st, p0010001 as total_pop, (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) as us_median, p0010001 - (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) as diff_from_median  
from us_counties_2010
where p0010001 - (select percentile_cont(.5) within group (order by p0010001)
from us_counties_2010) between -1000 and 1000;  --population for each county and state and subtracts from usa median population 25857 difference between -1000 and 1000
--same as with common table expressions
with temporarytable_us_median as
	(select percentile_cont(.5) within group (order by p0010001) as us_median_pop
	from us_counties_2010)
select geo_name, state_us_abbreviation as st, p0010001 as total_pop, us_median_pop, (p0010001 - us_median_pop) as diff_from_median
from us_counties_2010 cross join temporarytable_us_median
where (p0010001 - us_median_pop) between -1000 and 1000;  --cross join make the temporarytable_us_median 25857 available to every row.  Also, you can run the same query if you want the 90th percentile replace .5 with .9.

--cross tabulations summarize and compare variables by displaying them in a table layout.  Need to install tablefunc module.
--Instructor says there are modules for PostgreSQL https://www.postgresql.org/docs/current/static/contrib.html
--Execute the command:  create extension tablefunc; to use crosstab() function.
create table ice_cream_survey (response_id integer primary key, office varchar(20), flavor varchar(20));
copy ice_cream_survey
from 'i:\program files\postgresql\ice_cream_survey.csv'
with (format csv, header);  --there are three flavors chocolate, vnailla, strawberry and three office Downtown, Midtown, Uptown
select office, flavor, count(*)
from ice_cream_survey
group by office, flavor
order by office;
select flavor
from ice_cream_survey
group by flavor
order by flavor;
select *
from crosstab
	('select office, flavor, count(*)
	from ice_cream_survey
	group by office, flavor
	order by office',  --first subquery generates the data and required columns.  First column office supplies the category row.  Second column flavor supplies the category columns.  The third column count(*) supplies the values where row and column intersect.
	'select flavor
	from ice_cream_survey
	group by flavor
	order by flavor')  --second subquery produces the set of category names for the columns.  The crosstab() requies the second subquery return only one column.  The group by return the column's unique values.
as
	(office varchar(20), chocolate bigint, strawberry bigint, vanilla bigint);  --specify the names and data types of the crosstab's output columns office, chocolate, strawberry, and vanilla.  The list must match the row and column names in the order the subqueries generate them.
--RM:  I can't run a crosstab query to restrict flavors to Chocolate and Vanilla
select *
from crosstab
	('select office, flavor, count(*)
	from ice_cream_survey
	where flavor = 'Chocolate' or flavor = 'Vanilla'
	group by office, flavor
	order by office',  --first subquery generates the data and required columns.  First column office supplies the category row.  Second column flavor supplies the category columns.  The third column count(*) supplies the values where row and column intersect.
	'select flavor
	from ice_cream_survey
	group by flavor
	order by flavor')  --second subquery produces the set of category names for the columns.  The crosstab() requies the second subquery return only one column.  The group by return the column's unique values.
as
	(office varchar(20), chocolate bigint, vanilla bigint);  --specify the names and data types of the crosstab's output columns.  The list must match the row and column names in the order the subqueries generate them.
create table temperature_readings (reading_id bigserial, station_name varchar(50), observation_date date, max_temp integer, min_temp integer);
copy temperature_readings (station_name, observation_date, max_temp, min_temp)
from 'i:\program files\postgresql\temperature_readings.csv'
with (format csv, header);
select station_name, date_part('month', observation_date) as extractmonth, percentile_cont(.5) within group (order by max_temp) as higher50percentmaxtemp
from temperature_readings
group by station_name, date_part('month', observation_date)
order by station_name;  --return median max temperature for each station each month
select *
from crosstab
	('select station_name, date_part(''month'', observation_date) as extractmonth, percentile_cont(.5) within group (order by max_temp) as higher50percentmaxtemp
	from temperature_readings
	group by station_name, date_part(''month'', observation_date)
	order by station_name',  --notice the comma separating the two subqueries.  station_name is the row header, date_part extract the month for the column headers, percentile_cont(.5) the median max_temp is the data.
	'select month
	from generate_series(1,12) month') --notice month is double single quotes.  Category names for the column headers.
as
	(station varchar(50), jan numeric(3,0), feb numeric(3,0), mar numeric(3,0), apr numeric(3,0), may numeric(3,0), jun numeric(3,0), jul numeric(3,0), aug numeric(3,0), sep numeric(3,0), oct numeric(3,0), nov numeric(3,0), dec numeric(3,0));  --notice month is double single quotes.  Names or labels and data types for the column header and data field.

--case or if-then or if then conditional expression
/*
case when condition1 then result1
	when another_condition2 then result2
	when another_condition3 then result3
	when another_condition4 then result4
	else result5
end
*/
select station_name, observation_date, max_temp
from temperature_readings;
select station_name, observation_date, max_temp, 
	case when max_temp > 90 then 'Hot'
	when max_temp between 70 and 89 then 'Warm'
	when max_temp between 50 and 69 then 'Pleasant'
	when max_temp between 33 and 49 then 'Cold'
	when max_temp between 20 and 32 then 'Freezing'
	else 'Inhumane'
	end as "Temperature Description"
from temperature_readings;


--case or if-then or if then conditional expression in a common table expression
with temps_collapsed (station_name, max_temperature_group) as
	(select station_name,
	case when max_temp > 90 then 'Hot'
	when max_temp between 70 and 89 then 'Warm'
	when max_temp between 50 and 69 then 'Pleasant'
	when max_temp between 33 and 49 then 'Cold'
	when max_temp between 20 and 32 then 'Freezing'
	else 'Inhumane'
	end
from temperature_readings)
select station_name, max_temperature_group, count(*)
from temps_collapsed
group by station_name, max_temperature_group
order by station_name, count(*) desc;