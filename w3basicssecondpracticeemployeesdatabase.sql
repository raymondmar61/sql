#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/subqueries-exercises-on-employee-database.php
#Use weblink for the editor https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php#SQLEDITOR
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

#35. Write a query in SQL to list the employees who are SALESMAN and gathered an experience over 10 years.
select *
from employees
where job_name = 'SALESMAN'
and extract(year from age(current_date, hire_date)) > 10;

#36. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.
select *
from employees
where dep_id in (3001, 1001)
and hire_date >= '1991-01-01' and hire_date <= '1991-12-31';
#also
select *
from employees
where dep_id in (3001, 1001)
and to_char(hire_date, 'yyyy') = '1991';

#37. Write a query in SQL to list the employees who are working for the department ID 1001 or 2001.
select *
from employees
where dep_id in (1001, 2001);

#38. Write a query in SQL to list all the employees of designation CLERK in department no 2001.
select *
from employees
where job_name = 'CLERK'
and dep_id = 2001;

#39. Write a query in SQL to list the ID, name, salary, and job_name of the employees for 1. Annual salary is below 34000 but receiving some commission which should not be more than the salary, 2. And designation is SALESMAN and working for department 3001.  #RM:  solution says (salary + commission) * 12 which is incorrect from the question.
select emp_id, emp_name, salary, job_name
from employees
where (salary * 12) < 34000
and commission < salary
and job_name = 'SALESMAN'
and dep_id = 3001;

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
where to_char(hire_date,'mon') not in ('feb');

#42. Write a query in SQL to list the employees who joined in the year 91.
select *
from employees
where to_char(hire_date,'yyyy') = '1991';

#43. Write a query in SQL to list the employees who joined in the month of June in 1991.
select *
from employees
where to_char(hire_date,'yyyy') = '1991'
and to_char(hire_date,'mon') = 'jun';

#44. Write a query in SQL to list the employees whose annual salary is within the range 24000 and 50000.
select *
from employees
where salary >= (24000/12) and salary <= (50000/12);

#45. Write a query in SQL to list the employees who have joined on the following dates 1st May,20th Feb, and 03rd Dec in the year 1991.
select *
from employees
where hire_date in ('1991-05-01','1991-02-20','1991-12-03');

#46. Write a query in SQL to list the employees working under the managers 63679,68319,66564,69000.
select *
from employees
where manager_id in (63679, 68319, 66564, 69000);

#47. Write a query in SQL to list the employees who joined after the month JUNE in the year 1991.
select *
from employees
where hire_date > '1991-06-30';

#48. Write a query in SQL to list the employees who joined in 90's.
select *
from employees
where to_char(hire_date,'yyyy') >= '1990'
and to_char(hire_date,'yyyy') <= '1999';
#also
select *
from employees
where to_char(hire_date,'yyyy') between '1990' and '1999';
#also
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31';

#49. Write a query in SQL to list the managers of department 1001 or 2001.  #RM:  question didn't say job_name is manager.
select distinct(manager_id)
from employees
where dep_id in (1001, 2001);
#official solution
select *
from employees
where job_id = 'MANAGER' 
and dep_id in (1001, 2001);

#50. Write a query in SQL to list the employees, joined in the month FEBRUARY with a salary range between 1001 to 2000.
select *
from employees
where to_char(hire_date,'mon') = 'feb'
and salary between 1001 and 2000;

#51. Write a query in SQL to list all the employees who joined before or after 1991.
select *
from employees
where hire_date <= '1990-12-31'
and hire_date >= '1992-01-01';  #returns nothing
#use union
select *
from employees
where hire_date <= '1990-12-31'
union
(select *
from employees
where hire_date >= '1992-01-01');  #returns correct rows
#also
select *
from employees
where to_char(hire_date,'yyyy') <> '1991';

#52. Write a query in SQL to list the employees along with department name.
select e.*, d.dep_name
from employees e, department d
where e.dep_id = d.dep_id;

