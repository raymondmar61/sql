#https://www.w3resource.com/sql/tutorials.php #RM: click column for SQL topic help
#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php

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

#1. Write a query to display all customers with a grade above 100.
select *
from customer
where grade > 100;

#2. Write a query statement to display all customers in New York who have a grade value above 100.
select *
from customer
where city = 'New York' and grade > 100;

#3. Write a SQL statement to display all customers, who are either belongs to the city New York or had a grade above 100.
select *
from customer
where city = 'New York' or grade > 100;

#4. Write a SQL statement to display all the customers, who are either belongs to the city New York or not had a grade above 100.
select *
from customer
where city = 'New York' or grade <= 100;

#5.Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
select *
from customer
where city != 'New York' or grade <= 100;
#also
select * 
from customer 
where not (city = 'New York' or grade > 100);

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
#6. Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is [5005] and below or those orders which purchase amount is 1000.00 and below.
select *
from orders
where (ord_date != '2012-09-10' and salesman_id > 5005) or purch_amt <= 1000;

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
#7.Write a SQL statement to display salesman_id, name, city and commission who gets the commission within the range more than 0.10% and less than 0.12%.
select *
from salesman
where commission > .10 and commission < .12;

#8. Write a SQL query to display all orders where purchase amount less than 200 or exclude those orders which order date is on or greater than 10th Feb,2012 and customer id is below 3009.
select *
from orders
where (purch_amt < 200 or ord_date < '2012-02-10') and customer_id < 3009;

#9. Write a SQL statement where i) order dates are anything but 2012-08-17, or customer id is not greater than 3005 ii) and purchase amount is not below 1000.
select *
from orders
where (ord_date != '2012-08-17' or customer_id <= 3005) and purch_amt >= 1000;

#10. Write a SQL query to display order number, purchase amount, achieved, the unachieved percentage for those order which exceeds the 50% of the target value of 6000.
#RM:  official solution
select ord_no, purch_amt, (100*purch_amt)/6000 as "Achieved %", (100*(6000-purch_amt)/6000) as "Unachieved %" 
from orders 
where (100*purch_amt)/6000>50;

/*
Sample table : emp_details
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
#11. Write a query in SQL to find the data of employees whose last name is Dosni or Mardy.
select *
from emp_details
where emp_lname = 'Dosni' or emp_lname = 'Mardy';

#12. Write a query in SQL to display all the data of employees that work in department 47 or department 63.
select *
from emp_details
where emp_dept in (47, 63);