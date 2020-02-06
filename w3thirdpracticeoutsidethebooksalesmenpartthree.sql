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
where purch_mat > (
	select avg(purch_mat)
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
