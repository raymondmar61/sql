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
#RM:  if you're creating a new column based on another column, the based on another column name must be mentioned.  In the example below, name is the column name for based on another column name.
select *,
	case name
		when 'kale-smoothie'    then 'smoothie'
		when 'banana-smoothie'  then 'smoothie'
		when 'orange-juice'     then 'drink'
		when 'soda'             then 'drink'
		when 'blt'              then 'sandwich'
		when 'grilled-cheese'   then 'sandwich'
		when 'tikka-masala'     then 'dinner'
		when 'chicken-parm'     then 'dinner'
		else 'other'
	end as category
from order_items
order by id
limit 100;
/*
You just learned about Conditional Aggregates in SQL. What can we generalize so far?

Conditional Aggregates are aggregate functions the compute a result set based on a given set of conditions.
NULL can be used to denote an empty field value
CASE statements allow for custom classification of data
CASE statements can be used inside aggregates (like SUM() and COUNT()) to provide filtered measures
*/

#4 Date, Number, and String Functions
#We'll be learning about some of SQL's built-in functions for transforming dates, numbers and strings.
/*
bakeries 1000 rows
id	integer
distance	integer
first_name	varchar(255)
last_name	varchar(255)
city	varchar(255)
state	varchar(255)
baked_goods 500 rows
id	BIGINT
cost	double
manufacture_time	text
delivery_time	text
cook_time	text
cool_down_time	text
ingredients_cost	double
packaging_cost	double
ingredients	varchar (255)
*/
#Dates are often written in the following format  1. Date: YYYY-MM-DD.  2. Datetime or Timestamp: YYYY-MM-DD hh:mm:ss  We can use SQL's date functions to transform data into a desired format.
#Using the datetime function, select the date and time of all deliveries in the baked_goods table using the column delivery_time.
select datetime(delivery_time)
from baked_goods;
#We can use the DATE() function to easily convert timestamps to dates and complete the following query:
select date(manufacture_time), count(*) as count_baked_goods
from baked_goods
group by date(manufacture_time);
#or by time
select time(manufacture_time), count(*) as count_baked_goods
from baked_goods
group by time(manufacture_time);
#Find the number of baked goods by date of delivery.
select date(delivery_time), count(*) as count_baked_goods
from baked_goods
group by date(delivery_time);
#We can increment date or timestamp values by a specified interval.
datetime(time1, '+3 hours', '40 minutes', '2 days'); #in SQLite.  Returns time 3 hours, 20 minutes, and 2 days after time1
#Each dessert in our baked_goods table is inspected 2 hours, 30 minutes, and 1 day after the manufacture time. 
select datetime(manufacture_time, '+2 hours', '30 minutes', '1 day') as inspection_time
from baked_goods;
#Each of the baked goods is packaged by Baker's Market exactly five hours, twenty minutes, and two days after the delivery (designated by delivery_time).  Create a query to return all packaging times for goods.
select datetime(delivery_time, '+5 hours', '20 minutes', '2 day') as package_time
from baked_goods;
#We'd like to make sure that each ingredient cost is rounded to four decimal places rather than two, to account for currency fluctuations.
select round(ingredients_cost, 4) as rounded_cost
from baked_goods;
#Find the bakery's distance from the market rounded to two decimal places.
select round(distance, 2) as distance_from_market
from bakeries;
#We can use the MAX function to determine the overall greatest value of ingredients_cost or packaging_cost for each item using the following query:
select id, max(ingredients_cost, packaging_cost)
from baked_goods;
SELECT id, cook_time, cool_down_time, max(cook_time, cool_down_time)
FROM baked_goods
limit(10);
#Find the greatest time value for each item in the table for cook_time and cool_down_time
select id, cook_time, cool_down_time, max(cook_time, cool_down_time)
from baked_goods
limit(10);
/*
id	cook_time	cool_down_time	max(cook_time, cool_down_time)
1	89	63	89
2	5	33	5
3	1	100	100
4	46	26	46
5	16	57	57
6	29	14	29
7	85	76	85
8	56	25	56
9	43	1	43
10	97	37	97
*/
select id, max(cook_time, cool_down_time)
from baked_goods;  #RM:  correct answer Find the greatest time value for each item in the table for cook_time and cool_down_time
#Find the least time value for each item in the table for cook_time and cool_down_time
select id, min(cook_time, cool_down_time)
from baked_goods;
#A common use case for string manipulation in SQL is concatenation of strings. select string1 || ' ' || string2;  select city || ' ' || state as location from bakeries;
#Combine the first_name and last_name columns from the bakeries table as the full_name to identify the owners of the bakeries.
select first_name  || ' ' || last_name  as full_name
from bakeries;
#REPLACE() REPLACE(string,from_string,to_string) The function returns the string string with all occurrences of the string from_string replaced by the string to_string.
#replace the underscores with spaces in ingredients column
select id, replace(ingredients,'_',' ') as item_ingredients
from baked_goods;
#Any time enriched_flour appears in the ingredients list, we’d like to replace it with just flour.
select id, replace(ingredients,'enriched_flour','flour') as item_ingredients
from baked_goods;
select replace(ingredients,'enriched_',' ') as item_ingredients
from baked_goods;  --RM:  correct answer

