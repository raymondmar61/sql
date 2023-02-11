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