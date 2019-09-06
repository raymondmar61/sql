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

#111. Write a query in SQL to list the employees whose ID not starting with digit 68.
select *
from employees
where emp_id < 68000 or emp_id >= 69000;
#official solution #convert number to text
select emp_id, trim(to_char(emp_id,'99999'))
from employees
where trim(to_char(emp_id,'99999')) not like '68%';
#user solution
select *
from employees
where cast(emp_id as varchar) not like '68%';
#29. Write a query in SQL to list the details of the departments where maximum number of employees are working.  #RM:  question asks highest number of employees
select *
from department
where dep_id = (
	select dep_id
	from employees
	group by dep_id
	having max(count(emp_id)));  #incorrect
select dep_id, count(dep_id)
from employees
group by dep_id;
/*
dep_id	count
1001	3
3001	6
2001	5
*/
select count(dep_id)
from employees
group by dep_id;
/*
count
3
6
5
*/
select max(alias1)
from (
	select count(dep_id) alias1
	from employees
	group by dep_id) alias2;
/*
max
6
*/
select *
from department
where dep_id = (
	select dep_id
	from department
	group by dep_id
	having count(*) = (
		select max(alias1)
		from (
			select count(e.dep_id) alias1
			from employees e
			group by e.dep_id) alias2));  #incorrect.  first subquery department is incorrect.
select *
from department
where dep_id = (
	select dep_id
	from employees
	group by dep_id
	having count(dep_id) = (
		select max(alias1)
		from (
			select count(e.dep_id) alias1
			from employees e
			group by e.dep_id) alias2));  #correct.  first subquery employees is correct.
#user solution
select dep_name, count(emp_id)
from employees e join department d
on e.dep_id=d.dep_id
group by dep_name
having count(emp_id) >= all(
  select count(emp_id)
  from employees e join department d
  on e.dep_id=d.dep_id
  group by dep_name);

#38. Write a query in SQL to find out the least 5 earners of the company.
select *
from employees
where salary in (
	select salary
	from employees
	order by salary limit 5 offset 0);
#user solution
select *
from employees
where salary in (
	select salary from (
		select salary, rank() over (order by salary asc) rank from employees) neednamehere
		where rank <= 5);
#40. Write a query in SQL to list the name, salary, commission and netpay for those employees whose netpay is more than any other employee.  #RM:  dumb question; however, learned another SQL technique.
#official solution.
/*
 emp_name | salary  | commission | netpay
----------+---------+------------+---------
 KAYLING  | 6000.00 |            | 8500.00
 BLAZE    | 2750.00 |            | 8500.00
 CLARE    | 2550.00 |            | 8500.00
 JONAS    | 2957.00 |            | 8500.00
 SCARLET  | 3100.00 |            | 8500.00
 FRANK    | 3100.00 |            | 8500.00
 SANDRINE |  900.00 |            | 8500.00
 ADELYN   | 1700.00 |     400.00 | 8500.00
 WADE     | 1350.00 |     600.00 | 8500.00
 MADDEN   | 1350.00 |    1500.00 | 8500.00
 TUCKER   | 1600.00 |       0.00 | 8500.00
 ADNRES   | 1200.00 |            | 8500.00
 JULIUS   | 1050.00 |            | 8500.00
 MARKER   | 1400.00 |            | 8500.00
(14 rows)
*/
select e.emp_name, e.salary, e.commission, (
	select sum(salary+commission)
	from employees) as "netpay"
from employees e
where (
	select sum(salary+commission)
	from employees) > any (
		select salary
		from employees
		where emp_id=e.emp_id);
#user solution
select emp_name, salary, commission, (
	select sum(salary+commission)
	from employees)
from employees;

#41. Write a query in SQL to list the name of the department where number of employees is equal to the number of characters in the department name.
/*
dep_id	count
1001	3
3001	6
2001	5
*/
select dep_id, count(*)
from employees
group by dep_id;
/*
dep_name
AUDIT
*/
select dep_name
from department
where length(dep_name) = any (
	select count(*)
	from employees
	group by dep_id);
#official solution
select d.dep_name, count(*)
from employees e, department d
where e.dep_id = d.dep_id
group by d.dep_name
having count(*) = length (d.dep_name);

