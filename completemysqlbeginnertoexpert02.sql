/* Complete MySQL Beginner to Expert [en6YPAgc6WM] */
/* Second file */
show databases;
use bookshop;
select count(*)
from books; #return 19
select count(title)
from books; #return 19
select count(distinct authorfname) as "Unique count first name authors"
from books; #return 12
select count(distinct authorfname, authorlname) as "Unique count author full name"
from books; #return 12
select count(*)
from books
where title like '%the%'; #return 6
select authorlname, count(*) as "Count rows by author's last name"
from books
group by authorlname;
/*
# authorlname	Count rows by author's last name
Lahiri	2
Gaiman	3
Eggers	3
Chabon	1
Smith	1
Carver	2
DeLillo	1
Steinbeck	1
Foster Wallace	2
Harris	2
Saunders	1
*/
select authorlname, count(title) as "Count titles by author's last name"
from books
group by authorlname;
/*
# authorlname	Count titles by author's last name
Lahiri	2
Gaiman	3
Eggers	3
Chabon	1
Smith	1
Carver	2
DeLillo	1
Steinbeck	1
Foster Wallace	2
Harris	2
Saunders	1
*/
select authorfname, authorlname, count(*) as "Correct count rows by author's first name and author's last name"
from books
group by authorfname, authorlname;
/*
# authorfname	authorlname	Correct count rows by author's first name and author's last name
Jhumpa	Lahiri	2
Neil	Gaiman	3
Dave	Eggers	3
Michael	Chabon	1
Patti	Smith	1
Raymond	Carver	2
Don	DeLillo	1
John	Steinbeck	1
David	Foster Wallace	2
Dan	Harris	1
Freida	Harris	1
George	Saunders	1
*/
#Concat function
select concat('In ',releaseyear,' ',count(*),' book(s) was released') as "Merge functions"
from books
group by releaseyear
order by releaseyear;
/*
# Merge functions
In 1945 1 book(s) was released
In 1981 1 book(s) was released
In 1985 1 book(s) was released
In 1989 1 book(s) was released
In 1996 1 book(s) was released
In 2000 1 book(s) was released
In 2001 3 book(s) was released
In 2003 2 book(s) was released
In 2004 1 book(s) was released
In 2005 1 book(s) was released
In 2010 1 book(s) was released
In 2012 1 book(s) was released
In 2013 1 book(s) was released
In 2014 1 book(s) was released
In 2016 1 book(s) was released
In 2017 1 book(s) was released
*/
select min(releaseyear) as "Earliest book year"
from books; #return 1945
select max(pages) as "Largest number of pages"
from books; #return 634
select title as "Preview subquery book largest number of pages"
from books
where pages = (
    select max(pages)
    from books); #return 'The Amazing Adventures of Kavalier & Clay'
