#https://www.codecademy.com/learn/learn-sql
#1 Learn SQL:  Manipulation Interactive Lesson
select *
from celebs;
/*
id	name	age
1	Justin Bieber	22
2	Beyonce Knowles	33
3	Jeremy Lin	26
4	Taylor Swift	26
*/
/* create table tablename (column1 integer, column2 text, column3 data, column 4 real)
or
clause tablename (parameters)
RM:  create table also a statement such as select statement for select query?  It seems statement and clause are interchangeably.
*/values (3, 'Jeremy Lin', 26);

create table celebs (id integer, name text, age integer);
insert into celebs (id, name, age)
values (1, 'Justin Bieber', 21);
insert into celebs (id, name, age)
values (2, 'Beyonce Knowles', 33);
insert into celebs (id, name, age)
insert into celebs (id, name, age)
values (4, 'Taylor Swift', 26);
select name
from celebs;
update celebs
set age = 22
where id = 1;  #update record, edit record, edit row, update row
alter table celebs
add column twitter_handle text;  #insert column
update celebs
set twitter_handle = '@taylorswift13'
where id = 4;
delete from celebs
where twitter_handle is null;  #delete record, delete row
create table awards (id integer primary key, recipient text not null, award_name text default "Grammy");
#UNIQUE columns have a different value for every row. This is similar to PRIMARY KEY except a table can have many different UNIQUE columns.
#DEFAULT columns take an additional argument that will be the assumed value for an inserted row if the new row does not specify a value for that column.

#1 Learn SQL:  Manipulation Create a Table
create table friends (id integer, name text, birthday date);
insert into friends (id, name, birthday)
values (1, "Jane Doe",'1990-05-30');
update friends
set name = 'Jane Smith'
where id = 1;
alter table friends
add column email text; 
update friends
set email = 'jane@codecademy.com'
where id = 1;
delete from friends
where id = 1;
#1 Learn SQL:  Manipulation Quiz
/*
What is a NULL value?  A value that represents missing or unknown data.
Which clause is used with the ALTER TABLE statement?  ADD COLUMN
What is the purpose of the * character?  It selects every column in the table.
What are common data types in SQL?  Integer, Text, Date, Real.  Real is a decimal number.
What would be correct syntax for a CREATE TABLE statement?  CREATE TABLE meals (name TEXT, rating INTEGER);
Which of the following statements is correct and complete?  DELETE FROM icecream WHERE flavor IS NULL;
What would you need to complete the associated UPDATE statement UPDATE ________ SET height = 6 WHERE id = 1;?  A table name.
What does SQL stand for?  Structured Query Language.  SQL is a programming language designed to manage data stored in relational databases.
What does the INSERT statement do?  Insert new rows into a table.  Insert records.  Insert rows.
What is a relational database?  A database that organizes information into one or more tables.
*/

#2 Learn SQL:  Queries Interactive Lesson
select *
from movies;
/*
Database Schema
movies 230 rows
id	INTEGER
name	TEXT
genre	TEXT
year	INTEGER
imdb_rating	REAL
*/
select name, genre, year
from movies;
select imdb_rating as 'IMDb'
from movies;  #AS is a keyword in SQL that allows you to rename a column or table using an alias.
select distinct genre
from inventory; #DISTINCT is used to return unique values in the output. It filters out all duplicate values in the specified column(s).
select *
from movies
where imdb_rating < 5;  #WHERE clause restricts query results to obtain only the information we want.
select *
from movies
where name like 'Se_en';
select *
from movies
where name like '%man%';
select *
from movies
where name like 'The %';  #selects all the information about the movie titles that begin with the word 'The'.  Exclude They, Them, Their, There
select name
from movies
where imdb_rating is null;
select *
from movies
where name between 'A' and 'J';  #The BETWEEN operator can be used in a WHERE clause to filter the result set within a certain range. The values can be numbers, text or dates.  Returns movies beginning with letters between A inclusive and J exclusive.
select *
from movies
where year between 1990 and 1999;  #Returns movies between 1990 and 1999 both inclusive
select *
from movies
where name between 'D' and 'G';  #Returns movies between D and F.
select *
from movies
where year between 1970 and 1979
and imdb_rating > 8;
select *
from movies
where year < 1985
and genre = 'horror';
select *
from movies
where genre = 'romance'
or genre = 'comedy';
select name, year, imdb_rating
from movies
order by imdb_rating desc;  #The column that we ORDER BY doesn't even have to be one of the columns that we're displaying.  ORDER BY always goes after WHERE if WHERE is present.
select *
from movies
order by imdb_rating desc
limit 3;  #LIMIT is a clause that lets you specify the maximum number of rows the result set will have.  LIMIT must be at the end.  Some SQL databases support LIMIT.
select name, case when imdb_rating > 8 then 'Fantastic' when imdb_rating > 6 then 'Poorly Received' else 'Avoid at all costs' end as 'Review'
from movies;  #A CASE statement allows us to create different outputs (usually in the SELECT statement). It is SQL's way of handling if-then if then logic.  Each WHEN tests a condition and the following THEN gives us the string if the condition is true.  The ELSE gives us the string if all the above conditions are false.  The CASE statement must end with END.  We can rename the case when column to 'Review' using AS.
select name, case when genre = 'romance' then 'Chill' when genre = 'comedy' then 'Chill' else 'Intense' end as 'Mood'
from movies;
#also
select name, case when genre = 'romance' or genre = 'comedy' then 'Chill' else 'Intense' end as 'Mood'
from movies;

