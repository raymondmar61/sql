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