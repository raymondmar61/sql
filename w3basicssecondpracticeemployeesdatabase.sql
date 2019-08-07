#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php
#1. Write a query in SQL to display all the information of the employees.
select *
from employees;

#2. Write a query in SQL to find the salaries of all employees.
select salary
from employees;

#3. Write a query in SQL to display the unique designations for the employees.
select distinct job_name
from employees;

#4. Write a query in SQL to list the emp_name and salary is increased by 15% and expressed as no.of Dollars.
select emp_name, salary, '$' ||salary*1.15 as "salary increase", '$' ||round(salary*1.15,2) as "salary increase rounded"
from employees;
#official solution
select emp_name, to_char(salary*1.15, '$99,999') as "salary increase"
from employees;
#RM:  to_char convert number or date to character works in Oracle

#5. Write a query in SQL to produce the output of employees name and job name as a fromat of "Employee & Job".
select emp_name || ' & ' || job_name
from employees;

#6. Write a query in SQL to produce the output of employees as follows.   Employee JONAS(manager)
select emp_name || '(' || lower(job_name) || ')'
from employees;

#7. Write a query in SQL to list the employees with Hire date in the format like February 22, 1991.
select emp_name, to_char(hire_date, 'Month dd, yyyy')
from employees;

#8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.  length, len, count character count characters count string count
select emp_name, length(trim(emp_name))
from employees;

#9. Write a query in SQL to list the emp_id,salary, and commission of all the employees.
select emp_id, salary, commission
from employees;

#10. Write a query in SQL to display the unique department with jobs.
select distinct dep_id
from employees;

#11. Write a query in SQL to list the employees who does not belong to department 2001.
select *
from employees
where dep_id <> 2001;

#12. Write a query in SQL to list the employees who joined before 1991.
select *
from employees
where hire_date <= '1990-12-31';

#13. Write a query in SQL to display the average salaries of all the employees who works as ANALYST.
select avg(salary)
from employees
where job_name = 'ANALYST';

#14. Write a query in SQL to display the details of the employee BLAZE.
select *
from employees
where emp_name in ('BLAZE');

#15. Write a query in SQL to display all the details of the employees whose commission is more than their salary.
select *
from employees
where commission > salary;

#16. Write a query in SQL to list the employees whose salary is more than 3000 after giving 25% increment.
select *
from employees
where (salary*1.25) > 3000;

#17. Write a query in SQL to list the name of the employees, those having six characters to their name.
select *
from employees
where length(emp_name) = 6;

#18. Write a query in SQL to list the employees who joined in the month January.
select to_char(hire_date, 'Month')
from employees;  #returns the Month full spelling
select *
from employees
where to_char(hire_date, 'Month') = 'January'; #doesn't work
select *
from employees
where to_char(hire_date, 'mon') = 'jan'; #works
select *
from employees
where to_char(hire_date,'mon') like 'jan'; #works
#user solution
select *
from employees
where to_char(hire_date,'MM') = '01';

#19. Write a query in SQL to list the name of employees and their manager separated by the string 'works for'.
select e.emp_name as "Employee", m.emp_name as "Manager"
from employees e, employees m
where e.manager_id = m.emp_id; #return employees and their managers
select e.emp_name || ' works for ' || m.emp_name
from employees e, employees m
where e.manager_id = m.emp_id;

#20. Write a query in SQL to list all the employees whose designation is CLERK.
select *
from employees
where job_name = 'CLERK';

#21. Write a query in SQL to list the employees whose experience is more than 27 years.
select hire_date, to_char(hire_date,'yyyy'), 2019 - to_number(to_char(hire_date,'yyyy'),'9999') 
from employees;  #works, calculates by years
select hire_date, ('2019-08-07' - hire_date)/365
from employees; #works, subtract number of days divided by 365 days a year
select hire_date, (current_date - hire_date)/365
from employees; #works, subtract number of days divided by 365 days a year
#official solution
select *
from employees
where extract(year
	from age(current_date, hire_date)
	) > 27;

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
where to_char(hire_date, 'yyyy') = '1991';
#also
select *
from employees
where hire_date between '1991-01-01' and '1991-12-31';

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

#28. Write a query in SQL to list the id, name, salry, and experiences of all the employees working for the manger 68319.
select *
from employees
where manager_id = 68319;

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
where age('1999-12-31',hire_date) > '8 years';