#2 Learn SQL:  Queries New York Restaurants Freefrom Project
/* table name nomnom 53 rows
name restaurant name text
neighborhood neighborhood name text
cuisine cuisine type text
review average user review integer
price price range text as dollar signs $
health health inspection grade text
*/
select distinct neighborhood
from nomnom;
select *
from nomnom
where cuisine = 'Chinese';
select *
from nomnom
where review >= 4;
select *
from nomnom
where cuisine = 'Italian'
and price = '$$$';
select name
from nomnom
where name like '%meatball%';
select *
from nomnom
where neighborhood = 'Midtown'
or neighborhood = 'Downtown'
or neighborhood = 'Chinatown';
#also
select *
from nomnom
where neighborhood in ('Midtown','Downtown','Chinatown');
select *
from nomnom
where health is null;  #Find all the health grade pending restaurants (empty values).
select *
from nomnom
order by review desc
limit 10;  #Create a Top 10 Restaurants Ranking based on reviews.
select name, case when review > 4.5 then 'Extraordinary' when review > 4 then 'Excellent' when review > 3 then 'Good' when review > 2 then 'Fair' else 'Poor' end as "column name Review Rating"
from nomnom;

#2 Learn SQL:  Queries Quiz
/*
Which operator would you use to query values that meet all conditions in a WHERE clause?  AND
IS NULL condition returns true if the field is empty.  True
Which of the following is NOT a comparison operator in SQL? ~
What is the correct query to select only the cities with temperatures less than 35? SELECT * FROM cities WHERE temperature < 35;
What code would you add to this query to order colors by name alphabetically (Z to A) SELECT * 
FROM colors _________________;?  ORDER BY name DESC
Find the error in this code:  Missing END statement.  CASE statement must end with END.  RM:  The column was not renamed is after the END statement end as "column name".  ELSE statement appears to be optional.
	SELECT name,
	 CASE
	  WHEN imdb_rating > 8 THEN 'Oscar'
	  WHEN imdb_rating > 7 THEN 'Good'
	  WHEN imdb_rating > 6 THEN 'Fair'
	FROM movies;
How would you query all the unique genres from the books table?  SELECT DISTINCT genres FROM books;
What is the correct syntax to query both the name and date columns from the database SELECT __________ FROM album;?  name, date
What is ORDER BY?  A clause that sorts the result set alphabetically or numerically.
What does the wildcard character % in the following SQL statement do SELECT * FROM sports WHERE name LIKE '%ball';?  It matches all sports that end with 'ball'.
What is LIKE?  A special operator that can be used with the WHERE clause to search for a pattern.
What is LIMIT?  A clause that lets you specify the maximum number of rows the result set will have.
*/