#49. Write a query in SQL to list the name of the employees for their manager JONAS and also the name of the manager of JONAS.
/*
employee	manager
JONAS	KAYLING
SCARLET	JONAS
FRANK	JONAS
*/
select e.emp_name as "employee", m.emp_name as "manager"
from employees e join employees m
on e.manager_id = m.emp_id
where m.emp_name = 'JONAS'
or e.emp_name = 'JONAS';
/*
employee	manager	JONAS manager
SCARLET	JONAS	KAYLING
FRANK	JONAS	KAYLING
*/
select e.emp_name as "employee", m.emp_name as "manager", (
	select m2.emp_name
	from employees e2 join employees m2
	on e2.manager_id = m2.emp_id
	where e2.emp_name = 'JONAS') as "JONAS manager"
from employees e join employees m
on e.manager_id = m.emp_id
where m.emp_name = 'JONAS';

#52. Write a query in SQL to find the most recently hired [employees] in each department order by hire_date.
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
68736	ADNRES	CLERK	67858	1997-05-23	1200.00		2001
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001
69000	JULIUS	CLERK	66928	1991-12-03	1050.00		3001
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001
*/
select *
from employees
where hire_date in (
	select max(hire_date)
	from employees
	group by dep_id)
order by hire_date desc;  #incorrect.  Frank in dep_id 2001 is incorrect.  Adnres in dep_id 2001 is correct.
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
68736	ADNRES	CLERK	67858	1997-05-23	1200.00		2001
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001
69000	JULIUS	CLERK	66928	1991-12-03	1050.00		3001
*/
select *
from employees e1
where e1.hire_date in (
	select max(e2.hire_date)
	from employees e2
	where e1.dep_id=e2.dep_id)
order by e1.hire_date desc;  #correct.

#53. Write a query in SQL to list the name,salary, and department id for each employee who earns a salary greater than the average salary for their department and list the result in ascending order on department id.
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
68319	KAYLING	PRESIDENT		1991-11-18	6000.00		1001
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001
67858	SCARLET	ANALYST	65646	1997-04-19	3100.00		2001
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001
*/
select e1.*
from employees e1
where e1.salary > (
	select avg(e2.salary)
	from employees e2
	where e1.dep_id=e2.dep_id)
order by e1.dep_id;






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
#RM:  age(current_date, hire_date) returns data like 27 years 8 mons 21 days

#30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period.
#official solution
select emp_name
from employees
where hire_date + interval '96 months' > '1999-12-31';
#user solution which makes sense
select *, age('1999-12-31',hire_date)
from employees
where age('1999-12-31',hire_date) > '8 years';
#RM:  age('1999-12-31',hire_date) returns data like 8 years 1 mon 13 days or 9 years 13 days

#34. Write a query in SQL to list the employees those who joined in company before 19th of the month.  RM:  to_char(hire_date, 'dd') extracts the date number, to_number(to_char(hire_date, 'dd'),'99') converts date number to a two digit or one digit number.
select *, to_number(to_char(hire_date, 'dd'),'99') as "extract day number convert to number"
from employees
where to_number(to_char(hire_date, 'dd'),'99') < 19;
#official solution
select *
from employees
where to_char(hire_date,'dd') < '19';  #we run comparisons with numbers converted to string
#user solution
select *
from employees
where extract(day from age(current_date, hire_date)) < 19;
#reference extract(day from age(current_date, hire_date))
select hire_date, age(current_date, hire_date), extract(day from age(current_date, hire_date))
from employees;
'''
hire_date	age	date_part
1991-11-18	27 years 8 mons 21 days	21
1991-05-01	28 years 3 mons 8 days	8
1991-06-09	28 years 2 mons	0
1991-04-02	28 years 4 mons 7 days	7
1991-02-20	28 years 5 mons 17 days	17
1991-02-22	28 years 5 mons 15 days	15
1991-09-28	27 years 10 mons 11 days	11
1991-09-08	27 years 11 mons 1 day	1
1997-05-23	22 years 2 mons 17 days	17
1991-12-03	27 years 8 mons 6 days	6
1992-01-23	27 years 6 mons 17 days	17
1997-04-19	22 years 3 mons 20 days	20
1991-12-03	27 years 8 mons 6 days	6
1990-12-18	28 years 7 mons 22 days	22
'''

#48. Write a query in SQL to list the employees who joined in 90's.
select *
from employees
where to_char(hire_date,'yyyy') >= '1990'
and to_char(hire_date,'yyyy') <= '1999';
#also
select *
from employees
where to_char(hire_date,'yyyy') between '1990' and '1999';
#also
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31';

