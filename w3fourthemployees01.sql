#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/subqueries-exercises-on-employee-database.php

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

#28. Write a query in SQL to list the id, name, [salary], and experiences of all the employees working for the manger 68319.
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

#45. Write a query in SQL to list the employees who have joined on the following dates 1st May,20th Feb, and 03rd Dec in the year 1991.
select *
from employees
where hire_date in ('1991-05-01','1991-02-20','1991-12-03');

#46. Write a query in SQL to list the employees working under the managers 63679,68319,66564,69000.
select *
from employees
where manager_id in (63679,68319,66564,69000);

#47. Write a query in SQL to list the employees who joined after the month JUNE in the year 1991.  #RM:  find employees hired June-December in the year 1991.
select *
from employees
where to_char(hire_date,'yyyy') = '1991'
and to_char(hire_date,'mm') > '06';

#48. Write a query in SQL to list the employees who joined in 90's.
select *
from employees
where to_char(hire_date,'yyyy') >= '1990'
and to_char(hire_date,'yyyy') <= '1999';

#49. Write a query in SQL to list the managers of department 1001 or 2001.  #RM:  want to find job_name MANAGER in dep_id 1001 or 2001
select *
from employees
where emp_id in (
	select distinct manager_id
	from employees
	where dep_id in (1001,2001));
#answers the question
select *
from employees
where dep_id in (1001,2001)
and job_name = 'MANAGER';

#50. Write a query in SQL to list the employees, joined in the month FEBRUARY with a salary range between 1001 to 2000.
select *
from employees
where to_char(hire_date,'mm') = '02'
and salary between 1001 and 2000;

#51. Write a query in SQL to list all the employees who joined before or after 1991.
select *
from employees
where to_char(hire_date,'yyyy') <> '1991';

#52. Write a query in SQL to list the employees along with department name.
select e.*, d.dep_name
from employees e, department d
where e.dep_id = d.dep_id;

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

#55. Write a query in SQL to list the employees name, department, salary and commission. For those whose salary is between 2000 and 5000 while location is PERTH.
select emp_name, dep_name, salary, commission
from employees e join department d
on e.dep_id = d.dep_id
where e.salary between 2000 and 5000
and d.dep_location = 'PERTH';

#56. Write a query in SQL to list the grade, employee name for the department id 1001 or 3001 but salary grade is not 4 while they joined the company before 1992-12-31.
select s.grade, e.emp_name
from salary_grade s, employees e
where e.salary between s.min_sal and s.max_sal
and e.dep_id in (1001,3001)
and s.grade not in (4)
and e.hire_date <= '1992-12-31';

#57. Write a query in SQL to list the employees whose manager name is JONAS.
select *
from employees
where manager_id in (
	select emp_id
	from employees
	where emp_name = 'JONAS');

#58. Write a query in SQL to list the name and salary of FRANK if his salary is equal to max_sal of his grade.
select e.emp_name, e.salary
from salary_grade s, employees e
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

#61. Write a query in SQL to list the employees along with their location who belongs to SYDNEY, MELBOURNE with a salary range between 2000 and 5000 and joined in 1991.
select e.*, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and d.dep_location in ('SYDNEY','MELBOURNE')
and e.salary between 2000 and 5000
and to_char(e.hire_date,'yyyy') = '1991';

#62. Write a query in SQL to list the employees with their location and grade for MARKETING department who comes from MELBOURNE or PERTH within the grade 3 to 5 and experience over 5 years.
select e.*, d.dep_location, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where d.dep_name = 'MARKETING'
and d.dep_location in ('MELBOURNE','PERTH')
and s.grade between 3 and 5
and extract(year from age(current_date,e.hire_date)) > 5;

#63. Write a query in SQL to list the employees who are senior to their own manager. #RM:  self-join
select workers.emp_name "worker", workers.hire_date as "worker date", manager.emp_name as "manager", manager.hire_date as "manager date"
from employees workers, employees manager
where workers.manager_id = manager.emp_id
and workers.hire_date > manager.hire_date;

#64. Write a query in SQL to list the employee with their grade for the grade 4.
select *
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and s.grade = 4;

#65. Write a query in SQL to list the employees in department PRODUCTION or AUDIT who joined after 1991 and they are not MARKER or ADELYN to their name.
select *
from employees e, department d
where e.dep_id = d.dep_id
and d.dep_name in ('PRODUCTION','AUDIT')
and e.hire_date >= '1992-01-01'
and e.emp_name not in ('MARKER','ADELYN');

