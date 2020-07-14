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

#53. Write a query in SQL to list the name, job name, annual salary, department id, department name and grade of the employees who earn [greater than or equal to] 60000 in a year or not working as an ANALYST.
select e.emp_name, e.job_name, (e.salary*12) as "Annual Salary", e.dep_id, d.dep_name, s.grade
from employees e, department d, salary_grade s
where e.dep_id = d.dep_id
and e.salary between s.min_sal and s.max_sal
and ((e.salary*12) >= 60000 or e.job_name <> 'ANALYST');

#54. Write a query in SQL to list the name, job name, manager id, salary, manager name, manager's salary for those employees whose salary is greater than the salary of their managers.  #RM:  Using two or more column ID the second column ID and thereafter need a column alias.
select worker.emp_name, worker.job_name, worker.manager_id, worker.salary, manager.emp_name as "Manager", manager.salary as "Manager Salary", manager.emp_id as "Manager Employee ID"
from employees worker, employees manager
where worker.manager_id = manager.emp_id
and worker.salary > manager.salary;
/*
emp_name	job_name	manager_id	salary	Manager	Manager Salary	Manager Employee ID
SCARLET	ANALYST	65646	3100.00	JONAS	2957.00	65646
FRANK	ANALYST	65646	3100.00	JONAS	2957.00	65646
*/

#60. Write a query in SQL to list the id, name, salary, and location of the employees working at PERTH,or MELBOURNE with an experience over 10 years.
select e.emp_id, e.emp_name, e.salary, d.dep_location
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_location in ('PERTH','MELBOURNE')
and to_number(to_char(current_date,'yyyy'),'0000') - to_number(to_char(hire_date,'yyyy'),'0000') > 10;
#official solution
select e.emp_id, e.emp_name, e.dep_id, e.salary, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and d.dep_location in ('PERTH','MELBOURNE')
and extract(month from age(current_date, hire_date)) > 10;
#user solution
select emp_id,emp_name, salary, dep_location
from employees e join department d
on e.dep_id=d.dep_id
where dep_location in ('PERTH','MELBOURNE')
and age(current_date,hire_date) > '10 years';

#63. Write a query in SQL to list the employees who are senior to their own manager. #RM:  self-join
select workers.emp_name "worker", workers.hire_date as "worker date", manager.emp_name as "manager", manager.hire_date as "manager date"
from employees workers, employees manager
where workers.manager_id = manager.emp_id
and workers.hire_date > manager.hire_date;

#79. Write a query in SQL to list the employee id, name, annual salary, daily salary of all the employees in the ascending order of annual salary who works as a SALESMAN.  #RM:  sort alias sort by aslias
select emp_id, emp_name, salary*12 as "annual salary", (salary*12)/365 as "daily salary"
from employees
where job_name = 'SANDRINE'
order by "annual salary" asc;

#99. Write a query in SQL to display the Grade, Number of employees, and maximum salary of each grade.
select s.grade, count(*), max(e.salary)
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
group by s.grade
order by s.grade;

#111. Write a query in SQL to list the employees whose ID not starting with digit 68.
select *
from employees
where emp_id <= 67999
or emp_id >= 69000;
#official solution
select *
from employees
where trim(to_char(emp_id,'99999')) not like '68%';
#user solution
select *
from employees
where cast(emp_id as varchar) not like '68%';

#https://www.w3resource.com/sql-exercises/employee-database-exercise/subqueries-exercises-on-employee-database.php
#2. Write a query in SQL to display the employee ID, name, job name, hire date, and experience of all the managers.
select *, to_number(to_char(current_date,'yyyy'),'0000') - to_number(to_char(hire_date,'yyyy'),'0000') as "Years Worked Experience", age(CURRENT_DATE, hire_date) "Age Experience"
from employees
where emp_id in (
	select distinct manager_id
	from employees);
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id	Years WORked Experience	Age Experience
68319	KAYLING	PRESIDENT		1991-11-18	6000.00		1001	29	28 years 4 mons 29 days
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001	29	28 years 11 mons 16 days
67832	CLARE	MANAGER	68319	1991-06-09	2550.00		1001	29	28 years 10 mons 8 days
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001	29	29 years 15 days
67858	SCARLET	ANALYST	65646	1997-04-19	3100.00		2001	23	22 years 11 mons 28 days
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001	29	28 years 4 mons 14 days
*/

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
#official solution didn't use subquery

