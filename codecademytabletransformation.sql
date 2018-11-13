#https://www.codecademy.com/learn/sql-table-transformation

#1 Subqueries
#We transform data from one format to achieve a desired result called data transformation or table transformation.
/*
airports 644 rows
id	bigint
code	text
site_number	text
fac_type	text
fac_use	text
faa_region	text
faa_dist	text
city	text
county	text
state	text
full_name	text
own_type	text
longitude	double
latitude	double
elevation	integer
aero_cht	text
cbd_dist	integer
cbd_dir	text
act_date	text
cert	text
fed_agree	text
cust_intl	text
c_ldg_rts	text
joint_use	text
mil_rts	text
cntl_twr	text
major	text

flights 499 rows
id	BIGINT
carrier	text
origin	text
destination	text
flight_num	text
flight_time	int
tail_num	text
dep_time	text
arr_time	text
dep_delay	int
arr_delay	int
taxi_out	int
taxi_in	int
distance	int
cancelled	text
diverted	text
dep_day_of_week	varchar (255)
dep_month	varchar (255)
dep_date	text
*/

#A non-correlated subquery is a subquery that can be run independently of the outer query.
#Which flights had an origin airport with an elevation greater than 2000 feet?
select code
from airports
where elevation > 2000; #finds the airports with elevation greater than 2000 from the airports table
select *
from flights
where origin in
	(select code
	from airports
	where elevation > 2000); #take the result set of the inner query and use it to filter on the flights table, to find the flight detail that meets the elevation criteria.
#Which flights had an origin airport with an elevation less than 2000 feet?
select *
from flights
where origin in
	(select code
	from airports
	where elevation < 2000); #take the result set of the inner query and use it to filter on the flights table, to find the flight detail that meets the elevation criteria.
#Look at a selection of flights whose origin airport is a seaplane base, designated by SEAPLANE_BASE. The facility type of an airport is located in the fac_type field of the airports table.
select *
from flights
where origin in
	(select code
	from airports
	where fac_type = "SEAPLANE_BASE");
#Find flight information about flights where the Federal Aviation Administration region (faa_region) is the Southern region (ASO).
select *
from flights
where origin in
	(select code
	from airports
	where faa_region = "ASO");
#We can also perform transformations on a single table. For instance, sometimes we need to aggregate in multiple steps - like taking an average of a count.
#How many flights there are on average, for all Fridays in a given month from the flights table. First, we’d need to calculate the number of flights per day, and then we’d need to calculate the average based on the daily flight count for each day of the week. We can do this all in one step using a subquery:
select a.dep_month, a.dep_day_of_week, avg(a.flight_count) as average_flights
from 
	(select dep_month, dep_day_of_week, dep_date, count(*) as flight_count
	from flights
	group by 1,2,3) a
group by 1,2
order by 1,2; #The inner query provides the count of flights by day, and the outer query uses the inner query’s result set to compute the average by day of week of a given month.
#Find the average total distance flown by day of week and month.
select a.dep_month, a.dep_day_of_week, avg(a.flight_distance) as average_distance 
from
	(select dep_month, dep_day_of_week, dep_date, sum(distance) as flight_distance
	from flights
	group by 1, 2, 3) a
group by 1, 2
order by 1, 2;
#In a correlated subquery, the subquery can not be run independently of the outer query. The order of operations is important in a correlated subquery:  A row is processed in the outer query.  Then, for that particular row in the outer query, the subquery is executed.  For each row processed by the outer query, the subquery will also be processed for that row.
#In this example, we will find the list of all flights whose distance is above average for their carrier.
select id
from flights as f
where distance >
	(select avg(distance)
 	from flights
 	where carrier = f.carrier);
#In the above query the inner query has to be re-executed for each flight. Correlated subqueries may appear elsewhere besides the WHERE clause, they can also appear in the SELECT.
#Find the id of the flights whose distance is below average for their carrier.
select id
from flights as f
where distance <
	(select avg(distance)
 	from flights
 	where carrier = f.carrier);
