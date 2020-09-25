#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#https://www.w3resource.com/sql-exercises/subqueries/index.php
#https://www.w3resource.com/sql-exercises/union/sql-union.php

#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#1. Write a query to find those customers with their name and those salesmen with their name and city who lives in the same city.
select s.name, c.cust_name, s.city, c.city as "c.city"
from salesman s, customer c
where s.city = c.city;

#2. Write a SQL statement to find the names of all customers along with the salesmen who works for them.
select c.cust_name, s.name, c.salesman_id, s.salesman_id as "s.salesman_id"
from salesman s join customer c
on s.salesman_id = c.salesman_id;

#3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
select o.*, c.city as "customer city", s.city as "salesman city"
from orders o, customer c, salesman s
where o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id
and c.city <> s.city;

#4. Write a SQL statement that finds out each order number followed by the name of the customers who made the order.
select o.ord_no, c.cust_name
from orders o join customer c
on o.customer_id = c.customer_id;

#5. Write a SQL statement that sorts out the customer and their grade who made an order. Each of the customers must have a grade and served by at least a salesman, who belongs to a city.  #RM:  dumb question all salesman have a city.  Most customers have a grade Must be an exercise to practice is not null.
select c.cust_name, c.grade, o.*, s.city
from customer c, orders o, salesman s
where c.customer_id = o.customer_id
and s.salesman_id = o.salesman_id
and c.grade is not null;

#6. Write a query that produces all customers with their name, city, salesman and commission, who served by a salesman and the salesman works at a rate of the commission within 12% to 14%.
select c.*, s.name, s.commission
from customer c join salesman s
on c.salesman_id = s.salesman_id
where s.commission between 0.12 and 0.14;

#7. Write a SQL statement that produces all orders with the order number, customer name, commission rate and earned commission amount for those customers who carry their grade is 200 or more and served by an existing salesman.
select o.ord_no, c.cust_name, s.commission, round(o.purch_amt*s.commission,2) as "earned commission"
from orders o, customer c, salesman s
where o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id
and c.grade >= 200;

#8.Find all customers with orders on October 5, 2012.
select c.*
from customer c join orders o
on c.customer_id = o.customer_id
where o.ord_date = '2012-10-05';

#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city.
select s.name, c.cust_name, s.city, c.city as "c.city"
from salesman s, customer c
where s.city = c.city;

#2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000.
select c.cust_name, o.*
from customer c join orders o
on c.customer_id = o.customer_id
where purch_amt between 500 and 2000;

#3. Write a SQL statement to know which salesman are working for which customer.
select c.cust_name, s.name
from customer c, salesman s
where c.salesman_id = s.salesman_id;

#4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%.
select c.cust_name
from customer c join salesman s
on c.salesman_id = s.salesman_id
where s.commission > .12;

#5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12%.
select c.cust_name
from customer c, salesman s
where c.salesman_id = s.salesman_id
and s.commission > .12
and c.city <> s.city;

#6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.
select o.*, c.cust_name, s.name, s.commission
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on s.salesman_id = o.salesman_id;

#7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
select o.*, c.*, s.*
from orders o, customer c, salesman s
where o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;
#official solution
select *
from orders natural join customer
natural join salesman;

#8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own.  #RM:  dumb question all customers go through a salesman.  Practice left outer join.
select c.*
from customer c left join salesman s
on c.salesman_id = s.salesman_id
order by c.cust_name;

#9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own.
select c.*
from customer c left join salesman s
on c.salesman_id = s.salesman_id
where c.grade < 300
order by c.cust_name;

#10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c left join orders o
on c.customer_id = o.customer_id
order by o.ord_date;

#11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission
from customer c left join orders o
on c.customer_id = o.customer_id
left join salesman s
on c.salesman_id = s.salesman_id;

#12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.
select s.*
from salesman s left join customer c
on s.salesman_id = c.salesman_id
order by s.salesman_id;

