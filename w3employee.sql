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

#28. Write a query in SQL to list the id, name, (salary), and experiences of all the employees working for the manger 68319
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

#51. Write a query in SQL to list all the employees who joined before [1991] or after 1991.
select *
from employees
where to_char(hire_date, 'YYYY') > '1991'
or to_char(hire_date, 'YYYY') < '1991';
#also
select *
from employees
where to_char(hire_date, 'YYYY') not in ('1991');

#52. Write a query in SQL to list the employees along with department name.
select e.emp_name, e.dep_id, d.dep_name
from employees e, department d
where e.dep_id = d.dep_id;

#53. Write a query in SQL to list the name, job name, annual salary, department id, department name and grade of the employees who earn 60000 in a year or not working as an ANALYST.
select e.emp_name, e.job_name, e.salary, e.dep_id, d.dep_id, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal;
#official solution with additional criteria and salary is monthly.  RM:  first time I wrote between in the join on statement.  between join between.
select e.emp_name, e.job_name, e.salary, e.dep_id, d.dep_id, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.salary >=5000
or e.job_name <> 'ANALYST';

#54. Write a query in SQL to list the name, job name, manager id, salary, manager name, manager's salary for those employees whose salary is greater than the salary of their managers.  #RM:  self-join, join same table join, self join.
select e.emp_name, e.job_name, e.manager_id, e.salary, m.emp_name as "Manager Name", m.salary as "Manager Salary"
from employees e, employees m
where e.manager_id = m.emp_id
and e.salary > m.salary;

#55. Write a query in SQL to list the employees name, department, salary and commission. For those whose salary is between 2000 and 5000 while location is PERTH.
select e.emp_name, d.dep_name, e.salary, e.commission
from employees e join department d
on e.dep_id = d.dep_id
where e.salary between 2000 and 5000
and d.dep_location = 'PERTH';

#56. Write a query in SQL to list the grade, employee name for the department id 1001 or 3001 but salary grade is not 4 while they joined the company before 1992-12-31.  RM:  first time I wrote between in the join on statement.  between join between.
select s.grade, e.emp_name
from salary_grade s join employees e
on e.salary between s.min_sal and s.max_sal;
select s.grade, e.emp_name
from salary_grade s join employees e
on e.salary between s.min_sal and s.max_sal
where e.dep_id in (1001, 3001)
and s.grade not in (4)
and hire_date < '1992-12-31';

#57. Write a query in SQL to list the employees whose manager name is JONAS.  #RM:  self-join, join same table join, self join.
select e.*
from employees e, employees m
where e.manager_id = m.emp_id
and manager_id = (
	select e.emp_id
	from employees e
	where e.emp_name = 'JONAS');

#58. Write a query in SQL to list the name and salary of FRANK if his salary is equal to max_sal of his grade.  RM:  first time I wrote between in the where join statement.  between where between.
select e.emp_name, e.salary, s.grade
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal;
select e.emp_name, e.salary, s.grade
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and e.emp_name = 'FRANK'
and e.salary = s.max_sal;

#59. Write a query in SQL to list the employees who are working either MANAGER or ANALYST with a salary range between 2000 to 5000 without any commission.
select *
from employees
where job_name in ('MANAGER','ANALYST')
and salary between 2000 and 5000
and commission is null;

#60. Write a query in SQL to list the id, name, salary, and location of the employees working at PERTH,or MELBOURNE with an experience over 10 years.
select e.emp_id, e.emp_name, e.salary, d.dep_location
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_location in ('PERTH','MELBOURNE')
and extract(month from age(current_date, hire_date)) > 10;

#61. Write a query in SQL to list the employees along with their location who belongs to SYDNEY, MELBOURNE with a salary range between 2000 and 5000 and joined in 1991.
select e.*, d.dep_location
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_location in ('SYDNEY','MELBOURNE')
and salary >= 2000 and salary <= 5000
and hire_date >= '1991-01-01' and hire_date <= '1991-12-31';
#official solution
select e.emp_id, e.emp_name, e.dep_id, e.salary, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and d.dep_location in ('SYDNEY', 'MELBOURNE')
and to_char(e.hire_date,'yy') = '91'
and e.salary between 2000 and 5000;

