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

#https://www.w3resource.com/sql-exercises/joins-hr/index.php
#bonus
#self join all employees and his or her manager or no manager
select e.employee_id, e.first_name, e.last_name, manager.employee_id as "manager's employee id", manager.first_name as "manager first name", manager.last_name as "manager last name"
from employees e left outer join employees manager
on e.manager_id = manager.employee_id;
/*
employee_id	first_name	last_name	manager's employee id	manager first name	manager last name
100	Steven	King			
101	Neena	Kochhar	100	Steven	King
102	Lex	De Haan	100	Steven	King
103	Alexander	Hunold	102	Lex	De Haan
104	Bruce	Ernst	103	Alexander	Hunold
105	David	Austin	103	Alexander	Hunold
106	Valli	Pataballa	103	Alexander	Hunold
107	Diana	Lorentz	103	Alexander	Hunold
108	Nancy	Greenberg	101	Neena	Kochhar
109	Daniel	Faviet	108	Nancy	Greenberg
110	John	Chen	108	Nancy	Greenberg
111	Ismael	Sciarra	108	Nancy	Greenberg
112	Jose Manuel	Urman	108	Nancy	Greenberg
113	Luis	Popp	108	Nancy	Greenberg
114	Den	Raphaely	100	Steven	King
115	Alexander	Khoo	114	Den	Raphaely
116	Shelli	Baida	114	Den	Raphaely
117	Sigal	Tobias	114	Den	Raphaely
118	Guy	Himuro	114	Den	Raphaely
119	Karen	Colmenares	114	Den	Raphaely
120	Matthew	Weiss	100	Steven	King
121	Adam	Fripp	100	Steven	King
122	Payam	Kaufling	100	Steven	King
123	Shanta	Vollman	100	Steven	King
124	Kevin	Mourgos	100	Steven	King
125	Julia	Nayer	120	Matthew	Weiss
126	Irene	Mikkilineni	120	Matthew	Weiss
127	James	Landry	120	Matthew	Weiss
128	Steven	Markle	120	Matthew	Weiss
129	Laura	Bissot	121	Adam	Fripp
130	Mozhe	Atkinson	121	Adam	Fripp
*/

#7. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
select first_name, last_name, salary
from employees
where salary < (
	select salary
	from employees
	where employee_id = 182);
#also using joins
select e.first_name, e.last_name, e.salary
from employees e join employees salary182
on e.salary < salary182.salary
and salary182.employee_id = 182;
/*
first_name	last_name	salary
James		Landry		2400.00
Steven		Markle		2200.00
TJ		Olson		2100.00
Ki		Gee		2400.00
Hazel		Philtanker	2200.00
*/

#12. Write a query in SQL to display the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
select first_name, last_name, department_id
from employees
where department_id in (
	select department_id
	from employees
	where last_name = 'Taylor');
#also using joins
select e.first_name, e.last_name, e.department_id
from employees e join employees taylor
on e.department_id = taylor.department_id
and taylor.last_name = 'Taylor';
/*
first_name	last_name	department_id
Matthew	Weiss	50
Adam	Fripp	50
Payam	Kaufling	50
Shanta	Vollman	50
Kevin	Mourgos	50
Julia	Nayer	50
Irene	Mikkilineni	50
James	Landry	50
Steven	Markle	50
Laura	Bissot	50
Mozhe	Atkinson	50
James	Marlow	50
TJ	Olson	50
Jason	Mallin	50
Michael	Rogers	50
Ki	Gee	50
Hazel	Philtanker	50
Renske	Ladwig	50
Stephen	Stiles	50
John	Seo	50
Joshua	Patel	50
Trenna	Rajs	50
Curtis	Davies	50
Randall	Matos	50
Peter	Vargas	50
John	Russell	80
Karen	Partners	80
Alberto	Errazuriz	80
Gerald	Cambrault	80
Eleni	Zlotkey	80
Peter	Tucker	80
David	Bernstein	80
...
*/

#25. Write a query in SQL to display full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
#partially correct because wanted the last job
select e.first_name, e.last_name, j.job_title, job_history.start_date, job_history.end_date
from employees e join job_history
on e.employee_id = job_history.employee_id
join jobs j
on job_history.job_id = j.job_id
where e.commission_pct = 0;
/*
first_name	last_name	job_title	start_date	end_date
Jennifer	Whalen	Administration Assistant	1995-09-17	2001-06-17
Neena	Kochhar	Accounting Manager	2001-10-28	2005-03-15
Jennifer	Whalen	Public Accountant	2002-07-01	2006-12-31
Neena	Kochhar	Public Accountant	1997-09-21	2001-10-27
Payam	Kaufling	Stock Clerk	2007-01-01	2007-12-31
Den	Raphaely	Stock Clerk	2006-03-24	2007-12-31
Lex	De Haan	Programmer	2001-01-13	2006-07-24
Michael	Hartstein	Marketing Representative	2004-02-17	2007-12-19
*/
#official solution
select concat(e.first_name, ' ', e.last_name) as employee_name, j.job_title, h.*
from employees e join (
	select max(start_date), max(end_date), employee_id
	from job_history
	group by employee_id) h
	on e.employee_id=h.employee_id
