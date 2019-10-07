#https://sqlzoo.net/

#Select Reference
#How to read the data from a database
#https://sqlzoo.net/wiki/SELECT_Reference
#The select command shows data from a database.  The output is always a grid with rows and columns.
select name, population
from bbc
where region = 'North America';
#Use the concat operator to combine strings.  Some SQL databases use ||.
select concat(region, name)
from bbc;
#Use the like operator as a wild card.  _ matches any single character.  % matches any character.  like operator is case insensitive.
select name
from bbc
where name like 'Z%';
#Use the union operator to list multiple select statements.  The same number of columns must be the same.  Combine select statements.
/*
name
Zambia
Zimbabwe
Z-Trip
Za'Mari Breedlove
Zaa Nkweta
Zac Benoir
Zac Efron
*/
select name
from bbc
where name like 'Z%'
union
select name
from actor
where name like 'Z%';
#Use an additional apostrophe as an escape character
select *
from bbc
where name = 'Cote d''Ivoire';
#Self-join each table is given an alias to treat each table differently.  Inner-join is default.
select w.first_name as worker, b.first_name as boss
from employee w, employee b
where w.manager_id=b.employee_id;
#Column names with spaces column names are enclosed in single quotes
select 'Account Balance'
from spacemonster;
#Use is null for null value missing data or unknown data
select name, gdp
from world
where name is null;

#Create and Drop Reference
#How to create tables, indexes, views and other things. How to get rid of them
#https://sqlzoo.net/wiki/CREATE_and_DROP_Reference
#Create a new table
/*
INTEGER	A whole number
VARCHAR(10)	Up to 10 characters.
CHAR(10)	Fixed number of characters
DATE	A date
TIMESTAMP	Date and time
FLOAT	Floating point numbers
TEXT	Allows up to 65535 characters
DECIMAL(10,2)	Up to 10 digits before the point, 2 after.
*/
create table tablename (
	wholenumber integer primary key,
	variablecharacter varchar(10),
	fixedcharacter char(10),
	datecolumn date,
	timecolumn timestamp,
	floatcolumn float,
	textcolumn text,
	decimal_10beforewards2afterwards decimal(10,2));
#Drop a table or delete a table
drop table deletetablename;
#Composite primary key.  A composite key has more than one attribute or one field.
create table tablename (
	album char(10) not null,
	disk integer not null,
	position integer not null,
	song varchar(255), 
	primary key (album, disk, position));
#Create a foreign key  #RM:  no foreign key example
create table microprocessors (
	jaar integer primary key,
	architecture varchar(15),
	fabricant varchar(10),
	cores integer
	threads integer);
insert into microprocessors
values(2011,"Sandy Bridge","Intel",4,8);
#Create a view.  A view is a named select statement.
create view viewname as
	select name, population
	from world
	where region = 'Europe';
#Create a new table with auto number or auto increment or autonumber or autoincrement.
create table tablename (
	id integer auto_increment primary key,
	name varchar(10));
insert into tablename(name)
values('Andrew');
insert into tablename(name)
values('Gordon');  #RM:  must identify columnname in insert SQL
#Alter table add column insert column
alter table tablename add column newcolumnname integer;
#Alter table drop column delete column
alter table tablename drop column dropcolumnname;
#Alter table add constraint insert constraint
#constraintaction is a foreign key reference, a unique requirement, or a check constraint
alter table tablename add constraintaction ();
alter table tablename add check (y>0);
#Create table foreign key reference
#A foreign key should refer to a candiate key in some table which is usually the primary key.  A foreign key may be a field or list of fields specified as unique.
create table customer (
	id integer primary key,
	name varchar(100));
create table invoice (
	customernumber integer,
	orderdate date,
	amount decimal(6,2),
	foreign key(customernumber) references customer(id));
insert into customer
values(101,'Arnold Anxious');
insert into invoice
values(101,'2014-08-21',42.00);
#Rename column name alter column name
alter table tablename change oldcolumnname newcolumnname integer;

#Insert and Delete
#How to put records into a table, change them and how to take them out again.
#https://sqlzoo.net/wiki/INSERT_and_DELETE_Reference
#Insert new records insert new row
insert into tablename(numberid, firstname)
values(1,'andrew');
insert into tablename
values(2,'gordon');  #if values are in order of columns from left to right, then no need to mention column names
#Update existing records update row
update tablename
set columnname1 = 'newvalue1', columnname2 = 'newvalue2'
where columnname2 = 'oldvalue2';
#Delete removes records delete row
delete from tablename
where columnname = 'delete criteria';
#Insert new records insert new rows from a table
insert into tablename1
select columnname1, columnname2
from tablenamesource
where columnname = 'criteria';
#Insert new records insert new row selected columns.  insert: not all fields need be specified. default values may be specified in the create table clause - otherwise null is used.
insert into tablename(specifiedcolumnname)
values(99);
#Insert new records insert new row date
insert into tablename(name, entrydate)
values('Ryka','1997-03-01');
insert into tablename(name, entrydate)
values('Impos','1997-09-20');
#Insert null records insert null row
insert into tablename(name, entrydate)
values(null,'2001-03-15');
#String contains a quote escape quote use two quotes double quotes
insert into tablename
values('O''Brian');

#Date and Time
#How to work with dates; adding, subtracting and formatting.
#https://sqlzoo.net/wiki/DATE_and_TIME_Reference
#Date and time types
#The SQL standard permits date, time, and timestamp.  Timestamp includes a date and a time.  Timestamp is different for different SQL languages.
create table dateandtime(
	datecolumn date,
	timecolumn time,
	timestampcolumn timestamp);