#66. Write a query in SQL to list the employees in the ascending order of their salaries.
select *
from employees
order by salary asc;

#67. Write a query in SQL to list the details of the employees in ascending order to the department_id and descending order to the jobs.
select *
from employees
order by dep_id asc, job_name desc;

#68. Write a query in SQL to display all the unique job in descending order.
select distinct job_name
from employees
order by job_name desc;

#69. Write a query in SQL to list the id, name, monthly salary, daily salary of all the employees in the ascending order of their annual salary.
select emp_id, emp_name, salary, salary/30 as "daily salary", salary*12 as "annual salary"
from employees
order by salary*12 asc;

#70. Write a query in SQL to list the employees in descending order who are either 'CLERK' or 'ANALYST'.
select *
from employees
where job_name in ('CLERK','ANALYST')
order by job_name desc;

#71. Write a query in SQL to display the location of CLARE.
select dep_location
from department
where dep_id = (
	select dep_id
	from employees
	where emp_name = 'CLARE');

#72. Write a query in SQL to list the employees in ascending order of seniority who joined on 1-MAY-91,or 3-DEC-91, or 19-JAN-90.
select *
from employees
where hire_date in ('1991-05-01','1991-12-03','1990-01-19')
order by hire_date asc;

#73. Write a query in SQL to list the employees in ascending order of seniority who joined on 1-MAY-91,or 3-DEC-91, or 19-JAN-90.
select *
from employees
where salary < 1000
order by salary;

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
order by dep_id desc;

#77. Write a query in SQL to list all the employees except PRESIDENT and MANAGER in ascending order of salaries.
select *
from employees
where job_name not in ('PRESIDENT','MANAGER')
order by salary asc;

#78. Write a query in SQL to list the employees in ascending order of the salary whose annual salary is below 25000.
select *
from employees
where salary*12 < 25000
order by salary asc;

#79. Write a query in SQL to list the employee id, name, annual salary, daily salary of all the employees in the ascending order of annual salary who works as a SALESMAN.  #RM:  sort alias sort by aslias
select emp_id, emp_name, salary*12 as "annual salary", (salary*12)/365 as "daily salary"
from employees
where job_name = 'SANDRINE'
order by "annual salary" asc;

#80. Write a query in SQL to list the employee id, name, hire_date, current date and experience of the employees in ascending order on their experiences.
select *, age(current_date,hire_date) as "experience"
from employees
order by experience asc;

#81. Write a query in SQL to list the employees in ascending order of designations of those, joined after the second half of 1991.
select *
from employees
where hire_date >='1991-06-01' and hire_date <='1991-12-31'
order by job_name asc;

#82. Write a query in SQL to list the total information of employees table along with department, and location of all the employees working under FINANCE and AUDIT in the ascending department no.
select e.*, d.dep_name, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and d.dep_name in ('FINANCE','AUDIT')
order by d.dep_id asc;

#83. Write a query in SQL to display the total information of the employees along with grades in ascending order.
select *
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
order by s.grade asc;
#also
select *
from employees e, salary_grade s
where e.salary >= s.min_sal
and e.salary <= s.max_sal
order by s.grade asc;

#84. Write a query in SQL to list the name, job name, department, salary, and grade of the employees according to the department in ascending order.
select e.emp_name, e.job_name, d.dep_name, e.salary, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary >= s.min_sal and e.salary <=s.max_sal
order by e.dep_id asc;

#85. Write a query in SQL to list the name, job name, salary, grade and department name of employees except CLERK and sort result set on the basis of highest salary.
select e.emp_name, e.job_name, e.salary, s.grade, d.dep_name
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.job_name not in ('CLERK')
order by e.salary desc;

#86. Write a query in SQL to list the employee ID, name, salary, department, grade, experience, and annual salary of employees working for department 1001 or 2001.
select e.emp_id, e.emp_name, e.salary, d.dep_name, s.grade, age(current_date,hire_date) as "experience", salary*12 as "annual salary"
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.dep_id in (1001,2001);

#87. Write a query in SQL to list the details of the employees along with the details of their departments.
select e.*, d.dep_name, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id;

#88. Write a query in SQL to list the employees who are senior to their own MANAGERS.  #RM:  same as question 63
select workers.emp_name "worker", workers.hire_date as "worker date", manager.emp_name as "manager", manager.hire_date as "manager date"
from employees workers, employees manager
where workers.manager_id = manager.emp_id
and workers.hire_date > manager.hire_date;

