#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/union/sql-union.php

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
#1. Write a query to display all salesmen and customer located in London.  
#RM:  mismatch data types between salesman table and customer table.  Must include column names.
select *
from salesman
union
select *
from customer
where city = 'London';  #error message because mismatched columns
select s.salesman_id, s.name, s.city
from salesman s
union
select c.customer_id, c.cust_name, c.city
from customer c
where c.city = 'London';  #error message from website.
#RM:  mismatch data types between salesman table and customer table.  Must include column names.  Also, from the official solution, I needed paranthesis.
select s.salesman_id, s.name, s.city
from salesman s
where s.city = 'London'
union
(select c.customer_id, c.cust_name, c.city
from customer c
where c.city = 'London');

#2. Write a query to display distinct salesman and their cities.
#official solution  RM:  I don't understand.  Now I do, distinct salesman_id and cities from salesman table and customer table
select salesman_id, city
from customer
union
(select salesman_id, city
from salesman);

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
#3. Write a query to display all the salesmen and customer involved in this inventory management system.
select salesman_id, customer_id
from orders
union
(select salesman_id, customer_id
from customer);

#4. Write a query to make a report of which salesman produce the largest and smallest orders on each date.
#official solution
select a.salesman_id, name, ord_no, "highest on", ord_date
from salesman a, orders b
where a.salesman_id = b.salesman_id
and b.purch_amt = (
	select max(purch_amt)
	from orders c
	where c.ord_date = b.ord_date)
union
(select a.salesman_id, name, ord_no, "lowest on", ord_date
from salesman a, orders b
where a.salesman_id = b.salesman_id
and b.purch_amt =
	(select min (purch_amt)
	from orders c
	where c.ord_date = b.ord_date));

#5. Write a query to make a report of which salesman produce the largest and smallest orders on each date and arranged the orders number in smallest to the largest number.
select s.salesman_id, s.name, o1.ord_no, 'Highest Number', o1.ord_date
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
	select max(o2.purch_amt)
	from orders o2
	where o2.ord_date=o1.ord_date)
union
(select s.salesman_id, s.name, o1.ord_no, 'Lowest Number', o1.ord_date
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
	select min(o2.purch_amt)
	from orders o2
	where o2.ord_date=o1.ord_date))
order by ord_no;

#6. Write a query to list all the salesmen, and indicate those who do not have customers in their cities, as well as whose who do.
select s.name, s.city as "Sales City", c.city as "Customer City", 'Customers In City'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city = c.city
union
(select s.name, s.city as "Sales City", c.city as "Customer City", 'Customers Not In City'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city <> c.city);

#7. Write a query to that appends strings to the selected fields, indicating whether or not a specified salesman was matched to a customer in his city.
select s.salesman_id, s.name, s.city as "Salesman City", c.city as "Customer City", 'Match'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city = c.city
union
(select s.salesman_id, s.name, s.city as "Salesman City", c.city as "Customer City", 'No Match'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city <> c.city;

#8. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words "High Rating", while the others will have the words "Low Rating".
select cust_name, city, grade, (case when grade >=200 then 'High Rating' else 'Low Rating' end) as "Unknown Rating"
from customer;
#official solution
select cust_name, city, grade, 'High Rating'
from customer
where grade >=200
union
(select cust_name, city, grade, 'Low Rating'
from customer
where grade <200);

#9. Write a command that produces the name and number of each salesman and each customer with more than one current order. Put the results in alphabetical order.
#official solution
select customer_id, cust_name
from customer a
where 1<
	(select count (*)
	   from orders b
	   where a.customer_id = b.customer_id)
union
(select salesman_id, name
from salesman a
where 1 <
	(select count (*)
	 from orders b
	 where  a.salesman_id = b.salesman_id))
order by 2;