insert into dateandtime(datecolumn, timecolumn, timestampcolumn)
values('1962-05-20','10:32:16','2002-06-30 14:34:55');
/*
datecolumn	timecolumn	timestampcolumn
1962-05-20	10:32:16	2002-06-30 14:34:55
*/
#Format a date and time.  Many support the SQL standard.  Date format date.  date_format() function.
select date_format(columnname1, '%d/%m/%Y'), song
from tablename
where singer='Tom Jones';
/*
DATE_FORMAT(w..	song
30/04/1987	A Boy From Nowhere
14/05/1987	A Boy From Nowhere
...
*/
/*
Specifier	Description
%a	Abbreviated weekday name (Sun..Sat)
%b	Abbreviated month name (Jan..Dec)
%c	Month, numeric (0..12)
%D	Day of the month with English suffix (0th, 1st, 2nd, 3rd, ...)
%d	Day of the month, numeric (00..31)
%e	Day of the month, numeric (0..31)
%f	Microseconds (000000..999999)
%H	Hour (00..23)
%h	Hour (01..12)
%I	Hour (01..12)
%i	Minutes, numeric (00..59)
%j	Day of year (001..366)
%k	Hour (0..23)
%l	Hour (1..12)
%M	Month name (January..December)
%m	Month, numeric (00..12)
%p	AM or PM
%r	Time, 12-hour (hh:mm:ss followed by AM or PM)
%S	Seconds (00..59)
%s	Seconds (00..59)
%T	Time, 24-hour (hh:mm:ss)
%U	Week (00..53), where Sunday is the first day of the week
%u	Week (00..53), where Monday is the first day of the week
%V	Week (01..53), where Sunday is the first day of the week; used with %X
%v	Week (01..53), where Monday is the first day of the week; used with %x
%W	Weekday name (Sunday..Saturday)
%w	Day of the week (0=Sunday..6=Saturday)
%X	Year for the week where Sunday is the first day of the week, numeric, four digits; used with %V
%x	Year for the week, where Monday is the first day of the week, numeric, four digits; used with %v
%Y	Year, numeric, four digits
%y	Year, numeric, two digits
%%	A literal `%'.
*/
#Specify a date.  SQL standard date specify.
select *
from tablename
where yearmonthdaycolumnname = '1982-05-29';
#Match a range of dates.  Date range date.
select *
from tablename
where yearmonthdaycolumnname between '1980-01-22' and '1982-06-30';
#Subtract dates.  SQL standard result is year-month-day hour:minute:second.  Number of days.  to_days() function.
select columnname1, columnname2, to_days(now()) - to_days(datecolumn) as "Number Of Days"
from tablename;
#Intervals of time.  We can add or subtract number of days, years, months, hours, minutes, or seconds from date.  Date between date.  Use interval keyword.
select *
from tablename
where date '1976-05-20' between datecolumn - interval '7' day and datecolumn;  #RM:  return dates 1976-05-20 and 1976-05-27
#Components of date.  Extract date.  Extract year, extract month, extract day, extract week.  Functions are the following:  dayofmonth dayofweek dayofyear dayname hour minute month monthname quarter second week weekday year yearweek.
select datecolumn, year(datecolumn), month(datecolumn), dayofmonth(datecolumn), dayname(datecolumn)
from tablename;
/*
wk	YEAR(wk)	MONTH(wk)	DAYOFMONTH(wk)	DAYNAME(wk)
1982-11-18	1982	11	18	Thursday
1982-12-02	1982	12	2	Thursday
*/
#Date functions.  Count or average by days of the week.  Use group by.  Date group by date.
select dayofweek(wk), count(song)
from totp
group by dayofweek(wk);
/*
DAYOFWEEK(wk)	COUNT(song)
1	7
2	61
3	63
4	99
5	6166
6	1026
7	6
*/
#Select oldest date earliest date
select *
from tablename
order by datecolumn asc limit 1;
#Select newest date latest date.  RM:  it's a subquery.
select *
from tablename
where datecolumn = (
	select max(datecolumn)
	from tablename);
#Return specified date format date_format() function example
select date_format(datecolumn, '%Y%m%d') as "YYYYMMDD"
from tablename;

#Functions
#How to use string functions, logical functions and mathematical functions.
#https://sqlzoo.net/wiki/Functions_Reference
/*Standard SQL Functions: % MODULO, + (string), + INTERVAL, +(dates), ABS, AVG, CASE, CAST, CEIL, COALESCE, CONCAT, COS, COUNT, CURRENT_DATE, CURRENT_TIMESTAMP, DATEPART, DAY, DIV, EXTRACT, FLOOR, HOUR, IFNULL, INSTR, LEFT, LEN, LENGTH, MAX, MIN, MINUTE, MOD, MONTH, NULLIF, NVL, PATINDEX, POSITION, QUARTER, RANK, REPLACE, RIGHT, ROUND, SECOND, SIN, Strings, SUBSTR, SUBSTRING, SUBSTRING(ansi), SUM, TAN, TO_CHAR(dates), TRIM, YEAR */
#Concatenate strings
select concat(columnname1, ' is in ', columnname2)
from tablename;  #RM:  some SQL only two strings are concatenate
#Extracting substrings
select columnname1, substring(columnname1 from 1 for 2) as "first two characters"
from tablename;
#Lower case.  Upper case is similar.
select lower(columnname) as "all lower case"
from tablename
where upper(columnname) = 'ALL UPPER CASE';
#Finding a substring in a string
select columnname, position(' ' in columnname), substring(columnname from 1 for position(' ' in columnname)) as "characters from start to first space"
from tablename;
#Formatting numbers to two decimal spaces
select columnname, round(columnname/1000000,2) as "two decimal places", round(columnname,-6) as "round million with six zeroes 106400000 is 106000000"
from tablename;
#Replace a null with a specific value
select coalesce(columnname, "string to replace the null under columnname for each row")
from tablename;
#Conditional values
select columnname1, case when columnname2>8.5 then 'Excellent' when columnname2>10 then 'Good' when columnname2>20 then 'Fair' else 'Average' end, columnname3
from tablename;
#Get a date and time now at the moment
select current_timestamp, current_date, current_time
from tablename;
#Format dates
select date_format(columnname, '%d/%m/%Y')  as "14/05/1987"
from tablename;