#13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier.
select s.*
from customer c right join salesman s
on c.salesman_id = s.salesman_id
right join orders o
on o.salesman_id = s.salesman_id;
#official solution.  Some comments says official solution is incorrect.
select s.*
from customer c right join salesman s
on c.salesman_id = s.salesman_id
right join orders o
on o.customer_id = s.customer_id;

#14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select s.*, o.ord_no
from customer c right join salesman s
on c.salesman_id = s.salesman_id
left join orders o 
on o.customer_id = c.customer_id
where o.purch_amt >= 2000
and c.grade is not null;

#15. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from orders o left join customer c
on o.customer_id = c.customer_id;
#official solution.  Some comments says official solution is incorrect.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from orders o full outer join customer c
on o.customer_id = c.customer_id;

#16. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from orders o left join customer c
on o.customer_id = c.customer_id
where c.grade is not null;
#official solution.  Some comments says official solution is incorrect.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from orders o full outer join customer c
on o.customer_id = c.customer_id
where c.grade is not null;

#17. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa.
select s.*, c.*
from salesman s, customer c;
#official solution
select *
from salesman s cross join customer c;

#18. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that salesman who belongs to a city.  #RM:  Salesman must have a city.  It's not salesman's city same as customer's city.
select *
from salesman s cross join customer c
where s.city is not null;

#19. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade.
select *
from salesman s cross join customer c
where s.city is not null
and c.grade is not null;

#20. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade.
select *
from salesman s cross join customer c
where s.city is not null
and c.grade is not null
and s.city <> c.city;

#21. Write a SQL query to display all the data from the item_mast, including all the data for each item's producer company.
select *
from item_mast, company_mast
where item_mast.pro_com = company_mast.com_id;

#22. Write a SQL query to display the item name, price, and company name of all the products.
select i.pro_name, i.pro_price, c.com_name
from item_mast i join company_mast c
on i.pro_com = c.com_id;

#23. Write a SQL query to display the average price of items of each company, showing the name of the company.
select c.com_name, avg(i.pro_price)
from item_mast i join company_mast c
on i.pro_com = c.com_id
group by c.com_name;

#24. Write a SQL query to display the names of the company whose products have an average price larger than or equal to Rs. 350.  RM:  The average price of items of each company is greater than or equal to 350.
select c.com_name, avg(i.pro_price)
from item_mast i join company_mast c
on i.pro_com = c.com_id
group by c.com_name
having avg(i.pro_price) >= 350;

#25. Write a SQL query to display the name of each company along with the ID and price for their most expensive product.  RM:  Find the company's or com_name's most expensive product.
#Incorrect
select c.com_name, i.pro_name, max(i.pro_price)
from item_mast i join company_mast c
on i.pro_com = c.com_id
group by c.com_name, i.pro_name;
/*
com_name	pro_name	max
Asus	Mother Board	3200.00
Epsion	Refill cartridge	350.00
iBall	Mouse	250.00
Epsion	Printer	2600.00
iBall	CD drive	800.00
Frontech	Key Board	450.00
Samsung	Monitor	5000.00
Frontech	Speaker	550.00
iBall	DVD drive	900.00
Zebronics	ZIP drive	250.00
*/
#correct
select c.com_name, i.pro_name, i.pro_price
from item_mast i join company_mast c
on i.pro_com = c.com_id
and i.pro_price in (
	select max(pro_price)
	from item_mast ia
	where ia.pro_com = c.com_id
	group by pro_com);

#26. Write a query in SQL to display all the data of employees including their department.
select *
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code;

#27. Write a query in SQL to display the first name and last name of each employee, along with the name and sanction amount for their department.
select emp_details.emp_fname, emp_details.emp_lname, emp_department.dpt_name, emp_department.dpt_allotment
from emp_details join emp_department
on emp_details.emp_dept = emp_department.dpt_code;

#28. Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000.
select emp_details.emp_fname, emp_details.emp_lname
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
and emp_department.dpt_allotment > 50000;

#29. Write a query in SQL to find the names of departments where more than two employees are working.  #RM:  solution included inner join which is unnecessary.
select emp_department.dpt_name
from emp_department
where emp_department.dpt_code in (
	select emp_dept
	from emp_details
	group by emp_dept
	having count(*) > 2);
