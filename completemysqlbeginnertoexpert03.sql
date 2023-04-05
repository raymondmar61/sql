/* Complete MySQL Beginner to Expert [en6YPAgc6WM] */
/* Third file */
drop database customersnadorders;
create database customersandorders;
show databases;
use customersandorders;
create table customers(id int not null auto_increment primary key, firstname varchar(100), lastname varchar(100), email varchar(100));
desc customers;
insert into customers(firstname,  lastname, email)
values('Boy','George','george@gmail.com'),('George','Michael','gm@gmail.com'),('David','Bowie','david@gmail.com'),('Blue','Steele','blue@gmail.com'),('Bette','Davis','bette@aol.com');
select *
from customers;
/*
# id	firstname	lastname	email
1	Boy	George	george@gmail.com
2	George	Michael	gm@gmail.com
3	David	Bowie	david@gmail.com
4	Blue	Steele	blue@gmail.com
5	Bette	Davis	bette@aol.com
*/
drop table customers;
create table orders(id int not null auto_increment, orderdate date, amount decimal(8,2), customerid int, primary key (id), foreign key (customerid) references customers (id));
# Oracle SQL partially correct-->create table orders(id int not null auto_increment, orderdate date, amount decimal(8,2), customerid int foreign key (id) references customers, primary key (id));
desc orders;
/*
# Field	Type	Null	Key	Default	Extra
id	int	NO	PRI		auto_increment
orderdate	date	YES			
amount	decimal(8,2)	YES			
customerid	int	YES	MUL		
*/
insert into orders(orderdate, amount, customerid)
values ('2016-02-10',99.99,1),('2017-11-11',35.50,1),('2014-12-12',800.67,2),('2015-01-03',12.50,2),('1999-04-11',450.25,5);
select *
from orders;
/*
# id	orderdate	amount	customerid
1	2016-02-10	99.99	1
2	2017-11-11	35.50	1
3	2014-12-12	800.67	2
4	2015-01-03	12.50	2
5	1999-04-11	450.25	5
*/
drop table orders;
#insert into orders(orderdate, amount, customerid)
#values ('2016-06-06',33.67,98); #Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`customersandorders`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customers` (`id`))
#cross join or cartesian join.  Implicit join.
select *
from customers, orders;
/*
# id	firstname	lastname	email	id	orderdate	amount	customerid
5	Bette	Davis	bette@aol.com	1	2016-02-10	99.99	1
4	Blue	Steele	blue@gmail.com	1	2016-02-10	99.99	1
3	David	Bowie	david@gmail.com	1	2016-02-10	99.99	1
2	George	Michael	gm@gmail.com	1	2016-02-10	99.99	1
1	Boy	George	george@gmail.com	1	2016-02-10	99.99	1
5	Bette	Davis	bette@aol.com	2	2017-11-11	35.50	1
4	Blue	Steele	blue@gmail.com	2	2017-11-11	35.50	1
3	David	Bowie	david@gmail.com	2	2017-11-11	35.50	1
2	George	Michael	gm@gmail.com	2	2017-11-11	35.50	1
1	Boy	George	george@gmail.com	2	2017-11-11	35.50	1
5	Bette	Davis	bette@aol.com	3	2014-12-12	800.67	2
...
1	Boy	George	george@gmail.com	4	2015-01-03	12.50	2
5	Bette	Davis	bette@aol.com	5	1999-04-11	450.25	5
4	Blue	Steele	blue@gmail.com	5	1999-04-11	450.25	5
3	David	Bowie	david@gmail.com	5	1999-04-11	450.25	5
2	George	Michael	gm@gmail.com	5	1999-04-11	450.25	5
1	Boy	George	george@gmail.com	5	1999-04-11	450.25	5
*/
select *
from customers, orders
where customers.id=orders.customerid;
/*
# id	firstname	lastname	email	id	orderdate	amount	customerid
1	Boy	George	george@gmail.com	1	2016-02-10	99.99	1
1	Boy	George	george@gmail.com	2	2017-11-11	35.50	1
2	George	Michael	gm@gmail.com	3	2014-12-12	800.67	2
2	George	Michael	gm@gmail.com	4	2015-01-03	12.50	2
5	Bette	Davis	bette@aol.com	5	1999-04-11	450.25	5
*/
select firstname, lastname, orderdate, amount as "Implicit Inner Join"
from customers, orders
where customers.id=orders.customerid;
/*
# firstname	lastname	orderdate	Implicit Inner Join
Boy	George	2016-02-10	99.99
Boy	George	2017-11-11	35.50
George	Michael	2014-12-12	800.67
George	Michael	2015-01-03	12.50
Bette	Davis	1999-04-11	450.25
*/
select firstname, lastname, orderdate, amount as "Explicit Inner Join"
from customers join orders
on customers.id = orders.customerid;
/*
# firstname	lastname	orderdate	Explicit Inner Join
Boy	George	2016-02-10	99.99
Boy	George	2017-11-11	35.50
George	Michael	2014-12-12	800.67
George	Michael	2015-01-03	12.50
Bette	Davis	1999-04-11	450.25
*/
select firstname, lastname, sum(amount) as "Total amount per customer"
from customers join orders
on customers.id = orders.customerid
group by orders.customerid
order by 3 desc;
/*
# firstname	lastname	Total amount per customer
George	Michael	813.17
Bette	Davis	450.25
Boy	George	135.49
*/
select *
from customers left join orders
on customers.id = orders.customerid;
/*
# id	firstname	lastname	email	id	orderdate	amount	customerid
1	Boy	George	george@gmail.com	1	2016-02-10	99.99	1
1	Boy	George	george@gmail.com	2	2017-11-11	35.50	1
2	George	Michael	gm@gmail.com	3	2014-12-12	800.67	2
2	George	Michael	gm@gmail.com	4	2015-01-03	12.50	2
3	David	Bowie	david@gmail.com				
4	Blue	Steele	blue@gmail.com				
5	Bette	Davis	bette@aol.com	5	1999-04-11	450.25	5
*/
select firstname, lastname, orderdate, amount
from customers left join orders
on customers.id = orders.customerid;
/*
# firstname	lastname	orderdate	amount
Boy	George	2016-02-10	99.99
Boy	George	2017-11-11	35.50
George	Michael	2014-12-12	800.67
George	Michael	2015-01-03	12.50
David	Bowie		
Blue	Steele		
Bette	Davis	1999-04-11	450.25
*/
select firstname, lastname, ifnull(sum(amount),0) as "Sum all customer's amount include customers with no purchases if null then 0"
from customers left join orders
on customers.id = orders.customerid
group by customers.id;
/*
# firstname	lastname	Sum all customer's amount include customers with no purchases if null then 0
Boy	George	135.49
George	Michael	813.17
David	Bowie	0.00
Blue	Steele	0.00
Bette	Davis	450.25
*/
select *
from customers right join orders
on customers.id = orders.customerid;
/*
# id	firstname	lastname	email	id	orderdate	amount	customerid
1	Boy	George	george@gmail.com	1	2016-02-10	99.99	1
1	Boy	George	george@gmail.com	2	2017-11-11	35.50	1
2	George	Michael	gm@gmail.com	3	2014-12-12	800.67	2
2	George	Michael	gm@gmail.com	4	2015-01-03	12.50	2
5	Bette	Davis	bette@aol.com	5	1999-04-11	450.25	5
*/
create table students (id int not null auto_increment primary key, firstname varchar(20));
drop table students;
insert into students(firstname)
values ('Caleb'),('Samantha'),('Raj'),('Carlos'),('Lisa');
select *
from students;
/*
# id	firstname
1	Caleb
2	Samantha
3	Raj
4	Carlos
5	Lisa
*/
create table papers(studentid int, title varchar(50), grade int, foreign key (studentid) references students (id));
insert into papers(studentid, title, grade)
values (1,'My First Book Report',60),(1,'My Second Book Report',75),(2,'Russian Lit Through The Ages',94),(2,'De Montaigne And The Art Of The Essay',98),(4,'Borges And Magical Realism',89);
select *
from papers;
/*
# studentid	title	grade
1	My First Book Report	60
1	My Second Book Report	75
2	Russian Lit Through The Ages	94
2	De Montaigne And The Art Of The Essay	98
4	Borges And Magical Realism	89
*/
select students.firstname, papers.title, papers.grade
from students join papers
on students.id=papers.studentid
order by papers.grade desc;
/*
# firstname	title	grade
Samantha	De Montaigne And The Art Of The Essay	98
Samantha	Russian Lit Through The Ages	94
Carlos	Borges And Magical Realism	89
Caleb	My Second Book Report	75
Caleb	My First Book Report	60
*/
select students.firstname, papers.title, papers.grade
from students left join papers
on students.id=papers.studentid;
/*
# firstname	title	grade
Caleb	My First Book Report	60
Caleb	My Second Book Report	75
Samantha	Russian Lit Through The Ages	94
Samantha	De Montaigne And The Art Of The Essay	98
Raj		
Carlos	Borges And Magical Realism	89
Lisa		
*/
select students.firstname, papers.title, papers.grade
from students right join papers
on students.id=papers.studentid
order by firstname desc, grade desc;
/*
# firstname	title	grade
Samantha	De Montaigne And The Art Of The Essay	98
Samantha	Russian Lit Through The Ages	94
Carlos	Borges And Magical Realism	89
Caleb	My Second Book Report	75
Caleb	My First Book Report	60
*/
select students.firstname, ifnull(papers.title,'MISSING') as "title", ifnull(papers.grade,0) as "grade"
from students left join papers
on students.id=papers.studentid;
/*
# firstname	title	grade
Caleb	My First Book Report	60
Caleb	My Second Book Report	75
Samantha	Russian Lit Through The Ages	94
Samantha	De Montaigne And The Art Of The Essay	98
Raj	MISSING	0
Carlos	Borges And Magical Realism	89
Lisa	MISSING	0
*/
select students.firstname, ifnull(avg(grade),0) as "average"
from students left join papers
on students.id=papers.studentid
group by students.firstname
order by 2 desc;
/*
# firstname	average
Samantha	96.0000
Carlos	89.0000
Caleb	67.5000
Raj	0.0000
Lisa	0.0000
*/
select students.firstname, ifnull(avg(grade),0) as "average", case when avg(grade) >=75 then 'PASSING' when avg(grade) is null then 'add case when null to be explicit' else 'FAILING' end as "passing status"
from students left join papers
on students.id=papers.studentid
group by students.firstname
order by 2 desc;
/*
# firstname	average	passing status
Samantha	96.0000	PASSING
Carlos	89.0000	PASSING
Caleb	67.5000	FAILING
Raj	0.0000	add case when null to be explicit
Lisa	0.0000	add case when null to be explicit
*/
create database relationships;
show databases;
use relationships;
create table reviewers (id int auto_increment primary key, firstname varchar(100), lastname varchar(100));
create table series (id int auto_increment primary key, title varchar(100), releasedyear year(4), genre varchar(100));
drop table series;
#Copy code to insert data D:\SQL\mysql-bootcamp-master\relationships\tv-review-app
insert into series (title, releasedyear, genre) values ('Archer', 2009, 'Animation'), ('Arrested Development', 2003, 'Comedy'), ("Bob's Burgers", 2011, 'Animation'), ('Bojack Horseman', 2014, 'Animation'), ("Breaking Bad", 2008, 'Drama'), ('Curb Your Enthusiasm', 2000, 'Comedy'), ("Fargo", 2014, 'Drama'), ('Freaks and Geeks', 1999, 'Comedy'), ('General Hospital', 1963, 'Drama'), ('Halt and Catch Fire', 2014, 'Drama'), ('Malcolm In The Middle', 2000, 'Comedy'), ('Pushing Daisies', 2007, 'Comedy'), ('Seinfeld', 1989, 'Comedy'), ('Stranger Things', 2016, 'Drama');
insert into reviewers (firstname, lastname) values ('Thomas', 'Stoneman'), ('Wyatt', 'Skaggs'), ('Kimbra', 'Masters'), ('Domingo', 'Cortes'), ('Colt', 'Steele'), ('Pinkie', 'Petit'), ('Marlon', 'Crafford');
create table reviews (id int auto_increment primary key, rating decimal (2,1), seriesid int, reviewerid int, foreign key(seriesid) references series(id), foreign key(reviewerid) references reviewers(id)); #rating decimal (2,1) is from 0.0 to 9.9.  No 10.0.
insert into reviews(seriesid, reviewerid, rating) values (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9), (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9), (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0), (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5), (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9), (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1), (7,2,9.1),(7,5,9.7), (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3), (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5), (10,5,9.9), (13,3,8.0),(13,4,7.2), (14,2,8.5),(14,3,8.9),(14,4,8.9);
select s.title, reviews.rating
from series s join reviews
on s.id = reviews.seriesid
limit 10;
/*
# title	rating
Archer	8.0
Archer	7.5
Archer	8.5
Archer	7.7
Archer	8.9
Arrested Development	8.1
Arrested Development	6.0
Arrested Development	8.0
Arrested Development	8.4
Arrested Development	9.9
*/
select s.title, avg(reviews.rating)
from series s join reviews
on s.id = reviews.seriesid
group by s.title
order by avg(reviews.rating) asc;
/*
# title	avg(reviews.rating)
General Hospital	5.38000
Bob's Burgers	7.52000
Seinfeld	7.60000
Bojack Horseman	7.94000
Arrested Development	8.08000
Archer	8.12000
Curb Your Enthusiasm	8.12000
Freaks and Geeks	8.60000
Stranger Things	8.76667
Breaking Bad	9.36000
Fargo	9.40000
Halt and Catch Fire	9.90000
*/
select reviewers.firstname, reviewers.lastname, reviews.rating
from reviewers join reviews
on reviewers.id = reviews.reviewerid
limit 10;
/*
# firstname	lastname	rating
Thomas	Stoneman	8.0
Thomas	Stoneman	8.1
Thomas	Stoneman	7.0
Thomas	Stoneman	7.5
Thomas	Stoneman	9.5
Wyatt	Skaggs	7.5
Wyatt	Skaggs	7.6
Wyatt	Skaggs	9.3
Wyatt	Skaggs	6.5
Wyatt	Skaggs	8.4
*/
#Find series with no reviews
select *
from series left join reviews
on series.id = reviews.seriesid;
/*
# id	title	releasedyear	genre	id	rating	seriesid	reviewerid
9	General Hospital	1963	Drama	37	5.5	9	2
9	General Hospital	1963	Drama	38	6.8	9	3
9	General Hospital	1963	Drama	39	5.8	9	4
9	General Hospital	1963	Drama	40	4.3	9	6
9	General Hospital	1963	Drama	41	4.5	9	5
10	Halt and Catch Fire	2014	Drama	42	9.9	10	5
11	Malcolm In The Middle	2000	Comedy				
12	Pushing Daisies	2007	Comedy				
13	Seinfeld	1989	Comedy	43	8.0	13	3
13	Seinfeld	1989	Comedy	44	7.2	13	4
*/
select *
from series left join reviews
on series.id = reviews.seriesid
where reviews.rating is null;
#where reviews.seriesid is null and reviews.reviewerid is null; #also works
/*
# id	title	releasedyear	genre	id	rating	seriesid	reviewerid
11	Malcolm In The Middle	2000	Comedy				
12	Pushing Daisies	2007	Comedy				
*/
select series.genre, round(avg(reviews.rating),2)
from series join reviews
on series.id = reviews.seriesid
group by series.genre
order by 1 asc;
/*
# genre	avg(reviews.rating)
Animation	7.86
Comedy	8.16
Drama	8.04
*/
select reviewers.firstname, reviewers.lastname, count(reviews.reviewerid) as count, ifnull(min(reviews.rating),0) as min, ifnull(max(reviews.rating),0) as max, round(ifnull(avg(reviews.rating),0),2) as avg, if(count(rating)>1,'Active','Inactive') as 'Status If', case when count(reviews.reviewerid) >=10 then 'Power User' when count(reviews.reviewerid) >1 then 'Active' else 'Inactive' end as 'Status Case'
from reviewers left join reviews
on reviewers.id = reviews.reviewerid
group by 1, 2;
/*
# firstname	lastname	count	min	max	avg	Status If	Status Case
Thomas	Stoneman	5	7.0	9.5	8.02	Active	Active
Wyatt	Skaggs	9	5.5	9.3	7.80	Active	Active
Kimbra	Masters	9	6.8	9.0	7.99	Active	Active
Domingo	Cortes	10	5.8	9.1	7.83	Active	Power User
Colt	Steele	10	4.5	9.9	8.77	Active	Power User
Pinkie	Petit	4	4.3	8.8	7.25	Active	Active
Marlon	Crafford	0	0.0	0.0	0.00	Inactive	Inactive
*/
select series.title, reviews.rating, concat(reviewers.firstname, " ",reviewers.lastname) as reviewer
from series left join reviews
on series.id = reviews.seriesid
left join reviewers
on reviewers.id = reviews.reviewerid
limit 15;
/*
# title	rating	reviewer
Archer	8.0	Thomas Stoneman
Archer	7.5	Wyatt Skaggs
Archer	8.5	Kimbra Masters
Archer	7.7	Domingo Cortes
Archer	8.9	Colt Steele
Arrested Development	8.1	Thomas Stoneman
Arrested Development	6.0	Domingo Cortes
Arrested Development	8.0	Kimbra Masters
Arrested Development	8.4	Pinkie Petit
Arrested Development	9.9	Colt Steele
Bob's Burgers	7.0	Thomas Stoneman
Bob's Burgers	7.5	Pinkie Petit
Bob's Burgers	8.0	Domingo Cortes
Bob's Burgers	7.1	Kimbra Masters
Bob's Burgers	8.0	Colt Steele
*/
#official solution
select series.title, reviews.rating, concat(reviewers.firstname, " ",reviewers.lastname) as reviewer
from reviewers join reviews
on reviewers.id = reviews.reviewerid
join series
on series.id = reviews.seriesid
limit 15;
/*
# title	rating	reviewer
Archer	8.0	Thomas Stoneman
Arrested Development	8.1	Thomas Stoneman
Bob's Burgers	7.0	Thomas Stoneman
Bojack Horseman	7.5	Thomas Stoneman
Breaking Bad	9.5	Thomas Stoneman
Archer	7.5	Wyatt Skaggs
Bojack Horseman	7.6	Wyatt Skaggs
Breaking Bad	9.3	Wyatt Skaggs
Curb Your Enthusiasm	6.5	Wyatt Skaggs
Curb Your Enthusiasm	8.4	Wyatt Skaggs
Fargo	9.1	Wyatt Skaggs
Freaks and Geeks	7.8	Wyatt Skaggs
General Hospital	5.5	Wyatt Skaggs
Stranger Things	8.5	Wyatt Skaggs
Archer	8.5	Kimbra Masters
*/