#89. Write a query in SQL to list the employee id, name, salary, and department id of the employees in ascending order of salary who works in the department 1001.
select *
from employees
where dep_id = 1001
order by salary asc;

#90. Write a query in SQL to find the highest salary from all the employees.
select salary
from employees
order by salary desc limit 1;  #RM:  analysis paralysis
select max(salary)
from employees;

#91. Write a query in SQL to find the average salary and average total remuneration(salary and commission) for each type of job.
select job_name, avg(salary) as "salary", avg(salary+commission) as "salary+commission"
from employees
group by job_name;

#92. Write a query in SQL to find the total annual salary distributed against each job in the year 1991.
select job_name, sum(salary*12)
from employees
where hire_date between '1991-01-01' and '1991-12-31'
group by job_name;

#93. Write a query in SQL to list the employee id, name, department id, location of all the employees.
select e.emp_id, e.emp_name, e.dep_id, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id;

#94. Write a query in SQL to list the employee id, name, location, department of all the departments 1001 and 2001.
select e.emp_id, e.emp_name, d.dep_location, d.dep_name
from employees e, department d
where e.dep_id = d.dep_id
and e.dep_id in (1001,2001);

#95. Write a query in SQL to list the employee id, name, salary, grade of all the departments 1001 and 2001.
select e.emp_id, e.emp_name, e.salary, s.grade
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and e.dep_id in (1001,2001);

#96. Write a query in SQL to list the manager no and the number of employees working for those managers in ascending order on manager id.
select manager_id, count(manager_id)
from employees
where manager_id is not null
group by manager_id
order by manager_id;

#97. Write a query in SQL to display the number of employee for each job in each department.  RM:  count number of employees by department and by job.
select dep_id, job_name, count(*)
from employees
group by dep_id, job_name;

#98. Write a query in SQL to list the department where at least two employees are working.
select dep_id, count(*)
from employees
group by dep_id
having count(*) >= 2;

#99. Write a query in SQL to display the Grade, Number of employees, and maximum salary of each grade.
select s.grade, count(*), max(e.salary)
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
group by s.grade
order by s.grade;

#100. Write a query in SQL to display the department name, grade, no. of employees where at least two employees are working as a SALESMAN.
select d.dep_name, s.grade, count(e.*)
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where job_name = 'SALESMAN'
group by d.dep_name, s.grade
having count(e.*) >= 2;

#101. Write a query in SQL to list the no. of employees in each department where the no. is less than 4.
select dep_id, count(*)
from employees
group by dep_id
having count(*) < 4;

#102. Write a query in SQL to list the name of departments where atleast 2 employees are working in that department.
select d.dep_name, count(e.*)
from employees e, department d
where e.dep_id = d.dep_id
group by d.dep_name
having count(e.*) >= 2;

#103. Write a query in SQL to check whether all the employees numbers are indeed unique.
select emp_id, count(emp_id) as "Two or more there is a duplicate"
from employees
group by emp_id
having count(emp_id) >=2;

#104. Write a query in SQL to list the no. of employees and average salary within each department for each job name.
select dep_id, job_name, count(*), avg(salary)
from employees
group by dep_id, job_name;

#105. Write a query in SQL to list the names of those employees starting with 'A' and with six characters in length.
select *
from employees
where emp_name like 'A_____';
#official solution
select *
from employees
where emp_name like 'A%'
and length(emp_name) = 6;

#106. Write a query in SQL to list the employees whose name is six characters in length and third character must be 'R'.
select *
from employees
where emp_name like '__R___';

#107. Write a query in SQL to list the name of the employee of six characters long and starting with 'A' and ending with 'N'.
select *
from employees
where emp_name like 'A____N';

#108. Write a query in SQL to list the employees who joined in the month of which second character is 'a'.
select *, to_char(hire_date,'Month')
from employees
where to_char(hire_date,'Month') like '_a%';

#109. Write a query in SQL to list the employees whose names containing the character set 'AR' together.
select *
from employees
where emp_name like '%AR%'
or emp_name like 'AR%'
or emp_name like '%AR';

#110. Write a query in SQL to list the employees those who joined in 90's.  RM:  It's not 1990 year itself.
select *
from employees
where to_char(hire_date,'yyyy') like '199%';
#also
select *
from employees
where to_char(hire_date,'yyyy') >= '1990'
and to_char(hire_date,'yyyy') <= '1999';

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

#112. Write a query in SQL to list the employees whose names containing the letter 'A'.
select *
from employees
where emp_id like '%A%';