#or
select title as "Order by limit 1 return first row"
from books
order by pages desc limit 1; #return 'The Amazing Adventures of Kavalier & Clay'
select min(releaseyear), authorfname, authorlname as "Find year first book release by author incorrect"
from books
group by releaseyear, authorfname, authorlname
order by releaseyear;
select authorfname, authorlname, min(releaseyear) as "Find year first book release by author correct"
from books
group by authorfname, authorlname
order by authorlname;
/*
# authorfname	authorlname	Find year first book release by author correct
Raymond	Carver	1981
Michael	Chabon	2000
Don	DeLillo	1985
Dave	Eggers	2001
David	Foster Wallace	2004
Neil	Gaiman	2001
Dan	Harris	2014
Freida	Harris	2001
Jhumpa	Lahiri	1996
George	Saunders	2017
Patti	Smith	2010
John	Steinbeck	1945
*/
select concat(authorfname,' ',authorlname) as "Combine columns", max(pages) as "Longest number of pages by author"
from books
group by authorfname, authorlname
order by 2 desc;
/*
# Combine columns	Longest number of pages by author
Michael Chabon	634
Raymond Carver	526
Dave Eggers	504
Neil Gaiman	465
Freida Harris	428
George Saunders	367
David Foster Wallace	343
Don DeLillo	320
Patti Smith	304
Jhumpa Lahiri	291
Dan Harris	256
John Steinbeck	181
*/
select sum(pages)
from books; #print 6623
select authorfname, authorlname, sum(pages)
from books
group by authorlname, authorfname;
/*
# authorfname	authorlname	sum(pages)
Jhumpa	Lahiri	489
Neil	Gaiman	977
Dave	Eggers	1293
Michael	Chabon	634
Patti	Smith	304
Raymond	Carver	702
Don	DeLillo	320
John	Steinbeck	181
David	Foster Wallace	672
Dan	Harris	256
Freida	Harris	428
George	Saunders	367
*/
select avg(pages)
from books; #return 348.5789
select releaseyear, avg(stockquantity)
from books
group by releaseyear
order by releaseyear;
/*
# releaseyear	avg(stockquantity)
1945	95.0000
1981	23.0000
1985	49.0000
1989	12.0000
1996	97.0000
2000	68.0000
2001	134.3333
2003	66.0000
2004	172.0000
2005	92.0000
2010	55.0000
2012	154.0000
2013	26.0000
2014	29.0000
2016	43.0000
2017	1000.0000
*/
select count(*) as "Count number of books"
from books; #return 19
select releaseyear, count(releaseyear) as "Count number of books by year"
from books
group by releaseyear;
/*
# releaseyear	Count number of books by year
2003	2
2016	1
2001	3
1996	1
2012	1
2013	1
2000	1
2010	1
1981	1
1989	1
1985	1
1945	1
2004	1
2005	1
2014	1
2017	1
*/
select sum(stockquantity) as "Total number of books in stock"
from books; #print 2450
select authorfname, authorlname, avg(releaseyear) as "Average year by author"
from books
group by authorfname, authorlname;
/*
# authorfname	authorlname	Average year by author
Jhumpa	Lahiri	1999.5000
Neil	Gaiman	2006.6667
Dave	Eggers	2008.6667
Michael	Chabon	2000.0000
Patti	Smith	2010.0000
Raymond	Carver	1985.0000
Don	DeLillo	1985.0000
John	Steinbeck	1945.0000
David	Foster Wallace	2004.5000
Dan	Harris	2014.0000
Freida	Harris	2001.0000
George	Saunders	2017.0000
*/
select concat(authorfname, ' ', authorlname) as "Author wrote longest book"
from books
where pages = (
    select max(pages)
    from books); #return 'Michael Chabon'