#Here is solution inner join group by join inner join group by
select emp_department.dpt_name
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
group by emp_department.dpt_name
having count(*) > 2;

#https://www.w3resource.com/sql-exercises/subqueries/index.php
#1. Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
select *
from orders
where salesman_id = (
	select salesman_id
	from orders
	where name = 'Paul Adam');

#2. Write a query to display all the orders for the salesman who belongs to the city London.
select *
from orders
where salesman_id in (
	select salesman_id
	from salesman
	where city = 'London');

#3. Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007.  RM:  Confusing.  Question asked find all orders from salesman_id for which customer_id 3007 is the salesman_id's customer_id.
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
where salesman_id = (
	select salesman_id
	from customer
	where city = 'Paris');

#7. Write a query to display all the customers whose id is 2001 bellow the salesman ID of Mc Lyon.  RM:  Dumb question.  Subtract 2,001 from salesman_id which matches salesman Mc Lyon.  The number is the customer_id in customer table.
select *
from customer
where customer_id in (
	select salesman_id - 2001
	from salesman
	where name = 'Mc Lyon');

#8. Write a query to count the customers with grades above New York's average.
select grade, count(*)
from customer
group by grade
having grade > (
	select avg(grade)
	from customer
	where city = 'New York');

#9. Write a query to extract the data from the orders table for those salesman who earned the maximum commission.
select *
from orders
where salesman_id in (	
	select salesman_id
	from salesman
	where commission = (
		select max(commission)
		from salesman));

#10. Write a query to display all the customers with orders issued on date 17th August, 2012.
select *
from customer
where customer_id in (
	select customer_id
	from orders
	where ord_date = '2012-08-17');

#11. Write a query to find the name and numbers of all salesmen who had more than one customer.
select salesman_id, count(salesman_id)
from customer
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) > 1)
group by salesman_id;
#answers question correctly
select s1.name, count(c1.salesman_id)
from salesman s1, customer c1
where s1.salesman_id in (
	select c2.salesman_id
	from customer c2
	group by c2.salesman_id
	having count(c2.salesman_id) > 1)
and s1.salesman_id = c1.salesman_id
group by s1.name;
/*
name	count
Nail Knite	2
James Hoog	2
*/

#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.  #RM:  I don't understand the question.
#official solution
select * 
from orders a
where purch_amt > (
	select avg(purch_amt)
	from orders b
	where b.customer_id = a.customer_id);

#13. Write a queries to find all orders with order amounts which are on or above-average amounts for their customers. 
#official solution
select * 
from orders a
where purch_amt >= (
	select avg(purch_amt)
	from orders b
	where b.customer_id = a.customer_id);

#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
select ord_date, sum(purch_amt)
from orders
where ord_date in (
	select ord_date
	from orders
	group by ord_date
	having sum(purch_amt) > max(purch_amt)+1000)
group by ord_date;
#official solution
select ord_date, sum(purch_amt)
from orders a
group by ord_date
having sum(purch_amt) > (
	select 1000.00 + max(purch_amt) 
    from orders b 
    where a.ord_date = b.ord_date);

#15. Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.
select *
from customer
where 1 > (
	select count(*)
	from customer
	where city = 'Paris');
#official solution
select *
from customer
where exists (
	select *
	from customer 
	where city = 'London');

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

#19. Write a query to find salesmen with all information who lives in the city where any of the customers lives.  #RM:  Find all salesman who lives in any cities where the customer lives.
select *
from salesman
where city = any (
	select city
	from customer);

#20. Write a query to find all the salesmen for whom there are customers that follow them.
select *
from salesman
where city in (
	select city
	from customer);

#21. Write a query to display the salesmen which name are alphabetically lower than the name of the customers.
select *
from salesman
where name < any (
	select cust_name
	from customer);

#22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.  #RM:  graduation is grade
select *
from customer
where grade > any (
	select grade
	from customer
	where city < 'New York');

#23. Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012.
select *
from orders
where purch_amt > any (
	select purch_amt
	from orders
	where ord_date = '2012-09-10');

