#RM:  open w3basicssecondpracticedatabases.sql for database tables
#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/subqueries/index.php
#RM:  Website last updated 11/27/19.  I practice with the updated website.

#1. Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
select *
from orders
where salesman_id = (
	select salesman_id
	from salesman
	where name = 'Paul Adam');

#2. Write a query to display all the orders for the salesman who belongs to the city London.
select *
from orders
where salesman_id in (
	select salesman_id
	from salesman
	where city = 'London');

#3. Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007.  #RM:  find the orders from the salesmen who worked with customer_id 3007.
select *
from orders
where salesman_id in (
	select salesman_id
	from orders
	where customer_id = 3007);

#4. Write a query to display all the orders which values are greater than the average order value for 10th October 2012.
select *
from orders
where purch_amt > (
	select avg(purch_amt)
	from orders
	where ord_date = '2012-10-10');

#5. Write a query to find all orders attributed to a salesman in New york.
select *
from orders
where salesman_id in (
	select salesman_id
	from salesman
	where city = 'New York');

#6. Write a query to display the commission of all the salesmen servicing customers in Paris.
select commission
from salesman
where salesman_id in (
	select salesman_id
	from customers
	where city = 'Paris');

#7. Write a query to display all the customers whose id is 2001 bellow the salesman ID of Mc Lyon.  #RM:  dumb question
#official solution
select *
from customer
where customer_id = (
	select salesman_id -2001
	from salesman
	where name = 'Mc Lyon');

#8. Write a query to count the customers with grades above New York's average.
select count(*)
from customer
where grade > (
	select avg(grade)
	from customer
	where city = 'New York');
#official solution want to breakdown by grade
select grade, count(*)
from customer
group by grade
having grade > (
	select avg(grade)
	from customer
	where city = 'New York');
/*
grade	count
200		3
300		2
*/

#9. Write a query to extract the data from the orders table for those salesman who earned the maximum commission.
select *
from orders
where salesman_id in (
	select salesman_id
	from salesman
	where commission = (
		select max(commission
		from salesman)));

#10. Write a query to display all the customers with orders issued on date 17th August, 2012.
select *
from customers
where customer_id in (
	select customer_id
	from orders
	where ord_date = '2012-08-17');

#11. Write a query to find the name and numbers of all salesmen who had more than one customer.
select salesman_id, count(*)
from customer
group by salesman_id;
/*
salesman_id	count
5002	2
5001	2
5003	1
5005	1
5007	1
5006	1
*/
select salesman_id
from customer
group by salesman_id
having count(*) > 1;
/*
salesman_id
5002
5001
*/
select name, salesman_id
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(*) > 1);
/*
name	salesman_id
James Hoog	5001
Nail Knite	5002
*/
#official solution
select salesman_id, name 
from salesman a 
where 1 < (
	select count(*) 
	from customer 
	where salesman_id=a.salesman_id);

#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.
#official solution
#We refer to two identical, yet independent tables.  The average price is calculated for each customer's orders.
select *
from orders a
where a.purch_amt > (
	select avg(b.purch_amt)
	from orders b
	where a.customer_id = b.customer_id);

#13. Write a queries to find all orders with order amounts which are on or above-average amounts for their customers.
select *
from orders a
where a.purch_amt >= (
	select avg(b.purch_amt)
	from orders b
	where a.customer_id = b.customer_id);

#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
select a.ord_date, sum(a.purch_amt)
from orders a
group by a.ord_date
having sum(a.purch_amt) > (
	select max(b.purch_amt)+1000
	from orders b
	where a.ord_date = b.ord_date)
order by a.ord_date;
/*
ord_date	sum
2012-09-10	6979.15
2012-10-10	4463.83
*/

#15. Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.
#RM:  if there is a customer in London, then extract all customers from the customer table.
select *
from customer
where exists (
	select *
	from customer
	where city = 'London');
/*
customer_id	cust_name	city	grade	salesman_id
3002	Nick Rimando	New York	100	5001
3007	Brad Davis	New York	200	5001
3005	Graham Zusi	California	200	5002
3008	Julian Green	London	300	5002
3004	Fabian Johnson	Paris	300	5006
3009	Geoff Cameron	Berlin	100	5003
3003	Jozy Altidor	Moscow	200	5007
3001	Brad Guzan	London		5005
*/

#16. Write a query to find the salesmen who have multiple customers.
select *
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) > 1);

#17. Write a query to find all the salesmen who worked for only one customer.
select *
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) = 1);

#18. Write a query that extract the rows of all salesmen who have customers with more than one orders.
select *
from salesman
where salesman_id in (
	select salesman_id
	from customer
	where customer_id in (
		select customer_id
		from orders
		group by customer_id
		having count(customer_id) > 1));

#19. Write a query to find salesmen with all information who lives in the city where any of the customers lives.
select *
from salesman
where exists (
	select city
	from customer);
#official solution
select *
from salesman 
where city = any (
	select city
	from customer);

#20. Write a query to find all the salesmen for whom there are customers that follow them.
#RM:  dumb question.  Looked at solution to understand question.  Find all salesmen in the cities from the customers.
select *
from salesman
where city in (
	select city
	from customers);

#21. Write a query to display the salesmen which name are alphabetically lower than the name of the customers.
#incorrect
select *
from salesman s join customer c
on s.salesman_id = c.salesman_id
and s.name < c.cust_name;
/*
select s.*
from salesman s join customer c
on s.salesman_id = c.salesman_id
and s.name < c.cust_name;
*/
#official solution
select *
from salesman
where exists (
	select *
	from customer
	where salesman.name < customer.cust_name);
#user solution
select *
from salesman
where salesman.name < any (
	select customer.cust_name
	from customer);

#22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.
select *
from customer
where grade > any (
	select inner.grade
	from customer inner
	where inner.city < 'New York');

#23. Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012.
select a.*
from orders a
where a.purch_amt > any (
	select b.purch_amt
	from orders b
	where b.ord_date = '2012-09-10');
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70005	2400.60		2012-07-27	3007			5001
70008	5760.00		2012-09-10	3002			5001
70010	1983.43		2012-10-10	3004			5006
70003	2480.40		2012-10-10	3009			5003
70013	3045.60		2012-04-25	3002			5001
70007	948.50		2012-09-10	3005			5002
*/

#24. Write a query to find all orders with an amount smaller than any amount for a customer in London.
select a.*
from orders a
where a.purch_amt < any (
	select b.purch_amt
	from orders b
	where b.salesman_id in (
		select salesman_id
		from customer
		where city = 'London'));
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70009	270.65	2012-09-10	3001	5005
70002	65.26	2012-10-05	3002	5001
70004	110.50	2012-08-17	3009	5003
70011	75.29	2012-08-17	3003	5007
70001	150.50	2012-10-05	3005	5002
70012	250.45	2012-06-27	3008	5002
*/
#RM:  ord_no 70009 $270.65 in results is incorrect
#official solution
#RM:  subquery and join
select *
from orders
where purch_amt < any (
	select purch_amt
	from orders o, customer c
	where o.customer_id=c.customer_id
	and c.city = 'London');

#25. Write a query to display all orders with an amount smaller than the maximum amount for a customer in London.
select *
from orders
where purch_amt < (
	select max(purch_amt)
	from orders o, customer c
	where o.customer_id=c.customer_id
	and c.city = 'London');