#53. Write a query in SQL to list the name, job name, annual salary, department id, department name and grade of the employees who earn 60000 in a year or not working as an ANALYST.
select e.emp_name, e.job_name, e.salary*12 as "annual salary", e.dep_id, d.dep_name, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.salary*12 >= 60000
or e.job_name <> 'ANALYST';

#54. Write a query in SQL to list the name, job name, manager id, salary, manager name, manager's salary for those employees whose salary is greater than the salary of their managers.
#standard SQL linking employee and employee's manager
select e.emp_name, e.job_name, e.manager_id, e.salary, m.emp_name as "manager", m.salary as "manager salary"
from employees e, employees m
where e.manager_id = m.emp_id;
#solution
select e.emp_name, e.job_name, e.manager_id, e.salary, m.emp_name as "manager", m.salary as "manager salary"
from employees e, employees m
where e.manager_id = m.emp_id
and e.salary > m.salary;

#55. Write a query in SQL to list the employees name, department, salary and commission. For those whose salary is between 2000 and 5000 while location is PERTH.
select emp_name, dep_name, salary, commission
from employees e, department d
where e.dep_id = d.dep_id
and salary between 2000 and 5000
and dep_location = 'PERTH';

#56. Write a query in SQL to list the grade, employee name for the department id 1001 or 3001 but salary grade is not 4 while they joined the company before 1992-12-31.
select s.grade, e.emp_name
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and e.dep_id in (1001, 3001)
and s.grade <> 4
and e.hire_date <= '1992-12-31';

#57. Write a query in SQL to list the employees whose manager name is JONAS. 
select e.*
from employees e, employees m
where e.manager_id = m.emp_id
and m.emp_name = 'JONAS';

#58. Write a query in SQL to list the name and salary of FRANK if his salary is equal to max_sal of his grade.
select emp_name, salary
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and emp_name = 'FRANK'
and e.salary = s.max_sal;

#59. Write a query in SQL to list the employees who are working either MANAGER or ANALYST with a salary range between 2000 to 5000 without any commission.
select *
from employees
where job_name in ('MANAGER','ANALYST')
and salary between 2000 and 5000
and commission is null;

#60. Write a query in SQL to list the id, name, salary, and location of the employees working at PERTH,or MELBOURNE with an experience over 10 years.
select emp_id, emp_name, salary, dep_location
from employees e, department d
where e.dep_id = d.dep_id
and dep_location in ('PERTH','MELBOURNE')
and extract(year from age(current_date, hire_date)) > 10;

#61. Write a query in SQL to list the employees along with their location who belongs to SYDNEY, MELBOURNE with a salary range between 2000 and 5000 and joined in 1991.
select e.*, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and d.dep_location in ('SYDNEY','MELBOURNE')
and e.salary between 2000 and 5000
and to_char(e.hire_date, 'yyyy') = '1991';

#62. Write a query in SQL to list the employees with their location and grade for MARKETING department who comes from MELBOURNE or PERTH within the grade 3 to 5 and experience over 5 years.
select e.*, d.dep_location, s.grade
from employees e, department d, salary_grade s
where e.dep_id = d.dep_id
and e.salary between s.min_sal and s.max_sal
and d.dep_name in ('MARKETING')
and d.dep_location in ('MELBOURNE','PERTH')
and s.grade in (3,4,5)
and extract(year from age(current_date,hire_date)) > 5;

#63. Write a query in SQL to list the employees who are senior to their own manager.
select e.*, m.hire_date
from employees e, employees m
where e.manager_id = m.emp_id
and e.hire_date < m.hire_date;

#64. Write a query in SQL to list the employee with their grade for the grade 4.
select e.*, s.grade
from employees e, salary_grade s
where e.salary_grade between s.min_sal and s.max_sal
and s.grade = 4;

