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