#Assuming flight_id increments with each additional flight, we could use the following query to view flights by carrier, flight id, and sequence number.
select carrier, id,
	(select count(*)
	from flights f
	where f.id < flights.id
	and f.carrier=flights.carrier) + 1
 	as flight_sequence_number
from flights;
#Write a query to view flights by origin, flight id, and sequence number.
select origin, id,
	(select count(*)
	from flights f
	where f.id < flights.id
	and f.origin=flights.origin) + 1
 	as flight_sequence_number
from flights;
/*
- Subqueries are used to complete an SQL transformation by nesting one query within another query.
- A non-correlated subquery is a subquery that can be run independently of the outer query and can be used to complete a multi-step transformation.
- A correlated subquery is a subquery that cannot be run independently of the outer query. The order of operations in a correlated subquery is as follows:
1. A row is processed in the outer query.
2. Then, for that particular row in the outer query, the subquery is executed.
*/

#2 Set Operations
#Unions allow us to utilize information from multiple tables in our queries.
/*
new_products 500 rows
id	integer
category	varchar(255)
item_name	varchar(255)
brand	varchar(255)
retail_price	double
department	varchar(255)
rank	integer
sku	varchar(255)

legacy_products 500 rows
id	integer
category	varchar(255)
item_name	varchar(255)
brand	varchar(255)
retail_price	double
department	varchar(255)
rank	integer
sku	varchar(255)

order_items 500 rows
id	integer
order_id	integer
sale_price	double
inventory_item_id	integer
returned_at	text

order_items_historic 500 rows
id	integer
order_id	integer
sale_price	double
inventory_item_id	integer
returned_at	text
*/
#We need to merge two tables together and then query the merged result.  There are two ways of doing this:  Merge the rows, called a join.  Merge the columns, called a union.  Union combines the result of two or more SELECT statements, using the following syntax:  select column_name(s) from table1 union select column_name(s) from table2;
#Each SELECT statement within the UNION must have the same number of columns with similar data types. The columns in each SELECT statement must be in the same order. By default, the UNION operator selects only distinct values.
#We acquired another store. The product data still exists in two separate tables: a legacy_products table and a new_products table. To get the complete list of product names from both tables, we can perform the following union.
select item_name
from legacy_products
union 
select item_name
from new_products;
#Select a complete list of brand names from the legacy_products and new_products tables.  By default, the UNION operator selects only distinct values.
select brand
from legacy_products
union
select brand
from new_products;
#What if we wanted to allow duplicate values? We can do this by using the ALL keyword with UNION, with the following syntax:  select column_name(s) from table1 union all select column_name(s) from table2;
#we learned we had records from historic order items in an additional table, we could use the following query to combine the tables for a complete analysis of sale price:
select id, sale_price
from order_items
union all
select id, sale_price
from order_items_historic;
#we can perform an analysis on top of the combined result set, like finding the total count of order items.
select count(*)
from 
	(select id, sale_price
	from order_items
	union all
	select id, sale_price
	from order_items_historic) as a;
#Find the average sale price over both order_items and order_items_historic tables.
select avg(a.sale_price)
from 
	(select id, sale_price
	from order_items
	union all
	select id, sale_price
	from order_items_historic) as a;
#INTERSECT is used to combine two SELECT statements, but returns rows only from the first SELECT statement that are identical to a row in the second SELECT statement. This means that it returns only common rows returned by the two SELECT statements:  select column_name(s) from table1 intersect select column_name(s) from table2;
#We might want to know what brands in our newly acquired store are also in our legacy store. We can do so using the following query:
select brand from new_products
intersect
select brand from legacy_products;
#EXCEPT is constructed in the same way, but returns distinct rows from the first SELECT statement that aren’t output by the second SELECT statement:  select column_name(s) from table1 except select column_name(s) from table2;
#We want to see if there are any categories that are in the new_products table that aren't in the legacy_products table. We can use an EXCEPT query to perform this analysis:
select category from new_products
except
select category from legacy_products;
#Select the items in the category column that are in the legacy_products table and not in the new_products table.
/*
We just learned about Set Operations in SQL. What can we generalize so far?
The UNION clause allows us to utilize information from multiple tables in our queries.
The UNION ALL clause allows us to utilize information from multiple tables in our queries, including duplicate values.
INTERSECT is used to combine two SELECT statements, but returns rows only from the first SELECT statement that are identical to a row in the second SELECT statement.
EXCEPT returns distinct rows from the first SELECT statement that aren’t output by the second SELECT statement
*/