#62. Write a query in SQL to list the employees with their location and grade for MARKETING department who comes from MELBOURNE or PERTH within the grade 3 to 5 and experience over 5 years.
select e.*, d.dep_location, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where d.dep_name = 'MARKETING'
and d.dep_location in ('MELBOURNE','PERTH')
and s.grade in (3, 4, 5)
and extract(month from age(current_date, hire_date)) > 5;

#63. Write a query in SQL to list the employees who are senior to their own manager.  #RM:  looked at solution.  What employee's hire date earlier than their manager's hire date.
select e.emp_name as "Employee Name", e.hire_date as "Employee Hire Date", m.emp_name as "Manager Name", m.hire_date as "Manager Hire Date"
from employees e, employees m
where e.manager_id = m.emp_id
and e.hire_date < m.hire_date;

#64. Write a query in SQL to list the employee with their grade for the grade 4.
select employees.*, salary_grade.grade
from employees join salary_grade
on employees.salary between salary_grade.min_sal and salary_grade.max_sal
and salary_grade.grade = 4;

#65. Write a query in SQL to list the employees in department PRODUCTION or AUDIT who joined after 1991 and they are not MARKER or ADELYN to their name.
select e.*
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_name in ('PRODUCTION','AUDIT')
and e.hire_date >= '1992-01-01'
and e.emp_name not in ('MARKER','ADELYN');

#66. Write a query in SQL to list the employees in the ascending order of their salaries.
select *
from employees
order by salary asc;

#67. Write a query in SQL to list the details of the employees in ascending order to the department_id and descending order to the jobs.  #RM:  dep_id asc and job_name desc
select *
from employees
order by dep_id asc, job_name desc;

#68. Write a query in SQL to display all the unique job in descending order.
select distinct job_name
from employees
order by job_name desc;

#69. Write a query in SQL to list the id, name, monthly salary, daily salary of all the employees in the ascending order of their annual salary.
select emp_id, emp_name, salary, salary/30 as "Daily Salary", salary*12 as "Annual Salary"
from employees
order by "Annual Salary" asc;
#also
select emp_id, emp_name, salary, salary/30 as "Daily Salary", salary*12 as "Annual Salary"
from employees
order by 5 asc;

#70. Write a query in SQL to list the employees in descending order who are either 'CLERK' or 'ANALYST'.  #RM:  solution says sort by job_name desc
select *
from employees
where job_name in ('CLERK','ANALYST')
order by job_name desc;

#71. Write a query in SQL to display the location of CLARE.
select e.emp_name, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and e.emp_name = 'CLARE';

#72. Write a query in SQL to list the employees in ascending order of seniority who joined on 1-MAY-91,or 3-DEC-91, or 19-JAN-90.
select *
from employees
where hire_date in ('1991-05-01','1991-12-03','1990-01-19')
order by hire_date asc;

#73. Write a query in SQL to list the employees who are drawing the salary less than 1000 and sort the output in ascending order on salary.
select *
from employees
where salary < 1000
order by salary asc;

#74. Write a query in SQL to list the details of the employees in ascending order on the salary.
select *
from employees
order by salary asc;

#75. Write a query in SQL to list the employees in ascending order on job name and descending order on employee id.
select *
from employees
order by job_name asc, emp_id desc;

#76. Write a query in SQL to list the unique jobs of department 2001 and 3001 in descending order.
select distinct job_name
from employees
where dep_id in (2001,3001)
order by 1 desc;

#77. Write a query in SQL to list all the employees except PRESIDENT and MANAGER in ascending order of salaries.
select *
from employees
where job_name not in ('PRESIDENT','MANAGER')
order by salary asc;

#78. Write a query in SQL to list the employees in ascending order of the salary whose annual salary is below 25000.
select *
from employees
where salary < 25000/12
order by salary asc;