#65. Write a query in SQL to list the employees in department PRODUCTION or AUDIT who joined after 1991 and they are not MARKER or ADELYN to their name.
select e.*
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_name in ('PRODUCTION','AUDIT')
and hire_date > '1991-12-31'
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
order by 1 desc;

#69. Write a query in SQL to list the id, name, monthly salary, daily salary of all the employees in the ascending order of their annual salary.
select emp_id, emp_name, salary, round(salary/30,2) as "daily salary"
from employees
order by salary;

#70. Write a query in SQL to list the employees in descending order who are either 'CLERK' or 'ANALYST'.
select *
from employees
where job_name in ('CLERK','ANALYST')
order by emp_name desc;

#71. Write a query in SQL to display the location of CLARE.
select e.emp_name, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and e.emp_name = 'CLARE';

#72. Write a query in SQL to list the employees in ascending order of seniority who joined on 1-MAY-91,or 3-DEC-91, or 19-JAN-90.
select *
from employees
where hire_date in ('1991-05-01','1991-12-03','1990-01-19')
order by hire_date;

#73. Write a query in SQL to list the employees who are drawing the salary less than 1000 and sort the output in ascending order on salary.
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
order by job_name, emp_id desc;

#76. Write a query in SQL to list the unique jobs of department 2001 and 3001 in descending order.
select distinct job_name
from employees
where dep_id in (2001, 3001);

#77. Write a query in SQL to list all the employees except PRESIDENT and MANAGER in ascending order of salaries.
select *
from employees
where job_name not in ('PRESIDENT','MANAGER')
order by salary;

#78. Write a query in SQL to list the employees in ascending order of the salary whose annual salary is below 25000.
select *
from employees
where salary*12 < 25000
order by salary;

#79. Write a query in SQL to list the employee id, name, annual salary, daily salary of all the employees in the ascending order of annual salary who works as a SALESMAN.
select emp_id, emp_name, salary*12 as "annual salary", round(salary/30,2) as "daily salary"
from employees
where job_name in ('SALESMAN')
order by salary;

#80. Write a query in SQL to list the employee id, name, hire_date, current date and experience of the employees in ascending order on their experiences.  #RM:  ascending order of hire date means highest experience to lowest experience on the date Jul 15, 1999.
select emp_id, emp_name, hire_date, current_date, age('1999-07-15', hire_date)
from employees
order by hire_date;

#81. Write a query in SQL to list the employees in ascending order of designations of those, joined after the second half of 1991.  #RM  want employees joined in the year 1991 second half.
select *
from employees
where hire_date >= '1991-07-01'
and to_char(hire_date,'yyyy') = '1991'
order by job_name;

#82. Write a query in SQL to list the total information of employees table along with department, and location of all the employees working under FINANCE and AUDIT in the ascending department no.
select e.*, d.dep_name, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and e.job_name in ('FINANCE','AUDIT')
order by e.dep_id;

#83. Write a query in SQL to display the total information of the employees along with grades in ascending order.
select e.*, s.grade
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
order by s.grade;

#84. Write a query in SQL to list the name, job name, department, salary, and grade of the employees according to the department in ascending order.
select e.emp_name, e.job_name, d.dep_name, e.salary, s.grade
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
order by d.dep_name;

#85. Write a query in SQL to list the name, job name, salary, grade and department name of employees except CLERK and sort result set on the basis of highest salary.
select e.emp_name, e.job_name, e.salary, s.grade, d.dep_name
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.job_name not in ('CLERK')
order by salary desc;

#86. Write a query in SQL to list the employee ID, name, salary, department, grade, experience, and annual salary of employees working for department 1001 or 2001.
select e.emp_id, e.emp_name, e.salary, d.dep_name, s.grade, age(current_date, hire_date), e.salary*12
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.dep_id in (1001, 2001);

#87. Write a query in SQL to list the details of the employees along with the details of their departments.
select e.*, d.dep_name, d.dep_location
from employees e join department d
on e.dep_id = d.dep_id;

