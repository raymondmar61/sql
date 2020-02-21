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

#28. Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London.
select main.*
from customer main
where main.grade not in (
	select subquery.grade
	from customer subquery
	where city = 'London');  #RM:  query works as long as there's no null grades.
#official solution
select *
from customer
where grade <> any (
	select grade
	from customer
	where city = 'London');

#33. Write a SQL query to display the name of each company, price for their most expensive product along with their Name.
select c.com_name, max(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name;
/*
com_name	max
Samsung	5000.00
iBall	900.00
Epsion	2600.00
Frontech	550.00
Zebronics	250.00
Asus	3200.00
*/
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb
	where itemb.pro_com = company.com_id
	group by itemb.pro_com)
/*
com_name	pro_name	pro_price
Samsung	Monitor	5000.00
iBall	DVD drive	900.00
Epsion	Printer	2600.00
Zebronics	ZIP drive	250.00
Asus	Mother Board	3200.00
Frontech	Speaker	550.00
*/
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb, company_mast companyb
	where itemb.pro_com = companyb.com_id
	group by itemb.pro_com);
/*
returns no rows
*/