#Users
#How to create users, GRANT and DENY access, get at other peoples tables. How to find processes and kill them.
#https://sqlzoo.net/wiki/Users_Reference
#RM:  scanned.  Copy and paste solutions.
#Create a new user.  Give a new user permission.
create database scott;
grant select, insert,update,delete,create,drop,alter
	on scott.* to scott@localhost
	identified by 'tiger';
flush privileges;
#Read tables from another schema/database
#A particular server may support a number of different sets of tables. In Oracle these are schemas in MySQL they are databases. In both cases each user normally has their own set of tables, other users tables may be accessed using a dot notation.
select *
from gisq.one;
#Change the default schema/database
#In many engines several independant databases may exist. Often each user has his or her own database. This allows different users to use the same names for tables.
use scott;
#Find another process and kill it.  Change the default schema/database.
#Sometimes users set off queries that may take a very long time to complete. We may want to find such long running processes and stop them. Some kind of administrative account is usually required.
show processlist;
kill 16318
#Set a timeout
#Users may accidentally (or deliberately) start queries which would take a very long time to complete. We can set a 'timeout'; this means that the system gives up after a certain amount of time.
#RM:  no example
#Change my own password
#Users should be able to change their own passwords. The administrator should be able to change other people's passwords.
set password for scott@localhost=password('tiger');
#Who am I?  What is my user id?
#Find the user name or user id. The SQL standard permits the function USER.
select user()

#Meta Data Reference
#How to find out what tables and columns exist. How to count and limit the rows return
#https://sqlzoo.net/wiki/Meta_Data_Reference
#What are my tables?  Get a list of all tables.  Table names.
show tables;  #RM:  some SQL need the paranthesis? show tables();
#What are the columns [in the] table?  List column names column
show columns
from tablename;
#Get first rows.  Get top rows.  Get n rows.
select *
from tablename
limit 10;
#Get selected rows selected.  Get range rows.  Get between rows between.
select *
from tablename
limit 11, 10; #get the 11th row to 20th.
#What version [version SQL version] am I using?
select version();
#What is the syntax to view structure of table?  Structure table structure.  View table view.
show columns
from tablename;
#How can you determine the primary key using SQL?  Find primary key.  What is primary key?
describe tablename;
#Return a sequential record count for all records returned
#website says copy the table to another table with auto-increment auto increment autoincrement as the first column.
#Create auto-increment table
create table tablename (
	counter integer not null auto_increment primary key,
	columnname1 varchar(50),
	columnname2 decimal(10,0)
	columnname3 integer);
insert into tablename
select columnname1, columnname2, columnname3
from tablenamesource;

#SQL Hacks
#Some SQL Hacks, taken from "SQL Hacks" published by O'Reilly
#https://sqlzoo.net/wiki/Hacks_Reference
#Hack 10 Subquery and join
select payment
from salary
where rank = (
	select rank
	from ranks
	where title = (
		select title
		from jobs
		where employee = 'Andrew Cumming'));
#The subquery is more efficient if it was a join because there are no aggregate functions.
select payment
from salary, ranks, jobs
where salary.rank = ranks.rank
and ranks.title = jobs.title
and jobs.employee = 'Andrew Cumming';
#Hack 11 Converting aggregate subqueries into joins
select customer, whn, totalitems
from orders a
where a.whn = (
	select max(totalitems)
	from orders b
	where a.customer = b.customer);
#The subquery is more efficient using having
select a.customer, a.whn, a.totalitems
from orders a join orders b
on a.customer = b.customer
group by a.customer, a.whn, a.totalitems
having a.whn = max(b.whn);
#Hack 14 Combinations
#A JOIN with no join conditions results in every row in one table being connected to every row in another table, forming all possible row combinations.
select home.teamname home, away.teamname away, tscores.homescore, tscores.awayscore
from teams home cross join teams away left join tscores
on (home.teamname = tscores.hometeam and tscores.awayteam = away.teamname)
where home.teamname != away.teamname;
#Hack 16 String over columns
#Using or increases the chances for careless mitakes instead of concat.  Concat makes the query more efficient.
select name
from bedrooms
where floorcolor = 'YELLOW'
or ceilingcolor = 'YELLOW'
or wallcolor = 'YELLOW';
select name
from bedrooms
where concat(':',floorcolor':',ceilingcolor,':',wallcolor,':')
like '%:yellow:%';
#Hack 24 Multiply across a result set
/*
EXP(SUM(LN((r..
118.0998
*/
select exp(sum(ln((rate/100)+1)))*100
from interest;
#Hack 25 Running total
/*
dte	description	a	balance
2006-11-01	Wages	50	50
2006-11-02	Company Store	-10	40
2006-11-03	Company Store	-10	30
2006-11-04	Company Store	-10	20
2006-11-05	Company Store	-10	10
2006-11-06	Company Store	-10	0
*/
#To calculate a running total a table needs to be joined to itself, each version can be called table x and table y.
select w as dte, d as description, a, balance
from (
	select x.whn as w, x.description as d, x.amount as a, sum(y.amount) as balance
	from transact x join transact y
	on x.whn>=y.whn
	group by x.whn, x.description, x.amount) t;