#or
select concat(authorfname, ' ', authorlname) as "Author wrote longest book"
from books
order by pages desc limit 1; #return 'Michael Chabon'
select releaseyear, count(releaseyear), avg(pages)
from books
group by releaseyear
order by releaseyear;
/*
# releaseyear	count(releaseyear)	avg(pages)
1945	1	181.0000
1981	1	176.0000
1985	1	320.0000
1989	1	526.0000
1996	1	198.0000
2000	1	634.0000
2001	3	443.3333
2003	2	249.5000
2004	1	329.0000
2005	1	343.0000
2010	1	304.0000
2012	1	352.0000
2013	1	504.0000
2014	1	256.0000
2016	1	304.0000
2017	1	367.0000
*/
/* Data Types
CHAR is fixed length between 0 and 255; for example, CHAR(3) stores three characters or three string length.  0 is blank.  If there are empty characters, CHAR adds spaces to get up to the number CHAR assigned by creator.  User enters more than the CHAR length SQL trunicates the entry.  CHAR good examples state abbreviations, yes Y or no N, and sex male M or female F.  CHAR is faster than VARCHAR.  VARCHAR also trunicates when user enters more than the VARCHAR length.  Use VARCHAR when in doubt.
DECIMAL(total number of digits left and right of decimal place, number of digits to the right of decimal place)  DECIMAL(5,2) means five total digits with two digits on the right side of the decimal 123.45.  DECIMAL rounds up 298.9999 returns 299.00 and 1.9999 rounds up to 2.00.  DECIMAL(5,2) max is 999.99 when a number 7987654 is inputted. 
DATE stores a date with no time.  Format is 'yyyy-mm-dd' such as '2022-04-25' which is April 25, 2022.  TIME stores a time with no date.  Format is 'hh:mm:ss' such as '21:15:37' which is 9:15pm and 37 seconds.  DATETIME stores a date and a time together.  Format is 'yyyy-mm-dd hh:mm:ss' such as '2022-04-25 21:15:37' which is April 25, 2022 9:15pm and 37 seconds.
*/
create table people(name varchar(100), birthdate date, birthtime time, birthdatetime datetime); #RM:  I didn't activate a databse creating people table
insert into people (name, birthdate, birthtime, birthdatetime) values ('Padma','1983-11-11','10:07:35','1983-11-11 10:07:35');
insert into people (name, birthdate, birthtime, birthdatetime) values ('Larry','1943-12-25','04:10:42','1943-12-25 04:10:42');
insert into people (name, birthdate, birthtime, birthdatetime) values ('EdwardElric','2004-05-30','23:50:17','2004-05-30 23:50:17');
select *
from people;
/*
# name	birthdate	birthtime	birthdatetime
Padma	1983-11-11	10:07:35	1983-11-11 10:07:35
Larry	1943-12-25	04:10:42	1943-12-25 04:10:42
EdwardElric	2004-05-30	23:50:17	2004-05-30 23:50:17
*/
show databases; #people table didn't show up in Database column results
select curdate() as "return current date"; #print 2023-02-11
select curtime() as "return current time in 24 hour format"; #print 01:04:39
select now() as "return current datetime"; #print 2023-02-11 01:05:12
insert into people (name, birthdate, birthtime, birthdatetime) values ('AlElric',curdate(),curtime(),now());
select *
from people;
/*
# name	birthdate	birthtime	birthdatetime
Padma	1983-11-11	10:07:35	1983-11-11 10:07:35
Larry	1943-12-25	04:10:42	1943-12-25 04:10:42
EdwardElric	2004-05-30	23:50:17	2004-05-30 23:50:17
AlElric	2023-02-11	01:07:18	2023-02-11 01:07:18
*/
select name, birthdate, day(birthdate) as "day number", dayname(birthdate) as "day name", dayofweek(birthdate) as "day name number Sun 1 Sat 7", dayofyear(birthdate) as "day number of the year", monthname(birthdate) as "month name full"
from people;
/*
# name	birthdate	day number	day name	day name number Sun 1 Sat 7	day number of the year	month name full
Padma	1983-11-11	11	Friday	6	315	November
Larry	1943-12-25	25	Saturday	7	359	December
EdwardElric	2004-05-30	30	Sunday	1	151	May
AlElric	2023-02-11	11	Saturday	7	42	February
*/
select name, birthtime, hour(birthtime) as "hour in 24 hour clock"
from people;
select name, birthdate, concat(monthname(birthdate),' ',day(birthdate),', ',year(birthdate)) as "MMM dd, yyyy"
from people;
/*
'Padma', '1983-11-11', 'November 11, 1983', 'November 11 1983'
'Larry', '1943-12-25', 'December 25, 1943', 'December 25 1943'
'EdwardElric', '2004-05-30', 'May 30, 2004', 'May 30 2004'
'AlElric', '2023-02-11', 'February 11, 2023', 'February 11 2023'
*/
/*
# name	birthdate	MMM dd, yyyy
Padma	1983-11-11	November 11, 1983
Larry	1943-12-25	December 25, 1943
EdwardElric	2004-05-30	May 30, 2004
AlElric	2023-02-11	February 11, 2023
*/
select name, birthdate, concat(monthname(birthdate),' ',day(birthdate),', ',year(birthdate)) as "MMM dd, yyyy", date_format(birthdate,'%M %d, %Y') as "MMM dd, yyyy", date_format(birthdate,'%m/%d/%Y') as "mm/dd/yyyy"
from people;
/*
# name	birthdate	MMM dd, yyyy	MMM dd, yyyy	mm/dd/yyyy
Padma	1983-11-11	November 11, 1983	November 11, 1983	11/11/1983
Larry	1943-12-25	December 25, 1943	December 25, 1943	12/25/1943
EdwardElric	2004-05-30	May 30, 2004	May 30, 2004	05/30/2004
AlElric	2023-02-11	February 11, 2023	February 11, 2023	02/11/2023
*/
select name, birthtime, date_format(birthtime,'%h:%m')
from people;
/*
# name	birthtime	date_format(birthtime,'%h:%m')
Padma	10:07:35	10:02
Larry	04:10:42	04:02
EdwardElric	23:50:17	11:02
AlElric	01:07:18	01:02
*/
select datediff('2007-12-31 23:59:59','2007-12-30') as "difference in days"; #print 1
select datediff(now(),'2023-01-22') as "difference today Feb 11, 2023 and Jan 22, 2023"; #print 20
select name, birthdate, datediff(now(),birthdate) as "Number of days old"
from people;
/*
# name	birthdate	Number of days old
Padma	1983-11-11	14337
Larry	1943-12-25	28903
EdwardElric	2004-05-30	6831
AlElric	2023-02-11	0
*/
select birthdatetime, date_add(birthdatetime, interval 1 month) as "add one month to birthdatetime" /* date_add(date, interval expression unit) date add.  date_sub() date subtraction exists */
from people;
/*
# birthdatetime	add one month to birthdatetime
1983-11-11 10:07:35	1983-12-11 10:07:35
1943-12-25 04:10:42	1944-01-25 04:10:42
2004-05-30 23:50:17	2004-06-30 23:50:17
2023-02-11 01:07:18	2023-03-11 01:07:18
*/
select birthdatetime, birthdatetime + interval 15 month + interval 10 hour as "15 months and 10 hours later"
from people;
/*
# birthdatetime	15 months and 10 hours later
1983-11-11 10:07:35	1985-02-11 20:07:35
1943-12-25 04:10:42	1945-03-25 14:10:42
2004-05-30 23:50:17	2005-08-31 09:50:17
2023-02-11 01:07:18	2024-05-11 11:07:18
*/
/* Datetime year range is from year 1000 to year 9999.  Timestamp year range is from 1970 to 2038.  Timestamp uses less memory. */
create table comments
(content varchar(100), createdate timestamp default now());
insert into comments (content) values("lol what a funny article");
insert into comments (content) values("I found an octopus");
insert into comments (content) values("A third comment minutes later");
select *
from comments;
/*
# content	createdate
lol what a funny article	2023-02-11 15:49:00
I found an octopus	2023-02-11 15:49:40
A third comment minutes later	2023-02-11 15:56:10
*/
alter table comments
add column changeddate timestamp default now() on update current_timestamp;  #change in a row SQL updates the column changeddate.  Default is timestamp when column changeddate created.  Date update.  on update current_timestamp or on update now() is the same.
select *
from comments;
/*
# content	createdate	changeddate
lol what a funny article	2023-02-11 15:49:00	2023-02-11 15:59:00
I found an octopus	2023-02-11 15:49:40	2023-02-11 15:59:00
A third comment minutes later	2023-02-11 15:56:10	2023-02-11 15:59:00
*/
set sql_safe_updates = 0;
update comments
set content = 'lol what a funny article Update at 4:07pm'
where content = 'lol what a funny article';
select *
from comments; #RM:  needed to set sql_safe_updates = 0;  Update change date is 4:09pm.
/*
# content	createdate	changeddate
lol what a funny article Update at 4:07pm	2023-02-11 15:49:00	2023-02-11 16:09:00
I found an octopus	2023-02-11 15:49:40	2023-02-11 15:59:00
A third comment minutes later	2023-02-11 15:56:10	2023-02-11 15:59:00
*/
#What's a good use case for char [instead of varchar]?  A column with a fixed length.  State abbreviation, male or female.
create table inventorydontexecute
(itemname varchar(100), price decimal(8,2), quantity int); #price is less than 1,000,000.  999,999.99.  Eight digits decimal with two on the right of the decimal.
select now() as "display current date and time", curtime() as "display current time", curdate() as "display current date only", dayofweek(now()) as "display day number Sun 1 Sat 7", date_format(now(),'%w') as "display day number Sun 0 Sat 6", dayname(now()) as "display day name", date_format(now(),'%W') as "display day name again";
/*
# display current date and time	display current time	display current date only	display day number Sun 1 Sat 7	display day number Sun 0 Sat 6	display day name	display day name again
2023-02-11 16:29:18	16:29:18	2023-02-11	7	6	Saturday	Saturday
*/
select date_format(now(),'%m/%d/%Y') as "Current date mm/dd/yyyy"; #print 02/11/2023
select date_format(curdate(),'%m/%d/%Y') as "Current date mm/dd/yyyy"; #print 02/11/2023
select date_format(now(),'%M %D at %l:%i') as "like January 2nd at 3:15"; #print February 11th at 4:35
create table tweetstabledontexecute
(content varchar(180), username varchar(25), datecreated timestamp default now());
select title as "Not equal year !="
from books
where releaseyear != 2017;
select title as "Wild card % not like"
from books
where title not like 'W%';
select 99>1; #print 1 which is True
select 99<1; #print 0 which is False
select 'a'>'b'; #print 0.  MySQL b is greater than a.  Other programming languages a is greater than b.
select 'b'>'a'; #print 1
select 'h' < 'p'; #print 1
select 'A'>'a'; #print 0
select 'A'='a'; #print 1.  It seems upper case and lower case are irrelevant.  String comparison case insensitive.
select 'Q' <= 'q'; #print 1
select title, authorlname, releaseyear as "And can use &&"
from books
where authorlname = 'Eggers' && releaseyear > 2010 and title like '%novel%';
/*
# title	authorlname	And can use &&
A Hologram for the King: A Novel	Eggers	2012
*/
select title, authorlname, releaseyear as "Or can use ||"
from books
where authorlname = 'Eggers' || releaseyear > 2010 or title like '%novel%';
/*
# title	authorlname	Or can use ||
Norse Mythology	Gaiman	2016
A Hologram for the King: A Novel	Eggers	2012
The Circle	Eggers	2013
A Heartbreaking Work of Staggering Genius	Eggers	2001
10% Happier	Harris	2014
Lincoln In The Bardo	Saunders	2017
*/
select 'a' = 5 || 3000 > 2000; #print 1.  True or False is True.
select title, releaseyear as "between is inclusive"
from books
where releaseyear between 2004 and 2015;
select title, releaseyear as "not between is inclusive"
from books
where releaseyear not between 2004 and 2015
order by releaseyear;
/*
# title	not between is inclusive
Cannery Row	1945
What We Talk About When We Talk About Love:  Stories	1981
White Noise	1985
Where I'm Calling From: Selected Stories	1989
Interpreter of Maladies	1996
The Amazing Adventures of Kavalier & Clay	2000
American Gods	2001
A Heartbreaking Work of Staggering Genius	2001
fake_book	2001
The Namesake	2003
Coraline	2003
Norse Mythology	2016
Lincoln In The Bardo	2017
*/
/*https://www.tutorialspoint.com/how-to-get-the-datatype-of-mysql-table-columns*/
select column_name, data_type
from information_schema.columns
where table_schema='bookshop' and table_name='books';
/*
# COLUMN_NAME	DATA_TYPE
authorfname	varchar
authorlname	varchar
bookid	int
pages	int
releaseyear	int
stockquantity	int
title	varchar
*/
desc books;
/*
# Field	Type	Null	Key	Default	Extra
bookid	int	NO	PRI		auto_increment
title	varchar(100)	YES			
authorfname	varchar(100)	YES			
authorlname	varchar(100)	YES			
releaseyear	int	YES			
stockquantity	int	YES			
pages	int	YES			
*/
describe books title; #RM:  desc or describe is valid.
/*
# Field	Type	Null	Key	Default	Extra
title	varchar(100)	YES			
*/
desc books 'author%';
/*
# Field	Type	Null	Key	Default	Extra
authorfname	varchar(100)	YES			
authorlname	varchar(100)	YES			
*/
select('2017-05-22') as "May 22, 2017"; #print 2017-05-22
desc select('2017-05-22');
/*
# id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE										No tables used
*/
select cast('2017-05-22' as datetime); #print '2017-05-22 00:00:00'
desc select cast('2017-05-22' as datetime);
/*
# id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE										No tables used
*/
select *
from people;
/*
# name	birthdate	birthtime	birthdatetime
Padma	1983-11-11	10:07:35	1983-11-11 10:07:35
Larry	1943-12-25	04:10:42	1943-12-25 04:10:42
EdwardElric	2004-05-30	23:50:17	2004-05-30 23:50:17
AlElric	2023-02-11	01:07:18	2023-02-11 01:07:18
*/
desc people;
/*
# Field	Type	Null	Key	Default	Extra
name	varchar(100)	YES			
birthdate	date	YES			
birthtime	time	YES			
birthdatetime	datetime	YES			
*/
select *
from people
where birthdatetime between '1980-01-01' and '1999-12-31';
/*
# name	birthdate	birthtime	birthdatetime
Padma	1983-11-11	10:07:35	1983-11-11 10:07:35
*/
select name, birthdatetime as "No need to convert to datetype using case because birthdatetime is datetime data type"
from people
where birthdatetime between cast('1980-01-01' as datetype) and cast('1999-12-31' as datetype);
/*
Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'datetype) and cast('1999-12-31' as datetype)' at line 3	0.000095 sec
*/
select title, releaseyear as "for loop modulo in where clause odd years"
from books
where releaseyear >= 2000
and releaseyear % 2 != 0
order by releaseyear;
select title, releaseyear as "for loop modulo in where clause odd years"
from books
where releaseyear >= 2000
and releaseyear % 2 = 0
order by releaseyear;
select title, releaseyear as "Case if else based on year", case when releaseyear>=2000 then 'Modern Lit' else '20th Century Lit' end as columnnamegenre
from books;
/*
# title	Case if else based on year	columnnamegenre
The Namesake	2003	Modern Lit
Norse Mythology	2016	Modern Lit
American Gods	2001	Modern Lit
Interpreter of Maladies	1996	20th Century Lit
A Hologram for the King: A Novel	2012	Modern Lit
The Circle	2013	Modern Lit
The Amazing Adventures of Kavalier & Clay	2000	Modern Lit
Just Kids	2010	Modern Lit
A Heartbreaking Work of Staggering Genius	2001	Modern Lit
Coraline	2003	Modern Lit
What We Talk About When We Talk About Love:  Stories	1981	20th Century Lit
Where I'm Calling From: Selected Stories	1989	20th Century Lit
White Noise	1985	20th Century Lit
Cannery Row	1945	20th Century Lit
Oblivion: Stories	2004	Modern Lit
Consider the Lobster	2005	Modern Lit
10% Happier	2014	Modern Lit
fake_book	2001	Modern Lit
Lincoln In The Bardo	2017	Modern Lit
*/
select title, stockquantity, case when stockquantity <50 then '*' when stockquantity <100 then '**' else '***' end as columnnamestock
from books;
/*
# title	stockquantity	columnnamestock
The Namesake	32	*
Norse Mythology	43	*
American Gods	12	*
Interpreter of Maladies	97	**
A Hologram for the King: A Novel	154	***
The Circle	26	*
The Amazing Adventures of Kavalier & Clay	68	**
Just Kids	55	**
A Heartbreaking Work of Staggering Genius	104	***
Coraline	100	***
What We Talk About When We Talk About Love:  Stories	23	*
Where I'm Calling From: Selected Stories	12	*
White Noise	49	*
Cannery Row	95	**
Oblivion: Stories	172	***
Consider the Lobster	92	**
10% Happier	29	*
fake_book	287	***
Lincoln In The Bardo	1000	***
*/
select authorlname, count(*)
from books
group by authorlname
order by authorlname;
/*
# authorlname	count(*)
Carver	2
Chabon	1
DeLillo	1
Eggers	3
Foster Wallace	2
Gaiman	3
Harris	2
Lahiri	2
Saunders	1
Smith	1
Steinbeck	1
*/
select title, authorlname as "Substring wildcard author's last name first character begins with C or S"
from books
where substr(authorlname,1,1) in ('c','s');
/*
# title	Substring wildcard author's last name first character begins with C or S
The Amazing Adventures of Kavalier & Clay	Chabon
Just Kids	Smith
What We Talk About When We Talk About Love:  Stories	Carver
Where I'm Calling From: Selected Stories	Carver
Cannery Row	Steinbeck
Lincoln In The Bardo	Saunders
*/
select title, authorlname, case when title like '%stories%' then 'Short Stories' when title in ('Just Kids','A Heartbreaking Work of Staggering Genius') then 'Memoir' else 'Novel' end as columnnamegenre
from books;
/*
# title	authorlname	columnnamegenre
The Namesake	Lahiri	Novel
Norse Mythology	Gaiman	Novel
American Gods	Gaiman	Novel
Interpreter of Maladies	Lahiri	Novel
A Hologram for the King: A Novel	Eggers	Novel
The Circle	Eggers	Novel
The Amazing Adventures of Kavalier & Clay	Chabon	Novel
Just Kids	Smith	Memoir
A Heartbreaking Work of Staggering Genius	Eggers	Memoir
Coraline	Gaiman	Novel
What We Talk About When We Talk About Love:  Stories	Carver	Short Stories
Where I'm Calling From: Selected Stories	Carver	Short Stories
White Noise	DeLillo	Novel
Cannery Row	Steinbeck	Novel
Oblivion: Stories	Foster Wallace	Short Stories
Consider the Lobster	Foster Wallace	Novel
10% Happier	Harris	Novel
fake_book	Harris	Novel
Lincoln In The Bardo	Saunders	Novel
*/
#RM:  If I listened to the video for five more seconds, then I didn't need the title column in the sql code below.  The solution included author's first name and author's last name.
select authorfname, authorlname, case when count(authorlname) = 1 then concat(count(authorlname),' book') else concat(count(authorlname),' books') end as columnnameCOUNT
from books
group by authorlname, authorfname
order by authorlname;
/*
# authorfname	authorlname	columnnameCOUNT
Raymond	Carver	2 books
Michael	Chabon	1 book
Don	DeLillo	1 book
Dave	Eggers	3 books
David	Foster Wallace	2 books
Neil	Gaiman	3 books
Dan	Harris	1 book
Freida	Harris	1 book
Jhumpa	Lahiri	2 books
George	Saunders	1 book
Patti	Smith	1 book
John	Steinbeck	1 book
*/