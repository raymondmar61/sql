#https://www.w3resource.com/sql/tutorials.php #RM: click column for SQL topic help
#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php

/*
Sample table : salesman
salesman_id  name        city        commission
-----------  ----------  ----------  ----------
5001         James Hoog  New York    0.15
5002         Nail Knite  Paris       0.13
5005         Pit Alex    London      0.11
5006         Mc Lyon     Paris       0.14
5003         Lauson Hen              0.12
5007         Paul Adam   Rome        0.13
*/
#1. Write a SQL statement to find those salesmen with all information who come from the city either Paris or Rome.
select *
from salesman
where city = 'Paris' or city = 'Rome';

#2. Write a query to filter those salesmen with all information who comes from any of the cities Paris and Rome.  RM:  #1 and #2 are the same.
select *
from salesman
where city in ('Paris','Rome');

#3. Write a query to produce a list of salesman_id, name, city and commission of each salesman who live in cities other than Paris and Rome.
select *
from salesman
where city not in ('Paris','Rome');
#also from official solution
select * 
from salesman 
where not city in('Paris','Rome');

/*
Sample table: customer
customer_id  cust_name     city        grade       salesman_id
-----------  ------------  ----------  ----------  -----------
3002         Nick Rimando  New York    100         5001
3005         Graham Zusi   California  200         5002
3001         Brad Guzan    London                  5005
3004         Fabian Johns  Paris       300         5006
3007         Brad Davis    New York    200         5001
3009         Geoff Camero  Berlin      100         5003
3008         Julian Green  London      300         5002
3003         Jozy Altidor  Moscow      200         5007
*/
#4. Write a query to sort out those customers with all information whose ID value is within any of 3007, 3008 and 3009.
select *
from customer
where customer_id in (3007, 3008, 3009);

#5. Write a SQL statement to find those salesmen with all information who gets the commission within a range of 0.12 and 0.14.
select *
from salesman
where commission between 0.12 and 0.14;

/*
Sample table : orders
ord_no      purch_amt   ord_date    customer_id  salesman_id
----------  ----------  ----------  -----------  -----------
70001       150.5       2012-10-05  3005         5002
70009       270.65      2012-09-10  3001         5005
70002       65.26       2012-10-05  3002         5001
70004       110.5       2012-08-17  3009         5003
70007       948.5       2012-09-10  3005         5002
70005       2400.6      2012-07-27  3007         5001
70008       5760        2012-09-10  3002         5001
70010       1983.43     2012-10-10  3004         5006
70003       2480.4      2012-10-10  3009         5003
70012       250.45      2012-06-27  3008         5002
70011       75.29       2012-08-17  3003         5007
70013       3045.6      2012-04-25  3002         5001
*/
#6. Write a query to filter all those orders with all information which purchase amount value is within the range 500 and 4000 except those orders of purchase amount value 948.50 and 1983.43.
select *
from orders
where (purch_amt between 500 and 4000) and (purch_amt not in (948.50,1983.43));

#7. Write a SQL statement to find those salesmen with all other information and name started with any letter within 'A' and 'K'.  RM:  ...where name between 'A' and 'J'; The BETWEEN operator can be used in a WHERE clause to filter the result set within a certain range. The values can be numbers, text or dates.  Returns movies beginning with letters between A inclusive and J exclusive.
select *
from salesman
where name between 'A%' and 'K%';

#8. Write a SQL statement to find those salesmen with all other information and name started with other than any latter within 'A' and 'L'.
select *
from salesman
where name not between 'A%' and 'M%';

#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from customer
where cust_name like 'B%';
#comparsion using like and not using like for between sql statement
select *
from customer
where cust_name between 'A%' and 'C%';

#10. Write a SQL statement to find all those customers with all information whose names are ending with the letter 'n'.
select *
from customer
where cust_name like '%n';

#11. Write a SQL statement to find those salesmen with all information whose name containing the 1st character is 'N' and the 4th character is 'l' and rests may be any character.
select *
from salesman
where name like 'N__l%';

/*
Sample table: testtable
col1
--------------------------
A001/DJ-402\44_/100/2015
A001_\DJ-402\44_/100/2015
A001_DJ-402-2014-2015
A002_DJ-401-2014-2015
A001/DJ_401
A001/DJ_402\44
A001/DJ_402\44\2015
A001/DJ-402%45\2015/200
A001/DJ_402\45\2015%100
A001/DJ_402%45\2015/300
A001/DJ-402\44
*/
#12. Write a SQL statement to find those rows from the table testtable which contain the escape character underscore ( _ ) in its column 'col1'.
select *
from testtable
where col1 like '%/_%';

#13. Write a SQL statement to find those rows from the table testtable which does not contain the character underscore ( _ ) in its column 'col1'.
select *
from testtable
where col1 not like '%/_%';

#14. Write a SQL statement to find those rows from the table testtable which contain the escape character ( / ) in its column 'col1'.
select *
from testtable
where col1 like '%/%';

#15. Write a SQL statement to find those rows from the table testtable which does not contain the escape character ( / ) in its column 'col1'.
select *
from testtable
where col1 not like '%/%';

#16. Write a SQL statement to find those rows from the table testtable which contain the string ( _/ ) in its column 'col1'.
select *
from testtable
where col1 like '%/_//%' escape '/';

#17. Write a SQL statement to find those rows from the table testtable which does not contain the string ( _/ ) in its column 'col1'.
select *
from testtable
where col1 not like '%/_//%' escape '/';

#18. Write a SQL statement to find those rows from the table testtable which contain the character ( % ) in its column 'col1'.
select *
from testtable
where col1 like '%/%%' escape '/';
#RM:  Use the backslash for Oracle https://docs.oracle.com/cd/B28359_01/text.111/b28304/cqspcl.htm#CCREF0400

#19. Write a SQL statement to find those rows from the table testtable which does not contain the character ( % ) in its column 'col1'.
select *
from testtable
where col1 not like '%/%%' escape '/';
#RM:  Use the backslash for Oracle https://docs.oracle.com/cd/B28359_01/text.111/b28304/cqspcl.htm#CCREF0400

#20. Write a SQL statement to find that customer with all information who does not get any grade except NULL.
select *
from customer
where grade is null;

#21. Write a SQL statement to find that customer with all information who gets a grade except NULL value.
select *
from customer
where grade is not null;

/*
Sample table: emp_details
 EMP_IDNO EMP_FNAME       EMP_LNAME         EMP_DEPT
--------- --------------- --------------- ----------
   127323 Michale         Robbin                  57
   526689 Carlos          Snares                  63
   843795 Enric           Dosio                   57
   328717 Jhon            Snares                  63
   444527 Joseph          Dosni                   47
   659831 Zanifer         Emily                   47
   847674 Kuleswar        Sitaraman               57
   748681 Henrey          Gabriel                 47
   555935 Alex            Manuel                  57
   539569 George          Mardy                   27
   733843 Mario           Saule                   63
   631548 Alan            Snappy                  27
   839139 Maria           Foster                  57
*/
#22. Write a query in SQL to display all the data of employees whose last name begins with an 'D'.
select *
from emp_details
where emp_lname like 'D%';