#88. Write a query in SQL to list the employees who are senior to their own [MANAGER].
select e.*, m.hire_date
from employees e, employees m
where e.manager_id = m.emp_id
and e.hire_date < m.hire_date;

#89. Write a query in SQL to list the employee id, name, salary, and department id of the employees in ascending order of salary who works in the department 1001.
select emp_id, emp_name, salary, dep_id
from employees
where dep_id in (1001)
order by salary;

#90. Write a query in SQL to find the highest salary from all the employees.
select *
from employees
where salary = (
	select max(salary)
	from employees);
#also
select *
from employees
order by salary desc limit 1;
#bonus second highest
select *
from employees
where salary = (
	select salary
	from employees
	order by salary desc limit 1 offset 1);

#91. Write a query in SQL to find the average salary and average total remuneration(salary and commission) for each type of job.  #RM:  must label columns to return the two averages. 
select job_name, round(avg(salary),2) as "average salary", round(avg(salary+commission),2) as "average salary plus commission"
from employees
group by job_name;

#92. Write a query in SQL to find the total annual salary distributed against each job in the year 1991.  #RM:  stupid question.  Take the sum of monthly salary multiply by 12 group by job_name for hire_date in 1991.
select job_name, sum(salary*extract(age(hire_date,'1991-12-31')))
from employees
where to_char(hire_date,'yyyy') = '1991'
group by job_name;
#another SQL
select hire_date, salary*(('1991-12-31' - hire_date)/12)
from employees
where hire_date <= '1991-12-31';
#corret answer
select job_name, sum(salary*12)
from employees
where to_char(hire_date,'yyyy') = '1991'
group by job_name;

#93. Write a query in SQL to list the employee id, name, department id, location of all the employees.
select e.emp_id, e.emp_name, d.dep_id, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id;

#94. Write a query in SQL to list the employee id, name, location, department of all the departments 1001 and 2001.
select e.emp_id, e.emp_name, d.dep_id, d.dep_location
from employees e, department d
where e.dep_id = d.dep_id
and e.dep_id in (1001, 2001);

#95. Write a query in SQL to list the employee id, name, salary, grade of all the employees.
select e.emp_id, e.emp_name, e.salary, g.grade
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal;

#96. Write a query in SQL to list the manager no and the number of employees working for those managers in ascending order on manager id.
select e.manager_id, count(m.emp_id)
from employees m, employees e
where e.manager_id = m.emp_id
group by e.manager_id
order by e.manager_id;
#better answer
select manager_id, count(manager_id)
from employees
group by manager_id
order by manager_id;

#97. Write a query in SQL to display the number of employee for each job in each department.
select dep_id, job_name, count(*)
from employees
group by dep_id, job_name;

#98. Write a query in SQL to list the department where at least two employees are working.
select dep_id
from employees
group by dep_id
having count(dep_id) >= 2;

#99. Write a query in SQL to display the Grade, Number of employees, and maximum salary of each grade.
select s.grade, count(*), max(e.salary)
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
group by s.grade
order by s.grade;

#100. Write a query in SQL to display the department name, grade, no. of employees where at least two employees are working as a SALESMAN.
select d.dep_name, s.grade, count(*)
from employees e, department d, salary_grade s
where e.dep_id = d.dep_id
and e.salary between s.min_sal and s.max_sal
and job_name = 'SALESMAN'
group by 1, 2
having count(*) >= 2;

#101. Write a query in SQL to list the no. of employees in each department where the no. is less than 4.
select dep_id, count(*)
from employees
group by dep_id
having count(*) < 4;

#102. Write a query in SQL to list the name of departments where atleast 2 employees are working in that department.
select dep_name, count(*)
from employees, department
where employees.dep_id = department.dep_id
group by dep_name
having count(*) > 2;

#103. Write a query in SQL to check whether all the employees numbers are indeed unique.
select emp_id, count(*)
from employees
group by emp_id
having count(*) > 1;