#Hack 25.5 Splitting and combining columns
#The SUBSTRING used in the example is used to get rid of the negative sign infront of the number so that there are only positive numbers in the table.
/*
dte	description	cshIN	cshOUT
2006-11-01	Wages	50	
2006-11-02	Company Store		10
2006-11-03	Company Store		10
2006-11-04	Company Store		10
2006-11-05	Company Store		10
2006-11-06	Company Store		10
*/
select w as dte, d as description, case when (a>=0) then a else null end as cshin, case when (a<0) then substr(a,2,10) else null end as cshout
from (
	select x.whn as w, x.description as d, x.amount as a
	from transact x join transact y
	on x.whn>=y.whn
	group by x.whn, x.description, x.amount) t;
#Hack 26 Include the rows your JOIN forgot
/*
name	COUNT(custid)
Arnold Anxious	0
Betty	2
Janette	1
Robert	0
*/
select name, count(custid)
from customer join invoice
on id = custid
group by name;
#In order to obtain the rows where the count from the query is 0 a LEFT JOIN or a UNION can be used.
select name, count(custid)
from customer left join invoice
on id = custid
group by name;
#Hack 30 Calculate the maximum/minimum of two fields
/*
id	x	y	(x+y+ABS(x-y)..
A	1	2	2.0000
B	4	3	4.0000
C	5	5	5.0000
*/
select id, x, y, (x+y+abs(x-y))/2 
from t; maximum value over x and y column
/*
id	x	y	(x+y-ABS(x-y)..
A	1	2	1.0000
B	4	3	3.0000
C	5	5	5.0000
*/
select id, x, y, (x+y+abs(x-y))/2 
from t; #minimum value over x and y column
#Hack 33 Get values and subtotals in one shot
#In this example a UNION is used to make the query show the subtotal results along with the price results and to ensure the subtotals come after the price a COALESCE function is also used.
/*
item	serialnumber	price
Awl	1	10
Awl	3	10
Awl		20
Bowl	2	10
Bowl	5	10
Bowl	6	10
Bowl		30
Cowl	4	10
Cowl		10
*/
select item, serialnumber, price 
from(
	select item, serialnumber, price 
	from serial
	union
	select item, null, sum(price)
	from serial
	group by item) t
order by item, coalesce(serialnumber,1e9);
#Hack 50 Combine tables containing different data
#how to take tables with different data and put them into a single table that is more understandable allowing all the information from two or more tables to be seen.
#You will have to make the two tables agree before you can do the UNION though, this is done by making the final table contain all information from all tables with NULL entries in the rows that don't have the data required.
/*
id	name	email	salary	gpa	species
F173	Stern, Stan	stan@bos.edu	99000		Staff
F101	Aloof, Alison	ali@bos.edu	30000		Staff
S1007	Perfect,Peter	1007@bos.edu		590	Student
S1008	Dunce,Donald	1008@bos.edu		220	Student
*/
select concat('f',staffid) id, name name, email email, salary salary, null gpa, 'staff' species
from staff
union
select concat('s',id) id, concat(lname,',',fname) name, concat(id,'@bos.edu') email, null salary, gpa gpa, 'student' species
from student;
#Hack 51/52 Display rows as columns.  Transverse.  Flip results.  Pivot table.
/*
student	course	grade
Gao Cong	Java	80
Gao Cong	Database	77
Gao Cong	Algebra	50
Dongyan Zhou	Java	62
Dongyan Zhou	Database	95
Dongyan Zhou	Algebra	62
/*
/*
name	java	DB	Algebra
Gao Cong	80	77	50
Dongyan Zhou	62	95	62
*/
select name, java.grade as java, db.grade as db, alg.grade as algebra
from exam left outer join coursegrade java
on (name=java.student and java.course='java')
left outer join coursegrade db
on (name=db.student and db.course='database')
left outer join coursegrade alg on
(name=alg.student and alg.course='algebra');
#Hack 55 Import Someone Else's Data
/*
Table 1
id	parkingSpace
E01	F8
E02	G22
E03	F7
Table 2
id	name	phone
E01	Harpo	2753
E02	Zeppo	2754
E03	Groucho	2755
Table 3
id	name	phone	parkingSpace
E01	Harpo	2753	F8
E02	Zeppo	2754	G22
E03	Groucho	2755	F7
*/
create view mimic as
	select employeeparking.id, coalesce(name, employeeparking.id) as name, coalesce(phone, 'not available') as phone, parkingspace
	from employeeparking left outer join employeecopy
	on (employeeparking.id = employeecopy.id);
select *
from mimic;  #see Table 3 for answer
#Hack 62 Issue Queries Without Using a Table
#Only certain functions can be used without a table and these functions are called static functions.  Static functions can allow a user to obtain the current username, current date, current timestamp and also the version of the database being used.
/*
CURRENT_USER	CURRENT_DATE
scott@localhost	2019-09-25
*/
select current_user, current_date;
#Hack 63 Generate rows without tables.  In other words, run a SQL query to returns results without accessing or linking a table in database.
/*
centigrade	fahrenheit
0	32.0000
10	50.0000
20	68.0000
30	86.0000
40	104.0000
*/
select x centigrade, x*9/5+32 fahrenheit
from  (
	select 0 x
	union
	select 10
	union
	select 20
	union
	select 30
	union
	select 40) t;
