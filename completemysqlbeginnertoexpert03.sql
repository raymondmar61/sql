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