#51. Write a query in SQL to list all the employees who joined before or after 1991.
select *
from employees
where hire_date <= '1990-12-31'
and hire_date >= '1992-01-01';  #returns nothing
#use union
select *
from employees
where hire_date <= '1990-12-31'
union
(select *
from employees
where hire_date >= '1992-01-01');  #returns correct rows
#also
select *
from employees
where to_char(hire_date,'yyyy') <> '1991';

#53. Write a query in SQL to list the name, job name, annual salary, department id, department name and grade of the employees who earn 60000 in a year or not working as an ANALYST.
select e.emp_name, e.job_name, e.salary*12 as "annual salary", e.dep_id, d.dep_name, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.salary*12 >= 60000
or e.job_name <> 'ANALYST';

#91. Write a query in SQL to find the average salary and average total remuneration(salary and commission) for each type of job.  #RM:  must label columns to return the two averages. 
select job_name, round(avg(salary),2) as "average salary", round(avg(salary+commission),2) as "average salary plus commission"
from employees
group by job_name;

#111. Write a query in SQL to list the employees whose ID not starting with digit 68.
select *
from employees
where emp_id < 68000 or emp_id >= 69000;
#official solution #convert number to text
select emp_id, trim(to_char(emp_id,'99999'))
from employees
where trim(to_char(emp_id,'99999')) not like '68%';
#user solution
select *
from employees
where cast(emp_id as varchar) not like '68%';


#https://www.w3resource.com/sql-exercises/employee-database-exercise/subqueries-exercises-on-employee-database.php
#4. Write a query in SQL to display the employee ID, name, salary, department name, location, department ID, job name of all the employees working at SYDNEY or working in the FINANCE deparment with an annual salary above 28000, but the monthly salary should not be 3000 or 2800 and who does not works as a MANAGER and whose ID containing a digit of '3' or '7' in 3rd position. List the result in ascending order of department ID and descending order of job name.
select e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, d.dep_id, e.job_name
from employees e join department d
on e.dep_id = d.dep_id
where (d.dep_location in ('SYDNEY')
or d.dep_name in ('FINANCE'))
and (e.salary > 28000/12
and e.salary not in (3000, 2800))
and e.job_name not in ('MANAGER')
and (trim(to_char(e.emp_id,'99999')) like '__3%'
or trim(to_char(e.emp_id,'99999')) like '__7%')
order by d.dep_id, e.job_name desc;  #RM:  wild card like search numbers convert to string wild card number wild card search number

#5. Write a query in SQL to list all the employees of grade 2 and 3.
select *
from employees
where salary between (
	select min_sal
	from salary_grade
	where grade = 2)
and (
	select max_sal
	from salary_grade
	where grade = 3);
#29. Write a query in SQL to list the details of the departments where maximum number of employees are working.  #RM:  question asks highest number of employees
select *
from department
where dep_id = (
	select dep_id
	from employees
	group by dep_id
	having max(count(emp_id)));  #incorrect
select dep_id, count(dep_id)
from employees
group by dep_id;
/*
dep_id	count
1001	3
3001	6
2001	5
*/
select count(dep_id)
from employees
group by dep_id;
/*
count
3
6
5
*/
select max(alias1)
from (
	select count(dep_id) alias1
	from employees
	group by dep_id) alias2;
/*
max
6
*/
select *
from department
where dep_id = (
	select dep_id
	from department
	group by dep_id
	having count(*) = (
		select max(alias1)
		from (
			select count(e.dep_id) alias1
			from employees e
			group by e.dep_id) alias2));  #incorrect.  first subquery department is incorrect.
select *
from department
where dep_id = (
	select dep_id
	from employees
	group by dep_id
	having count(dep_id) = (
		select max(alias1)
		from (
			select count(e.dep_id) alias1
			from employees e
			group by e.dep_id) alias2));  #correct.  first subquery employees is correct.
#user solution
select dep_name, count(emp_id)
from employees e join department d
on e.dep_id=d.dep_id
group by dep_name
having count(emp_id) >= all(
  select count(emp_id)
  from employees e join department d
  on e.dep_id=d.dep_id
  group by dep_name);

#33. Write a query in SQL to list the name of the employees who are getting the highest salary of each department.
select dep_id, max(salary)
from employees
group by dep_id;
select emp_name, salary
from employees
group by emp_name, salary
having max(salary) in (
	select max(salary)
	from employees
	group by dep_id);