#3 Learn SQL:  Aggregate Functions Interactive Lesson
#Calculations performed on multiple rows of a table are called aggregates.
/*
A table named fake_apps which is made up of fake mobile applications data.
fake_apps 200 rows
id	INTEGER
name	TEXT
category	TEXT
downloads	INTEGER
price	REAL

startups 70 rows
name	TEXT
location	TEXT
category	TEXT
employees	INTEGER
raised	INTEGER
valuation	INTEGER
founded	INTEGER
stage	TEXT
ceo	TEXT
info	TEXT
*/
select count(*)
from fake_apps
where price = 0;  #how many free apps are in the table.
select sum(downloads)
from fake_apps; #the total number of downloads for all of the apps combined
select max(downloads), min(downloads)
from fake_apps; #How many downloads does the most popular app have?  The least popular app have?
select avg(downloads)
from fake_apps; #the average number of downloads for an app
select name, round(price, 0)
from fake_apps; #It rounds the values in the column to the number of decimal places specified by the integer.  Returns 1.0 or 0.0 or 15.0
select round(avg(price), 2)
from fake_apps;
#GROUP BY is a clause in SQL that is used with aggregate functions. It is used in collaboration with the SELECT statement to arrange identical data into groups.  The GROUP BY statement comes after any WHERE statements, but before ORDER BY or LIMIT.
select price, count(*)
from fake_apps
group by price;
select price, count(*)
from fake_apps
where downloads > 20000
group by price;
select category, sum(downloads)
from fake_apps
group by category; #total number of downloads for each category
select round(imdb_rating), count(name)
from movies
group by round(imdb_rating)
order by round(imdb_rating);
#same as
select round(imdb_rating), count(name)
from movies
group by 1
order by 1;
#SQL also allows you to filter which groups to include and which to exclude.  We can't use WHERE here because we don't want to filter the rows; we want to filter groups.  This is where HAVING comes in.  HAVING is very similar to WHERE. In fact, all types of WHERE clauses you learned about thus far can be used with HAVING.
select year, genre, count(name)
from movies
group by 1, 2
having count(name) > 10;
select price, round(avg(downloads)), count(*)
from fake_apps
group by price
having count(*)>10;

#3 Learn SQL:  Aggregate Functions Freeform Project
/*
startups 70 rows
name	TEXT
location	TEXT
category	TEXT
employees	INTEGER
raised	INTEGER
valuation	INTEGER
founded	INTEGER
stage	TEXT
ceo	TEXT
info	TEXT
*/
select count(*)
from startups;  #total number of companies
select sum(valuation)
from startups;  #total value of all companies
select max(raised)
from startups
where stage = 'Seed';  #maximum amount of money raised during 'Seed' stage.
select min(founded)
from startups; #the oldest company on the list founded
select category, round(avg(valuation),2)
from startups
group by category
order by 2 desc; #the average valuation for each category
select category, count(*)
from startups
group by category
having count(*) > 3
order by count(*) desc; #return the name of each category with the total number of companies each category greater than 3
select location, avg(employees)
from startups
group by location
having avg(employees) > 500; # average size of a startup in each location greater than 500

#3 Learn SQL:  Aggregate Functions Quiz
/*
The WHERE clause filters rows, whereas the HAVING clause filter groups.  TRUE
What does the COUNT() function take as argument(s)?  The name of a column or *.
What does the following query do? SELECT price, COUNT(*) FROM menu WHERE orders > 50 GROUP BY price;.  It calculates the total number of menu items that have been ordered more than 50 times – for each price.
What does the following query do?  SELECT genre, SUM(downloads) FROM kindle GROUP BY genre;.  It returns the total amount of downloads – for each genre.
Aggregate functions ... compute a single result set from a set of values.
What does the following query do? SELECT neighborhood, AVG(price) FROM apartments GROUP BY neighborhood;.  It calculates the average price of apartments in each neighborhood.
Find the error in this code: SELECT COUNT(*) FROM songs HAVING plays > 100;.  It should be WHERE instead of HAVING.
How would you calculate the minimum number of stops from the train table?  SELECT MIN(stops) FROM train;
What does the ROUND function take as argument(s)?  The column name, and the number of decimal places to round the values in the column to.  ROUND(column, 2) would round the values in the column to 2 decimal places in the output.
Which function takes a column and returns the total sum of the numeric values in that column?  SUM()
*/

