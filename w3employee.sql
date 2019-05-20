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

#33. Write a query in SQL to list the employees who joined in the month of APRIL.
select emp_name
from employees
where to_char(hire_date, 'Month') = 'April';  #RM:  doesn't work
select *
from employees
where to_char(hire_date,'mon') = 'apr';  #RM:  does work
#also
select *
from employees
where to_char(hire_date,'MON') = 'APR';  #RM:  does work

#34. Write a query in SQL to list the employees those who joined in company before 19th of the month.
select *
from employees
where to_char(hire_date,'dd') < 19;  #RM:  doesn't work
select *
from employees
where to_char(hire_date,'DD') < '19';  #RM:  does work

#35. Write a query in SQL to list the employees who are SALESMAN and gathered an experience over 10 years.
select emp_name, current_date, hire_date, current_date-hire_date as "Days on the job"
from employees
where job_name = 'SALESMAN'
and current_date-hire_date > (365*10);
#official solution
select *
from employees
where job_name = 'salesman'
and extract(month from age(current_date, hire_date)) > 10;

#36. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.
select *
from employees
where dep_id in (3001, 1001)
and to_char(hire_date,'YYYY') = '1991';

#37. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.
select *
from employees
where dep_id in (3001, 1001)
and to_char(hire_date,'YYYY') = '1991';

#38. Write a query in SQL to list all the employees of designation CLERK in department no 2001.
select *
from employees
where job_name = 'CLERK'
and dep_id = 2001;

#39. Write a query in SQL to list the ID, name, salary, and job_name of the employees for 1. Annual salary is below 34000 but receiving some commission which should not be more than the salary, 2. And designation is SALESMAN and working for department 3001.
select emp_id, emp_name, job_name
from employees
where (salary*12 < 34000 and commission < (salary))
and job_name = 'SALESMAN'
and dep_id = 3001;

#40. Write a query in SQL to list the employees who are either CLERK or MANAGER.
select *
from employees
where job_name in ('CLERK','MANAGER');

#41. Write a query in SQL to list the employees who joined in any year except the month February.
select *
from employees
where to_char(hire_date,'mon') not in ('feb');

#42. Write a query in SQL to list the employees who joined in the year 91.
select *
from employees
where to_char(hire_date,'YYYY') = '1991';
#also from official solution
select *
from employees
where hire_date between '1991-01-01' and '1991-12-31';

#43. Write a query in SQL to list the employees who joined in the month of June in 1991.
select *
from employees
where hire_date between '1991-06-01' and '1991-06-30';
#also from official solution
select *
from employees
where to_char(hire_date,'mon-yyyy') = 'jun-1991';
#also
select *
from employees
where to_char(hire_date,'YYYY') = '1991'
and to_char(hire_date,'mon') in ('jun');

#44. Write a query in SQL to list the employees whose annual salary is within the range 24000 and 50000.
select *
from employees
where (salary*12) >= 24000 and (salary*12) <=50000;
#also from official solution
select *
from employees
where 12*salary between 24000 and 50000;

#45. Write a query in SQL to list the employees who have joined on the following dates 1st May,20th Feb, and 03rd Dec in the year 1991.
select *
from employees
where to_char(hire_date,'MON-DD-YYYY') in ('May-01-1991','Feb-20-1991','Dec-03-1991');
#user solution
select *
from employees
where hire_date in ('1991-05-01','1991-02-20','1991-12-03');

#46. Write a query in SQL to list the employees working under the managers 63679,68319,66564,69000.
select *
from employees
where manager_id in (63679, 68319, 66564, 69000);

#47. Write a query in SQL to list the employees who joined after the month JUNE in the year 1991.  #RM:  solution is all employees employed July 1991 to Dec 1992?!?
select *
from employees
where hire_date >= '1991-07-01' and hire_date <='1991-12-31';

#48. Write a query in SQL to list the employees who joined in 90's.  #RM:  all employees joined in 90's.
select *
from employees
where to_char(hire_date,'YYYY') >= '1990' and to_char(hire_date,'YYYY') <= '1999';  #Between or Range works for text or quoted numbers?!?
select *
from employees
where to_char(hire_date,'MON-DD-YYYY') between 'Jan-01-1990' and 'Dec-31-1999'; #doesn't work

#49. Write a query in SQL to list the managers of department 1001 or 2001.  #RM:  Find job_name MANAGER in dept_id 1001 or 2001
select m.emp_name as "Manager", m.dep_id as "Department ID"
from employees e join employees m
on (e.manager_id = m.emp_id)
where m.dep_id in (1001, 2001);  #RM:  incorrect
select *
from employees
where job_name = 'MANAGER'
and dep_id in (1001, 2001);  #RM:  correct

#50. Write a query in SQL to list the employees, joined in the month FEBRUARY with a salary range between 1001 to 2000. 
select *
from employees
where to_char(hire_date,'mon') = 'feb'
and salary between 1001 and 2000;