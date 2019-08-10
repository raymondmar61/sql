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
#RM:  age(current_date, hire_date) returns data like 27 years 8 mons 21 days

#30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period.
#official solution
select emp_name
from employees
where hire_date + interval '96 months' > '1999-12-31';
#user solution which makes sense
select *, age('1999-12-31',hire_date)
from employees
where age('1999-12-31',hire_date) > '8 years';
#RM:  age('1999-12-31',hire_date) returns data like 8 years 1 mon 13 days or 9 years 13 days

#31. Write a query in SQL to list those employees whose salary is an odd value.
select *
from employees
where mod(salary,2) <> 0;
#also from user solution
select *
from employees
where salary % 2 = 1;

#32. Write a query in SQL to list those employees whose salary contain only 3 digits.
select salary as "6000.00", to_char(salary,'9999') as "6000 to_char", length(to_char(salary,'9999')) as "5", trim(to_char(salary,'9999')) as "6000 trim", length(trim(to_char(salary,'9999'))) as "4"
from employees;
'''
6000.00	6000 to_char	5	6000 trim	4
6000.00	6000	5	6000	4
2750.00	2750	5	2750	4
2550.00	2550	5	2550	4
2957.00	2957	5	2957	4
1700.00	1700	5	1700	4
1350.00	1350	5	1350	4
1350.00	1350	5	1350	4
1600.00	1600	5	1600	4
1200.00	1200	5	1200	4
1050.00	1050	5	1050	4
1400.00	1400	5	1400	4
3100.00	3100	5	3100	4
3100.00	3100	5	3100	4
900.00	900		5	900	    3
'''

#33. Write a query in SQL to list the employees who joined in the month of APRIL.
select *
from employees
where to_char(hire_date,'mon') = 'apr';

#34. Write a query in SQL to list the employees those who joined in company before 19th of the month.  RM:  to_char(hire_date, 'dd') extracts the date number, to_number(to_char(hire_date, 'dd'),'99') converts date number to a two digit or one digit number.
select *, to_number(to_char(hire_date, 'dd'),'99') as "extract day number convert to number"
from employees
where to_number(to_char(hire_date, 'dd'),'99') < 19;
#official solution
select *
from employees
where to_char(hire_date,'dd') < '19';  #we run comparisons with numbers converted to string
#user solution
select *
from employees
where extract(day from age(current_date, hire_date)) < 19;
#reference extract(day from age(current_date, hire_date))
select hire_date, age(current_date, hire_date), extract(day from age(current_date, hire_date))
from employees;
'''
hire_date	age	date_part
1991-11-18	27 years 8 mons 21 days	21
1991-05-01	28 years 3 mons 8 days	8
1991-06-09	28 years 2 mons	0
1991-04-02	28 years 4 mons 7 days	7
1991-02-20	28 years 5 mons 17 days	17
1991-02-22	28 years 5 mons 15 days	15
1991-09-28	27 years 10 mons 11 days	11
1991-09-08	27 years 11 mons 1 day	1
1997-05-23	22 years 2 mons 17 days	17
1991-12-03	27 years 8 mons 6 days	6
1992-01-23	27 years 6 mons 17 days	17
1997-04-19	22 years 3 mons 20 days	20
1991-12-03	27 years 8 mons 6 days	6
1990-12-18	28 years 7 mons 22 days	22
'''