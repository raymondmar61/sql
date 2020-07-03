#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
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

#75. Write a query in SQL to find the maximum average salary drawn for each job name except for PRESIDENT.
select job_name, round(avg(salary),2) as maxavgsalary
from employees
where job_name <> 'PRESIDENT'
group by job_name
order by maxavgsalary desc limit 1;
#RM:  no user solution used rank() and group by
#official solution
select max(maxavgsalary)
from (
	select round(avg(salary),2) as maxavgsalary
	from employees
	where job_name <> 'PRESIDENT'
	group by job_name) neednamehere;

#76. Write a query in SQL to find the number of employees are performing the duty of a manager.
select count(*)
from employees
where emp_id in (
	select distinct manager_id
	from employees);

#77. Write a query in SQL to list the department where there are no employees.
select dep_name
from department
where dep_id not in (
	select distinct dep_id
	from employees);