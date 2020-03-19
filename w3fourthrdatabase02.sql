#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php

#https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php
#1. Write a query to display the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
select first_name, last_name
from employees
where salary > (
	select salary
	from employees
	where employee_id = 163);

#2. Write a query to display the name ( first name and last name ), salary, department id, job id for those employees who works in the same designation as the employee works whose id is 169.  RM:  designation is job_id
select *
from employees
where job_id = (
	select job_id
	from employees
	where employee_id = 169);

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

#4. Write a query to display the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
select *
from employees
where salary > (
	select avg(salary)
	from employees);

#5. Write a query to display the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
select *
from employees
where manager_id = (
	select employee_id
	from employees
	where first_name = 'Payam');

#6. Write a query to display the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
select *
from employees
where department_id = (
	select department_id
	from departments
	where department_name = 'Finance');

#7. Write a query to display all the information of an employee whose salary and reporting person id (RM:  manager_id) is 3000 and 121 respectively.
select *
from employees
where salary = 3000
and manager_id = 121;

#8. Display all the information of an employee whose id is any of the number 134, 159 and 183.
select *
from employees
where employee_id in (134,159,183);

#9. Write a query to display all the information of the employees whose salary is within the range 1000 and 3000.
select *
from employees
where salary is between 1000 and 3000;
#also official solution
select * 
from employees 
where salary between (select 1000) and 3000;

#10. Write a query to display all the information of the employees whose salary is within the range of smallest salary and 2500.
select *
from employees
where salary is between (
	select min(salary)
	from employees)
and 2500;

#11. Write a query to display all the information of the employees who does not work in those departments where some employees works whose manager id within the range 100 and 200.  RM:  find employees who work in departments not managed with manager id between 100 and 200.
select *
from employees
where department_id not in (
	select distinct department_id
	from employees
	where manager_id between 100 and 200);

#12. Write a query to display all the information for those employees whose id is any id who earn the second highest salary.
#RM:  official solution
select * 
from employees 
where employee_id in (
	select employee_id 
	from employees  
	where salary = (
		select max(salary) 
		from employees 
		where salary < (
			select max(salary) 
			from employees)));

#13. Write a query to display the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
select *
from employees
where department_id in (
	select department_id
	from employees
	where first_name = 'Clara')
and first_name <> 'Clara';

#14. Write a query to display the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.  #RM:  solution says name is first_name and t is capital T.
select *
from employees
where department_id in (
	select department_id
	from employees
	where first_name like '%T%');

#15. Write a query to display the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.  #RM:  solution says name is first_name and j is capital J.
select *
from employees
where salary > (
	select avg(salary)
	from employees)
and department_id in (
	select department_id
	from employees
	where first_name like '%J%');

#16. Display the employee name( first name and last name ), employee id, and job title for all employees whose department location is Toronto.
select *
from employees
where department_id in (
	select department_id
	from departments
	where location_id in (
		select location_id
		from locations
		where city = 'Toronto'));

#17. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
select *
from employees
where salary < any (
	select salary
	from employees
	where job_title = 'MK_MAN');

#18. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
select *
from employees
where salary < any (
	select salary
	from employees
	where job_title = 'MK_MAN')
and job_title <> 'MK_MAN';

#19. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.
select *
from employees
where salary > any (
	select salary
	from employees
	where job_title = 'PU_MAN')
and job_title <> 'PU_MAN';

#20. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
select *
from employees
where salary > any (
	select avg(salary)
	from employees
	group by department_id);

#21. Write a query to display the employee name( first name and last name ) and department for all employees for any existence of those employees whose salary is more than 3700.
select first_name, last_name, department_id
from employees
where exists (
	select *
	from employees
	where salary > 3700);

#22. Write a query to display the department id and the total salary for those departments which contains at least one employee.
select department_id, sum(salary)
from employees
group by department_id
having count(department_id) > 0;
#official solution
select departments.department_id, result1.total_amt 
from departments, (
	select employees.department_id, sum(employees.salary) total_amt
	from employees
	group by department_id) result1
where result1.department_id = departments.department_id;

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

#26. Write a subquery that returns a set of rows to find all departments that do actually have one or more employees assigned to them.
select *
from departments
where department_id in (
	select department_id
	from employees
	group by department_id
	having count(department_id)>=1);
#official solution.  Duh, all department id's in employees table have at least one employee.  It's the employees table.
select *
from departments
where department_id in (
	select distinct department_id
	from employees);