#Hack 70 Combine your queries
#Here you are shown how to combine multiple queries.  Both related and unrelated queries can be merged, if the queries are often used together then combining them together can greatly improve performance.  Use UNION and match columns with column name null.
#Table 1 and 2 show the two separate tables and Table 3 shows the result you would obtain from combining queries.
/*
Table 1
content	Page name
hello	index.html
Hia	index.html
page2	p2.html
Index	contents.html
Table 2
Message
The site will be down on Tuesday
Table 3
pagename	content	NULL	page
index.html	hello		page
index.html	Hia		page
The site will be down on Tuesday	motd
*/
select pagename, content
from page
where pagename = 'index.html';
select message from motd;
select pagename, content, null, 'page'
from page
where pagename = 'index.html'
union 
select null, null, message, 'motd'
from motd;
#Hack 72 Extract a subset of the results.  Extract part.  Extract in part.  Extract top.  Extract bottom.
select username, score
from highscore
order by score desc limit 10;
#Hack 78 Break it down by Range
/*
the_range	avgSpend
15-24	140.0000
25-34	105.0000
35-44	125.0000
*/
select concat(low-5,'-' ,low+4) as the_range, avgspend
from (
	select round(age,-1) as low, avg(spend) as avgspend
	from population
	group by round(age,-1)) t;
#Hack 88 Test two values from a subquery
/*
Table 1
Customer	Item	Price
Brian	Table	100
Robert	Chair	20
Robert	Carpet	200
Janette	Statue	300
Table 2
Customer	Item	Price
Brian	Table	100
Robert	Carpet	200
Janette	Statue	300
*/
select x.customer, x.item, x.price
from custitem x join ( 
	select customer, max(price) as price
	from custitem
	group by customer) y
on (x.customer = y.customer and x.price = y.price);  #answer is Table 2
#Hack 98 Find and stop long running queries
#Here you are shown how to find long running queries and to kill them stopping them from using up database resources and therefore allowing the database to respond quicker.
/*
Id	User	Host	db	Command	Time	State	Info	Progress
2308933	scott	localhost	scott	Query	0	init	SHOW PROCESSLIST	0
*/
show processlist;
#Hack 100 Run SQL from a Web Page

#https://sqlzoo.net/wiki/SELECT_basics
/*
world
name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
....
*/
#1. Show the population of Germany
select population
from world
where name = 'Germany';
#2. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
select name, population
from world
where name in ('Sweden','Norway','Denmark');
#3. Show the country and the area for countries with an area between 200,000 and 250,000.
select name, area
from world
where area between 200000 and 250000;

#https://sqlzoo.net/wiki/SELECT_names
/*
world
name	continent
Afghanistan	Asia
Albania	Europe
Algeria	Africa
Andorra	Europe
Angola	Africa
....
*/
#1. Find the country that start with Y.
select name
from world
where name like 'Y%';
#2. Find the countries that end with y.
select name
from world
where name like '%y';
#3. Find the countries that contain the letter x.
select name
from world
where name like '%x%';
#4. Find the countries that end with land.
select name
from world
where name like '%land';
#5. Find the countries that start with C and end with ia.
select name
from world
where name like 'C%ia';
#6. Find the country that has oo in the name.
select name
from world
where name like '%oo%';
#7. Find the countries that have three or more a in the name.
select name
from world
where name like '%a%a%a%';
#8. Find the countries that have "t" as the second character.
select name
from world
where name like '_t%';
#9. Find the countries that have two "o" characters separated by two others.
select name
from world
where name like '%o__o%';
#10. Find the countries that have exactly four characters.
select name
from world
where name like '____';
#11. Find the country where the name is the capital city.
select name, capital
from world
where name = capital;
#12. Find the country where the capital is the country plus "City".
select name, concat(name,' City')
from world
where capital = concat(name,' City');
#13. Find the capital and the name where the capital includes the name of the country.
select capital, name
from world
where capital like('%'||name||'%');
#14. Find the capital and the name where the capital is an extension of name of the country.  You should include Mexico City as it is longer than Mexico. You should not include Luxembourg as the capital is the same as the country.
select capital, name
from world
where capital like(name||'%')
and capital != name;
#15. For Monaco-Ville the name is Monaco and the extension is -Ville.  Show the name and the extension where the capital is an extension of name of the country.  You can use the SQL function REPLACE.
select name, substr(capital,length(name)+1,100)
from world
where capital like(name||'%')
and capital != name;

#https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial
/*
world
name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...
*/
#2. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
select name
from world
where population >= 200000000;
#3.  Give the name and the per capita GDP for those countries with a population of at least 200 million.
select name, gdp/population
from world
where population >= 200000000;
#4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
select name, population/1000000
from world
where continent = 'South America';
#5. Show the name and population for France, Germany, Italy.
select name, population
from world
where name in ('France','Germany','Italy');
#6. Show the countries which have a name that includes the word 'United'.
select name
from world
where name like 'United%';
#7. Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.  Show the countries that are big by area or big by population. Show name, population and area.
select name, population, area
from world
where area > 3000000 or
population > 250000000;
#8. Exclusive OR (XOR). Show the countries that are big by area or big by population but not both. Show name, population and area.
#Australia has a big area but a small population, it should be included.  Indonesia has a big population but a small area, it should be included.  China has a big population and big area, it should be excluded.  United Kingdom has a small population and a small area, it should be excluded.
select name, population, area
from world
where (area > 3000000) xor
(population > 250000000);
#9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.  For South America show population in millions and GDP in billions both to 2 decimal places.
select name, round(population/1000000,2), round(gdp/1000000000,2)
from world
where continent = 'South America';
#10. Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.  Show per-capita GDP for the trillion dollar countries to the nearest $1000.
select name, round(gdp/population,-3)
from world
where gdp > 1000000000000;
#11. Greece has capital Athens. Each of the strings 'Greece', and 'Athens' has 6 characters. Show the name and capital where the name and the capital have the same number of characters.
select name, capital
from world
where length(name) = length(capital);
#12.  The capital of Sweden is Stockholm. Both words start with the letter 'S'.  Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
select name, capital
from world
where name <> capital
and left(name,1) = left(capital,1);
#13. Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.  Find the country that has all the vowels and no spaces in its name.  You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.  The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'.  Source:  https://stackoverflow.com/questions/42773102/sqlzoo-select-from-world-tutorial-13
select name
from world
where name like '%a%'
and name like '%e%'
and name like '%i%'
and name like '%o%'
and name like '%u%'
and name not like '% %';