#official solution and a user solution
select emp_name, dep_id
from employees
where salary in (
	select max(salary)
	from employees
	group by dep_id);

#36. Write a query in SQL to list the employees whose salary is less than the salary of his manager but more than the salary of any other manager.
#copied solution
select *
from employees e, employees m
where e.manager_id = m.emp_id
and e.salary < m.salary
and e.salary > any (
	select salary
	from employees
	where emp_id in (
		select manager_id
		from employees));

#37. Write a query in SQL to list the name and average salary of employees in department wise.
#copied solution
select e.emp_name, d.maxsal, e.dep_id as "current salary"
from employees e, (
	select avg(salary) maxsal, dep_id
	from employees
	group by dep_id) d
where e.dep_id=d.dep_id;
#user solution
select emp_id, emp_name, b.dep_id, avg
from employees a left join (
	select avg(salary), dep_id
	from employees group by dep_id) b
on a.dep_id=b.dep_id;
select a.emp_id, a.emp_name, a.dep_id, b.avg a 
from employees a join (
	select dep_id, avg(salary)
	from employees
	group by dep_id) b
on a.dep_id=b.dep_id;

#38. Write a query in SQL to find out the least 5 earners of the company.
select *
from employees
where salary in (
	select salary
	from employees
	order by salary limit 5 offset 0);
#user solution
select *
from employees
where salary in (
	select salary from (
		select salary, rank() over (order by salary asc) rank from employees) neednamehere
		where rank <= 5);

#40. Write a query in SQL to list the name, salary, commission and netpay for those employees whose netpay is more than any other employee.  #RM:  dumb question; however, learned another SQL technique.
#official solution.
/*
 emp_name | salary  | commission | netpay
----------+---------+------------+---------
 KAYLING  | 6000.00 |            | 8500.00
 BLAZE    | 2750.00 |            | 8500.00
 CLARE    | 2550.00 |            | 8500.00
 JONAS    | 2957.00 |            | 8500.00
 SCARLET  | 3100.00 |            | 8500.00
 FRANK    | 3100.00 |            | 8500.00
 SANDRINE |  900.00 |            | 8500.00
 ADELYN   | 1700.00 |     400.00 | 8500.00
 WADE     | 1350.00 |     600.00 | 8500.00
 MADDEN   | 1350.00 |    1500.00 | 8500.00
 TUCKER   | 1600.00 |       0.00 | 8500.00
 ADNRES   | 1200.00 |            | 8500.00
 JULIUS   | 1050.00 |            | 8500.00
 MARKER   | 1400.00 |            | 8500.00
(14 rows)
*/
select e.emp_name, e.salary, e.commission, (
	select sum(salary+commission)
	from employees) as "netpay"
from employees e
where (
	select sum(salary+commission)
	from employees) > any (
		select salary
		from employees
		where emp_id=e.emp_id);
#user solution
select emp_name, salary, commission, (
	select sum(salary+commission)
	from employees)
from employees;

#41. Write a query in SQL to list the name of the department where number of employees is equal to the number of characters in the department name.
/*
dep_id	count
1001	3
3001	6
2001	5
*/
select dep_id, count(*)
from employees
group by dep_id;
/*
dep_name
AUDIT
*/
select dep_name
from department
where length(dep_name) = any (
	select count(*)
	from employees
	group by dep_id);
#official solution
select d.dep_name, count(*)
from employees e, department d
where e.dep_id = d.dep_id
group by d.dep_name
having count(*) = length(d.dep_name);

#49. Write a query in SQL to list the name of the employees for their manager JONAS and also the name of the manager of JONAS.
/*
employee	manager
JONAS	KAYLING
SCARLET	JONAS
FRANK	JONAS
*/
select e.emp_name as "employee", m.emp_name as "manager"
from employees e join employees m
on e.manager_id = m.emp_id
where m.emp_name = 'JONAS'
or e.emp_name = 'JONAS';
/*
employee	manager	JONAS manager
SCARLET	JONAS	KAYLING
FRANK	JONAS	KAYLING
*/
select e.emp_name as "employee", m.emp_name as "manager", (
	select m2.emp_name
	from employees e2 join employees m2
	on e2.manager_id = m2.emp_id
	where e2.emp_name = 'JONAS') as "JONAS manager"
from employees e join employees m
on e.manager_id = m.emp_id
where m.emp_name = 'JONAS';