#17. Write a query in SQL to list any job of department ID 1001 those that are not found in department ID 2001.
select distinct e1.job_name
from employees e1
where e1.dep_id = 1001
minus
select distinct e2.job_name
from employees e2
where e2.dep_id = 2001;  #RM:  minus doesn't work.  Union, union all, and intersect all work.
#official solution
select job_name
from employees
where dep_id = 1001
and job_name not in (
	select job_name
	from employees
	where dep_id = 2001);

#20. Write a query in SQL to list the employees of grade 3 who have been hired in most recently and belongs to PERTH.
select *
from employees
where hire_date = (
	select max(hire_date)
	from employees e join department d
	on e.dep_id = d.dep_id
	join salary_grade s
	on e.salary between s.min_sal and s.max_sal
	where s.grade = 3
	and d.dep_location = 'PERTH');

#22. Write a query in SQL to list the details of the employees within grade 3 to 5 and belongs to SYDNEY. The employees are not in PRESIDENT designated and salary is more than the highest paid employee of PERTH where no MANAGER and SALESMAN are working under KAYLING.  RM:  highest paid employees works at PERTH, is not a manager, is not a salesman, and doesn't work under KAYLING.
select e.*
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
join department d
on e.dep_id = d.dep_id
where grade in (3,4,5)
and d.dep_location = 'SYDNEY'
and e.job_name <> 'PRESIDENT'
and e.salary > all (
	select max(e2.salary)
	from employees e2, department d2
	where e2.dep_id = d2.dep_id
	and d2.dep_location = 'PERTH'
	and e2.job_name not in ('MANAGER','SALESMAN')
	and e2.manager_id not in (
		select e3.emp_id
		from employees e3
		where e3.emp_name = 'KAYLING'));
/*
 emp_id | emp_name | job_name | manager_id | hire_date  | salary  | commission | dep_id
--------+----------+----------+------------+------------+---------+------------+--------
  67832 | CLARE    | MANAGER  |      68319 | 1991-06-09 | 2550.00 |            |   1001
 */

#34. Write a query in SQL to list the employees whose salary is equal or more to the average of maximum and minimum salary.
select *
from employees
where salary >= (
	select round((max(salary)+min(salary))/2,2)
	from employees);
#RM:  avg(max(salary),min(salary)) and avg(max(salary)+min(salary)) are invalid

#35. Write a query in SQL to list the employees who are SALESMAN and gathered an experience which month portion is more than 10.
#35. Write a query in SQL to list the managers whose salary is more than the average salary his employees.  #Join inside a subquery or first join main query and second join subquery.  Also subquery as temporary table alias and a join.
#official solution
select m.*
from employees m
where m.emp_id in (
	select manager_id
	from employees)
and m.salary > (
	select avg(e.salary)
	from employees e
	where e.manager_id = m.emp_id);
#user solution
select *
from employees as e join (
	select manager_id, avg(salary) as m_avg
	from employees
	group by manager_id) as j
on e.emp_id = j.manager_id
where e.salary > j.m_avg;

#35.  Bonus.  Subquery is a temp table.
#Find employees working in SYDNEY.
select *
from employees as e join (
	select dep_id, dep_location
	from department) as d
on e.dep_id = d.dep_id
where d.dep_location = 'SYDNEY';
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id	dep_location
68319	KAYLING	PRESIDENT		1991-11-18	6000.00		1001	SYDNEY
67832	CLARE	MANAGER	68319	1991-06-09	2550.00		1001	SYDNEY
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001	SYDNEY
*/

#36. Write a query in SQL to list the employees whose salary is less than the salary of his manager but more than the salary of any other manager.  #two subqueries provides two temporary tables.  temp tables.
select e2.emp_name as "employee", e2.salary as "employee salary", m2.emp_name as "not manager", m2.salary as "not salary"
from employees e2, employees m2
where e2.manager_id <> m2.emp_id;
/*
employee	employee salary	not manager	not salary
BLAZE	2750.00	BLAZE	2750.00
BLAZE	2750.00	CLARE	2550.00
BLAZE	2750.00	JONAS	2957.00
BLAZE	2750.00	ADELYN	1700.00
BLAZE	2750.00	WADE	1350.00
BLAZE	2750.00	MADDEN	1350.00
BLAZE	2750.00	TUCKER	1600.00
BLAZE	2750.00	ADNRES	1200.00
BLAZE	2750.00	JULIUS	1050.00
BLAZE	2750.00	MARKER	1400.00
BLAZE	2750.00	SCARLET	3100.00
BLAZE	2750.00	FRANK	3100.00
BLAZE	2750.00	SANDRINE	900.00
CLARE	2550.00	BLAZE	2750.00
CLARE	2550.00	CLARE	2550.00
CLARE	2550.00	JONAS	2957.00
*/
#official solution correct
select distinct employeelowersalary.*
from (
	select e.*
	from employees e, employees m
	where e.manager_id = m.emp_id
	and e.salary < m.salary) employeelowersalary,
	(
	select *
	from employees
	where emp_id in (
		select manager_id
		from employees)) managertable