#24. Write a query to find all orders with an amount smaller than any amount for a customer in London. (Using ANY keyword)
select *
from orders
where purch_amt < any (
	select purch_amt
	from orders
	where customer_id in (
		select customer_id
		from customer
		where city = 'London'));

#25. Write a query to display all orders with an amount smaller than any amount for a customer in London. (Using MAX)
select *
from orders
where purch_amt < (
	select max(purch_amt)
	from orders
	where customer_id in (
		select customer_id
		from customer
		where city = 'London'));

#26. Write a query to display only those customers whose grade are, in fact, higher than every customer in New York.
select *
from customer
where grade > all (
	select grade
	from customer
	where city = 'New York');

#27. Write a query in sql to find the name, city, and the total sum of orders amount a salesman collects. Salesman should belong to the cities where any of the customer belongs.
select s.name, s.city, sum(o.purch_amt)
from salesman s, orders o
where s.salesman_id = o.salesman_id
and s.city in (
	select city
	from customer)
group by s.name, s.city;

#28. Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London.  #RM:  There is a null grade in customer with city London.
select *
from customer
where grade not in (
	select grade
	from customer
	where city = 'London'
	and grade is not null);

#29. Write a query to find all those customers whose grade are not as the grade, belongs to the city Paris.
select *
from customer
where grade not in (
	select grade
	from customer
	where city = 'Paris');

#30. Write a query to find all those customers who hold a different grade than any customer of the city Dallas.
select *
from customer
where not grade = any (
	select grade
	from customer
	where city = 'Dallas');

#31. Write a SQL query to find the average price of each manufacturer's products along with their name.
select c.com_name, i.pro_name, avg(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name, i.pro_name;

#32. Write a SQL query to display the average price of the products which is more than or equal to 350 along with their names.
select c.com_name, i.pro_name, avg(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name, i.pro_name
having avg(i.pro_price) >= 350;

#33. Write a SQL query to display the name of each company, price for their most expensive product along with their Name.  #RM:  find the company's most expensive product.  Include the most expensive product's name.  #RM:  same as question 25 in https://www.w3resource.com/sql-exercises/sql-joins-exercises.php.
select c.com_name, i.pro_name, i.pro_price
from item_mast i join company_mast c
on i.pro_com = c.com_id
and i.pro_price in (
	select max(pro_price)
	from item_mast ia
	where ia.pro_com = c.com_id
	group by pro_com);

#34. Write a query in SQL to find all the details of employees whose last name is Gabriel or Dosio.
select *
from emp_details
where emp_lname in ('Gabriel','Dosio');

#35. Write a query in SQL to display all the details of employees who works in department 89 or 63.
select *
from emp_details
where emp_dept in (89,93);

#36. Write a query in SQL to display the first name and last name of employees working for the department which allotment amount is more than Rs.50000.
select *
from emp_details
where emp_dept in (
	select dpt_code
	from emp_department
	where dpt_allotment > 50000);

#37. Write a query in SQL to find the departments which sanction amount is larger than the average sanction amount of all the departments.
select *
from emp_department
where dpt_allotment > (
	select avg(dpt_allotment)
	from emp_department);

#38. Write a query in SQL to find the names of departments with more than two employees are working.
select *
from emp_department
where dpt_code in (
	select emp_dept
	from emp_details
	group by emp_dept
	having count(emp_dept) > 2);

#39. Write a query in SQL to find the first name and last name of employees working for departments which sanction amount is second lowest.
select *
from emp_details
where emp_dept in (
	select dpt_code
	from (
		select dpt_code, rank() over (order by dpt_allotment asc) rankcolumnname
		from emp_department) neednamehere
	where rankcolumnname = 2);
/*
emp_idno	emp_fname	emp_lname	emp_dept
631548	Alan	Snappy	27
539569	George	Mardy	27
*/

#https://www.w3resource.com/sql-exercises/union/sql-union.php
#1. Write a query to display all salesmen and customer located in London.  
select s.salesman_id, s.name, s.city
from salesman s
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

#3. Write a query to display all the salesmen and customer involved in this inventory management system.
select salesman_id, customer_id
from salesman
union
(select salesman_id, customer_id
from customer);

#4. Write a query to make a report of which salesman produce the largest and smallest orders on each date.
select s.salesman_id, s.name, o1.ord_date as "date largest order"
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
	select max(o2.purch_amt)
	from orders o2
	where o2.ord_date = o1.ord_date)
union
(select s.salesman_id, s.name, o1.ord_date as "date smallest order"
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
	select min(o2.purch_amt)
	from orders o2
	where o2.ord_date = o1.ord_date));
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
select s.salesman_id, s.name, o1.ord_date as "date largest order"
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
	select max(o2.purch_amt)
	from orders o2
	where o2.ord_date = o1.ord_date)
