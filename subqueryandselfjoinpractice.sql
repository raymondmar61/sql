#Watch Oracle SQL videos last #58 Self Join, #64 Using Subqueries, #65 Single Row Subqueries, #66 Multiple Row Subqueries, #67 Multiple Column Subqueries

#Self Join
#YouTube Videos:  Database Design 50 - Self Join [720p], Self-joins YouTube Channel Andy Wicks [720p], 14 of 15 SQL Basics with Oracle - Self-joins and multiple joins between the same 2 tables [360p], Microsoft Access 2016 Queries_ Self Join Query [720p]
/*
A table and joining the same table with itself.  Create a copy of the table.  Join the original table and the copy table together.
A table is linked to itself.  The same table is used two times.  Each copy of the table becomes a view.  Use self-join to compare items in a single table; e.g. two titles are the same for different books.
Another reason is a subset of a table; e.g. a list of employees by department, a list in a family tree with the same family name.  You can use the subset as an input to another query.
Self join for two joins between two tables.
*/
/*
User Table
userid, firstname, lastname, email, referredby
5	Edward	Elric	eelric@yahoo.com
6	Roy	Mustang	rmustang@hotmail.com	5
7	Elsa	Snow	esnow@g.net	6
9	Logan	Bracket	l77@rain.ca	7
*/
/*
useroriginal.firstname useroriginal.lastname useroriginal.email referral.email
Edward	Elric	eelric@yahoo.com
Roy	Mustang	rmustang@hotmail.com	eelric@yahoo.com
Elsa	Snow	esnow@g.net	rmustang@hotmail.com
Logan	Bracket	l77@rain.ca	esnow@g.net
*/
select useroriginal.firstname, useroriginal.lastname, useroriginal.email, referral.email
from user useroriginal join user referral
on useroriginal.referredby = referral.userid;  #RM:  referredby is the foreign key for userid in the same table user.  user referral is considered a different table even though same data as table user useroriginal.
select t1.titleid, t1.title
from booktable t1, booktable t2
where t1.title = t2.title
and t1.bookid <> t2.bookid;  #RM:  find books with the same title
/*
subordinate.employeeid subordinate.firstname subordinate.lastname supervisor.employeeid supervisor.firstname supervisor.lastname
1060	Wilma	Washington	1050	Carlo	Mora
1077	Carlo	Stevens	1050	Carlo	Mora
1062	Robert	Block	1050	Carlo	Mora
1061	Rory	Block	1062	Robert	Block
1063	Teresa	Roberts	1062	Robert	Block
*/
select subordinate.employeeid, subordinate.firstname, subordinate.lastname, supervisor.employeeid, supervisor.firstname, supervisor.lastname
from employee subordinate, employee supervisor
where subordinate.supervisorid = supervisor.employeeid;  #RM get a list of employees and their supervisors
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
select evaluationid, evaluatee.studentid, evaluatee.firstname, evaluatee.lastname, evaluator.studentid, evaluator.firstname, evaluator.lastname
from students evaluatee, students evaluator, evaluations
where evaluatee.studentid = evaluations.evaluateeid
and evaluator.studentid = evaluations.evaluatorid
order by evaluateeid;  #RM:  Names of evaluatee and evaluator.  Use the students table twice.  One for each relationship in evaluations table.  Two joins between two tables.


#Watch Oracle SQL videos last #58 Self Join, #64 Using Subqueries, #65 Single Row Subqueries, #66 Multiple Row Subqueries, #67 Multiple Column Subqueries