#113. Write a query in SQL to list the employees whose name is ending with 'S' and six characters long.
select *
from employees
where emp_name like '_____S';

#114. Write a query in SQL to list the employees who joined in the month having char 'A' at any position.
select *, to_char(hire_date,'Month')
from employees
where to_char(hire_date,'Month') like '%a%'
or to_char(hire_date,'Month') like 'A%';
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id	to_char
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001	May
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001	April
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001	February
65271	WADE	SALESMAN	66928	1991-02-22	1350.00	600.00	3001	February
68736	ADNRES	CLERK	67858	1997-05-23	1200.00		2001	May
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001	January
67858	SCARLET	ANALYST	65646	1997-04-19	3100.00		2001	April
*/

#115. Write a query in SQL to list the employees who joined in the month having second char is 'A'.
select *, to_char(hire_date,'MONTH')
from employees
where to_char(hire_date,'MONTH') like '_A%';
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id	to_char
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001	MAY
68736	ADNRES	CLERK	67858	1997-05-23	1200.00		2001	MAY
69324	MARKER	CLERK	67832	1992-01-23	1400.00		1001	JANUARY
*/

#https://www.w3resource.com/sql-exercises/employee-database-exercise/subqueries-exercises-on-employee-database.php
#1. Write a query in SQL to display all the details of managers.
select *
from employees
where emp_id in (
	select distinct manager_id
	from employees);

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

#3. Write a query in SQL to list the employee ID, name, salary, department name of all the 'MANAGERS' and 'ANALYST' working in SYDNEY, PERTH with an exp more than 5 years without receiving the commission and display the list in ascending order of location.
select e.*, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and e.job_name in ('MANAGER','ANALYST')
and d.dep_location in ('SYDNEY','PERTH')
and to_number(to_char(current_date,'yyyy'),'0000') - to_number(to_char(hire_date,'yyyy'),'0000') > 5
and e.commission is null
order by d.dep_location asc;

#4. Write a query in SQL to display the employee ID, name, salary, department name, location, department ID, job name of all the employees working at SYDNEY or working in the FINANCE deparment with an annual salary above 28000, but the monthly salary should not be 3000 or 2800 and who does not works as a MANAGER and whose ID containing a digit of '3' or '7' in 3rd position. List the result in ascending order of department ID and descending order of job name.  RM:  dumb question.  Copied solution
#official solution
select e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, e.dep_id, e.job_name
from employees e, department d
where (d.dep_location = 'SYDNEY' or d.dep_name = 'FINANCE')
and e.dep_id = d.dep_id
and e.emp_id in (
	select emp_id
	from employees e
	where (12*e.salary) > 28000
	and e.salary not in (3000,2800)
	and e.job_name !='MANAGER'
	and (trim(to_char(emp_id,'99999')) like '__3%' or trim(to_char(emp_id,'99999')) like '__7%'))
order by e.dep_id asc, e.job_name desc;

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

#6. Write a query in SQL to display all the employees of grade 4 and 5 who are working as ANALYST or MANAGER.
select e.*
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and s.grade in (4,5)
and e.job_name in ('ANALYST','MANAGER');

#7. Write a query in SQL to list the details of the employees whose salary is more than the salary of JONAS.
select *
from employees
where salary > (
	select salary
	from employees
	where emp_name = 'JONAS');

#8. Write a query in SQL to list the employees who works in the same designation as FRANK.
select *
from employees
where job_name = (
	select job_name
	from employees
	where emp_name = 'FRANK');

#9. List the employees who are senior to ADELYN[.]
select *
from employees
where hire_date < (
	select hire_date
	from employees
	where emp_name = 'ADELYN');

#10. Write a query in SQL to list the employees of department ID 2001 who works in the designation same as department ID 1001.  #RM:  looking at solutions, find employees working in department id 2001 and have the same job titles in department id 1001.  Dumb question.
select *
from employees
where dep_id = 2001
and job_name in (
	select job_name
	from employees
	where dep_id = 1001);

#11. Write a query in SQL to list the employees whose salary is same as the salary of FRANK or SANDRINE. List the result in descending order of salary.
select *
from employees
where salary in (
	select salary
	from employees
	where emp_name in ('FRANK','SANDRINE'));
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
67858	SCARLET	ANALYST	65646	1997-04-19	3100.00		2001
69062	FRANK	ANALYST	65646	1991-12-03	3100.00		2001
63679	SANDRINE	CLERK	69062	1990-12-18	900.00		2001
*/
select *
from employees
where salary in (
	select salary
	from employees
	where emp_name in ('FRANK','SANDRINE'))