#4 Learn SQL:  Multiple Tables Interactive Lesson
/*
we can split our data into three tables:
#orders would contain just the information necessary to describe what was ordered 20 rows:
order_id  INT
customer_id INT
subscription_id INT
purchase_date DATE
#subscriptions would contain the information to describe each type of subscription 9 rows:
subscription_id int
description VARCHAR(256)
price_per_month INT
subscription_length TEXT
#customers would contain the information for each customer 10 rows:
customer_id INT
customer_name VARCHAR(256)
address VARCHAR(256)
*/
select *
from orders join subscriptions
on orders.subscription_id=subscriptions.subscription_id
where subscriptions.description='Fashion Magazine';  #selects rows from the join where description is equal to 'Fashion Magazine'.
select count(*)
from newspaper; #return 60
select count(*)
from online; #return 65
select count(*)
from newspaper join online
on newspaper.id=online.id; #return 50.  RM 50 rows or 50 ids subscribe to both newspaper and online.
#What if we want to combine two tables and keep some of the un-matched rows?  LEFT JOIN. A left join will keep all rows from the first table, regardless of whether there is a matching row in the second table.
select *
from newspaper left join online
on newspaper.id=online.id;
select *
from newspaper left join online
on newspaper.id=online.id
where online.id is null;
#Primary keys have a few requirements:  None of the values can be NULL.  Each value must be unique (i.e., you can't have two customers with the same customer_id in the customers table).  A table can not have more than one primary key column.
#When the primary key for one table appears in a different table, it is called a foreign key.  The most common types of joins will be joining a foreign key from one table with the primary key from another table. For instance, when we join orders and customers, we join on customer_id, which is a foreign key in orders and the primary key in customers.
select *
from classes join students
on classes.id=students.class_id;  #Perform an inner join of classes and students using the primary and foreign keys described above, and select all the columns.  classes table primary key is id.  students table primary key is id and foreign key corresponding to primary key id in classes table.
#Combine all rows of one table with all rows of another table.  Use a CROSS JOIN.  CROSS JOINS don't require an ON statement. You're not really joining on any columns!  A more common usage of CROSS JOIN is when we need to compare each row of a table to a list of values.
select shirts.shirt_color, pants.pants_color
from shirts cross join pants;
/*
Let's return to our newspaper subscriptions. This table contains two columns that we haven't discussed yet:
start_month: the first month where the customer subscribed to the print newspaper (i.e., 2 for February)
end_month: the final month where the customer subscribed to the print newspaper
Suppose we wanted to know how many users were subscribed during each month of the year. For each month (1, 2, 3) we would need to know if a user was subscribed. Follow the steps below to see how we can use a CROSS JOIN to solve this problem.
*/
select count(*)
from newspaper
where start_month <=3
and end_month >=3;  #return 13.  count the number of customers who were subscribed to the newspaper during March.  RM:  want start month less than or equal to 3 for customers subscribed before March and end month less than or equal to 3 for customers stopped receiving newspaper April and later.
select *
from newspaper cross join months; #Our database contains another table called months which contains the numbers between 1 and 12.  RM:  returns a table all newspaper subscribers and the months each number between 1 and 12 inclusive.
/*
id	first_name	last_name	email	start_month	end_month	month
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	1
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	2
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	3
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	4
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	5
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	6
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	7
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	8
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	9
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	10
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	11
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	12
*/
select *
from newspaper cross join months
where newspaper.start_month <=months.month
and newspaper.end_month >=months.month;  #Select all months where a user was subscribed.
/*
id	first_name	last_name	email	start_month	end_month	month
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	1
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	2
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	3
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	4
21253	Vinnie	Sagaser	Vinnie.Sagaser@yoohoo.com	1	5	5
*/
select months.month, count(*)
from newspaper cross join months
where newspaper.start_month <=months.month
and newspaper.end_month >=months.month
group by months.month;
/*
month	count(*)
1	2
2	9
3	13
4	17
5	27
6	30
7	20
8	22
9	21
10	19
11	15
12	10
*/
#To stack one dataset on top of the other.  The UNION operator allows us to do that.  Tables must have the same number of columns. The columns must have the same data types in the same order as the first table.
select *
from newspaper
union
select *
from online;
/*
We want to combine two tables, but one of the tables is the result of another calculation.
WITH previous_results AS (
   SELECT ...
   ...
   ...
   ...
)
SELECT *
FROM previous_results
JOIN customers
  ON _____ = _____;
We are putting a whole first query inside the parentheses () and giving it a name. After that, we can use this name as if it's a table and write a new query using the first query.
*/
select customer_id, count(subscription_id) as 'subscriptions'
from orders
group by customer_id;
with previous_query as 
	(select customer_id, count(subscription_id) as 'subscriptions'
	 from orders
	 group by customer_id)