#104. Write a query in SQL to list the no. of employees and average salary within each department for each job name.
select dep_id, job_name, count(*), avg(salary)
from employees
group by dep_id, job_name
order by dep_id, job_name;

#105. Write a query in SQL to list the names of those employees starting with 'A' and with six characters in length.
select *
from employees
where emp_name like 'A_____';

#106. Write a query in SQL to list the employees whose name is six characters in length and third character must be 'R'.
select *
from employees
where emp_name like '__R___';

#107. Write a query in SQL to list the name of the employee of six characters long and starting with 'A' and ending with 'N'.
select *
from employees
where emp_name like 'A____N';

#108. Write a query in SQL to list the employees who joined in the month of which second character is 'a'.
select *, to_char(hire_date,'Month') as "January"
from employees
where to_char(hire_date,'Month') like '_a%';

#109. Write a query in SQL to list the employees whose names containing the character set 'AR' together.
select *
from employees
where emp_name like '%AR%';

#110. Write a query in SQL to list the employees those who joined in 90's.
select *
from employees
where to_char(hire_date,'yyyy') = '1990';

#111. Write a query in SQL to list the employees whose ID not starting with digit 68.
select *
from employees
where emp_id < 68000 or emp_id >= 69000;
#official solution #convert number to text
select emp_id, trim(to_char(emp_id,'99999'))
from employees
where trim(to_char(emp_id,'99999')) not like '68%';
#user solution
select *
from employees
where cast(emp_id as varchar) not like '68%';

#112. Write a query in SQL to list the employees whose names containing the letter 'A'.
select *
from employees
where emp_name like '%A%';

#113. Write a query in SQL to list the employees whose name is ending with 'S' and six characters long.
select *
from employees
where emp_name like '_____S';

#114. Write a query in SQL to list the employees who joined in the month having char 'A' at any position.
select *, to_char(hire_date,'month') as "january"
from employees
where to_char(hire_date,'month') like '%a%';

#115. Write a query in SQL to list the employees who joined in the month having second char is 'A'.
select *, to_char(hire_date,'MONTH') as "JANUARY"
from employees
where to_char(hire_date,'MONTH') like '_A%';

#https://www.w3resource.com/sql-exercises/employee-database-exercise/subqueries-exercises-on-employee-database.php
#Use weblink for the editor https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php#SQLEDITOR
#1. Write a query in SQL to display all the details of managers.
select *
from employees
where emp_id in (
	select manager_id
	from employees);

#2. Write a query in SQL to display the employee ID, name, job name, hire date, and experience of all the managers.
select emp_id, emp_name, job_name, hire_date, age(current_date, hire_date)
from employees
where emp_id in (
	select manager_id
	from employees);

#3. Write a query in SQL to list the employee ID, name, salary, department name of all the '[MANAGER]' and 'ANALYST' working in SYDNEY, PERTH with an exp more than 5 years without receiving the commission and display the list in ascending order of location.
select emp_id, emp_name, salary, dep_name
from employees join department
on employees.dep_id = department.dep_id
where job_name in ('MANAGER','ANALYST')
and dep_location in ('SYDNEY','PERTH')
and extract(year from age(current_date,hire_date)) > 5
and commission is null
order by dep_location;

#4. Write a query in SQL to display the employee ID, name, salary, department name, location, department ID, job name of all the employees working at SYDNEY or working in the FINANCE deparment with an annual salary above 28000, but the monthly salary should not be 3000 or 2800 and who does not works as a MANAGER and whose ID containing a digit of '3' or '7' in 3rd position. List the result in ascending order of department ID and descending order of job name.
select e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, d.dep_id, e.job_name
from employees e join department d
on e.dep_id = d.dep_id
where (d.dep_location in ('SYDNEY')
or d.dep_name in ('FINANCE'))
and (e.salary > 28000/12
and e.salary not in (3000, 2800))
and e.job_name not in ('MANAGER')
and (trim(to_char(e.emp_id,'99999')) like '__3%'
or trim(to_char(e.emp_id,'99999')) like '__7%')
order by d.dep_id, e.job_name desc;  #RM:  wild card like search numbers convert to string wild card number wild card search number

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