union
(select s.salesman_id, s.name, o1.ord_date as "date smallest order"
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
	select min(o2.purch_amt)
	from orders o2
	where o2.ord_date = o1.ord_date));
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
	where c.ord_date = b.ord_date))
order by o1.ord_no;

#6. Write a query to list all the salesmen, and indicate those who do not have customers in their cities, as well as whose who do.
#RM:  List salesmen with customers in same cities and list salesmen with customer in different cities.
select s.*, c.city as "Customer City", 'Salesmen And Customers In Same City'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city = c.city
union
(select s.*, c.city as "Customer City", 'Salesmen And Customers In Different City'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city <> c.city);

#7. Write a query to that appends strings to the selected fields, indicating whether or not a specified salesman was matched to a customer in his city.
select s.*, c.city as "Customer City", 'Salesmen And Customers In Same City'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city = c.city
union
(select s.*, c.city as "Customer City", 'Salesmen And Customers In Different City'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city <> c.city);

#8. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words "High Rating", while the others will have the words "Low Rating".
select cust_name, city, grade, 'High Rating'
from customer
where grade >= 200
union
(select cust_name, city, grade, 'Low Rating'
from customer
where grade < 200);
#RM:  using case
select cust_name, city, grade, (case when grade >=200 then 'High Rating' else 'Low Rating' end) as "Label Rating Type"
from customer;

#9. Write a command that produces the name and number of each salesman and each customer with more than one current order. Put the results in alphabetical order.
select customer_id, cust_name
from customer mainquery
where 1 < (
	select count(*)
	from customer subquery
	where mainquery.customer_id = subquery.customer_id)
union
(select salesman_id, name
from salesman mainquery
where 1 < (
	select count(*)
	from salesman subquery
	where mainquery.salesman_id = subquery.salesman_id))
order by 2;

#https://www.w3resource.com/sql-exercises/view/sql-view.php
#RM:  w3 website query editor available for select queries only.  RM:  Interesting!  In the future practice views on my ININ account.
#1. Write a query to create a view for those salesmen belongs to the city New York.
create view newyorksalesmen as
	select *
	from salesman
	where city = 'New York';

#2. Write a query to create a view for all salesmen with columns salesman_id, name, and city. 
create view allsalesmen as
	select salesman_id, name, city
	from salesman;

#3. Write a query to find the salesmen of the city New York who achieved the commission more than 13%.
#RM:  after creating the view newyorksalesmen13, you can use the view newyorksalesmen13 in the from clause of a select query the same way for a standard select query.  The view newyorksalesmen13 saves time writing the same query(?) accessing the salesman table New York frequently.  It's a simple example.  Idea is same for complex situations.
create view newyorksalesmen13 as
	select *
	from salesman
select *
from newyorksalesmen13
where commission > .13;

#4. Write a query to create a view to getting a count of how many customers we have at each level of a grade.
create view allcustomers as
	select *
	from customers
select grade, count(*)
from allcustomers
group by grade;
#official solution
create view gradecount (grade, number) as
	select grade, count(*)
	from customer
	group by grade;

#5. Write a query to create a view to keeping track the number of customers ordering, number of salesmen attached, average amount of orders and the total amount of orders in a day.
create view trackcustomers as
	select ord_date, count(*), avg(purch_amt), sum(purch_amt)
	from trackcustomers
	group by ord_date;