select customers.customer_name, previous_query.subscriptions
from previous_query
join customers
on customers.customer_id =  previous_query.customer_id
order by previous_query.subscriptions desc;
/*
customer_name	subscriptions
Lizabeth Letsche	6
Allie Rahaim	4
Jessia Butman	2
Inocencia Goyco	2
Eryn Vilar	2
Jacquline Diddle	1
Bethann Schraub	1
Janay Priolo	1
Ophelia Sturdnant	1
*/

#4 Learn SQL:  Multiple Tables Freeform Project
/*
Three tables:
trips - trips information
riders - users data
cars - autonomous cars
id	date	pickup	dropoff	rider_id	car_id	type	cost
1001	2017-12-05	06:45	07:10	102	1	X	28.66
1002	2017-12-05	08:00	08:15	101	3	POOL	9.11
1003	2017-12-05	09:30	09:50	104	4	X	24.98
1004	2017-12-05	13:40	14:05	105	1	X	31.27
1005	2017-12-05	15:15	16:00	103	2	POOL	18.95
1006	2017-12-05	18:20	18:55	101	3	XL	78.52
id	first	last	username	rating	total_trips	referred
101	Sonny	Li	@sonnynomnom	4.66	352	null
102	Laura	Breiman	@lauracle	4.99	687	101
103	Kassa	Korley	@kassablanca	4.63	42	null
104	Yakov	Kagan	@yakovkagan	4.52	1910	103
id	model	OS	status	trips_completed
1	Ada	Ryzac	active	82
2	Ada	Ryzac	active	30
3	Turing XL	Ryzac	active	164
4	Akira	Finux	maintenance	22
*/
select *
from trips left join riders
on trips.rider_id = riders.id; #create a Trip Log with the trips and its users or riders.
select *
from trips left join cars
on trips.car_id = cars.id; #create a link between the trips and the cars used during those trips.
select *
from riders
union
select *
from riders2; #new riders data are in riders2 table.  Stack riders table on top of riders2 table.
select avg(cost)
from trips; #average cost for a trip
select *
from riders
where total_trips < 500; #find riders total trips less than 500 times
select count(*)
from cars
where status='active'; #calculate or count the number of cars that are active
select *
from cars
order by trips_completed desc
limit 2; #finds the two cars that have the highest trips_completed.

#4 Learn SQL:  Multiple Tables Quiz
/*
Which keyword would you use to alias recipes.name and chefs.name in the following query'? SELECT recipes.name __ 'Recipe', chefs.name __ 'Chef' FROM recipes JOIN chefs ON recipes.chef_id = chefs.id;.  Using AS, you can give a table or a column a temporary name.
What is the best definition of a primary key?  A unique identifier for each row or record in a given table.
Which kind of join is in the animation below?  Oh, that's a INNER JOIN.  When we perform a simple JOIN (often called an inner join), our result only includes rows that match our ON condition.
UNION allows us to stack one dataset on top of another.  TRUE.  The UNION operator is used to combine the results of two or more SELECT statements.
Why is a CROSS JOIN not so useful?  It combines every row in one table with every row in another table.
You have two tables teachers and students. Each student belongs to a teacher. Complete the query to join the tables on the teacher id.  SELECT * FROM students JOIN teachers ON __________________;.  students.teacher_id = teachers.id
What is the best definition of a foreign key?  A column that contains the primary key of another table in the database.
In a LEFT JOIN, if a join condition is not met, what will it use to fill columns on the right table?  NULL values
You have two tables authors and books. Each book belongs to an author and references that author through a foreign key. If a specific author has an id = 5, what would be the correct foreign key for a book that belongs to that author?  author_id = 5
What is the difference between an INNER JOIN and a LEFT JOIN?  LEFT JOIN combines rows from two or more tables, but unlike INNER JOIN, it does not require the join condition to be met.
*/

