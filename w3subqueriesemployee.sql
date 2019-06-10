#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/employee-database-exercise/subqueries-exercises-on-employee-database.php
#RM:  Use the editor from https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php

#1. Write a query in SQL to display all the details of managers.
select *
from employees
where emp_id in (
	select manager_id
	from employees);

#2. Write a query in SQL to display the employee ID, name, job name, hire date, and experience experience of all the managers.
select emp_id, emp_name, job_name, hire_date, age(current_date, hire_date) "copy Experience from solution"
from employees
where emp_id in (
	select manager_id
	from employees);

#3. Write a query in SQL to list the employee ID, name, salary, department name of all the 'MANAGERS' and 'ANALYST' working in SYDNEY, PERTH with an exp more than 5 years without receiving the commission and display the list in ascending order of location.  #RM:  override.  I used a join.
select e.emp_id, e.emp_name, e.salary, d.dep_name
from employees e join department d
on e.dep_id = d.dep_id
where e.job_name in ('MANAGER','ANALYST')
and d.dep_location in ('SYDNEY','PERTH')
and extract(year from age(current_date, hire_date)) > 5
and e.commission is null
order by d.dep_location;
#official solution
select e.emp_id, e.emp_name, e.salary, d.dep_name
from employees e, department d
where d.dep_location in ('SYDNEY','PERTH')
and e.dep_id = d.dep_id
and e.emp_id in (
	select e.emp_id
    from employees e
    where e.job_name in ('MANAGER','ANALYST')
    and (date_part('year', current_date)-date_part('year', hire_date)) > 5
    and e.commission is null)
order by d.dep_location asc;

#4. Write a query in SQL to display the employee ID, name, salary, department name, location, department ID, job name of all the employees working at SYDNEY or working in the FINANCE deparment with an annual salary above 28000, but the monthly salary should not be 3000 or 2800 and who does not works as a MANAGER and whose ID containing a digit of '3' or '7' in 3rd position. List the result in ascending order of department ID and descending order of job name.  #RM:  question confusing.  Looked at solution.
select e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, d.dep_id, e.job_name
from employees e join department d
on e.dep_id = d.dep_id
where (d.dep_location in ('SYDNEY') or e.job_name in ('FINANCE'))
and ((salary*12 > 28000) and e.salary not in (3000, 2800))
and e.job_name not in ('MANAGER')
and (trim(to_char(e.emp_id,'99999')) like '__3%' or trim(to_char(e.emp_id,'99999')) like '__7%')
order by e.dep_id asc, job_name desc;
#official solution subquery too messy imo
select e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, e.dep_id, e.job_name
from employees e, department d
where (d.dep_location = 'SYDNEY' or d.dep_name = 'FINANCE')
and e.dep_id=d.dep_id
and e.emp_id in (
	select emp_id
    from employees e
    where (12*e.salary) > 28000 and e.salary not in (3000, 2800)
    and e.job_name !='MANAGER'
    and (trim(to_char(emp_id,'99999')) like '__3%' or trim(to_char(emp_id,'99999')) like '__7%'))
order by e.dep_id asc, e.job_name desc;

#5. Write a query in SQL to list all the employees of grade 2 and 3.
select *
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
where s.grade in (2, 3);

#6. Write a query in SQL to display all the employees of grade 4 and 5 who are working as ANALYST or MANAGER.
select *
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
where s.grade in (4, 5)
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

#9. List the employees who are senior to ADELYN.
select *
from employees
where hire_date < (
	select hire_date
	from employees
	where emp_name = 'ADELYN');

#10. Write a query in SQL to list the employees of department ID 2001 who works in the designation same as department ID 1001.  #RM:  I don't understand the question.  User solution says employees in department ID 2001 and the job title from department id 1001.  Weird.
#user solution
select emp_name, job_name
from employees
where dep_id = 2001 and job_name in (
	select job_name
	from employees
	where dep_id = 1001);
#official solution
select *
from employees e,
     department d
where d.dep_id = 2001
  and e.dep_id = d.dep_id
  and e.job_name in
    (select e.job_name
     from employees e,
          department d
     where e.dep_id = d.dep_id
       and d.dep_id =1001);

#11. Write a query in SQL to list the employees whose salary is same as the salary of FRANK or SANDRINE. List the result in descending order of salary.
select *
from employees
where salary in (
	select salary
	from employees
	where emp_name in ('FRANK','SANDRINE'));
#better
select *
from employees
where salary in (
	select subquery.salary
	from employees subquery
	where subquery.emp_name in ('FRANK','SANDRINE')
	and employees.emp_id <> subquery.emp_id)    #RM:  prevent Frank and Sandrine duplicates.
