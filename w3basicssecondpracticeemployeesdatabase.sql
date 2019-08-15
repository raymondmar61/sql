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

#88. Write a query in SQL to list the employees who are senior to their own MANAGERS.
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