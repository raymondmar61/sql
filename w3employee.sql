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