#6. Write a query in SQL to display all the employees of grade 4 and 5 who are working as ANALYST or MANAGER.
select *
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
where e.job_name in ('ANALYST','MANAGER')
and s.grade in (4,5);

#7. Write a query in SQL to list the details of the employees whose salary is more than the salary of JONAS.
select *
from employees
where salary > (
	select salary
	from employees
	where emp_name = 'JONAS')

#8. Write a query in SQL to list the employees who works in the same designation as FRANK.
select *
from employees
where job_name = (
	select job_name
	from employees
	where emp_name = 'FRANK');

#9. List the employees who are senior to ADELYN.
select *
from employees
where hire_date < (
	select hire_date
	from employees
	where emp_name = 'ADELYN');

#10. Write a query in SQL to list the employees of department ID 2001 who works in the designation same as department ID 1001.  #RM:  designation is job_name.  Same job_name.
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

#12. Write a query in SQL to list the employees whose designation are same as the designation of [employee] MARKER or salary is more than the salary of ADELYN.
select *
from employees
where job_name in (
	select job_name
	from employees
	where emp_name = 'MARKER')
or salary > (
	select salary
	from employees
	where emp_name = 'ADELYN');

#13. Write a query in SQL to list the employees whose salary is more than the total remuneration of the SALESMAN.
select *
from employees
where salary > (
	select max(salary + commission)
	from employees
	where job_name = 'SALESMAN');

#14. Write a query in SQL to list the employees who are senior to BLAZE and working at PERTH or BRISBANE.
select *
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

#15. Write a query in SQL to list the employees of grade 3 and 4 working in the department of FINANCE or AUDIT and whose salary is more than the salary of ADELYN and experience is more than FRANK. List the result in the ascending order of experience.
select *, age(current_date,e.hire_date)
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where s.grade in (3,4)
and d.dep_name in ('FINANCE','AUDIT')
and e.salary > (
	select salary
	from employees
	where emp_name = 'ADELYN')
and age(current_date,e.hire_date) > (
	select age(current_date,hire_date)
	from employees
	where emp_name = 'FRANK')
order by age(current_date,e.hire_date);

#16. Write a query in SQL to list the employees whose designation is same as the designation of SANDRINE or ADELYN.  #RM:  designation is job_name.
select *
from employees
where job_name in (
	select job_name
	from employees
	where emp_name in ('SANDRINE','ADELYN'));

#17. Write a query in SQL to list any job of department ID 1001 those that are not found in department ID 2001. 
select job_name
from employees
where dep_id = 1001
and job_name not in (
	select job_name
	from employees
	where dep_id = 2001);
#another solution using minus?  I can't get it to work.
select job_name
from employees
where dep_id = 1001
minus (
select job_name
from employees
where dep_id = 2001);

#18. Write a query in SQL to find the details of highest paid employee.
select *
from employees
where salary = (
	select max(salary)
	from employees);

#19. Write a query in SQL to find the highest paid employees in the department MARKETING.
select *
from employees
where salary = (
	select max(e.salary)
	from employees e, department d
	where e.dep_id = d.dep_id
	and d.dep_name = 'MARKETING');

#20. Write a query in SQL to list the employees of grade 3 who have been hired in most recently and belongs to PERTH.
select *
from employees
where salary in (
	select e.salary
	from employees e, salary_grade s
	where e.salary between s.min_sal and s.max_sal
	and s.grade = 3)
and dep_id in (
	select dep_id
	from department
	where dep_location = 'PERTH');
order by hire_date desc limit 1;

#21. Write a query in SQL to list the employees who are senior to most recently hired employee working under KAYLING.
select *
from employees
where hire_date < (
	select max(hire_date)
	from employees
	where manager_id = (
		select emp_id
		from employees
		where emp_name = 'KAYLING'));