#https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial
/*
nobel
yr	subject	winner
1960	Chemistry	Willard F. Libby
1960	Literature	Saint-John Perse
1960	Medicine	Sir Frank Macfarlane Burnet
1960	Medicine	Peter Madawar
*/
#1. Change the query shown so that it displays Nobel prizes for 1950.
select yr, subject, winner
from nobel
where yr = 1950;
#2. Show who won the 1962 prize for Literature.
select winner
from nobel
where yr = 1962
and subject = 'Literature';
#3. Show the year and subject that won 'Albert Einstein' his prize.
select yr, subject
from nobel
where winner = 'Albert Einstein';
#4. Give the name of the 'Peace' winners since the year 2000, including 2000.
select winner
from nobel
where subject = 'Peace'
and yr >= 2000;
#5. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
select *
from nobel
where subject = 'Literature'
and yr between 1980 and 1989;
#6. Show all details of the presidential winners: Theodore Roosevelt, Woodrow Wilson, Jimmy Carter, Barack Obama
select *
from nobel
where winner in ('Theodore Roosevelt','Woodrow Wilson','Jimmy Carter','Barack Obama');
#7. Show the winners with first name John.
select winner
from nobel
where winner like 'John%';
#8. Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
select yr, subject, winner
from nobel
where (subject = 'Physics' and yr = 1980)
and (subject = 'Chemistry' and yr = 1984);
select yr, subject, winner
from nobel
where (subject = 'Physics' and yr = 1980)
union
select yr, subject, winner
from nobel
where (subject = 'Chemistry' and yr = 1984);
#9. Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine.
select yr, subject, winner
from nobel
where yr = 1980
and subject not in ('Chemistry','Medicine');
#10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004).
select yr, subject, winner
from nobel
where (subject = 'Medicine' and yr < 1910)
and (subject = 'Literature' and yr >= 2004);
select yr, subject, winner
from nobel
where (subject = 'Medicine' and yr < 1910)
union
select yr, subject, winner
from nobel
where (subject = 'Literature' and yr >= 2004);
#11. Find all details of the prize won by PETER GRÜNBERG.  #RM:  source to add the two dots above the letter u https://en.wikipedia.org/wiki/%C3%9C#Keyboarding
select *
from nobel
where winner = 'Peter Grünberg';
#12. Find all details of the prize won by EUGENE O'NEILL.
select *
from nobel
where winner = 'Eugene O''Neill';
#13. Knights in order.  List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
select winner, yr, subject
from nobel
where winner like 'Sir%'
order by yr desc, winner;
#14. The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.  Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
select winner, subject
from nobel
where yr = 1984
order by case
	when subject in ('Chemistry','Physics') then 1 else 0 end asc,
subject, winner;

#https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial
#RM:  subquery, subqueries
/*
name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...
*/
select name
from world
where population > (
	select population
	from world
	where name = 'Russia');
#2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
select name
from world
where continent = 'Europe'
and gdp/population > (
	select gdp/population
	from world
	where name = 'United Kingdom');
#3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
select name, continent
from world
where continent in (
	select continent
	from world
	where name in ('Argentina','Australia'))
order by name;
#4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
select name, population
from world
where population > (
	select population
	from world
	where name = 'Canada')
and population < (
	select population
	from world
	where name = 'Poland');
#5. Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.  Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.  Decimal places Percent symbol %.
/*
name	Percentage Po..
Albania	3%
Andorra	0%
Austria	11%
Belarus	12%
Belgium	14%
Bosnia and Herzegovina	5%
Bulgaria	9%
*/
select name, round(population/(select population from world where name = 'Germany')*100) || '%' as "Percentage Poplation Germany"
from world
where continent = 'Europe';
/*
We can use the word ALL to allow >= or > or < or <= to act over a list. For example, you can find the largest country in the world, by population with this query:
select name
from world
where population >= all (
	select population
	from world
	where population > 0);
You need the condition population > 0 in the sub-query as some countries have null for population.
*/
#6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values).
select name
from world
where gdp > all (
	select gdp
	from world
	where continent = 'Europe'
	and gdp is not null);
/*
We can refer to values in the outer select within the inner select. We name the tables [with different alias to] tell the difference between the inner and outer versions.  It's known as a correlated or synchronized sub-query.

A correlated subquery works like a nested loop: the subquery only has access to rows related to a single record at a time in the outer query. The technique relies on table aliases to identify two different uses of the same table, one in the outer query and the other in the subquery.

One way to interpret the line in the where clause that references the two table is ". . . where the correlated values are the same".  The SQL below asks "select the country . . . where the population is greater than or equal to the population of all countries where the continent is the same."
select continent, name, population
from world x
where population >= all (
	select population
	from world y
	where y.continent = x.continent
	and population > 0);

RM:  subquery finds the where answers for the primary query; e.g. find the highest area for the primary query.  Find the first countries alphabetically from each continent.  Link the tables using alias for which subquery has the where primaryqueryalias.columnreference = subqueryalias.columnreference.
*/
#7. Find the largest country (by area) in each continent, show the continent, the name and the area:
/*
continent	name	area
Africa	Algeria	2381741
Oceania	Australia	7692024
South America	Brazil	8515767
North America	Canada	9984670
Asia	China	9596961
Caribbean	Cuba	109884
Europe	Kazakhstan	2724900
Eurasia	Russia	17125242
*/
select continent, name, area
from world w1
where area = (
	select max(area)
	from world w2
	where w1.continent = w2.continent
	group by continent);
