#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php

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