#https://www.codecademy.com/learn/sql-table-transformation
#1 Subqueries Interactive Lesson
#Data transformation or table transformation transforms data from one format to another.  Subqueries, sometimes referred to as inner queries or nested queries, are used to transform table data by nesting one query within another query.
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
select code
from airports
where elevation > 2000; #finds the airports with elevation greater than 2000 from the airports table
select * 
from flights 
where origin in
	(select code 
    from airports 
    where elevation > 2000); #find the flight detail that meets the elevation criteria 2000 and greater
#The query above and below are a non-correlated subquery which is a subquery that can be run independently of the outer query and as we saw, can be used to complete a multi-step transformation.
select * 
from flights 
where origin in
    (select code 
    from airports 
    where fac_type = 'seaplane_base'); #look at a selection of flights whose origin airport is a seaplane base, designated by SEAPLANE_BASE. The facility type of an airport is located in the fac_type field of the airports table.
select * 
from flights 
where origin in
	(select code 
    from airports 
    where faa_region = 'ASO'); #find flight information about flights where the Federal Aviation Administration region (faa_region) is the Southern region (ASO).
#We can also perform transformations on a single table. For instance, sometimes we need to aggregate in multiple steps - like taking an average of a count.
#How many flights there are on average, for all Fridays in a given month from the flights table. First, we’d need to calculate the number of flights per day, and then we’d need to calculate the average based on the daily flight count for each day of the week. We can do this all in one step using a subquery:
select a.dep_month, a.dep_day_of_week, avg(a.flight_count) as average_flights
from
    (select dep_month, dep_day_of_week, dep_date, count(*) as flight_count
     from flights
     group by 1,2,3) a
 group by 1,2
 order by 1,2; #the inner query provides the count of flights by day, and the outer query uses the inner query’s result set to compute the average by day of week of a given month.
select a.dep_month, a.dep_day_of_week, avg(a.flight_distance) as average_distance
from
    (select dep_month, dep_day_of_week, dep_date, sum(distance) as flight_distance
     from flights
     group by 1,2,3) a
 group by 1,2
 order by 1,2; #find the average total distance flown by day of week and month.
 #In a correlated subquery, the subquery can not be run independently of the outer query. The order of operations is important in a correlated subquery:  A row is processed in the outer query.  Then, for that particular row in the outer query, the subquery is executed.  This means that for each row processed by the outer query, the subquery will also be processed for that row. In this example, we will find the list of all flights whose distance is above average for their carrier.
select id
from flights as f
where distance >
	(select avg(distance)
 	from flights
 	where carrier = f.carrier); #the inner query has to be re-executed for each flight. Correlated subqueries may appear elsewhere besides the WHERE clause, they can also appear in the SELECT.
select id
from flights as f
where distance <
	(select avg(distance)
 	from flights
 	where carrier = f.carrier); #Find the id of the flights whose distance is below average for their carrier.
select carrier, id,
	(select count(*)
	from flights f
	where f.id < flights.id
	and f.carrier=flights.carrier) + 1 as flight_sequence_number
from flights; #assuming flight_id increments with each additional flight, we could view flights by carrier, flight id, and sequence number.
select origin, id,
	(select count(*)
	from flights f
	where f.id < flights.id
	and f.origin=flights.origin) + 1 as flight_sequence_number
from flights; #view flights by origin, flight id, and sequence number. Alias the sequence number column as flight_sequence_number.
/*Summary
Generalizations
Congratulations! You've just learned about non-correlated and correlated subqueries in SQL. What can we generalize so far?

- Subqueries are used to complete an SQL transformation by nesting one query within another query.

- A non-correlated subquery is a subquery that can be run independently of the outer query and can be used to complete a multi-step transformation.

- A correlated subquery is a subquery that cannot be run independently of the outer query. The order of operations in a correlated subquery is as follows:

1. A row is processed in the outer query.

2. Then, for that particular row in the outer query, the subquery is executed.
*/
