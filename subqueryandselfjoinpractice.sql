#Self Join
#YouTube Videos:  Database Design 50 - Self Join [720p], Self-joins YouTube Channel Andy Wicks [720p], 14 of 15 SQL Basics with Oracle - Self-joins and multiple joins between the same 2 tables [360p], Microsoft Access 2016 Queries_ Self Join Query [720p], Oracle SQL videos 58 Self Join
/*
A table and joining the same table with itself.  Create a copy of the table.  Join the original table and the copy table together.
A table is linked to itself.  The same table is used two times.  Each copy of the table becomes a view.  Use self-join to compare items in a single table; e.g. two titles are the same for different books.
Another reason is a subset of a table; e.g. a list of employees by department, a list in a family tree with the same family name.  You can use the subset as an input to another query.
Self join for two joins between two tables.
Self join is join table with same table again.  Join two tables and two tables are the same tables called self join.
Joining a table with itself is named as self join.
*/
/*
User Table
userid, firstname, lastname, email, referredby
5	Edward	Elric	eelric@yahoo.com
6	Roy	Mustang	rmustang@hotmail.com	5
7	Elsa	Snow	esnow@g.net	6
9	Logan	Bracket	l77@rain.ca	7
*/
select useroriginal.firstname, useroriginal.lastname, useroriginal.email, referral.email
from user useroriginal join user referral
on useroriginal.referredby = referral.userid;  #RM:  referredby is the foreign key for userid in the same table user.  user referral is considered a different table even though same data as table user useroriginal.
/*
useroriginal.firstname useroriginal.lastname useroriginal.email referral.email
Edward	Elric	eelric@yahoo.com
Roy	Mustang	rmustang@hotmail.com	eelric@yahoo.com
Elsa	Snow	esnow@g.net	rmustang@hotmail.com
Logan	Bracket	l77@rain.ca	esnow@g.net
*/
select t1.titleid, t1.title
from booktable t1, booktable t2
where t1.title = t2.title
and t1.bookid <> t2.bookid;  #RM:  find books with the same title
select subordinate.employeeid, subordinate.firstname, subordinate.lastname, supervisor.employeeid, supervisor.firstname, supervisor.lastname
from employee subordinate, employee supervisor
where subordinate.supervisorid = supervisor.employeeid;  #RM get a list of employees and their supervisors
/*
subordinate.employeeid subordinate.firstname subordinate.lastname supervisor.employeeid supervisor.firstname supervisor.lastname
1060	Wilma	Washington	1050	Carlo	Mora
1077	Carlo	Stevens	1050	Carlo	Mora
1062	Robert	Block	1050	Carlo	Mora
1061	Rory	Block	1062	Robert	Block
1063	Teresa	Roberts	1062	Robert	Block
*/
select evaluationid, evaluatee.studentid, evaluatee.firstname, evaluatee.lastname, evaluator.studentid, evaluator.firstname, evaluator.lastname
from students evaluatee, students evaluator, evaluations
where evaluatee.studentid = evaluations.evaluateeid
and evaluator.studentid = evaluations.evaluatorid
order by evaluateeid;  #RM:  Names of evaluatee and evaluator.  Use the students table twice.  One for each relationship in evaluations table.  Two joins between two tables.
/*
evaluationid evaluatee.studentid evaluatee.firstname evaluatee.lastname evaluator.studentid evaluator.firstname evaluator.lastname
220	Akry	Adrienne	Kry	Yantipov	Yuri	Antipov
216	Bkry	Barbara	Kry	Lkomp	Lance	Komp
226	Bkry	Barbara	Kry	Sdavis	Sara	Davis
230	Bkry	Barbara	Kry	Aagassi	Andrew	Agassi
205	Bsmith	Bob		Smith	Calvarez	Carlos	Alvarez
224	Bsmith	Bob 	Smith	Doliver	Don	Oliver
215	Calvarez	Carlos	Alvarez	Bsmith	Bob 	Smith
212 Calvarez	Carlos	Alvarez	Bsmith	Bob 	Smith
210	Cmoya	Carlos	Moya	Pchen	Peter	Chen
200	Cmoya	Carlos	Moya	Thashemi	Tario	Hashemi
*/
#[ORACLE DATABASE TUTORIALS] LECTURE 58 SELF JOIN - YouTube [720p]
select worker.employeeid, worker.firstname, worker.lastname, worker.manager_id, manager.firstname, manager.lastname
from employees worker join employees manager
on worker.manager_id = manager.employeeid;
/*
employeeid firstname, lastname, manager_id employeeid_1 firstname_1, lastname_1
200	Michael	Hartstein	100	Steven King
149	Eleni Zlotkey	100	Steven King
...
102	Lex	De Haan	100	Steven King
101	Neena	Kochhar	100	Steven King
205	Shelly	Higgins	101	Neena	Kochhar
204	Hermann	Baer	101	Neena	Kochhar
...
103	Alexander	Hunold	102	Lex	De Haan
107	Diana	Lorentz	103	Alexander	Hunold
106	Valli	Pataballa	103	Alexander	Hunold
105	David	Austin	103	Alexander	Hunold
...
109	Daniel	Faviet	108	Nancy	Greenberg
*/