#8. List each continent and the name of the country that comes first alphabetically.
select min(name)
from world;  #RM:  find the first country alphabetically
/*
continent	name
Africa	Algeria
Asia	Afghanistan
Caribbean	Antigua and Barbuda
Eurasia	Armenia
Europe	Albania
North America	Belize
Oceania	Australia
South America	Argentina
*/
select continent, name
from world w1
where name in (
	select min(name)
	from world w2
	where w1.continent = w2.continent
	group by continent);
#9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
/*
name	continent	population
Antigua and Barbuda	Caribbean	86295
Australia	Oceania	23545500
Bahamas	Caribbean	351461
Barbados	Caribbean	285000
Cuba	Caribbean	11167325
Dominica	Caribbean	71293
Dominican Republic	Caribbean	9445281
Fiji	Oceania	858038
Grenada	Caribbean	103328
Haiti	Caribbean	10413211
Jamaica	Caribbean	2717991
Kiribati	Oceania	106461
Marshall Islands	Oceania	56086
Micronesia, Federated States of	Oceania	101351
Nauru	Oceania	9945
New Zealand	Oceania	4538520
Palau	Oceania	20901
Papua New Guinea	Oceania	7398500
Saint Lucia	Caribbean	180000
Samoa	Oceania	187820
Solomon Islands	Oceania	581344
Tonga	Oceania	103036
Trinidad and Tobago	Caribbean	1328019
Tuvalu	Oceania	11323
Vanuatu	Oceania	264652
*/
select name, continent, population
from world
where population <= 25000000
and continent not in ('Europe','North America','South America','Asia','Africa','Eurasia');  #RM:  I don't understand the question.  Results returned are correct.
#Source: https://stackoverflow.com/questions/28929307/sql-combined-select-statement
select name, continent, population 
from world w
where not exists (
	select *
	from world nx
	where nx.continent = w.continent
	and nx.population > 25000000);
select name, continent, population
from world x
where 25000000 >= all (
	select population
	from world y
	where x.continent = y.continent
	and population > 0);
#10.  Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
#Source: https://stackoverflow.com/questions/28763696/sql-query-for-finding-countries-in-the-world-with-3-times-bigger-population-than
/*
name	continent
Australia	Oceania
Brazil	South America
Russia	Eurasia
*/
select w.name, w.continent 
from world w
where w.population > (
	select 3 * max(w2.population) 
	from world w2
	where w2.continent = w.continent
	and w2.name <> w.name);

#https://sqlzoo.net/wiki/SUM_and_COUNT
#This tutorial is about aggregate functions such as COUNT, SUM and AVG. An aggregate function takes many values and delivers just one value. For example the function SUM would aggregate the values 2, 4 and 5 to deliver the single value 11.
/*
name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
*/
#1.  Show the total population of the world.
select sum(population)
from world;
#2.  List all the continents - just once each.
select distinct continent
from world;
#3.  Give the total GDP of Africa.
select sum(gdp)
from world
where continent = 'Africa';
#4.  How many countries have an area of at least 1000000.
select count(name)
from world
where area >= 1000000;
#5.  What is the total population of ('Estonia', 'Latvia', 'Lithuania').
select sum(population)
from world
where name in ('Estonia', 'Latvia', 'Lithuania');
#6.  For each continent show the continent and number of countries.
select continent, count(name)
from world
group by continent;
#7.  For each continent show the continent and number of countries with populations of at least 10 million.
select continent, count(name)
from world
where population > 10000000
group by continent;
#8.  List the continents that have a total population of at least 100 million.
select continent
from world
group by continent
having sum(population)>=100000000;