#2 Common Metrics
#We take a look at basic KPIs such as daily revenue, daily active users or DAU, ARPU or average revenue per purchasing user, and Retention for a video game Mindblocks.
/*
purchases 2000 rows
id	int
user_id	int
price	real
refunded_at	text
created_at	text

gameplays 14000 rows
id	int
user_id	int
created_at	text
platform	text
*/
#Daily Revenue is simply the sum of money made per day.
select date(created_at), round(sum(price), 2)
from purchases
group by 1
order by 1;
#Update our daily revenue query to exclude refunds.
select date(created_at), round(sum(price), 2) as daily_rev
from purchases
where refunded_at is null
group by 1
order by 1;
#DAU is defined as the number of unique players seen in-game each day.  Likewise, Weekly Active Users (WAU) and Monthly Active Users (MAU) are in the same family.
#For Mineblocks, we'll use the gameplays table to calculate DAU. Each time a user plays the game, their session is recorded in gameplays. Thus, a distinct count of users per day from gameplays will give us DAU.
select date(created_at), count(distinct user_id) as dau
from gameplays
group by 1
order by 1;
#Now we want DAU per platform, making the desired output [date, platform, dau_count].  Calculate DAU for Mineblocks per-platform.
select date(created_at), platform, count(distinct user_id) as dau
from gameplays
group by 1, 2
order by 1, 2;
#The next KPI we'll look at Daily ARPPU - Average Revenue Per Purchasing User. This metric shows if the average amount of money spent by purchasers is going up over time.  Daily ARPPU is defined as the sum of revenue divided by the number of purchasers per day.
select date(created_at), round(sum(price)/count(distinct user_id), 2) as arppu
from purchases
where refunded_at is null
group by 1
order by 1;
#The more popular (and difficult) cousin to Daily ARPPU is Daily ARPU, Average Revenue Per User. ARPU measures the average amount of money we're getting across all players, whether or not they've purchased.
#Daily ARPU is defined as revenue divided by the number of players, per-day. To get that, we'll need to calculate the daily revenue and daily active users separately, and then join them on their dates.
#One way to easily create and organize temporary results in a query is with CTEs, Common Table Expressions, also known as with clauses. The with clauses make it easy to define and use results in a more organized way than subqueries.  with clause create temporary result sets.  These clauses usually look like this:
/*
with {subquery_name} as (
	{subquery_body}
)
select ...
from {subquery_name}
where ...
*/
#Use a with clause to define daily_revenue and then select from it.
with daily_revenue as (
  select date(created_at) as dt, round(sum(price), 2) as rev
  from purchases
  where refunded_at is null
  group by 1
)
select *
from daily_revenue
order by dt;
/*
dt	rev
2015-08-04	41.5
2015-08-05	53.0
2015-08-06	24.5
2015-08-07	51.0
2015-08-08	40.5
2015-08-09	14.0
2015-08-10	30.0
2015-08-11	27.0
2015-08-12	64.0
2015-08-13	34.0
2015-08-14	40.5
2015-08-15	41.0
2015-08-16	54.5
2015-08-17	49.5
2015-08-18	53.0
2015-08-19	63.0
2015-08-20	23.5
2015-08-21	31.5
2015-08-22	35.0
2015-08-23	43.5
2015-08-24	45.5
2015-08-25	52.5
2015-08-26	31.0
2015-08-27	29.0
2015-08-28	43.0
2015-08-29	42.5
2015-08-30	42.0
2015-08-31	33.5
2015-09-01	24.5
*/
#You just built the first part of ARPU, daily_revenue. From here we can build the second half of ARPU in our with clause, daily_players, and use both together to create ARPU.
#We can add in DAU from earlier. Complete the query by calling the DAU query we created earlier, now aliased as daily_players:
with daily_revenue as (
  select date(created_at) as dt, round(sum(price), 2) as rev
  from purchases
  where refunded_at is null
  group by 1
), daily_players as (
  select date(created_at) as dt, count(distinct user_id) as players
  from gameplays
  group by 1
)
select *
from daily_players
order by dt;
#Now that we have the revenue and DAU, join them on their dates and calculate daily ARPU. Complete the query by adding the keyword using in the join clause.
with daily_revenue as (
  select date(created_at) as dt, round(sum(price), 2) as rev
  from purchases
  where refunded_at is null
  group by 1
), daily_players as (
  select date(created_at) as dt, count(distinct user_id) as players
  from gameplays
  group by 1
)
select daily_revenue.dt, daily_revenue.rev / daily_players.players
from daily_revenue join daily_players
using (dt); #In the final select statement, daily_revenue.dt represents the date, while daily_revenue.rev / daily_players.players is the daily revenue divided by the number of players that day. In full, it represents how much the company is making per player, per day.  We used using instead of on in the join clause. This is a special case join.
/*
dt	daily_revenue.rev / daily_players.players
2015-08-04	0.419191919191919
2015-08-05	0.452991452991453
2015-08-06	0.231132075471698
2015-08-07	0.490384615384615
2015-08-08	0.397058823529412
2015-08-09	0.110236220472441
2015-08-10	0.294117647058824
2015-08-11	0.228813559322034
2015-08-12	0.673684210526316
2015-08-13	0.354166666666667
2015-08-14	0.385714285714286
2015-08-15	0.36283185840708
2015-08-16	0.5
2015-08-17	0.462616822429907
2015-08-18	0.469026548672566
2015-08-19	0.567567567567568
2015-08-20	0.200854700854701
2015-08-21	0.28125
2015-08-22	0.299145299145299
2015-08-23	0.462765957446808
2015-08-24	0.421296296296296
2015-08-25	0.4375
2015-08-26	0.298076923076923
2015-08-27	0.252173913043478
2015-08-28	0.383928571428571
2015-08-29	0.366379310344828
2015-08-30	0.392523364485981
2015-08-31	0.291304347826087
2015-09-01	0.21875
*/
#We used using instead of on in the join clause. This is a special case join: from daily_revenue join daily_players using (dt);  When the columns to join have the same name in both tables you can use using instead of on. Our use of the using keyword is in this case equivalent to this clause:  from daily_revenue join daily_players on daily_revenue.dt = daily_players.dt;
#What percent of Mineblock players are returning to play the next day. This KPI is called 1 Day Retention. The most basic definition is  all players on Day N, we'll consider them retained if they came back to play again on Day N+1.  The stickier our game, the more days players will spend in-game.  And more time in-game means more opportunities to monetize and grow our business.
#Currently the gameplays table is a list of when the user played, and it's not easy to see if any user came back.
#By using a self-join, we can make multiple gameplays available on the same row of results. This will enable us to calculate retention.  The power of self-join comes from joining every row to every other row. This makes it possible to compare values from two different rows in the new result set. In our case, we'll compare rows that are one date apart from each user.
#To calculate retention, start from a query that selects the date(created_at) as dt and user_id columns from the gameplays table.
select date(created_at) as dt, user_id
from gameplays as g1
order by dt
limit 100;
#Now we'll join gameplays on itself so that we can have access to all gameplays for each player, for each of their gameplays.
#This is known as a self-join and will let us connect the players on Day N to the players on Day N+1. In order to join a table to itself, it must be aliased so we can access each copy separately.
#We aliased gameplays in the query above because in the next step, we need to join gameplays to itself so we can get a result selecting [date, user_id, user_id_if_retained].
#Complete the query by using a join statement to join gameplays to itself on user_id using the aliases g1 and g2.
select date(g1.created_at) as dt, g1.user_id
from gameplays as g1 inner join gameplays as g2
on g1.user_id = g2.user_id
order by 1
limit 100;
#Now that we have our gameplays table joined to itself, we can start to calculate retention.
#1 Day Retention is defined as the number of players who returned the next day divided by the number of original players, per day. Suppose 10 players played Mineblocks on Dec 10th. If 4 of them play on Dec 11th, the 1 day retention for Dec 10th is 40%.
select date(g1.created_at) as dt, g1.user_id, g2.user_id
from gameplays as g1 join gameplays as g2
on g1.user_id = g2.user_id
and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
order by 1
limit 100;
/*
dt	user_id	user_id
2015-08-04	128	128
2015-08-04	323	323
2015-08-04	323	323
2015-08-04	407	407
2015-08-04	393	393
2015-08-04	14	14
2015-08-04	14	14
2015-08-04	26	26
2015-08-04	375	375
2015-08-04	251	251
2015-08-04	238	238
2015-08-04	360	360
2015-08-04	191	191
2015-08-04	188	188
2015-08-04	283	283
2015-08-04	321	321
2015-08-04	311	311
2015-08-04	117	117
2015-08-04	0	0
2015-08-04	93	93
2015-08-04	190	190
2015-08-04	231	231
2015-08-04	321	321
2015-08-04	491	491
2015-08-04	491	491
2015-08-04	44	44
*/
#Instead, we want to use a left join, this way all rows in g1 are preserved, leaving nulls in the rows from g2 where users did not return to play the next day.  Change the join clause to use left join and count the distinct number of users from g1 and g2 per date.
select date(g1.created_at) as dt, count(distinct g1.user_id) as total_users, count(distinct g2.user_id) as retained_users
from gameplays as g1 left join gameplays as g2
on g1.user_id = g2.user_id
and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
group by 1
order by 1
limit 100;
/*
dt	total_users	retained_users
2015-08-04	99	23
2015-08-05	117	30
2015-08-06	106	24
2015-08-07	104	23
2015-08-08	102	20
2015-08-09	127	26
2015-08-10	102	25
2015-08-11	118	20
2015-08-12	95	18
2015-08-13	96	19
2015-08-14	105	26
2015-08-15	113	30
2015-08-16	109	26
2015-08-17	107	20
2015-08-18	113	24
2015-08-19	111	26
2015-08-20	117	31
2015-08-21	112	27
2015-08-22	117	24
2015-08-23	94	23
2015-08-24	108	23
2015-08-25	120	23
2015-08-26	104	24
2015-08-27	115	24
2015-08-28	112	33
2015-08-29	116	17
2015-08-30	107	30
2015-08-31	115	24
2015-09-01	112	36
*/
#Now that we have retained users as count(distinct g2.user_id) and total users as count(distinct g1.user_id), divide retained users by total users to calculate 1 day retention!
select date(g1.created_at) as dt, round(100 * count(distinct g2.user_id) / count(distinct g1.user_id)) as retention
from gameplays as g1 left join gameplays as g2
on g1.user_id = g2.user_id
and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
group by 1
order by 1
limit 100;
/*
dt	retention
2015-08-04	23.0
2015-08-05	25.0
2015-08-06	22.0
2015-08-07	22.0
2015-08-08	19.0
2015-08-09	20.0
2015-08-10	24.0
2015-08-11	16.0
2015-08-12	18.0
2015-08-13	19.0
2015-08-14	24.0
2015-08-15	26.0
2015-08-16	23.0
2015-08-17	18.0
2015-08-18	21.0
2015-08-19	23.0
2015-08-20	26.0
2015-08-21	24.0
2015-08-22	20.0
2015-08-23	24.0
2015-08-24	21.0
2015-08-25	19.0
2015-08-26	23.0
2015-08-27	20.0
2015-08-28	29.0
2015-08-29	14.0
2015-08-30	28.0
2015-08-31	20.0
2015-09-01	32.0
*/