#Subquery
#YouTube Videos:  Oracle SQL Subqueries [720p], SQL_ Update using correlated subquery [720p], Single Row Subqueries (Introduction to Oracle SQL) [720p], Multi Row Subqueries (Introduction to Oracle SQL) [720p], SQL JOINS vs Subqueries [720p], SQL with Microsoft Access 2016 Lesson 7 - Subqueries [720p], SQL Subqueries Introduction [720p], SQL Correlated Subqueries [720p], Subqueries in SQL [720p], Nested Queries _ SQL _ Tutorial 18 [720p]
/*
Four types of subqueries.  Three of unproblematic.  Correlated and uncorrelated.  Correlated means the inner and outer tables join.  Uncorrelated means the inner and outer tables don't join.  Single row and multi row. Uncorrelated single row returns a single row once and give it to the outer query no performance problem such as average, min, or max and compare against the outer query.  Correlated single row need to execute once for every row in the outer query; e.g. 5,000 rows in outer query conduct an additional 5,000 queries in the subquery.  Uncorrelated multi row execute subquery once returning the data set to the external query such as an exists operator or a comparison operator.  Correlated multi row subquery runs once for each row in the outer query; e.g. 5,000 rows in the outer query and internal query returns 2,000 rows returning 10,000,000 rows to memory.
Subqueries are queries within other queries.  Two main types of subqueries single row and multi row.  Single row subquery returns one row; e.g. AVG returns a single row  Multi row subquery reteurns multiple rows; e.g.  all salaries > 100000 returns multiple rows.  Comparison operators are invalid for multiple values.  Multi row subqueries can use operators which can handle multiple values such as in, > any, < all.  in is the most common.
Subquery.  The answers from the subquery is used to get the answers from the outer query or primary query.  Multiple subqueries are valid.
Subqueries can be used to test for set membership in conjunction with the in operator and not in operator.
A nested query is a query with multiple select statements.
*/
/*
productid	productdesc	productname	quantityonhand	productlength	productwidth	suggestedprice
1	Strawberry Jam	Grandpa's Strawberry Jam	15	10	6	5.99
2	Strawberry Jelly	Grandpa's Strawberry Jelly	10	10	5	3.99
3	Blueberry Jam	Grandpa's Blueberry Jam	10	10	5	5.99
4	Blueberry Jelly	Grandpa's Blueberry Jelly	10	10	5	3.99
5	Shine	Grandma's Shine	20	10	10	24
*/
#Uncorrelated single row subquery
select product name, to_char(suggestedprice,'$9,999.99')
from products
where suggestedprice >= (
	select avg(suggestedprice) #average suggested price is 8.792
	from products);
/*
productname	to_char(suggestedprice,'$9,999.99')
Grandma's Shine	$24.00
*/
#Uncorrelated single row subquery in having clause
select a.firstname || ' ' || a.lastname, count(*)
from customers a inner join orders b using customerid
inner join orderlineitems c using orderid
group by a.firstname, a.lastname
having count(*) > (
	select avg(count(*))  #average count is 6
	from orders d inner join orderlineitems e using orderid
	group by customerid);
#Uncorrelated single row from clause has subquery which is an inline view
select a.firstname || ' ' || a.lastname, d.productname, count(*)
from customers a, orders b, orderlineitems c, (
	select productname, productid
	from products pr) d
where a.customerid = b.customerid
and b.orderid = c.orderid
and c.productid = d.productid
group by a.firstname, a.lastname, d.productname
order by a.lastname, a.firstname, d.productname;
#Uncorrelated single row from clause has subquery which is an inline view better no inline view
#Instructor said don't bother use inline view in real life.  He's seen it once from a student.
select a.firstname || ' ' || a.lastname, d.productname, count(*)
from customers a inner join orders b using (customerid)
inner join orderlineitems c using (orderid)
inner join products d using (productid)
group by a.firstname, a.lastname, d.productname
order by a.lastname, a.firstname, d.productname;
#Uncorrelated single row from clause has subquery which is an inline view no inline view my way I learned
select a.firstname || ' ' || a.lastname, d.productname, count(*)
from customers a inner join orders b
on a.customerid = b.customerid
inner join orderlineitems c
on b.orderid = c.orderid
inner join products d
on c.productid = d.productid
group by a.firstname, a.lastname, d.productname
order by a.lastname, a.firstname, d.productname;
#Uncorrelated multi row
select a.firstname || ' ' || a.lastname
from customers
where customerid in (
	select customerid
	from customeraddress
	group by customerid
	having count(*) > 1);  #instructor says any operator and all operator works the same way replacing in operator.  any ( and all (
#Correlated multi row.  The inner table and outer table are joined over b.employeeid = a.managerid.  The subquery is executed for each row returned by the outer query.
select a.firstname || ' ' || a.lastname
from employees a
where exists (
	select 1
	from employees b
	where b.employeeid = a.managerid);  #use the exists operator.  Other valid operators are in and not exists which should not be used per instructor because it executes all rows in the outer query.  Exists operator stops when it finds the row.  #RM:  Use self join.