#79. Write a query in SQL to list the employee id, name, annual salary, daily salary of all the employees in the ascending order of annual salary who works as a SALESMAN.
select emp_id, emp_name, salary*12 as "Annual Salary", salary
from employees
where job_name = 'SALESMAN'
order by salary asc;

#80. Write a query in SQL to list the employee id, name, hire_date, current date and experience of the employees in ascending order on their experiences.  #subtract date
select emp_id, emp_name, hire_date, current_date, (current_date-hire_date)/365 as "Number Of Years", age(CURRENT_DATE, hire_date) EXP
from employees
order by 5 asc;
/*
emp_id	emp_name	hire_date	date	Number Of Years	exp
67858	SCARLET	1997-04-19	2019-05-24	22	22 years 1 mon 5 days
68736	ADNRES	1997-05-23	2019-05-24	22	22 years 1 day
68319	KAYLING	1991-11-18	2019-05-24	27	27 years 6 mons 6 days
67832	CLARE	1991-06-09	2019-05-24	27	27 years 11 mons 15 days
66564	MADDEN	1991-09-28	2019-05-24	27	27 years 7 mons 26 days
68454	TUCKER	1991-09-08	2019-05-24	27	27 years 8 mons 16 days
69000	JULIUS	1991-12-03	2019-05-24	27	27 years 5 mons 21 days
69324	MARKER	1992-01-23	2019-05-24	27	27 years 4 mons 1 day
69062	FRANK	1991-12-03	2019-05-24	27	27 years 5 mons 21 days
64989	ADELYN	1991-02-20	2019-05-24	28	28 years 3 mons 4 days
65271	WADE	1991-02-22	2019-05-24	28	28 years 3 mons 2 days
66928	BLAZE	1991-05-01	2019-05-24	28	28 years 23 days
63679	SANDRINE	1990-12-18	2019-05-24	28	28 years 5 mons 6 days
65646	JONAS	1991-04-02	2019-05-24	28	28 years 1 mon 22 days
*/

#81. Write a query in SQL to list the employees in ascending order of designations of those, joined after the second half of 1991.  #RM:  order by job_name
select *
from employees
where hire_date >= '1991-07-01' and hire_date <='1991-12-31'
order by job_name asc;

#82. Write a query in SQL to list the total information of employees table along with department, and location of all the employees working under FINANCE and AUDIT in the ascending department no.
select e.*, d.*
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_name in ('FINANCE','AUDIT')
order by d.dep_id asc;

#83. Write a query in SQL to display the total information of the employees along with grades in ascending order.  #RM:  range where statement range where join statement range join
select e.*, s.grade
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
order by s.grade;
#also
select e.*, s.grade
from employees e, salary_grade s
where e.salary >= s.min_sal
and e.salary <= s.max_sal
order by s.grade;

#84. Write a query in SQL to list the name, job name, department, salary, and grade of the employees according to the department in ascending order.  #RM:  order by d.dep_id.
select e.emp_name, e.job_name, d.dep_name, e.salary, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
order by d.dep_id;

#85. Write a query in SQL to list the name, job name, salary, grade and department name of employees except CLERK and sort result set on the basis of highest salary.
select e.emp_name, e.job_name, e.salary, s.grade, d.dep_name
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where job_name not in ('CLERK')
order by e.salary desc;

#86. Write a query in SQL to list the employee ID, name, salary, department, grade, experience, and annual salary of employees working for department 1001 or 2001.
select e.emp_id, e.emp_name, e.salary, d.dep_name, s.grade, age(CURRENT_DATE, hire_date) as "Experience", e.salary*12 as "Annual Salary"
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.dep_id in (1001, 2001)
order by e.salary desc;

#87. Write a query in SQL to list the details of the employees along with the details of their departments.
select e.*, d.*
from employees e, department d
where e.dep_id = d.dep_id;

#88. Write a query in SQL to list the employees who are senior to their own MANAGERS.
select e.emp_name as "Employee", e.hire_date as "Employee Hire Date", m.emp_name as "Manager", m.hire_date as "Manager Hire Date"
from employees e join employees m
on e.manager_id = m.emp_id
where e.hire_date < m.hire_date;

