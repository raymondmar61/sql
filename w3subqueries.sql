#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/subqueries/index.php

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

#1. Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
select *
from orders
where salesman_id = (
	select salesman_id
	from salesman
	where name = 'Paul Adams');

#2. Write a query to display all the orders for the salesman who belongs to the city London.
select *
from orders
where salesman_id = (
	select salesman_id
	from salesman
	where city = 'London');

#3. Write a query to find all the orders issued against the salesman who works for customer whose id is 3007.
select name
from salesman
where salesman_id = (
	select salesman_id
	from orders
	where customer_id = 3007);  #RM:  I interpret find the salesman who sold to customer_id 3007.
#official solution
select *
from orders
where salesman_id =
    (select distinct salesman_id 
     from orders 
     where customer_id =3007);

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
where salesman_id = (
	select salesman_id
	from salesman
	where city = 'New York'); #official solution:  Using = instead of IN will produce the same result. But that does not make = equivalent to IN.

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
#6. Write a query to display the commission of all the salesmen servicing customers in Paris.
select commission
from salesman
where salesman_id = (
	select salesman_id
	from customer
	where city = 'Paris');

#7. Write a query to display all the customers whose id is 2001 bellow the salesman ID of Mc Lyon. #RM copied solution.
select *
from customer
where customer_id = (
	select salesman_id -2001
	from salesman
	where name = 'Mc Lyon');

#8. Write a query to count the customers with grades above New York's average.
select count(customer_id)
from customer
where grade > (
	select avg(grade)
	from customer
	where city = 'New York');
#official solution want count breakdown by grade
select grade, count(distinct customer_id)
from customer
group by grade
having grade >
    (select avg(grade)
     from customer
     where city = 'New York');
#my way
select grade, count(customer_id)
from customer
where grade > (
	select avg(grade)
	from customer
	where city ='New York')
group by grade;

#9. Write a query to display all customers with orders on October 5, 2012.
select *
from customer
where customer_id in (
	select customer_id
	from orders
	where ord_date = '2012-10-05');
#official solution
select *
from customer a, orders  b 
where a.customer_id=b.customer_id 
and b.ord_date='2012-10-05';

#10. Write a query to display all the customers with orders issued on date 17th August, 2012.
select *
from customer
where customer_id in (
	select customer_id
	from orders
	where ord_date = '2012-08-17');
#official solution
select b.*, a.cust_name
from orders b, customer a
where a.customer_id=b.customer_id
and b.ord_date='2012-08-17';

#11. Write a query to find the name and numbers of all salesmen who had more than one customer.
select *
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) >= 2);
#official solution
select salesman_id,name 
from salesman a 
where 1 < 
    (select count(*) 
     from customer 
     where salesman_id=a.salesman_id);

#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.  RM:  subquery and join together.  subquery join subquery together.
select avg(o.purch_amt)
from orders o;
/*
avg
1461.7650000000000000
*/
select customer_id, avg(purch_amt)
from orders
group by customer_id
order by customer_id;
/*
customer_id	avg
3001	270.6500000000000000
3002	2956.9533333333333333
3003	75.2900000000000000
3004	1983.4300000000000000
3005	549.5000000000000000
3007	2400.6000000000000000
3008	250.4500000000000000
3009	1295.4500000000000000
*/
select *
from orders o
where o.purch_amt > (
	select avg(o.purch_amt)
	from orders o);
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70008	5760.00	2012-09-10	3002	5001
70013	3045.60	2012-04-25	3002	5001
70010	1983.43	2012-10-10	3004	5006
70005	2400.60	2012-07-27	3007	5001
70003	2480.40	2012-10-10	3009	5003
*/
#official solution
select *
from orders oa
where oa.purch_amt > (
	select avg(ob.purch_amt)
	from orders ob
	where oa.customer_id=ob.customer_id) #<-- take customers into account per official solution
order by customer_id;
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70008	5760.00	2012-09-10	3002	5001
70013	3045.60	2012-04-25	3002	5001
70007	948.50	2012-09-10	3005	5002
70003	2480.40	2012-10-10	3009	5003
*/

#13. Write a queries to find all orders with order amounts which are on or above-average amounts for their customers.
select *
from orders oa
where oa.purch_amt >= (
	select avg(ob.purch_amt)
	from orders ob
	where oa.customer_id=ob.customer_id) #<-- take customers into account per official solution
order by customer_id;
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70009	270.65	2012-09-10	3001	5005
70013	3045.60	2012-04-25	3002	5001
70008	5760.00	2012-09-10	3002	5001
70011	75.29	2012-08-17	3003	5007
70010	1983.43	2012-10-10	3004	5006
70007	948.50	2012-09-10	3005	5002
70005	2400.60	2012-07-27	3007	5001
70012	250.45	2012-06-27	3008	5002
70003	2480.40	2012-10-10	3009	5003
*/

#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
#official solution
select oa.ord_date, sum(oa.purch_amt)
from orders oa
group by oa.ord_date
having sum (oa.purch_amt) > (
	select 1000.00 + max(ob.purch_amt) 
	from orders ob 
	where oa.ord_date = ob.ord_date);
/*
ord_date	sum
2012-09-10	6979.15
2012-10-10	4463.83
*/

#15. Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.
#RM:  question is extract the customer table if one or more customer is from London.  There is a customer from London.
#official solution
select *
from customer
where exists (
	select *
    from customer 
    where city = 'London');
#also from comment section
select *
from customer ca
where 1 >= (
	select count(distinct cb.city)
	from customer cb
	where ca.customer_id=cb.customer_id
	and cb.city='London');

#16. Write a query to find the salesmen who have multiple customers.
select name
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) > 1);
#official solution
select * 
from salesman 
where salesman_id in (
   select distinct salesman_id 
   from customer a 
   where exists (
      select * 
      from customer b 
      where b.salesman_id=a.salesman_id 
      and b.cust_name<>a.cust_name));

#17. Write a query to find all the salesmen who worked for only one customer.
select name
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) = 1);
#official solution
select * 
from salesman 
where salesman_id in (
   select distinct salesman_id 
   from customer a 
   where not exists (
      select * 
      from customer b 
      where b.salesman_id=a.salesman_id 
      and b.cust_name<>a.cust_name));