#22. Write a query in SQL to list the details of the employees within grade 3 to 5 and belongs to SYDNEY. The employees are not in PRESIDENT designated and salary is more than the highest paid employee of PERTH where no MANAGER and SALESMAN are working under KAYLING.
select *
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
join department d
on e.dep_id = d.dep_id
where s.grade between 3 and 5
and d.dep_location = 'SYDNEY'
and e.job_name not in ('PRESIDENT')
and e.salary > (
	select max(salary)
	from employees e2 join department d2
	on e2.dep_id = d2.dep_id
	where d2.dep_location = 'PERTH')
and manager_id not in (
	select emp_id
	from employees
	where emp_name = 'KAYLING'
	and job_name not in ('MANAGER','SALESMAN'));
#official solution is incorrect.  There is no employee.

#23. Write a query in SQL to list the details of the senior employees as on year 1991.
select *
from employees
where to_char(hire_date,'yyyy') < '1991';

#24. Write a query in SQL to list the employees who joined in 1991 in a designation same as the most senior person of the year 1991.
select *
from employees
where to_char(hire_date,'yyyy') = '1991'
and job_name in (
	select job_name
	from employees
	where hire_date = (
		select min(hire_date)
		from employees
		where to_char(hire_date,'yyyy') = '1991'));

#25. Write a query in SQL to list the most senior employee working under KAYLING and grade is more than 3.
select *
from employees e, salary_grade s
where e.salary between s.min_sal and s.max_sal
and e.hire_date = (
	select min(hire_date)
	from employees
	where manager_id = (
		select emp_id
		from employees
		where emp_name = 'KAYLING'))
and s.grade > 3;

#26. Write a query in SQL to find the total salary given to the MANAGER.
select sum(salary)
from employees
where job_name in ('MANAGER');

#27. Write a query in SQL to display the total salary of employees belonging to grade 3.
select sum(salary)
from employees, salary_grade
where salary between min_sal and max_sal
and grade = 3;

#28. Write a query in SQL to list the employees in department 1001 whose salary is more than the average salary of employees in department 2001.
select *
from employees
where dep_id = 1001
and salary > (
	select avg(salary)
	from employees
	where dep_id = 2001);

#29. Write a query in SQL to list the details of the departments where maximum number of employees are working.  #RM:  question asks highest number of employees
select *
from department
where dep_id = (
	select dep_id
	from employees
	group by dep_id
	having max(count(emp_id)));  #incorrect
select dep_id, count(dep_id)
from employees
group by dep_id;
/*
dep_id	count
1001	3
3001	6
2001	5
*/
select count(dep_id)
from employees
group by dep_id;
/*
count
3
6
5
*/
select max(alias1)
from (
	select count(dep_id) alias1
	from employees
	group by dep_id) alias2;
/*
max
6
*/
select *
from department
where dep_id = (
	select dep_id
	from department
	group by dep_id
	having count(*) = (
		select max(alias1)
		from (
			select count(e.dep_id) alias1
			from employees e
			group by e.dep_id) alias2));  #incorrect.  first subquery department is incorrect.
select *
from department
where dep_id = (
	select dep_id
	from employees
	group by dep_id
	having count(dep_id) = (
		select max(alias1)
		from (
			select count(e.dep_id) alias1
			from employees e
			group by e.dep_id) alias2));  #correct.  first subquery employees is correct.
#user solution
select dep_name, count(emp_id)
from employees e join department d
on e.dep_id=d.dep_id
group by dep_name
having count(emp_id) >= all(
  select count(emp_id)
  from employees e join department d
  on e.dep_id=d.dep_id
  group by dep_name);

#30. Write a query in SQL to display the employees whose manager name is JONAS.
select *
from employees
where manager_id = (
	select emp_id
	from employees
	where emp_name = 'JONAS');