and emp_name not in ('FRANK','SANDRINE')
order by salary desc;

#12. Write a query in SQL to list the employees whose designation are same as the designation of MARKER or salary is more than the salary of ADELYN.
select *
from employees
where (job_name = (
	select job_name
	from employees
	where emp_name = 'MARKER')
and emp_name not in ('MARKER'))
or (salary > (
	select salary
	from employees
	where emp_name = 'ADELYN')
and emp_name <> 'ADELYN');

#13. Write a query in SQL to list the employees whose salary is more than the total remuneration of the SALESMAN.  #RM:  employees greater than all salary+commission
select *
from employees
where salary > all (
	select salary+commission
	from employees
	where job_name = 'SALESMAN');
#official answer is better
select *
from employees
where salary > (
	select max(salary+commission)
	from employees
	where job_name = 'SALESMAN');

#14. Write a query in SQL to list the employees who are senior to BLAZE and working at PERTH or BRISBANE.
select e.*
from employees e, department d
where e.dep_id = d.dep_id
and e.hire_date < (
	select hire_date
	from employees
	where emp_name = 'BLAZE')
and e.dep_id in (
	select dep_id
	from department
	where dep_location in ('PERTH','BRISBANE'));

#15. Write a query in SQL to list the employees of grade 3 and 4 working in the department of FINANCE or AUDIT and whose salary is more than the salary of ADELYN and experience is more than FRANK. List the result in the ascending order of experience.  RM:  experience is seniority, not the experience formula to_number(to_char(current_date,'yyyy'),'0000') - to_number(to_char(hire_date,'yyyy'),'0000').
select e.*
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where s.grade in (3,4)
and e.dep_id in (
	select dep_id
	from department
	where dep_name in ('FINANCE','AUDIT'))
and e.salary > (
	select salary
	from employees
	where emp_name = 'ADELYN')
and e.hire_date < (
	select hire_date
	from employees
	where emp_name = 'FRANK')
order by e.hire_date asc;

#16. Write a query in SQL to list the employees whose designation is same as the designation of SANDRINE or ADELYN.
select *
from employees
where job_name in (
	select job_name
	from employees
	where emp_name in ('SANDRINE','ADELYN'));

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

#18. Write a query in SQL to find the details of highest paid employee.
select *
from employees
where salary in (
	select max(salary)
	from employees);

#19. Write a query in SQL to find the highest paid employees in the department MARKETING.
select *
from employees
where salary = (
	select max(salary)
	from employees e, department d
	where e.dep_id = d.dep_id
	and d.dep_name = 'MARKETING');

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

#21. Write a query in SQL to list the employees who are senior to most recently hired employee working under KAYLING.  #RM:  find the employees who are senior to the most recent employee working under KAYLING.
select *
from employees
where hire_date < (
	select max(hire_date)
	from employees
	where manager_id = (
		select emp_id
		from employees
		where emp_name = 'KAYLING'));

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

 #23. Write a query in SQL to list the details of the senior employees as on year 1991.  #RM:  find the earliest employee hired in 1991.
 select *
 from employees
 where hire_date in (
 	select min(hire_date)
 	from employees
 	where to_char(hire_date,'YYYY') = '1991');

#24. Write a query in SQL to list the employees who joined in 1991 in a designation same as the most senior person of the year 1991.
select *
from employees
where to_char(hire_date,'YYYY') = '1991'
and job_name in (
	select job_name
	from employees
	where hire_date in (
		select min(hire_date)
		from employees
		where to_char(hire_date,'YYYY') = '1991'));

#25. Write a query in SQL to list the most senior employee working under KAYLING and grade is more than 3.
select *
from employees e, salary_grade s
where e.hire_date in (
	select min(hire_date)
	from employees
	where manager_id in (
		select emp_id
		from employees
		where emp_name = 'KAYLING'))
and e.salary between s.min_sal and s.max_sal
and s.grade >= 4;

#26. Write a query in SQL to find the total salary given to the MANAGER.
select sum(salary)
from employees
where job_name in ('MANAGER');

#27. Write a query in SQL to display the total salary of employees belonging to grade 3.
select sum(e.salary)
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and s.grade = 3;

#28. Write a query in SQL to list the employees in department 1001 whose salary is more than the average salary of employees in department 2001.
select *
from employees
where dep_id = 1001
and salary > (
	select avg(salary)
	from employees
	where dep_id = 2001);

