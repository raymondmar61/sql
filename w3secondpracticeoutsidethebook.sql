#NEW, NEW NEW
#24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
#official solution
select *
from nobel_win
where year = 1970
order by case
	when subject in ('Economics','Chemistry') then 1 else 0 end asc,
subject, winner;

#25. Write a SQL query to display the name of each company along with the ID and price for their most expensive product.
select c.com_name, max(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name;
#official solution
select c.com_name, i.pro_id, i.pro_name, i.pro_price
from company_mast c, item_mast i
where c.com_id = i.pro_com
and i.pro_price = (
	select max(i.pro_price)
	from item_mast i
	where i.pro_com = c.com_id);

#11. Write a query to find the name and numbers of all salesmen who had more than one customer.
select salesman_id, name
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) > 1);
#official solution
select salesman_id,name 
from salesman a 
where 1 < (
	select count(*)
	from customer 
	where salesman_id=a.salesman_id);
#also
select s.salesman_id, s.name 
from salesman s
where 1 < (
	select count(*)
	from customer c
	where c.salesman_id=s.salesman_id);
#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.
select *
from orders
where purch_amt > (
	select avg(purch_amt)
	from orders);
#official solution.  Find customer's orders above average for each customer
select * 
from orders a
where purch_amt > (
	select avg(purch_amt)
	from orders b
	where b.customer_id = a.customer_id);
#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
select ord_date, sum(purch_amt)
from orders a
group by ord_date
having sum(purch_amt) > (
	select max(purch_amt) + 1000
	from orders b
	where a.ord_date = b.ord_date);
#16. Write a query to find the salesmen who have multiple customers.
select s.name, c.salesman_id, count(c.salesman_id)
from customer c join salesman s
on c.salesman_id = s.salesman_id
group by s.name, c.salesman_id
having count(c.salesman_id) >= 2;  #correct
#user solution
select *
from salesman s
where 1 < (
	select count(*)
	from customer a
	where s.salesman_id = a.salesman_id);
#18. Write a query that extract the rows of all salesmen who have customers with more than one orders.
select *
from salesman s
where 1 < (
	select count(customer_id)
	from orders o
	where s.salesman_id = o.salesman_id);
#19. Write a query to find salesmen with all information who lives in the city where any of the customers lives.
select distinct s.*
from salesman s, customer c
where s.city = c.city;  #it works
select *
from salesman
where salesman_id in (
	select s.salesman_id
	from salesman s, customer c
	where s.city = c.city);
#official solution
select *
from salesman
where city = any (
	select city
	from customer);
#22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.
select *
from customer
where grade > any (
	select grade
	from customer
	where city < 'New York');
#26. Write a query to display only those customers whose grade are, in fact, higher than every customer in New York.
select *
from customer
where grade > all (
	select grade
	from customer
	where city = 'New York');
#33. Write a SQL query to display the name of each company, price for their most expensive product along with their Name.
select company.com_name, max(item.pro_price)
from item_mast item, company_mast company
where item.pro_com = company.com_id
group by company.com_name;  #partially correct.  Need the product name matching the most expensive product.
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb
	where item.pro_id = itemb.pro_id);  #incorrect.  Returns all items.
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb
	where itemb.pro_com = company.com_id
	group by itemb.pro_com);  #correct
#39. Write a query in SQL to find the first name and last name of employees working for departments which sanction amount is second lowest.
select *
from emp_details
where emp_dept in (
	select dpt_code from (
		select dpt_code, rank() over (order by dpt_allotment asc) rank from emp_department) neednamehere
		where rank = 2);
#user solution
select *
from emp_details
where emp_dept = (
	select dpt_code
	from emp_department
	order by dpt_allotment limit 1 offset 1);





#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
#official solution
select *
from nobel_win
where year = 1970
order by case
	when subject in ('Economics','Chemistry') then 1 else 0 end asc,
subject, winner;

#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#5.Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
select *
from customer
where city <> 'New York'
or grade <= 100;  #RM:  incorrect.  It's a neither nor
select *
from customer
where not (city = 'New York' or grade > 100);  #RM:  correct.  It's neither nor.

#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from customer
where cust_name like 'B%';
#also
select *
from customer
where cust_name between 'A%' and 'C%';
#also
select *
from customer
where cust_name between 'A' and 'C';

#12. Write a SQL statement to find those rows from the table testtable which contain the escape character underscore ( _ ) in its column 'col1'.  #RM:  underscore _ is a wildcard character.
select *
from testtable
where col1 like '%/_%'escape '/';
#RM:  Oracle SQl escape character http://www.dba-oracle.com/t_special_characters_like_sql_query.htm
/*
set escape '\'
select stuff
from mytable
where mycool like '%\_to\_%';
#also
select stuff
from mytable
where mycool like '%\_to\_%' escape '\';
*/

