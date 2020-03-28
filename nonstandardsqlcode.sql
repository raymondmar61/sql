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

#37. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
select *
from employees
where salary > (
	select max(salary)
	from employees
	where department_id = 40);
#official solution
select *
from employees
where salary > all (
	select salary
	from employees
	where department_id = 40);

#42. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
select *
from employees
where salary > (
	select min(salary)
	from employees
	where department_id = 40);
#also
select *
from employees
where salary > any (
	select salary
	from employees
	where department_id = 40);

#44. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
select *
from employees
where salary < (
	select min(salary)
	from employees
	where department_id = 70);
#also
select *
from employees
where salary < all (
	select salary
	from employees
	where department_id = 70);

#48. Write a query in SQL to display the the details of those departments which max salary is 7000 or above for those employees who already done one or more jobs.  #RM:  solution wants employees doing two or more jobs.  The maximum salary for each department is greater than 7000.
select *
from departments
where department_id in (
	select department_id
	from employees
	where employee_id in (
		select employee_id
		from job_history
		group by employee_id
		having count(employee_id) > 1)
	group by department_id
	having max(salary) > 7000);
/*
department_id	department_name	manager_id	location_id
80		Sales		145		2500
90		Executive	 100	1700
*/
#also
select *
from departments
where department_id in (
	select department_id
	from employees
	where employee_id in (
		select employee_id
		from job_history
		group by employee_id
		having count(employee_id) > 1)
	and department_id in (
		select department_id
		from employees
		group by department_id
		having max(salary) > 7000));

#52. Write a query in SQL to display all the infromation about those employees who earn second lowest salary of all the employees.
select *
from employees
where salary = (
	select salary
	from employees
	order by salary limit 1 offset 1);
#also
select * from (
	select rank() over (order by salary asc) ranknumber from employees) neednamehere
	where ranknumber = 2;
/*
ranknumber
2
2
*/
select * from (
	select rank() over (order by salary asc) rank, * from employees) as neednamehere
	where rank = 2;  #correct
/*
rank	employee_id	first_name	last_name	email	phone_number	hire_date	job_id	salary	commission_pct	manager_id	department_id
2	128	Steven	Markle	SMARKLE	650.124.1434	2008-03-08	ST_CLERK	2200.00	0.00	120	50
2	136	Hazel	Philtanker	HPHILTAN	650.127.1634	2008-02-06	ST_CLERK	2200.00	0.00	122	50
*/
select * from (select rank() over (order by salary asc) as RO, salary, * from employees) as a
where a.RO = 2; #user solution
/*
ro	salary	employee_id	first_name	last_name	email	phone_number	hire_date	job_id	commission_pct	manager_id	department_id
2	2200.00	128	Steven	Markle	SMARKLE	650.124.1434	2008-03-08	ST_CLERK	0.00	120	50
2	2200.00	136	Hazel	Philtanker	HPHILTAN	650.127.1634	2008-02-06	ST_CLERK	0.00	122	50
*/

#54. Write a query in SQL to display the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.  #RM:  find the employee who earns the highest salary in his or her department.
select *
from employees
where salary in (
	select max(salary)
	from employees
	group by department_id); #incorrect
/*
employee_id	first_name	last_name	email	phone_number	hire_date	job_id	salary	commission_pct	manager_id	department_id
100	Steven	King	SKING	515.123.4567	2003-06-17	AD_PRES	24000.00	0.00	0	90
103	Alexander	Hunold	AHUNOLD	590.423.4567	2006-01-03	IT_PROG	9000.00	0.00	102	60
108	Nancy	Greenberg	NGREENBE	515.124.4569	2002-08-17	FI_MGR	12000.00	0.00	101	100
109	Daniel	Faviet	DFAVIET	515.124.4169	2002-08-16	FI_ACCOUNT	9000.00	0.00	108	100
110	John	Chen	JCHEN	515.124.4269	2005-09-28	FI_ACCOUNT	8200.00	0.00	108	100
114	Den	Raphaely	DRAPHEAL	515.127.4561	2002-12-07	PU_MAN	11000.00	0.00	100	30
121	Adam	Fripp	AFRIPP	650.123.2234	2005-04-10	ST_MAN	8200.00	0.00	100	50
123	Shanta	Vollman	SVOLLMAN	650.123.4234	2005-10-10	ST_MAN	6500.00	0.00	100	50
145	John	Russell	JRUSSEL	011.44.1344.429268	2004-10-01	SA_MAN	14000.00	0.40	100	80
147	Alberto	Errazuriz	AERRAZUR	011.44.1344.429278	2005-03-10	SA_MAN	12000.00	0.30	100	80
148	Gerald	Cambrault	GCAMBRAU	011.44.1344.619268	2007-10-15	SA_MAN	11000.00	0.30	100	80
150	Peter	Tucker	PTUCKER	011.44.1344.129268	2005-01-30	SA_REP	10000.00	0.30	145	80
152	Peter	Hall	PHALL	011.44.1344.478968	2005-08-20	SA_REP	9000.00	0.25	145	80
155	Oliver	Tuvault	OTUVAULT	011.44.1344.486508	2007-11-23	SA_REP	7000.00	0.15	145	80
156	Janette	King	JKING	011.44.1345.429268	2004-01-30	SA_REP	10000.00	0.35	146	80
158	Allan	McEwen	AMCEWEN	011.44.1345.829268	2004-08-01	SA_REP	9000.00	0.35	146	80
161	Sarath	Sewall	SSEWALL	011.44.1345.529268	2006-11-03	SA_REP	7000.00	0.25	146	80
169	Harrison	Bloom	HBLOOM	011.44.1343.829268	2006-03-23	SA_REP	10000.00	0.20	148	80
174	Ellen	Abel	EABEL	011.44.1644.429267	2004-05-11	SA_REP	11000.00	0.30	149	80
178	Kimberely	Grant	KGRANT	011.44.1644.429263	2007-05-24	SA_REP	7000.00	0.15	149	0
200	Jennifer	Whalen	JWHALEN	515.123.4444	2003-09-17	AD_ASST	4400.00	0.00	101	10
201	Michael	Hartstein	MHARTSTE	515.123.5555	2004-02-17	MK_MAN	13000.00	0.00	100	20
203	Susan	Mavris	SMAVRIS	515.123.7777	2002-06-07	HR_REP	6500.00	0.00	101	40
204	Hermann	Baer	HBAER	515.123.8888	2002-06-07	PR_REP	10000.00	0.00	101	70
205	Shelley	Higgins	SHIGGINS	515.123.8080	2002-06-07	AC_MGR	12000.00	0.00	101	110
*/
#official solution
select department_id, first_name || ' ' || last_name as employee_name, salary 
from employees a
where salary = (
	select max(salary)
	from employees
	where department_id = a.department_id);
