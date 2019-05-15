#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php

#1. Write a query in SQL to display all the information of the employees.
select *
from employees;

#2. Write a query in SQL to find the salaries of all employees.
select salary
from employees;

#3. Write a query in SQL to display the unique designations for the employees.  #RM:  unique job_name or job titles.
select distinct job_name
from employees;

#4. Write a query in SQL to list the emp_name and salary is increased by 15% and expressed as no.of Dollars.
select emp_name, salary, to_char(salary*1.15,'$99,999') as "15% raise"
from employees;

#5. Write a query in SQL to produce the output of employees name and job name as a fromat of "Employee & Job".  #RM:  no Ampersand in solution 
select emp_name, job_name, emp_name|| ' ' || job_name
from employees;

#6. Write a query in SQL to produce the output of employees as follows.   Employee JONAS(manager).
select emp_name|| '(' ||lower(job_name)|| ')'
from employees;

#7. Write a query in SQL to list the employees with Hire date in the format like February 22, 1991.
select emp_name, hire_date, to_char(hire_date, 'Month dd, YYYY')
from employees;

#8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.
select emp_name, length(emp_name), trim(emp_name) as "no spaces before after", length(trim(emp_name)) as "count characters no spaces"
from employees;

#9. Write a query in SQL to list the emp_id,salary, and commission of all the employees.
select emp_id, salary, commission
from employees;

#10. Write a query in SQL to display the unique department with jobs.  #RM:  distinct everything or unique everything all columns; all distinct  /* distinct elimates duplicate rows.  distinct is row-based. One distinct operator in query. */
select distinct dep_id, job_name
from employees
order by dep_id, job_name;

#11. Write a query in SQL to list the employees who does not belong to department 2001.
select *
from employees
where dep_id <> 2001;

#12 Write a query in SQL to list the employees who joined before 1991.
select *
from employees
where hire_date < '1991-01-01';

#13. Write a query in SQL to display the average salaries of all the employees who works as ANALYST.
select avg(salary)
from employees
where job_name = 'ANALYST';

#14. Write a query in SQL to display the details of the employee BLAZE.
select *
from employees
where emp_name = 'BLAZE';

#15. Write a query in SQL to display all the details of the employees whose commission is more than their salary.
select *
from employees
where commission > salary;

#16. Write a query in SQL to list the employees whose salary is more than 3000 after giving 25% increment.
select *
from employees
where salary >= 2400;  #RM:  (3,000-x)/x=.25-->2,400=x
#official solution
select *
from employees
where (1.25*salary) > 3000;
#salary is given a 25% increment with current salary.  I interpret question as take current salary add 25% increase.
select emp_name, salary, salary*1.25 as "25% increase current salary"
from employees
where salary*1.25 > 3000;

#17. Write a query in SQL to list the name of the employees, those having six characters to their name.
select emp_name
from employees
where length(emp_name) = 6;

#18. Write a query in SQL to list the employees who joined in the month January.
select emp_name
from employees
where to_char(hire_date, 'Month') = 'January';  #RM:  doesn't work
#official solution
select emp_name
from employees
where to_char(hire_date, 'mon') = 'jan';

#19. Write a query in SQL to list the name of employees and their manager separated by the string 'works for'.
#employees and their manager_id
select emp_name, manager_id
from employees;
#trying 
select e.emp_name, m.emp_name
from employees e, employees m
where e.manager_id = m.emp_id;
#self join
select e.emp_name, m.emp_name
from employees e join employees m
on (e.manager_id = m.emp_id);
#stupid, need alias because same column name.  In oraclesql12cintroduction.sql, no need for column alias.
select e.emp_name as "Employee", m.emp_name as "Manager"
from employees e, employees m
where e.manager_id = m.emp_id;
#self join
select e.emp_name as "Employee", m.emp_name as "Manager"
from employees e join employees m
on (e.manager_id = m.emp_id);
#left join employees without a manager
select e.emp_name as "Employee", m.emp_name as "Manager", e.emp_name|| ' works for ' ||m.emp_name as "works for"
from employees e left join employees m
on (e.manager_id = m.emp_id);

#20. Write a query in SQL to list all the employees whose designation is CLERK.
select emp_name
from employees
where job_name = 'CLERK';

#21. Write a query in SQL to list the employees whose experience is more than 27 years.
#copied solution
select *
from employees
where extract(year from age(current_date, hire_date)) > 27;

#22. Write a query in SQL to list the employees whose salaries are less than 3500.
select *
from employees
where salary < 3500;

#23. Write a query in SQL to list the name, job_name, and salary of any employee whose designation is ANALYST.
select emp_name, job_name, salary
from employees
where job_name = 'ANALYST';

#24. Write a query in SQL to list the employees who have joined in the year 1991.
select *
from employees
where hire_date >= '1991-01-01' and hire_date <= '1991-12-31';
#official solution
select *
from employees
where to_char(hire_date,'yyyy') = '1991';

#25. Write a query in SQL to list the name, id, hire_date, and salary of all the employees joined before 1 apr 91.
select emp_name, emp_id, hire_date, salary
from employees
where hire_date < '1991-04-01';

#26. Write a query in SQL to list the employee name, and job_name who are not working under a manager.
select emp_name, job_name
from employees
where manager_id is null;

#27. Write a query in SQL to list all the employees joined on 1st may 91.
select *
from employees
where hire_date = '1991-05-01';

#28. Write a query in SQL to list the id, name, salry, and experiences of all the employees working for the manger 68319
select emp_id, emp_name, salary, age(current_date, hire_date) "copy Experience from solution"
from employees
where manager_id = 68319;
/*
emp_id	emp_name	salary	copy Experience from solution
66928	BLAZE	2750.00	28 years 14 days
67832	CLARE	2550.00	27 years 11 mons 6 days
65646	JONAS	2957.00	28 years 1 mon 13 days
*/

#29. Write a query in SQL to list the id, name, salary, and experience of all the employees who earn more than 100 as daily salary.  #RM:  looked at official solution.  Used 30 days as number of days per month.
select emp_id, emp_name, salary, age(current_date, hire_date) "copy Experience from solution"
from employees
where (salary/30) > 100;

#30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period.
#copied solution
select emp_name
from employees
where hire_date + interval '96 months' > '1999-12-31';

#31. Write a query in SQL to list those employees whose salary is an odd value.
select *
from employees
where mod(salary,2) <> 0;

#32. Write a query in SQL to list those employees whose salary contain only 3 digits.
select *
from employees
where length(trim(to_char(salary,'9999'))) = 3;