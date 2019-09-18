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
	id integer auto_increment primary key
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