#29. Write a query in SQL to list the details of the departments where maximum number of employees are working.  #RM:  departments where greatest number of employees are working
select *
from department
where dep_id in (
	select dep_id
	from employees
	group by dep_id
	order by count(dep_id) desc limit 1);

#30. Write a query in SQL to display the employees whose manager name is JONAS.
select *
from employees
where manager_id in (
	select emp_id
	from employees
	where emp_name = 'JONAS');

#31. Write a query in SQL to list the employees who are not working in the department MARKETING.
select *
from employees
where dep_id not in (
	select dep_id
	from department
	where dep_name = 'MARKETING');

#32. Write a query in SQL to list the name, job name, department name, location for those who are working as a manager.  #RM:  not job_name is MANAGER.  Employees who are managers.
select e.*, d.*
from employees e, department d
where e.dep_id = d.dep_id
and e.emp_id in (
	select manager_id
	from employees);

#33. Write a query in SQL to list the name of the employees who are getting the highest salary of each department.
select *
from employees
where salary in (
	select max(salary)
	from employees
	group by dep_id);

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

#37. Write a query in SQL to list the name and average salary of employees in department wise.  #column name alias as column name
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

#39. Write a query in SQL to list the managers who are not working under the PRESIDENT.  #RM:  want employees who are managers, not employees only.
select *
from employees
where emp_id in (
	select manager_id
	from employees)
and manager_id not in (
	select emp_id
	from employees
	where job_name = 'PRESIDENT');

#40. Write a query in SQL to list the name, salary, commission and netpay for those employees whose netpay is more than any other employee.  #RM:  I don't understand the point of netpay.
select e.emp_name, e.salary, e.commission, (select sum(salary + commission) from employees) netpay
from employees e
where (
	select sum(salary + commission)
	from employees) > any (
		select salary
		from employees
		where emp_id = e.emp_id);
/*
emp_name | salary  | commission | netpay
----------+---------+------------+---------
KAYLING  | 6000.00 |            | 8500.00
BLAZE    | 2750.00 |            | 8500.00
CLARE    | 2550.00 |            | 8500.00
JONAS    | 2957.00 |            | 8500.00
SCARLET  | 3100.00 |            | 8500.00
FRANK    | 3100.00 |            | 8500.00
SANDRINE |  900.00 |            | 8500.00
ADELYN   | 1700.00 |     400.00 | 8500.00
WADE     | 1350.00 |     600.00 | 8500.00
MADDEN   | 1350.00 |    1500.00 | 8500.00
TUCKER   | 1600.00 |       0.00 | 8500.00
ADNRES   | 1200.00 |            | 8500.00
JULIUS   | 1050.00 |            | 8500.00
MARKER   | 1400.00 |            | 8500.00
*/

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

#42. Write a query in SQL to list the name of the departments where highest number of employees are working.
select dep_name
from department
where dep_id = (
	select dep_id
	from employees
	group by dep_id
	order by count(emp_id) desc limit 1);

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

#45. Write a query in SQL to list the name of the managers who is having maximum number of employees working under him.
select *
from employees
where emp_id in (
	select manager_id
	from employees
	group by manager_id
	having count(emp_id) = (
		select count(emp_id)
		from employees
		where manager_id is not null
		group by manager_id
		order by count(emp_id) desc limit 1));

#46. Write a query in SQL to list those managers who are getting salary to less than the salary of his employees.  #RM:  find the manager earning a salary less than his employees.  Jonas is the answer.
select e.emp_name as employee, m.*
from employees e, employees m
where e.manager_id = m.emp_id
and e.salary > m.salary;
/*
employee	emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
SCARLET	65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001
FRANK	65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001
*/

#47. Write a query in SQL to list the details of all the employees who are sub-ordinates to BLAZE.
select *
from employees
where manager_id in (
	select emp_id
	from employees
	where emp_name = 'BLAZE');

#48. Write a query in SQL to list the employees who are working as managers, using co-related subquery.  #RM:  what is a co-related corelated subquery?  
select *
from employees
where emp_id in (
	select manager_id
	from employees);  #RM:  This is a co-related subquery?

#49. Write a query in SQL to list the name of the employees for their manager JONAS and also the name of the manager of JONAS.
select *
from employees
where manager_id in (
	select emp_id
	from employees
	where emp_name = 'JONAS')
or emp_id in (
	select manager_id
	from employees
	where emp_name = 'JONAS');