#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance.
select count(grade)
from customer
where grade is not null;
#official solution
select count(all grade)
from customer;  #RM:  works for Oracle?

#23. Write a SQL query to display the average price of each company's products, along with their code.  #groupby group by group-by aggregate function before aggregate function first
select pro_com, avg(pro_price)
from item_mast
group by pro_com;
#also
select avg(pro_price), pro_com
from item_mast
group by pro_com;

#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php
#1. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.  #RM:  concatenate concat combine.  CONCAT() works for two arguments only.
select commission*100 || '%' as "Commission Percentage", salesman_id, name, city
from salesman;

#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
select o.*
from orders o inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on c.city <> s.city;  #incorrect.  Cartesian return.
select o.*
from orders o inner join customer c
and o.customer_id = c.customer_id
inner join salesman s
on s.salesman_id = c.salesman_id
and c.city <> s.city;    #incorrect.  Return nothing.
#official solution
select o.*
from salesman s, customer c, orders o
where c.city <> s.city
and o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;  #correct
#user solution
select o.*
from orders o inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on o.salesman_id = s.salesman_id
where c.city <> s.city;

#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
select o.*, c.*, s.*
from orders o, customer c, salesman s
where o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;  #RM:  printed all orders no duplicate matching columns from two or more tables
#official solution
select *
from orders
natural join customer
natural join salesman;  #user feedback:  Because NATURAL JOIN will compare ALL matched columns (with same column name), in this case both salesman_id and city will take into account, so that only 6 records are left, this is because city column has only three same cities: four records of NY, one London and one Paris.

#14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select s.name, c.cust_name
from salesman s left join customer c
on s.salesman_id = c.salesman_id
left join orders o
on c.customer_id = o.customer_id
where (o.purch_amt >= 2000
and c.grade is not null)
or o.purch_amt is null;

#25. Write a SQL query to display the name of each company along with the ID and price for their most expensive product.
select c.com_name, max(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name;
#official solution
select c.com_name, i.pro_id, i.pro_name, i.pro_price
from company_mast c, item_mast i
where c.com_id = i.pro_com
and i.pro_price = (
	select max(i.pro_price)
	from item_mast i
	where i.pro_com = c.com_id);

#29. Write a query in SQL to find the names of departments where more than two employees are working.
select emp_department.dpt_name, count(emp_details.emp_dept)
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
group by emp_details.emp_dept;  #returns nothing
select emp_department.dpt_name, count(emp_details.emp_dept)
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
group by emp_department.dpt_name
order by 2 desc;  #correct
select emp_department.dpt_name, count(emp_details.emp_dept)
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
group by emp_department.dpt_name
having count(emp_details.emp_dept) > 2
order by 2 desc;  #correct answering question

#https://www.w3resource.com/sql-exercises/subqueries/index.php
#1. Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
select *
from orders
where salesman_id = (
	select salesman_id
	from salesman
	where name = 'Paul Adam');
#also
select o.*
from orders o, salesman s
where o.salesman_id = s.salesman_id
and s.name = 'Paul Adam';

#3. Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007.
select *
from orders
where salesman_id in (
	select salesman_id
	from orders
	where customer_id = 3007));

#11. Write a query to find the name and numbers of all salesmen who had more than one customer.
select salesman_id, name
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) > 1);
#official solution
select salesman_id,name 
from salesman a 
where 1 < (
	select count(*)
	from customer 
	where salesman_id=a.salesman_id);
#also
select s.salesman_id, s.name 
from salesman s
where 1 < (
	select count(*)
	from customer c
	where c.salesman_id=s.salesman_id);

#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.
select *
from orders
where purch_amt > (
	select avg(purch_amt)
	from orders);
#official solution.  Find customer's orders above average for each customer
select * 
from orders a
where purch_amt > (
	select avg(purch_amt)
	from orders b
	where b.customer_id = a.customer_id);

#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
select ord_date, sum(purch_amt)
from orders a
group by ord_date
having sum(purch_amt) > (
	select max(purch_amt) + 1000
	from orders b
	where a.ord_date = b.ord_date);

#16. Write a query to find the salesmen who have multiple customers.
select s.name, c.salesman_id, count(c.salesman_id)
from customer c join salesman s
on c.salesman_id = s.salesman_id
group by s.name, c.salesman_id
having count(c.salesman_id) >= 2;  #correct
#user solution
select *
from salesman s
where 1 < (
	select count(*)
	from customer a
	where s.salesman_id = a.salesman_id);

#18. Write a query that extract the rows of all salesmen who have customers with more than one orders.
select *
from salesman s
where 1 < (
	select count(customer_id)
	from orders o
	where s.salesman_id = o.salesman_id);