#50. Write a query in SQL to find all the employees who earn the minimum salary for a designation and arrange the list in ascending order on salary.  #RM:  designation is job_name.
select *
from employees
where salary in (
	select min(salary)
	from employees
	group by job_name)
order by salary asc;
#also
select e1.*
from employees e1
where e1.salary in (
	select min(e2.salary)
	from employees e2
	where e1.job_name = e2.job_name)
order by e1.salary asc;

#51. Write a query in SQL to find all the employees who earn the highest salary for a designation and arrange the list in descending order on salary.  #RM:  designation is job_name.
select *
from employees
where salary in (
	select max(salary)
	from employees
	group by job_name)
order by salary desc;
#also
select e1.*
from employees e1
where e1.salary in (
	select max(e2.salary)
	from employees e2
	where e1.job_name = e2.job_name)
order by e1.salary desc;

#52. Write a query in SQL to find the most recently hired [employees] in each department order by hire_date.
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
68736	ADNRES	CLERK	67858	1997-05-23	1200.00		2001
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001
69000	JULIUS	CLERK	66928	1991-12-03	1050.00		3001
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001
*/
select *
from employees
where hire_date in (
	select max(hire_date)
	from employees
	group by dep_id)
order by hire_date desc;  #incorrect.  Frank in dep_id 2001 is incorrect.  Adnres in dep_id 2001 is correct.
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
68736	ADNRES	CLERK	67858	1997-05-23	1200.00		2001
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001
69000	JULIUS	CLERK	66928	1991-12-03	1050.00		3001
*/
select *
from employees e1
where e1.hire_date in (
	select max(e2.hire_date)
	from employees e2
	where e1.dep_id=e2.dep_id)
order by e1.hire_date desc;  #correct.

#53. Write a query in SQL to list the name,salary, and department id for each employee who earns a salary greater than the average salary for their department and list the result in ascending order on department id.
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
68319	KAYLING	PRESIDENT		1991-11-18	6000.00		1001
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001
67858	SCARLET	ANALYST	65646	1997-04-19	3100.00		2001
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001
*/
select e1.*
from employees e1
where e1.salary > (
	select avg(e2.salary)
	from employees e2
	where e1.dep_id=e2.dep_id)
order by e1.dep_id;

#57. Write a query in SQL to list the department id, name, designation, salary, and net salary of the employees only who gets a commission and earn the second highest earnings.
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001
65271	WADE	SALESMAN	66928	1991-02-22	1350.00	600.00	3001
66564	MADDEN	SALESMAN	66928	1991-09-28	1350.00	1500.00	3001
68454	TUCKER	SALESMAN	66928	1991-09-08	1600.00	0.00	3001
*/
select *
from employees
where salary+commission in (
	select salary+commission from (
		select salary+commission, rank () over (order by salary+commission desc) from employees where commission is not null) neednamehere
		where rank=2);  #incorrect
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001
*/
select *
from employees
where emp_id in (
	select emp_id from (
		select emp_id, salary+commission, rank () over (order by salary+commission desc) from employees where commission is not null) neednamehere
		where rank=2);  #correct
select *
from employees
where emp_id in (
	select emp_id from (
		select emp_id, salary+commission, rank () over (order by salary+commission desc) from employees where job_name = 'SALESMAN') neednamehere
		where rank=2);  #also correct

#68. Write a query in SQL to list the employees whose salary is same as any one of the employee.
/* returns all rows */
select *
from employees
where salary = any (
	select s2.salary
	from employees s2);
/* returns no rows */
select samesalary.*
from employees all, employees samesalary
where all.salary = samesalary.salary;
/* returns no rows */
select *
from employees all join employees samesalary
on all.salary = samesalary.salary;
/* returns all employees no duplicates */
select distinct e1.emp_id, e1.salary
from employees e1, employees e2
where e1.salary = e2.salary;
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
65271	WADE	SALESMAN	66928	1991-02-22	1350.00	600.00	3001
66564	MADDEN	SALESMAN	66928	1991-09-28	1350.00	1500.00	3001
67858	SCARLET	ANALYST	65646	1997-04-19	3100.00		2001
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001
*/
/*official solution */
select *
from employees
where salary in	(
	select salary
	from employees e
	where employees.emp_id <> e.emp_id);
/* analysis paralysis.  Easy question */
select *
from employees
where salary in (
	select salary
	from employees
	group by salary
	having count(salary) > 1);