where employeelowersalary.salary > managertable.salary;
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001
*/

#37. Write a query in SQL to list the name and average salary of employees in department wise.  #subquery temporary table from statement
select e.*, deptaveragesalary."dept average salary"
from (
	select dep_id, round(avg(salary),2) as "dept average salary"
	from employees
	group by dep_id) deptaveragesalary,
employees e
where e.dep_id = deptaveragesalary.dep_id;
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id	dept average salary
68319	KAYLING	PRESIDENT		1991-11-18	6000.00		1001	3316.67
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001	1633.33
67832	CLARE	MANAGER	68319	1991-06-09	2550.00		1001	3316.67
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001	2251.40
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001	1633.33
65271	WADE	SALESMAN	66928	1991-02-22	1350.00	600.00	3001	1633.33
66564	MADDEN	SALESMAN	66928	1991-09-28	1350.00	1500.00	3001	1633.33
68454	TUCKER	SALESMAN	66928	1991-09-08	1600.00	0.00	3001	1633.33
68736	ADNRES	CLERK	67858	1997-05-23	1200.00		2001	2251.40
69000	JULIUS	CLERK	66928	1991-12-03	1050.00		3001	1633.33
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001	3316.67
67858	SCARLET	ANALYST	65646	1997-04-19	3100.00		2001	2251.40
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001	2251.40
63679	SANDRINE	CLERK	69062	1990-12-18	900.00		2001	2251.40
*/

#38. Write a query in SQL to find out the least 5 earners of the company.
select *
from employees
order by salary asc limit 5;
#or
select *
from employees
where salary <= (
	select distinct salary from (
		select rank() over (order by salary asc) rank, * from employees) as neednamehere
		where rank = 4);  #RM:  there was a tie for the fifth lowest salary.  Use rank 4 and distinct.
#official solution
select *
from employees e
where 5 > (
	select count(*)
	from employees
	where e.salary > salary);

#41. Write a query in SQL to list the name of the department where number of employees is equal to the number of characters in the department name.
select departmentlength.dep_name
from (
	select dep_name, length(dep_name) as "characters"
	from department) departmentlength,
	(
	select count(*) as "number employees"
	from employees
	group by dep_id) countemployee
where departmentlength."characters" = countemployee."number employees";

#43. Write a query in SQL to list the employees who joined in the company on the same date.  #RM:  Find employees with the same hire dates.
#official solution
select *
from employees e1
where hire_date in (
	select hire_date
	from employees e2
	where e1.emp_id <> e2.emp_id);
#user solutions
select hiredate1.*
from (
	select *
	from employees) hiredate1
join (
	select *
	from employees) hiredate2
on hiredate1.hire_date = hiredate2.hire_date
and hiredate1.emp_id <> hiredate2.emp_id;
#also
select *
from employees a join employees b
on a.hire_date = b.hire_date
and a.emp_id <> b.emp_id;
#RM:  It seems a.emp_id <> b.emp_id or hiredate1.emp_id <> hiredate2.emp_id prevents double posting the answers and prevents all employees returned.

#44. Write a query in SQL to list the name of the departments where more than average number of employees are working.
select *
from (
	select count(emp_id)
	from employees
	group by dep_id) averagecount;
/*
count
5
3
6
*/
select round(avg(employeecount),2) as "needemployeecountcolumnname"
from (
	select count(emp_id) as "employeecount"
	from employees
	group by dep_id) averagecount;
/*
needemployeecountcolumnname
4.67
*/
select *
from department
where dep_id in (
	select dep_id
	from employees
	group by dep_id
	having count(dep_id) > (
		select round(avg(employeecount),2) as "needemployeecountcolumnname"
		from (
			select count(emp_id) as "employeecount"
			from employees
			group by dep_id) averagecount));