#19. Write a query to find salesmen with all information who lives in the city where any of the customers lives.
select distinct s.*
from salesman s, customer c
where s.city = c.city;  #it works
select *
from salesman
where salesman_id in (
	select s.salesman_id
	from salesman s, customer c
	where s.city = c.city);
#official solution
select *
from salesman
where city = any (
	select city
	from customer);

#22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.
select *
from customer
where grade > any (
	select grade
	from customer
	where city < 'New York');

#26. Write a query to display only those customers whose grade are, in fact, higher than every customer in New York.
select *
from customer
where grade > all (
	select grade
	from customer
	where city = 'New York');

#33. Write a SQL query to display the name of each company, price for their most expensive product along with their Name.
select company.com_name, max(item.pro_price)
from item_mast item, company_mast company
where item.pro_com = company.com_id
group by company.com_name;  #partially correct.  Need the product name matching the most expensive product.
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb
	where item.pro_id = itemb.pro_id);  #incorrect.  Returns all items.
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb
	where itemb.pro_com = company.com_id
	group by itemb.pro_com);  #correct

#38. Write a query in SQL to find the names of departments with more than two employees are working.
select *
from emp_department
where dpt_code in (
	select emp_dept
	from emp_details
	group by emp_dept
	having count(emp_dept) > 2);
#also
select *
from emp_department
where 2 < (
	select count(*)
	from emp_details
	where emp_department.dpt_code = emp_details.emp_dept);

#39. Write a query in SQL to find the first name and last name of employees working for departments which sanction amount is second lowest.
select *
from emp_details
where emp_dept in (
	select dpt_code from (
		select dpt_code, rank() over (order by dpt_allotment asc) rank from emp_department) neednamehere
		where rank = 2);
#user solution
select *
from emp_details
where emp_dept = (
	select dpt_code
	from emp_department
	order by dpt_allotment limit 1 offset 1);

#https://www.w3resource.com/sql-exercises/union/sql-union.php
#5. Write a query to make a report of which salesman produce the largest and smallest orders on each date and arranged the orders number in smallest to the largest number.
select o.ord_no, s.name, o.purch_amt, 'highest on', o.ord_date
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select max(o2.purch_amt)
	from orders o2
	where o2.ord_date = o.ord_date)
union
(select o.ord_no, s.name, o.purch_amt, 'lowest on', o.ord_date
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select min(o2.purch_amt)
	from orders o2
	where o2.ord_date = o.ord_date))
order by ord_no;  #RM:  Exclude the table alias at the order by statement.  Column in order by statement must be included in select statement.  And Order By . . . limit 1 statement doesn't work in union.  Use subquery.

#6. Write a query to list all the salesmen, and indicate those who do not have customers in their cities, as well as whose who do.
#official solution
select salesman.salesman_id, name, cust_name, commission
from salesman, customer
where salesman.city = customer.city
union
(select salesman_id, name, 'no match', commission
from salesman
where not city = any
	(select city
	from customer))
order by 2 desc;
#user solution
select s.salesman_id, name, s.city as "Salesman City", c.city as "Customer City", commission, customer_id
from salesman s join customer c
on s.city=c.city
union
(select s.salesman_id, name, 'NO MATCH', c.city as "Customer City", commission, customer_id
from salesman s join customer c
on s.salesman_id = c.salesman_id
and s.city<>c.city);

#9. Write a command that produces the name and number of each salesman and each customer with more than one current order. Put the results in alphabetical order.
#customers with more than one order 3002, 3009, 3005
select c.customer_id, c.cust_name
from customer c
where c.customer_id in (
	select customer_id
	from orders
	group by customer_id
	having count(customer_id) > 1);
#salesman with more than one order 5002, 5003, 5001
select s.salesman_id, s.name
from salesman s
where s.salesman_id in (
	select salesman_id
	from orders
	group by salesman_id
	having count(salesman_id) > 1);
#union
select c.customer_id as "ID Number", c.cust_name as "Name", 'Customer'
from customer c
where c.customer_id in (
	select customer_id
	from orders
	group by customer_id
	having count(customer_id) > 1)
union
(select s.salesman_id, s.name, 'Salesman'
from salesman s
where s.salesman_id in (
	select salesman_id
	from orders
	group by salesman_id
	having count(salesman_id) > 1))
order by 2 asc;

#https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php
#8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.  length, len, count character count characters count string count
select emp_name, length(trim(emp_name))
from employees;

#29. Write a query in SQL to list the id, name, salary, and experience of all the employees who earn more than 100 as daily salary.  RM:  salary must be monthly.  Also, looked up solution for experience.
select emp_id, emp_name, salary, age(current_date, hire_date) "Experience"
from employees
where (salary/30) > 100;

#30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period.
#official solution
select emp_name
from employees
where hire_date + interval '96 months' > '1999-12-31';
#user solution which makes sense
select *
from employees
where age('1999-12-31', hire_date) > '8 years';