join jobs j
on j.job_id=e.job_id
where e.commission_pct = 0;
/*
employee_name		job_title			starting_date	ending_date	employee_id
Neena Kochhar		Administration Vice President	2001-10-28	2005-03-15	101
Lex De Haan		Administration Vice President	2001-01-13	2006-07-24	102
Den Raphaely		Purchasing Manager		2006-03-24	2007-12-31	114
Payam Kaufling		Stock Manager			2007-01-01	2007-12-31	122
Jennifer Whalen		Administration Assistant	2002-07-01	2006-12-31	200
Michael Hartstein	Marketing Manager		2004-02-17	2007-12-19	201
*/
#user solution
select e.first_name, e.last_name, j.job_title. h.start_date, h.end_date
from jobs j join job_history h
on h.job_id = j.job_id
join employees e
on e.employee_id = h.employee_id
where e.commission_pct = 0
and h.start_date = (
	select max(start_date)
	from job_history h1
	where h.employee_id = h1.employee_id);
/* can't confirm user solution works */

#https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php
#3. Write a query to display the name ( first name and last name ), salary, department id for those employees who earn such amount of salary which is the smallest salary of any of the departments.  RM:  question doesn't make sense.  Looked at solution.  Find employees who earn any of the minimum salaries in all departments
select first_name, last_name, salary, department_id
from employees
where salary in (
	select min(salary)
	from employees
	group by department_id);
/*
first_name	last_name	salary	department_id
Neena		Kochhar		17000.00	90
Lex		De Haan		17000.00	90
Bruce		Ernst		6000.00		60
Diana		Lorentz		4200.00		60
Luis		Popp		6900.00		100
Karen		Colmenares	2500.00		30
Shanta		Vollman		6500.00		50
James		Marlow		2500.00		50
TJ		Olson		2100.00		50
Joshua		Patel		2500.00		50
Peter		Vargas		2500.00		50
Peter		Tucker		10000.00	80
Oliver		Tuvault		7000.00		80
Janette		King		10000.00	80
Sarath		Sewall		7000.00		80
Harrison	Bloom		10000.00	80
Sundita		Kumar		6100.00		80
Kimberely	Grant		7000.00		0
Martha		Sullivan	2500.00		50
Nandita		Sarchand	4200.00		50
Randall		Perkins		2500.00		50
Jennifer	Whalen		4400.00		10
Pat		Fay		6000.00		20
Susan		Mavris		6500.00		40
Hermann		Baer		10000.00	70
William		Gietz		8300.00		110
*/

#21. Write a query to display the employee name( first name and last name ) and department for all employees for any existence of those employees whose salary is more than 3700.
select first_name, last_name, department_id
from employees
where exists (
	select *
	from employees
	where salary > 3700);

#23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.  RM:  display salary after job_id.  if then if then else.
select employee_id, first_name, last_name, case job_id when 'ST_MAN' then 'SALESMAN' when 'IT_PROG' THEN 'DEVELOPER' else job_id end as "title designation", salary
from employees;

#24. Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
select employee_id, first_name, last_name, salary, case salary when salary > (
	select avg(salary)
	from employees) then 'HIGH'
when salary < (
	select avg(salary)
	from employees) then 'LOW'
else 'ON_PAR' end as "SalaryStatus"
from employees;

#25. Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
select employee_id, first_name, last_name, salary as SalaryDrawn, salary - (
	select avg(salary)
	from employees) as AvgCompare,
case salary when salary >= (
	select avg(salary)
	from employees) then 'HIGH'
else 'LOW' end as SalaryStatus
from employees;

#31. Write a query which is looking for the names of all employees whose salary is greater than 50% of their department’s total salary bill.
select e1.first_name, e1.last_name
from employees e1
where e1.salary > (
	select sum(e2.salary)*.5
	from employees e2
	where e1.department_id = e2.department_id);

#34. Write a query to display the employee id, name ( first name and last name ), salary, department name and city for all the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.
select e.employee_id, e.first_name, e.last_name, e.salary, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.salary > (
	select max(e2.salary)
	from employees e2
	where e2.hiredate between '2002-01-01' and '2003-12-31');
#also?
select e.employee_id, e.first_name, e.last_name, e.salary, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.salary > (
	select e2.salary
	from employees e2
	where e2.hiredate between '2002-01-01' and '2003-12-31'
	order by e2.salary desc limit 1);  #Can't confirm.