#89. Write a query in SQL to list the employee id, name, salary, and department id of the employees in ascending order of salary who works in the department 1001.
select emp_id, emp_name, salary, dep_id
from employees
where dep_id = 1001
order by salary;

#90. Write a query in SQL to find the highest salary from all the employees.
select *
from employees
where salary = (
	select max(salary)
	from employees);

#91. Write a query in SQL to find the average salary and average total remuneration(salary and commission) for each type of job.
select avg(salary)
from employees;  #return 2214.7857142857142857
select avg(salary+commission)
from employees;  #return 2125.0000000000000000
select avg(salary+commission)
from employees
where commission is not null;  #return 2125.0000000000000000
select avg(salary+commission)
from employees
where commission > 0; #return 2300.0000000000000000  RM:  there is an entry with a zero.  Correct answer may be 2300 confirmed on Excel.  Three employees with salary and commission greater than zero.
select avg(salary+commission)
from employees
where commission >= 0; #return 2125.0000000000000000  RM:  there is an entry with a zero.  Correct answer may be 2125 confirmed on Excel.  Four employees with salary and commission not null.
select avg(salary) as "Avg Salary", avg(salary+commission) as "Avg Salary and Commission"
from employees;  #return 2214.7857142857142857, 2125.0000000000000000
select job_name, avg(salary) as "Avg Salary", avg(salary+commission) as "Avg Salary and Commission"
from employees
group by job_name;

#92. Write a query in SQL to find the total annual salary distributed against each job in the year 1991.  #RM:  Looked at solution.  Employees hired in 1991 annual salary grouped by job_name.
select job_name, sum(salary*12) as "Annual Salary"
from employees
where to_char(hire_date,'yyyy') = '1991'
group by job_name;

#93. Write a query in SQL to list the employee id, name, department id, location of all the employees.
select e.emp_id, e.emp_name, e.dep_id, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id;

#94. Write a query in SQL to list the employee id, name, location, department of all the departments 1001 and 2001.
select e.emp_id, e.emp_name, e.dep_id, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and e.dep_id in (1001, 2001);

#95. Write a query in SQL to list the employee id, name, salary, grade of all the employees.
select e.emp_id, e.emp_name, e.salary, s.grade
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
order by e.salary;

#96. Write a query in SQL to list the manager no and the number of employees working for those managers in ascending order on manager id.
select manager_id, count(manager_id)
from employees
where manager_id is not null
group by manager_id
order by manager_id;

#97. Write a query in SQL to display the number of employee for each job in each department.  #RM:  solution wanted group by dep_id and job_name.
select dep_id, job_name, count(*)
from employees
group by dep_id, job_name;

#98. Write a query in SQL to list the department where at least two employees are working.  #RM:  changed question to at least 4.  All departments have at least two.
select dep_id, count(emp_name)
from employees
group by dep_id
having count(emp_name) >= 4;

#99. Write a query in SQL to display the Grade, Number of employees, and maximum salary of each grade.
select s.grade, count(e.emp_name), max(e.salary)
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
group by s.grade
order by s.grade;

#100. Write a query in SQL to display the department name, grade, no. of employees where at least two employees are working as a SALESMAN.
select d.dep_name, s.grade, count(emp_name)
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.job_name = 'SALESMAN'
group by d.dep_name, s.grade
having count(emp_name) >= 2;

#101. Write a query in SQL to list the no. of employees in each department where the [number] is less than 4.
select dep_id, count(emp_name)
from employees
group by dep_id
having count(emp_name) < 4;

#102. Write a query in SQL to list the name of departments where atleast 2 employees are working in that department.
select d.dep_name, count(e.emp_name)
from employees e join department d
on e.dep_id = d.dep_id
group by d.dep_name
having count(e.emp_name) >= 2;

#103. Write a query in SQL to check whether all the employees numbers are indeed unique.
select emp_id, count(emp_id)
from employees
group by emp_id
having count(emp_id) >= 2;

#104. Write a query in SQL to list the no. of employees and average salary within each department for each job name.
select dep_id, job_name, count(emp_name), avg(salary)
from employees
group by dep_id, job_name;