order by salary desc;
select *
from employees p
where p.salary in (
	select sub.salary
	from employees sub
	where sub.emp_name in ('FRANK','SANDRINE')
	and p.emp_id <> sub.emp_id)
order by p.salary desc;  #Primary is a reserved word.  Use p.

#12. Write a query in SQL to list the employees whose designation are same as the designation of MARKER or salary is more than the salary of ADELYN.
select *
from employees
where job_name = (
	select job_name
	from employees
	where emp_name = 'MARKER')
or salary > (
	select salary
	from employees
	where emp_name = 'ADELYN');

#13. Write a query in SQL to list the employees whose salary is more than the total remuneration of the SALESMAN.  #RM:  looked at solution.  salary is greater than the highest total remuneration or salary plus commission of the SALESMAN.
select *
from employees
where salary > (
	select max(salary+commission)
	from employees
	where job_name = 'SALESMAN' 
	and commission > 0);

#14. Write a query in SQL to list the employees who are senior to BLAZE and working at PERTH or BRISBANE.
select *
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_location in ('PERTH','BRISBANE')
and hire_date < (
	select hire_date
	from employees
	where emp_name = 'BLAZE');

#15. Write a query in SQL to list the employees of grade 3 and 4 working in the department of FINANCE or AUDIT and whose salary is more than the salary of ADELYN and experience is more than FRANK. List the result in the ascending order of experience.
select *
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where s.grade in (3,4)
and d.dep_name in ('FINANCE','AUDIT')
and salary > (
	select salary
	from employees
	where emp_name = 'ADELYN')
and hire_date < (
	select hire_date
	from employees
	where emp_name = 'FRANK');

#16. Write a query in SQL to list the employees whose designation is same as the designation of SANDRINE or ADELYN.
select *
from employees
where job_name in (
	select job_name
	from employees
	where emp_name in ('SANDRINE','ADELYN'));

#17. Write a query in SQL to list any job of department ID 1001 those that are not found in department ID 2001.
select *
from employees
where job_name in (
	select job_name
	from employees
	where dep_id in (1001))
and job_name not in (
	select job_name
	from employees
	where dep_id in (2001));
#official solution
select e.job_name
from employees e
where e.dep_id = 1001
and e.job_name not in (
	select job_name
    from employees
    where dep_id =2001);

#18. Write a query in SQL to find the details of highest paid employee.
select *
from employees
where salary = (
	select max(salary)
	from employees);

#19. Write a query in SQL to find the highest paid employees in the department MARKETING.
select *
from employees e join department d
on e.dep_id = d.dep_id
where d.dep_name = 'MARKETING'
and e.salary = (
	select max(salary)
	from employees e join department d
	on e.dep_id = d.dep_id
	where d.dep_name = 'MARKETING');
#official solution
select *
from employees
where salary in (
	select max(salary)
    from employees
    where dep_id in (
    	select d.dep_id
        from department d
        where d.dep_name = 'MARKETING'));

#20. Write a query in SQL to list the employees of grade 3 who have been hired in most recently and belongs to PERTH.
select *
from employees e join department d
on e.dep_id = d.dep_id
join salary_grade s
on e.salary between s.min_sal and s.max_sal
where s.grade in (3)
and d.dep_location = 'PERTH'
and e.hire_date = (
	select max(e.hire_date)
	from employees e join department d
	on e.dep_id = d.dep_id
	join salary_grade s
	on e.salary between s.min_sal and s.max_sal
	where s.grade in (3)
	and d.dep_location = 'PERTH');
#official solution
select e.emp_id, e.emp_name, e.job_name, e.hire_date,e.salary
from employees e, department d
where d.dep_location = 'PERTH'
and hire_date in (
	select max(hire_date)
    from employees e, salary_grade s
    where salary between min_sal and max_sal
    and grade = 3);

#21. Write a query in SQL to list the employees who are senior to most recently hired employee working under KAYLING.  #RM:  sub-subquery.  Two subqueries.  Multiple subqueries.
#official solution
select *
from employees
where hire_date < (
	select max(hire_date)
	from employees
	where manager_id in (
		select emp_id
		from employees
		where emp_name = 'KAYLING'));
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001
64989	ADELYN	SALESMAN	66928	1991-02-20	1700.00	400.00	3001
65271	WADE	SALESMAN	66928	1991-02-22	1350.00	600.00	3001
63679	SANDRINE	CLERK	69062	1990-12-18	900.00		2001
*/
#RM:  I interpret question find employees working under KAYLING and hired before KAYLING.  Regardless, questions makes no sense.
select *
from employees
where manager_id in (
	select emp_id
	from employees
	where emp_name = 'KAYLING')
and hire_date < (
	select hire_date
	from employees
	where emp_name = 'KAYLING');