#27. Write a query that will identify all employees who work in departments located in the United Kingdom.
select *
from employees
where department_id in (
	select department_id
	from departments
	where location_id in (
		select location_id
		from locations
		where country_id in (
			select country_id
			from countries
			where country_name = 'United Kingdom')));

#28. Write a query to identify all the employees who earn more than the average and who work in any of the IT departments.
select *
from employees
where salary > (
	select avg(salary)
	from employees)
and department_id in (
	select department_id
	from departments
	where department_name like '%IT%');

#29. Write a query to determine who earns more than Mr. Ozer.
select *
from employees
where salary > (
	select salary
	from employees
	where last_name = 'Ozer');

#30. Write a query to find out which employees have a manager who works for a department based in the US.
select *
from employees
where manager_id in (
	select employee_id
	from employees
	where department_id in (
		select department_id
		from departments
		where location_id in (
			select location_id
			from locations
			where country_id = 'US')));

#31. Write a query which is looking for the names of all employees whose salary is greater than 50% of their department’s total salary bill.
select e1.first_name, e1.last_name
from employees e1
where e1.salary > (
	select sum(e2.salary)*.5
	from employees e2
	where e1.department_id = e2.department_id);

#32. Write a query to get the details of employees who are managers.
select *
from employees
where employee_id in (
	select distinct manager_id
	from employees);

#33. Write a query to get the details of employees who manage a department.
select *
from employees
where employee_id in (
	select manager_id
	from departments);

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

#35. Write a query in SQL to display the department code and name for all departments which located in the city London.
select department_id, department_name
from departments
where location_id = (
	select location_id
	from locations
	where city = 'London');
#also
select departments.department_id, departments.department_name
from departments, locations
where departments.location_id = locations.location_id
and locations.city = 'London';

#36. Write a query in SQL to display the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
select *
from employees
where salary > (
	select avg(salary)
	from employees)
order by salary desc;

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

#38. Write a query in SQL to display the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.  #RM:  lame question
select department_name, department_id
from departments
where location_id = (
	select location_id
	from departments
	where department_id = 30);

#39. Write a query in SQL to display the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
select *
from employees
where department_id = (
	select department_id
	from employees
	where employee_id = 201);

#40. Write a query in SQL to display the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
select *
from employees
where salary = (
	select salary
	from employees
	where department_id = 40);

#41. Write a query in SQL to display the first and last name, and department code for all employees who work in the department Marketing.
select *
from employees
where department_id = (
	select department_id
	from departments
	where department_name = 'Marketing');

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

#43. Write a query in SQL to display the full name,email, and designation for all those employees who was hired after the employee whose ID is 165.
select *
from employees
where hire_date > (
	select hire_date
	from employees
	where employee_id = 165);

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

#45. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
select *
from employees
where salary < (
	select avg(salary)
	from employees)
and department_id = (
	select department_id
	from employees
	where first_name = 'Laura');

#46. Write a query in SQL to display the first and last name, salary and department ID for those employees whose department is located in the city London.
select *
from employees
where department_id in (
	select department_id
	from departments
	where location_id in (
		select location_id
		from locations
		where city = 'London'));

#47. Write a query in SQL to display the city of the employee whose ID 134 and works there.
select city
from locations
where location_id = (
	select location_id
	from departments
	where department_id = (
		select department_id
		from employees
		where employee_id = 134));

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

#49. Write a query in SQL to display the detail information of those departments which starting salary is at least 8000.
select *
from departments
where department_id in (
	select department_id
	from employees
	group by department_id
	having min(salary) > 8000);

#50. Write a query in SQL to display the full name (first and last name) of manager who is supervising 4 or more employees.
select *
from employees
where employee_id in (
	select manager_id
	from employees
	group by manager_id
	having count(employee_id) >= 4);

#51. Write a query in SQL to display the details of the current job for those employees who worked as a Sales Representative in the past.  #RM:  stupid question.
select *
from jobs
where job_id = 'SA_REP';
#copied solution
select * 
from jobs 
where job_id in (
	select job_id 
	from employees 
	where employee_id in (
		select employee_id 
		from job_history 
		where job_id = "sa_rep"));

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

#53. Write a query in SQL to display the details of departments managed by Susan.
select *
from departments
where manager_id = (
	select employee_id
	from employees
	where first_name = 'Susan');

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

#55. Write a query in SQL to display all the information of those employees who did not have any job in the past.
select *
from employees
where employee_id not in (
	select distinct employee_id
	from job_history);