/*
department_id	employee_name	salary
90	Steven King	24000.00
60	Alexander Hunold	9000.00
100	Nancy Greenberg	12000.00
30	Den Raphaely	11000.00
50	Adam Fripp	8200.00
80	John Russell	14000.00
0	Kimberely Grant	7000.00
10	Jennifer Whalen	4400.00
20	Michael Hartstein	13000.00
40	Susan Mavris	6500.00
70	Hermann Baer	10000.00
110	Shelley Higgins	12000.
*/
#user solution
select *
from employees
where (department_id, salary) in (
	select department_id, max(salary)
	from employees
	group by department_id);

#https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php
#21. Write a query in SQL to list the employees whose experience is more than 27 years.  Sources:  https://stackoverflow.com/questions/13065555/oracle-string-to-number
select *, to_number(to_char(current_date,'yyyy'),'0000') - to_number(to_char(hire_date,'yyyy'),'0000') as "Years Worked"
from employees
where to_number(to_char(current_date,'yyyy'),'0000') - to_number(to_char(hire_date,'yyyy'),'0000') > 27;
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id	Years WORked
68319	KAYLING	PRESIDENT		1991-11-18	6000.00		1001	29
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001	29
67832	CLARE	MANAGER	68319	1991-06-09	2550.00		1001	29
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001	29
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001	29
65271	WADE	SALESMAN	66928	1991-02-22	1350.00	600.00	3001	29
66564	MADDEN	SALESMAN	66928	1991-09-28	1350.00	1500.00	3001	29
68454	TUCKER	SALESMAN	66928	1991-09-08	1600.00	0.00	3001	29
69000	JULIUS	CLERK	66928	1991-12-03	1050.00		3001	29
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001	28
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001	29
63679	SANDRINE	CLERK	69062	1990-12-18	900.00		2001	30
*/
#official solution
select *
from employees
where extract(year from age(current_date, hire_date)) > 27;

#30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period.
select *
from employees
where 2000 - to_number(to_char(hire_date,'yyyy'),'0000') > 8;
#official solution RM:  official solution doesn't answer the question.
select emp_name
from employees
where hire_date + interval '96 months' > '1999-12-31';
#user solution
select *
from employees
where age('1999-12-31',hire_date) > '8 years';

#31. Write a query in SQL to list those employees whose salary is an odd value.  #modulo
select *
from employees
where mod(salary,2) <> 0;

#32. Write a query in SQL to list those employees whose salary contain only 3 digits.
select salary, to_char(salary,'9999'), trim(to_char(salary,'9999')), length(trim(to_char(salary,'9999')))
from employees;
/*
salary	to_char	btrim	length
6000.00	6000	6000	4
2750.00	2750	2750	4
2550.00	2550	2550	4
2957.00	2957	2957	4
1700.00	1700	1700	4
1350.00	1350	1350	4
1350.00	1350	1350	4
1600.00	1600	1600	4
1200.00	1200	1200	4
1050.00	1050	1050	4
1400.00	1400	1400	4
3100.00	3100	3100	4
3100.00	3100	3100	4
900.00	900	900	3
*/

#34. Write a query in SQL to list the employees those who joined in company before 19th of the month.
select *
from employees
where to_number(to_char(hire_date,'dd'),'00') < 19;
#user solution
select *
from employees
where extract(day from age(current_date, hire_date)) < 19;

