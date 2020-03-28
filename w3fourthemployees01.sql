#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php

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
select emp_name, salary, salary*1.15 as "no.of Dollars", to_char(salary*1.15, '$99,999') as Salary
from employees;

#5. Write a query in SQL to produce the output of employees name and job name as a fromat of "Employee & Job".
select emp_name || '  ' || job_name
from employees;

#6. Write a query in SQL to produce the output of employees as follows. Employee JONAS(manager).
select emp_name || '(' || job_name || ')' as Employee
from employees;

#7. Write a query in SQL to list the employees with Hire date in the format like February 22, 1991.
select to_char(hire_date,'Month dd, yyyy')
from employees;

#8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.
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
where emp_name = 'BLAZE';

#15. Write a query in SQL to display all the details of the employees whose commission is more than their salary.
select *
from employees
where commission > salary;

#16. Write a query in SQL to list the employees whose salary is more than 3000 after giving 25% increment.  #RM:  dumb question
select *
from employees
where salary*1.25 > 3000;

#17. Write a query in SQL to list the name of the employees, those having six characters to their name.
select emp_name
from employees
where length(emp_name) = 6;

#18. Write a query in SQL to list the employees who joined in the month January.
select *
from employees
where to_char(hire_date,'Month') = 'January'; #doesn't work
select *
from employees
where to_char(hire_date,'Mon') = 'Jan'; #does work

#19. Write a query in SQL to list the name of employees and their manager separated by the string 'works for'.
select e.emp_name || ' works for ' || m.emp_name
from employees e, employees m
where e.manager_id = m.emp_id;

#20. Write a query in SQL to list all the employees whose designation is CLERK.
select *
from employees
where job_name = 'CLERK';

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

#22. Write a query in SQL to list the employees whose salaries are less than 3500.
select *
from employees
where salary < 3500;

#23. Write a query in SQL to list the name, job_name, and salary of any employee whose designation is ANALYST.
select *
from employees
where job_name = 'ANALYST';

#24. Write a query in SQL to list the employees who have joined in the year 1991.
select *
from employees
where to_char(hire_date,'yyyy') = '1991';

#25. Write a query in SQL to list the name, id, hire_date, and salary of all the employees joined before 1 apr 91.
select *
from employees
where hire_date < '1991-04-01';

#26. Write a query in SQL to list the employee name, and job_name who are not working under a manager.
select *
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

#29. Write a query in SQL to list the id, name, salary, and experience of all the employees who earn more than 100 as daily salary.
select *
from employees
where (salary/30) > 100;

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
select *
from employees
where length(trim(to_char(salary,'9999'))) = 3;
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

#33. Write a query in SQL to list the employees who joined in the month of APRIL.
select *
from employees
where to_char(hire_date,'Mon') = 'Apr';
#or
select *
from employees
where to_char(hire_date,'MON') ='APR';

#34. Write a query in SQL to list the employees those who joined in company before 19th of the month.
select *
from employees
where to_number(to_char(hire_date,'dd'),'00') < 19;
#user solution
select *
from employees
where extract(day from age(current_date, hire_date)) < 19;

#35. List the employees who are SALESMAN and gathered an experience which month portion is more than 10.
#official solution
select *
from employees
where job_name = 'SALESMAN'
and extract(month from age(current_date, hire_date)) > 10;

#36. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.
select *
from employees
where dep_id in (3001,1001)
and to_char(hire_date,'yyyy') = '1991';

#37. Write a query in SQL to list the employees who are working for the department ID 1001 or 2001.
select *
from employees
where dep_id in (1001,2001);

#38. Write a query in SQL to list all the employees of designation CLERK in department no 2001.
select *
from employees
where job_name = 'CLERK'
and dep_id = 2001;

#39. Write a query in SQL to list the ID, name, salary, and job_name of the employees for 1. Annual salary is below 34000 but receiving some commission which should not be more than the salary, 2. And designation is SALESMAN and working for department 3001.
select *
from employees
where ((salary*12) < 34000
and commission < salary)
and job_name = 'SALESMAN'
and dep_id = 3001;
#official solution (salary_commision)*12 < 34000

#40. Write a query in SQL to list the employees who are either CLERK or MANAGER.
select *
from employees
where job_name in ('CLERK','MANAGER');

#41. Write a query in SQL to list the employees who joined in any year except the month February.
select *
from employees
where to_char(hire_date,'mm') <> '02';
#also
select *
from employees
where to_char(hire_date,'Mon') not in ('Feb');

#42. Write a query in SQL to list the employees who joined in the year 91.
select *
from employees
where to_char(hire_date,'yy') = '91';

#43. Write a query in SQL to list the employees who joined in the month of June in 1991.
select *
from employees
where hire_date between '1991-06-01' and '1991-06-30';

#44. Write a query in SQL to list the employees whose annual salary is within the range 24000 and 50000.
select *
from employees
where (salary*12) >= 24000 and (salary*12) <= 50000;