#user solution
select emp_id as subordinate, (select emp_id as emp from employees where emp_name='JONAS'), (select manager_id as superior from employees where emp_name='JONAS'), emp_name as subordinate_name, (select emp_name from employees where emp_name='JONAS'), (select emp_name as superior_name from employees where emp_id in (select manager_id as superior from employees where emp_name='JONAS'))
from employees
where manager_id in (
	select emp_id
	from employees
	where emp_name='JONAS');
/*
subordinate	emp	superior	subordinate_name	emp_name	superior_name
67858	65646	68319	SCARLET	JONAS	KAYLING
69062	65646	68319	FRANK	JONAS	KAYLING
*/

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

#51. Write a query in SQL to find all the employees who earn the highest salary for a designation and arrange the list in descending order on salary.
select *
from employees
where salary in (
	select max(salary)
	from employees
	group by job_name)
order by salary desc;
#also by me
select employees.*
from employees join (
	select max(salary) as "maximumsalarycolumn"
	from employees
	group by job_name) maximumsalary
on employees.salary = maximumsalary."maximumsalarycolumn"
order by employees.salary desc;

#52. Write a query in SQL to find the most recently hired emps in each department order by hire_date.
select *
from employees
where hire_date in (
	select max(hire_date)
	from employees
	group by dep_id);
#also by me
select *
from employees e join (
	select max(hire_date) as "recenthiredatescolumn"
	from employees
	group by dep_id) recenthiredate
on e.hire_date = recenthiredate."recenthiredatescolumn";

#53. Write a query in SQL to list the name,salary, and department id for each employee who earns a salary greater than the average salary for their department and list the result in ascending order on department id.
select *
from employees e1
where salary > (
	select avg(salary)
	from employees e2
	where e1.dep_id = e2.dep_id)
order by dep_id asc;  #RM:  how does the official solution break down by department?
#also by me
select employees.*, deptaveragesalary.*
from employees join (
	select dep_id, round(avg(salary),2) as "averagesalary"
	from employees
	group by dep_id) as deptaveragesalary
on employees.dep_id = deptaveragesalary.dep_id
where employees.salary > deptaveragesalary."averagesalary"
order by employees.dep_id asc;

#54. Write a query in SQL to find the name and designation of the employees who earns a commission and salary is the maximum.  #RM:  question asked what's the highest salary for someone who earns a commission.  Commission is excluded from the highest salary calculation.  Confusing.
select *
from employees
where salary = (
	select max(salary)
	from employees
	where commission is not null);

#55. Write a query in SQL to list the name, designation, and salary of the employees who does not work in the department 1001 but works in same designation and salary as the employees in department 3001.
select *
from employees
where dep_id <> 1001
and job_name in (
	select job_name
	from employees
	where dep_id = 3001)
and salary in (
	select salary
	from employees
	where dep_id = 3001);

#56. Write a query in SQL to list the department id, name, designation, salary, and net salary (salary+commission) of the SALESMAN who are earning maximum net salary.
select *, salary+commission	as "net salary"
from employees
where salary+commission	= (
	select max(salary+commission)
	from employees
	where commission is not null);

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
	where rank = 2);  #search by employee's name for rank()
#user solution
select dep_id,emp_name, job_name, salary, salary+commission as net_salary from employees where emp_name in (
select a.emp_name from (
select emp_name,salary+commission, rank () over (order by salary+commission desc) from employees where commission is not null)a where rank=2)

#58. Write a query in SQL to list the department ID and their average salaries for those department where the average salary is less than the averages for all departments.
select dep_id, round(avg(salary),2)
from employees
group by dep_id
having avg(salary) < (
	select avg(salary)
	from employees);

#59. Write a query in SQL to display the unique department of the employees.  #RM:  literally run a query distinct dep_id in employees table.  Display the department information.
select *
from department
where dep_id in (
	select distinct(dep_id)
	from employees);

#60. Write a query in SQL to list the details of the employees working at PERTH.
select *
from employees
where dep_id = (
	select dep_id
	from department
	where dep_location = 'PERTH');

#61. Write a query in SQL to list the employees of grade 2 and 3 who belongs to the city PERTH.
select *
from employees
where dep_id = (
	select dep_id
	from department
	where dep_location = 'PERTH')
and salary between (
	select distinct min_sal
	from salary_grade
	where grade = 2)
	and (
	select distinct max_sal
	from salary_grade
	where grade = 3);  #RM: for some reason distinct keyword must be included because website prints the min_sal and max_sal twice.