#official solution
create view trackcustomers as
	select ord_date, count(distinct customer_id), avg(purch_amt), sum(purch_amt)
	from orders
	group by ord_date;


#6. Write a query to create a view that shows for each order the salesman and customer by name.
create view salesmancustomername as
	select s.name as salesmanname, c.cust_name as customername
	from salesman s, customer c, orders o
	where o.customer_id = c.customer_id
	and o.salesman_id = s.salesman_id;

#7. Write a query to create a view that finds the salesman who has the customer with the highest order of a day.
create view highestorderperday as
	select o.*, s.name
	from orders o join salesman s
	on o.salesman_id = s.salesman_id
select ord_no, ord_date, name
from highestorderperday h1
where h1.ord_no in (
	select ord_date, max(purch_amt)
	from highestorderperday h2
	where h2.ord_no = h1.ord_no
	group by ord_date);
#official solution
create view highestorderperday as
	select o.ord_date, s.salesman_id, s.name
	from salesman s, orders o
	where s.salesman_id = o.salesman_id
	and o.purch_amt = (
		select max(purch_amt)
		from orders ob
		where ob.ord_date = o.ord_date);

#8. Write a query to create a view that finds the salesman who has the customer with the highest order at least 3 times on a day.
create view highestorderthreetimes as
	select distinct salesman_id, name
	from highestorderperday h1
	where 3 <= (
		select count(*)
		from highestorderperday h2
		where h1.salesman_id = h2.salesman_id);

#9. Write a query to create a view that shows all of the customers who have the highest grade.
create view customershighestgrade as
	select *
	from customer
	where grade = (
		select max(grade)
		from customer);

#10. Write a query to create a view that shows the number of the salesman in each city.
create view countsalesmanbycity as
	select city, count(*)
	from salesman
	group by city;

#11. Write a query to create a view that shows the average and total orders for each salesman after his or her name. (Assume all names are unique)
create view salesmannumbers as
	select s.name, avg(purch_amt), sum(purch_amt)
	from salesman s, orders o
	where s.salesman_id = o.salesman_id
	group by s.name;

#12. Write a query to create a view that shows each salesman with more than one customers.
create view morethanonecustomer as
	select *
	from salesman
	where salesman_id in (
		select salesman_id, count(*)
		from customer
		having count(*) > 1);
#official solution
create view morethanonecustomer as
	select *
	from salesman mainquery
	where 1 < (
		select count(*)
		from salesman subquery
		where mainquery.salesman_id = subquery.salesman_id);

#13. Write a query to create a view that shows all matches of customers with salesman such that at least one customer in the city of customer served by a salesman in the city of the salesman.  #RM:  I don't understand the question.
#official solution
create view citymatch (custcity, salescity) as
	select distinct a.city, b.city
	from customer a, salesman b
	where a.salesman_id = b.salesman_id;

#14. Write a query to create a view that shows the number of orders in each day.
create view numberoforders as
	select ord_date, count(*)
	from orders
	group by ord_date;
#official solution
create view numberoforders (ord_date, odcount) as
	select ord_date, count(*)
	from orders
	group by ord_date;

#15. Write a query to create a view that finds the salesmen who issued orders on October 10th, 2012.
create view orders10102012 as
	select *
	from salesman
	where salesman_id in (
		select salesman_id
		from orders
		where ord_date = '2012-10-10');
#also
create view orders10102012 as
	select *
	from salesman
	where salesman.salesman_id = orders.salesman_id
	and orders.ord_date = '2012-10-10';

#16. Write a query to create a view that finds the salesmen who issued orders on either August 17th, 2012 or October 10th, 2012
create view orders10102012or08172012 as
	select *
	from salesman
	where salesman_id in (
		select salesman_id
		from orders
		where ord_date = '2012-10-10'
		or ord_date = '2012-08-17');
#also
create view orders10102012or08172012 as
	select *
	from salesman
	where salesman.salesman_id = orders.salesman_id
	and orders.ord_date = '2012-10-10'
	or orders.ord_date = '2012-08-17';