select a.firstname || ' ' || a.lastname
from employees a, employees b
where a.managerid = b.employeeid;  #Self join correct?
#Single row subquery
select employeeid, firstname, lastname, salary
from employee
where salary > (
	select avg(salary) #average salary is 68212.12
	from employee);
#Multi row subquery
select employeeid, firstname, lastname, departmentid
from employee
where departmentid in (
	select departmentid
	from department
	where departmentname in ('Sales','Finance'));
#Multiple Subquery
select students.studentid, firstname, lastname
from students
where students.studentid in (
	select enrollment.studentid
	from enrollment
	where subjectid in (
		select subjectid
		from subjects
		where subjectteacher = 'Chan'));
#Correlated multi row subquery join query.  Return the contact name and the latest or most recent order date.  It's like customers joined with orders table twice.
select contactname, orderdate
from customers c join orders o
on c.customerid = o.customerid
where orderdate = (
	select max(orderdate)
	from orders oo
	where oo.customerid = c.customerid);
select name, capacity
from room
where name like 'CAS%'
and capacity = (
	select max(capacity)
	from room
	where name like 'CAS%');
#set membership
select name
from student
where id not in (
	select studentid
	from enrolled
	where coursename = 'CS 105');
#Get names of employees sold over 30,000 to a single client
select firstname, lastname
from employees
where employeeid in (
	select employeeid
	from workswith
	where totalsales > 30000);
#Find clients handled by the branch Michael Scott manages.  You know Scott's employeeid and managerid.
select clientname
from client
where branchid = (
	select branchid
	from branch
	where managerid = 102);

#Oracle SQL videos last #64 Using Subqueries, #65 Single Row Subqueries, #66 Multiple Row Subqueries, #67 Multiple Column Subqueries
#Subquery with another query or the inner query is executed first and the result of the inner subquery is used as the input for the outer query or the main query.  Two or more subqueries are valid.
#Subqueries can be used with SELECT, WHERE, HAVING, and FROM clauses.
#There are three types of subqueries:  single row, multiple row, and multiple column.
#Single row subqueries return one row from the inner query.  Use with single row comparison operators =, >, <, >=, <=, <>.  A single row subquery returns multiple rows generates error message.  A single row subquery returns null main query returns null.
#Multiple row subqueries return more than one row from the inner query.  Use with multiple row comparison operators in, any, all.  In operator is equal to any element in the list.  Any operator at least one of the elements should match; can be used with comparison operators =, >, <, >=, <=, <>.  < any means less than the maximum.  = any means equal to one of the elements or is the same as in operator.  > any means more than the minimum.  All operator all of the elements should match; can be used with comparison operators =, >, <, >=, <=, <>.   < all means less than the minimum.  = all means nothing if there are more than one records is useless; i.e. many rows returned from the inner query and the outer query doesn't equal all of the inner query.  > all means more than the maximum.  Multiple row subqueries can be used within FROM, WHERE, and HAVING clauses.  Not in SELECT clause.
#Multiple column subqueries return more than one column in one row.  Can be used with FROM, WHERE, and HAVING clauses.  Useful in writing more than one inner query in one inner query.  Can be used with IN operator.
#Find employees who earn more than Michael.  We know Michael's employeeid is 201.
select salary
from employees
where employeeid = 201;  #return 13000
select *
from employees
where salary > 13000;
#What if Michael's salary goes up to 15000?  Create a dynamic SQL query using subqueries.
select *
from employees
where salary > (
	select salary
	from employees
	where employeeid = 201);
#Find employees who work in same department as Michael's employeeid 201 and earns less than Michael's salary.  Single row multiple subquery multiple subqueries.
select *
from employees
where departmentid = (
	select departmentid
	from employees
	where employeeid = 201)
and salary < (
	select salary
	from employees
	where employeeid = 201);
#Find employeee worked in the company first.  Use Group BY group function minimum.  Single row subquery.
select min(hiredate)
from employees;  #return 01-01-13
select *
from employees
where hiredate = (
	select min(hiredate)
	from employees);
select firstname, lastname, departmentid, salary
from employees
where salary in (14000, 15000, 10000);
#find employees who earn lowest salaries in their departments.  Single row subquery.
select firstname, lastname, departmentid, salary
from employees
where salary in (
	select min(salary)
	from employees
	group by departmentid);
#Find employees who earn more than sales managers. sama or sales manager is jobid.  Multiple row subquery.
select salary
from employees
where jobid = 'sama';  #return one column, five rows, five salaries of sales managers
select firstname, lastname, departmentid, salary
from employees
where salary > any (
	select salary
	from employees
	where jobid = 'sama');
#Find employees who earn more than all sales managers. sama is jobid.  Multiple row subquery.
select salary
from employees
where jobid = 'sama';  #return one column, five rows, five salaries of sales managers
select firstname, lastname, departmentid, salary
from employees
where salary > all (
	select salary
	from employees
	where jobid = 'sama');
#Find employees who earn the minimum salary in his or her department.  Multiple column subquery.
select firstname, lastname, departmentid, salary
from employees
where departmentid, salary in (
	select departmentid, min(salary)
	from employees
	group by departmentid);