#62. Write a query in SQL to list the employees whose designation is same as either the designation of [ADELYN] or the salary is more than salary of WADE.  #RM:  designation is job_name
select *
from employees
where job_name = (
	select job_name
	from employees
	where emp_name = 'ADELYN')
or salary > (
	select salary
	from employees
	where emp_name = 'WADE');

#63. Write a query in SQL to list the employees of department 1001 whose salary is more than the salary of ADELYN.
select *
from employees
where dep_id = 1001
and salary > (
	select salary
	from employees
	where emp_name = 'ADELYN');

#64. Write a query in SQL to list the managers who are senior to KAYLING and who are junior to SANDRINE.
select distinct e.manager_id as "manager id", m.emp_name as "manager name"
from employees e, employees m
where m.emp_id = e.manager_id
and m.hire_date < (
	select hire_date
	from employees
	where emp_name = 'KAYLING')
and m.hire_date > (
	select hire_date
	from employees
	where emp_name = 'SANDRINE');

#65. Write a query in SQL to list the ID, name,location,salary, and department of the all the employees belonging to the department where KAYLING works.
select *
from employees
where dep_id = (
	select dep_id
	from employees
	where emp_name = 'KAYLING')
and emp_name not in ('KAYLING');  #RM:  KAYLING is shown without emp_name not in ('KAYLING')

#66. Write a query in SQL to list the employees whose salary grade are greater than the grade of MARKER.
select *
from employees
where salary > (
	select distinct max_sal
	from salary_grade
	where grade = (
		select distinct s.grade
		from salary_grade s, employees e
		where e.salary between s.min_sal and s.max_sal
		and e.salary = (
			select salary
			from employees
			where emp_name = 'MARKER'))); #RM: for some reason distinct keyword must be included because website prints the min_sal and max_sal twice.

#67. Write a query in SQL to list the employees of the grade same as the grade of TUCKER or experience is more than SANDRINE and who are belonging to SYDNEY or PERTH.
#official solution
select *
from employees e, department d, salary_grade s
where e.dep_id= d.dep_id
and d.dep_location in ('SYDNEY','PERTH')
and e.salary between s.min_sal and s.max_sal
and (
	s.grade in (
		select s.grade
		from employees e, salary_grade s
		where e.salary between s.min_sal and s.max_sal
		and e.emp_name = 'TUCKER')
	or age (current_date,hire_date) > (
		select age(current_date,hire_date)
		from employees
		where emp_name = 'SANDRINE'));

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

#69. Write a query in SQL to list the total remuneration (salary+commission) of all sales person of MARKETING department.  #RM:  the question and its answer doesn't make sense.
select sum(salary+commission)
from employees
where dep_id = (
	select dep_id
	from department
	where dep_name = 'MARKETING')
and job_name = 'SALESMAN';

#70. Write a query in SQL to list the details of most recently hired employees of department 3001.
select *
from employees
where dep_id = 3001
and hire_date in (
	select max(hire_date)
	from employees
	where dep_id = 3001);

#71. Write a query in SQL to list the highest paid employees of PERTH who joined before the most recently hired employee of grade 2.
select *
from employees
where salary = (
	select max(e.salary)
	from employees e, department d
	where e.dep_id = d.dep_id
	and d.dep_location = 'PERTH')
and hire_date < (
	select max(e.hire_date)
	from employees e, salary_grade s
	where e.salary between s.min_sal and s.max_sal
	and s.grade = 2);

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

#73. Write a query in SQL to list the name, salary, and commission for those employees whose net pay is greater than or equal to the salary of any other employee in the company.
select e1.emp_name, e1.salary, e1.commission
from employees e1
where e1.salary+e1.commission >= any (
	select e2.salary+e2.commission
	from employees e2);
/*
emp_name	salary	commission
ADELYN	1700.00	400.00
WADE	1350.00	600.00
MADDEN	1350.00	1500.00
TUCKER	1600.00	0.00
*/
#official solution  #RM:  what?
select e.emp_name, e.salary, e.commission
from employees e
where (
	select max(salary+commission)
	from employees) >= any (
		select salary
		from employees);
/*
emp_name	salary	commission
KAYLING	6000.00	
BLAZE	2750.00	
CLARE	2550.00	
JONAS	2957.00	
ADELYN	1700.00	400.00
WADE	1350.00	600.00
MADDEN	1350.00	1500.00
TUCKER	1600.00	0.00
ADNRES	1200.00	
JULIUS	1050.00	
MARKER	1400.00	
SCARLET	3100.00	
FRANK	3100.00	
SANDRINE	900.00	
*/

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