#3 Conditional Aggregates
#Aggregate functions compute a single result from a set of multiple input values.
#Conditional Aggregates are aggregate functions that compute a result set based on a given set of conditions.
#Count the number of rows in the flights table, representing the total number of flights contained in the table.  RM:  each row is a flight.
select count(*) 
from flights; #return 499
#It's common to have empty or unknown "cells" in data tables.  A cell empty is denoted as NULL.
#We test whether a value is or is not null.  We use the special keywords IS NULL or IS NOT NULL in the WHERE clause (= NULL does not work).
#Count the number of rows from the flights table, where arr_time is not null and the destination is ATL.
select count(*) 
from flights
where arr_time is not null and destination = "ATL";
#In SQL, we represent if, then, else logic with the CASE statement, as follows:
select
    case
        when elevation < 500 then 'low'
        when elevation between 500 and 1999 then 'medium'
        when elevation >= 2000 then 'high'
        else 'unknown'
    end as elevation_tier, count(*)
from airports
group by 1;
#END is required to terminate the statement, but ELSE is optional. If ELSE is not included, the result will be NULL. Also notice the shorthand method of referencing columns to use in GROUP BY, so we don't have to rewrite the entire Case Statement.
#RM:  if then else group by combined if else group by
select
    case
        when elevation < 250 then 'Low'
        when elevation between 250 and 1749 then 'Medium'
        when elevation >= 1750 then 'High'
        else 'unknown'
    end as elevation_tier, count(*)
from airports
group by 1;
#Want to implement conditions on certain aggregates.  Identify the total amount of airports as well as the total amount of airports with high elevation in the same result set. We can accomplish this by putting a CASE WHEN statement in the aggregate.
select state, count(
	case
		when elevation >= 2000 then 1 else null end) as count_high_elevation_aiports 
from airports 
group by state;
#Write a query to count the number of low elevation airports by state where low elevation is defined as less than 1000 ft.
select state, count(
	case
		when elevation < 1000 then 1 else null end) as count_high_elevation_aiports 
from airports 
group by state;
#If we wanted to sum the total flight distance and compare that to the sum of flight distance from a particular airline (in this case, United Airlines) by origin airport, we could run the following query:
select origin, sum(distance) as total_flight_distance, sum(
	case
		when carrier = 'UA' then distance else 0 end) as total_united_flight_distance 
from flights 
group by origin;
#Find both the total flight distance and the flight distance by origin for Delta (carrier = 'DL').
select origin, sum(distance) as total_flight_distance, sum(
	case
		when carrier = 'DL' then distance else 0 end) as total_delta_flight_distance 
from flights 
group by origin;
#We combine aggregates to create percentages or ratios for instance.  find out the percent of flight distance that is from United by origin airport. We can do this simply by using the mathematical operators we need in SQL:
select origin, 100.0*(sum(
	case
		when carrier = 'UN' then distance else 0 end)/sum(distance)) as percentage_flight_distance_from_united from flights 
group by origin;
#Find the percentage of flights from Delta by origin (carrier = 'DL')
select origin, 100.0*(sum(
	case
		when carrier = 'DL' then distance else 0 end)/sum(distance)) as percentage_flight_distance_from_delta from flights 
group by origin;
#Find the percentage of high elevation airports (elevation >= 2000) by state from the airports table.
select state, 100.0*(sum(
	case
		when elevation >=2000 then 1 else 0 end)/count(*)) as percentage_high_elevation_airports from airports
group by state;
/*
You just learned about Conditional Aggregates in SQL. What can we generalize so far?

Conditional Aggregates are aggregate functions the compute a result set based on a given set of conditions.
NULL can be used to denote an empty field value
CASE statements allow for custom classification of data
CASE statements can be used inside aggregates (like SUM() and COUNT()) to provide filtered measures
*/