/*
emp_id	emp_name	job_name	manager_id	hire_date	salary	commission	dep_id
66928	BLAZE	MANAGER	68319	1991-05-01	2750.00		3001
67832	CLARE	MANAGER	68319	1991-06-09	2550.00		1001
65646	JONAS	MANAGER	68319	1991-04-02	2957.00		2001
*/

#22. Write a query in SQL to list the details of the employees within grade 3 to 5 and belongs to SYDNEY. The employees are not in PRESIDENT designated and salary is more than the highest paid employee of PERTH where no MANAGER and SALESMAN are working under KAYLING.  #RM:  confusing question.
select *
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
join department d
on e.dep_id = d.dep_id
where s.grade between 3 and 5
and d.dep_location = 'SYDNEY';
#official solution
select *
from employees
where dep_id in (
	select dep_id
	from department
	where department.dep_location ='SYDNEY')
and emp_id in (
	select emp_id
	from employees e, salary_grade s
	where e.salary between s.min_sal and s.max_sal
	and s.grade in (3, 4, 5))
and job_name != 'PRESIDENT'
and salary > (
	select max(salary)
	from employees
	where dep_id in (
		select dep_id
		from department
		where department.dep_location = 'PERTH')
	and job_name in ('MANAGER', 'SALESMAN')
	and manager_id not in (
		select emp_id
		from employees
		where emp_name = 'KAYLING'));

#23. Write a query in SQL to list the details of the senior employees as on year 1991.  #RM:  find the earliest hire in the year 1991
select *
from employees
where hire_date = (
	select min(hire_date)
	from employees
	where to_char(hire_date,'yyyy') = '1991');

#24. Write a query in SQL to list the employees who joined in 1991 in a designation same as the most senior person of the year 1991.  #RM:  find the earliest hire's job_name in the year 1991.  Find employees matching the job_name and hired in 1991.  sub-subquery  subsubquery.
select *
from employees
where job_name in (
  select job_name
  from employees
  where hire_date in (
    select min(hire_date)
    from employees
    where to_char(hire_date,'YYYY') = '1991'));
#user solution
select *
from employees
where date_part('year',hire_date)='1991'
and job_name in (
  select job_name
  from employees
  where hire_date in (
    select min(hire_date)
    from employees
    where date_part('year',hire_date)='1991'));

#25. Write a query in SQL to list the most senior employee working under KAYLING and grade is more than 3.  #sub-subquery subsubquery.
select *
from employees, salary_grade
where manager_id in (
	select emp_id
	from employees
	where emp_name = 'KAYLING')
and hire_date in (
	select min(hire_date)
	from employees
	where manager_id in (
		select emp_id
		from employees
		where emp_name = 'KAYLING'))
and employees.salary between salary_grade.min_sal and salary_grade.max_sal
and salary_grade.grade > 3;
#user solution
select *
from employees e join salary_grade s
on e.salary between s.min_sal and s.max_sal
where hire_date in (
	select min(hire_date)
	from employees
	where manager_id in (
		select emp_id
		from employees
		where emp_name='KAYLING'))
and grade > 3;

#26. Write a query in SQL to find the total salary given to the MANAGER.
select sum(salary)
from employees
where job_name in ('MANAGER');

#27. Write a query in SQL to display the total salary of employees belonging to grade 3.
select sum(employees.salary)
from employees, salary_grade
where employees.salary between salary_grade.min_sal and salary_grade.max_sal
and salary_grade.grade = 3;

#28. Write a query in SQL to list the employees in department 1001 whose salary is more than the average salary of employees in department 2001.
select *
from employees
where dep_id = 1001
and salary > (
	select avg(salary)
	from employees
	where dep_id = 2001);

#29. Write a query in SQL to list the details of the departments where maximum number of employees are working.  #RM:  find the department with the largest amount of employees.  Most amount of employees.  aggregate subquery aggregate
select d.dep_name, count(e.dep_id)
from employees e join department d
on e.dep_id = d.dep_id
group by d.dep_name
order by count(e.dep_id) desc limit 1;
#better
select d.*, count(e.dep_id)
from employees e join department d
on e.dep_id = d.dep_id
group by d.dep_id
order by count(e.dep_id) desc limit 1;
#official solution
select *
from department
where dep_id in (
  select dep_id
  from employees
  group by dep_id
  having count(*) in (
    select max (mycount)
    from (
      select count(*) mycount
      from employees
      group by dep_id) a));
#user solution
select d.*, count(emp_id)
from employees e join department d
on e.dep_id=d.dep_id
group by d.dep_id
having d.dep_id in (
  select dep_id
  from employees
  group by dep_id
  having count(emp_id)>=all(
    select count(emp_id)
    from employees
    group by dep_id));