#50. Write a query in SQL to find all the employees who earn the minimum salary for a designation and arrange the list in ascending order on salary.
select *
from employees
where salary in (
	select min(salary)
	from employees
	group by job_name)
order by salary asc;
#also by me
select employees.*
from employees join (
	select min(salary) as "minimumsalarycolumn"
	from employees
	group by job_name) minimumsalary
on employees.salary = minimumsalary."minimumsalarycolumn"
order by employees.salary asc;

#57. Write a query in SQL to list the department id, name, designation, salary, and net salary of the employees only who gets a commission and earn the second highest earnings.
select *
from employees
where (salary+commission) = (
	select (salary+commission) from (
		select salary+commission, rank() over (order by salary+commission desc) from employees where commission is not null) neednamehere
		where ranknumber = 2);  #error message
select *
from employees
where emp_name in (
	select emp_name from (
		select emp_name, salary+commission, rank() over (order by salary+commission desc)
		from employees
		where commission is not null) neednamehere
	where rank = 2);

#68. Write a query in SQL to list the employees whose salary is same as any one of the employee.
select *
from employees
where salary in (
	select salary
	from employees
	group by salary
	having count(salary) > 1);
#user solution
SELECT *
FROM employees a
WHERE a.salary = any (
	SELECT b.salary
	FROM employees b
	WHERE a.emp_id <> b.emp_id);
#official solution
select *
from employees
where salary in (
	select salary
	from employees e
	where employees.emp_id <> e.emp_id);

#72. Write a query in SQL to list the highest paid employees working under KAYLING.
select *
from employees
where emp_id in (
	select emp_id from (
		select emp_id, salary, rank() over (order by salary desc)
		from employees
		where manager_id = (
			select emp_id
			from employees
			where emp_name = 'KAYLING')) neednamehere
	where rank = 1);
#official solution.  RM:  It's easier
select *
from employees
where salary = (
	select max(salary)
	from employees
	where manager_id in (
		select emp_id
		from employees
		where emp_name = 'KAYLING'));

#74. Write a query in SQL to find out the employees whose salaries are greater than the salaries of their managers.  #RM:  subquery in from statement subquery from statement.
select e.emp_id as "employee id", e.emp_name as "employee name", e.manager_id as "manager id", m.emp_name as "manager name"
from employees e, employees m
where m.emp_id = e.manager_id
and e.salary > m.salary;
#also
select employees.*
from employees, (
	select emp_id, emp_name, salary
	from employees
	where emp_id in (
		select distinct manager_id
		from employees)) managers
where employees.manager_id = managers.emp_id
and employees.salary > managers.salary;

#75. Write a query in SQL to find the maximum average salary drawn for each job name except for PRESIDENT.
select job_name, round(avg(salary),2) as maxavgsalary
from employees
where job_name <> 'PRESIDENT'
group by job_name
order by maxavgsalary desc limit 1;
#RM:  no user solution used rank() and group by
#official solution
select max(maxavgsalary)
from (
	select round(avg(salary),2) as maxavgsalary
	from employees
	where job_name <> 'PRESIDENT'
	group by job_name) neednamehere;

#https://www.w3resource.com/sql-exercises/movie-database-exercise/subqueries-exercises-on-movie-database.php
#11. Write a query in SQL to find the movie title, and the highest number of stars that movie received and arranged the result according to the group of a movie and the movie title appear alphabetically in ascending order.  RM:  Post the movie title and it's highest rating.  It's not return the movie and its highest rating star separately.  Two tables joined using group by in one table.
select mov_title, max(rev_stars)
from movie, rating
where movie.mov_id = rating.mov_id
and rating.rev_stars is not null
group by movie.mov_title
order by mov_title;

#https://www.w3resource.com/sql-exercises/movie-database-exercise/joins-exercises-on-movie-database.php
#11. Write a query in SQL to find those lowest duration movies along with the year, director's name, actor's name and his/her role in that production.  #RM:  Find the shortest length movie(s).
select m.mov_title, m.mov_year, d.dir_fname, d.dir_lname, a.act_fname, a.act_lname, mc.role
from movie m natural join actor a
natural join director d
natural join movie_direction md
natural join movie_cast mc
where mov_time = (
	select min(mov_time)
	from movie);

#12. Write a query in SQL to find all the years which produced a movie that received a rating of 3 or 4, and sort the result in increasing order.
select m.mov_year, r.rev_stars
from movie m natural join rating r
where r.rev_stars between 3 and 4;