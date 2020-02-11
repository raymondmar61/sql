#https://www.w3resource.com/sql-exercises/subqueries/index.php
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
#We refer to two identical, yet independent tables.  The average price is calculated for each customer's orders.
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
#RM:  order 70009 $270.65 in results is incorrect
#official solution
#RM:  subquery and join
select *
from orders
where purch_amt < any (
	select purch_amt
	from orders o, customer c
	where o.customer_id=c.customer_id
	and c.city = 'London');