#https://sqlzoo.net/wiki/The_JOIN_operation
/*
The tables contain all matches and goals from UEFA EURO 2012 Football Championship in Poland and Ukraine.
game
id	mdate	stadium	team1	team2
1001	8 June 2012	National Stadium, Warsaw	POL	GRE
1002	8 June 2012	Stadion Miejski (Wroclaw)	RUS	CZE
1003	12 June 2012	Stadion Miejski (Wroclaw)	GRE	CZE
1004	12 June 2012	National Stadium, Warsaw	POL	RUS
...

goal
matchid	teamid	player	gtime
1001	POL	Robert Lewandowski	17
1001	GRE	Dimitris Salpingidis	51
1002	RUS	Alan Dzagoev	15
1002	RUS	Roman Pavlyuchenko	82
...

eteam
id	teamname	coach
POL	Poland	Franciszek Smuda
RUS	Russia	Dick Advocaat
CZE	Czech Republic	Michal Bilek
GRE	Greece	Fernando Santos
...
*/
#1.  Show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
select matchid, player
from goal
where teamid = 'GER';
#2.  The column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.  Show id, stadium, team1, team2 for just game 1012.
select id, stadium, team1, team2
from game
where id = 1012;
/*
select *
from game join goal
on id=matchid;
The from clause says to merge data from the goal table [and] from the game table. The on says how to figure out which rows in game go with which rows in goal [which is] the matchid from goal must match the id from game. (If we wanted to be more clear/specific we could say on (game.id=goal.matchid)).
*/
#3.  Show the player, teamid, stadium and mdate for every German goal.
select player, teamid, stadium, mdate
from goal join game
on goal.matchid = game.id
where teamid = 'GER';
#4.  Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'.
select team1, team2, player
from game join goal
on goal.matchid = game.id
where player like 'Mario%';
#5.  Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10.
select player, teamid, coach, gtime
from goal join eteam
on goal.teamid = eteam.id
where goal.gtime < 10;
#6.  List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
select mdate, teamname
from game join eteam
where game.team1 = eteam.id
and coach = 'Fernando Santos';
#7.  List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'.
select player
from goal join game
on goal.matchid = game.id
where stadium = 'National Stadium, Warsaw';
#8.  Show the name of all players who scored a goal against Germany.
select distinct player
from goal join game
on goal.matchid = game.id
where (team1 = 'GER' or team2 = 'GER')
and teamid != 'GER';
#9.  Show teamname and the total number of goals scored.
select teamname, count(teamid)
from goal join eteam
on goal.teamid = eteam.id
group by teamname;
#10.  Show the stadium and the number of goals scored in each stadium.
select stadium, count(matchid)
from goal join game
on goal.matchid = game.id
group by stadium;
#11.  For every match involving 'POL', show the matchid, date and the number of goals scored.
select id, mdate, count(matchid)
from goal join game
on goal.matchid = game.id
where (team1 = 'POL' or team2 = 'POL')
group by id, mdate;
#12.  For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'.
select id, mdate, count(matchid)
from goal join game
on goal.matchid = game.id
where (team1 = 'GER' or team2 = 'GER')
and goal.teamid = 'GER'
group by id, mdate;
#13.  List every match with the goals scored by each team as shown. This will use "case when" which has not been explained in any previous exercises.
/*
mdate team1 score1  team2 score2
1 July 2012 ESP 4 ITA 0
10 June 2012  ESP 1 ITA 1
10 June 2012  IRL 1 CRO 3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/
#RM:  if-then, if then, if statement, if then statement.  Sum case, group by case
#Source:  https://stackoverflow.com/questions/25837329/solution-to-13-of-sql-join-in-sqlzoo
select mdate, team1, sum(case when teamid = team1 then 1 else 0 end) as score1, 
team2, sum(case when teamid = team2 then 1 else 0 end) as score2
from game left join goal
on game.id = goal.matchid
group by mdate, team1, team2
order by mdate, matchid, team1, team2;

#https://sqlzoo.net/wiki/More_JOIN_operations
/*
movie database columns: id	title	yr	director	budget	gross 
actor database columns: id	name 
casting database columns: movieid	actorid	ord
movieid	actorid	ord
10001	4	1
10001	5	2
10001	6	3
10001	7	4
10001	8	5
10001	9	6
*/
#1.  List the films where the yr is 1962 [Show id, title]
select id, title
from movie
where yr = 1962;
#2.  Give year of 'Citizen Kane'.
select yr
from movie
where title = 'Citizen Kane';
#3.  List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
select id, title, yr
from movie
where title like '%Star Trek%'
order by yr;
#4.  What id number does the actor 'Glenn Close' have?
select id
from actor
where name = 'Glenn Close';
#5.  What is the id of the film 'Casablanca'.
select id
from movie
where title = 'Casablanca';
#6.  Obtain the cast list for 'Casablanca'.
select name
from actor join casting
on actor.id = casting.actorid
where casting.movieid = (
	select id
	from movie
	where title = 'Casablanca');
#7.  Obtain the cast list for the film 'Alien'.
select name
from actor join casting
on actor.id = casting.actorid
where casting.movieid = (
	select id
	from movie
	where title = 'Alien');
#8.  List the films in which 'Harrison Ford' has appeared.
select title
from movie join casting
on movie.id = casting.movieid
where actorid = (
	select id
	from actor
	where name = 'Harrison Ford');
#9.  List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role].
select title
from movie join casting
on movie.id = casting.movieid
where actorid = (
	select id
	from actor
	where name = 'Harrison Ford')
and casting.ord != 1;
#10.  List the films together with the leading star for all 1962 films.  [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role].
select movie.title, actor.name
from movie join casting
on movie.id = casting.movieid
join actor
on actor.id = casting.actorid
where movie.yr = 1962
and casting.ord = 1;
#11.  Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
select yr, count(id)
from movie join casting
on movie.id = casting.movieid
where actorid = (
	select id
	from actor
	where name = 'Rock Hudson')
group by yr
having count(id) > 2;
#12.  List the film title and the leading actor for all of the films 'Julie Andrews' played in.
select title, name
from movie join casting
on movie.id = casting.movieid
join actor
on actor.id = casting.actorid
where movie.id in (
	select movieid
	from casting
	where actorid = (
		select id
		from actor
		where name = 'Julie Andrews'))
and casting.ord = 1;
#13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.  #RM:  I added count(movieid) column for reference.
select name, count(movieid)
from actor join casting
on actor.id = casting.actorid
where casting.ord = 1
group by name
having count(movieid) >= 30
order by name;
#14.  List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
select title, count(actorid)
from movie join casting
on movie.id = casting.movieid
where movie.yr = 1978
group by title
order by count(actorid) desc, title;
#15.  List all the people who have worked with 'Art Garfunkel'.
select actor.name
from actor join casting
on actor.id = casting.actorid
where casting.movieid in (
	select movieid
	from casting
	where actorid = (
		select id
		from actor
		where name = 'Art Garfunkel'))
and actor.name not in ('Art Garfunkel');