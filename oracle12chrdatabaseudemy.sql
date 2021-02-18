#[ORACLE DATABASE TUTORIALS] LECTURE 9 DESCRIBE COMMAND - YouTube [720p]
desc employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 10 SQL STATEMENT BASICS - YouTube [720p]
select *
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 11 USING SELECT STATEMENT - YouTube [720p]
select first_name, last_name, email
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 12 USING COLUMN ALIASES - YouTube [720p]
select first_name as name, last_name as "two words between double quotes", email, salary*12 as "Yearly Salary"
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 13 QUOTE (Q) OPERATOR - YouTube [720p]
select 'Oracle dual dummy database'
from dual;
select *
from employees
where first_name = 'Steven'
and last_name = 'King';
select first_name as "The double quote""s first name"
from employees;
#select first_name as "The double quote\"s first name"
#from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 14 DISTINCT OPERATOR - YouTube [720p]
select distinct job_id
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 15 CONCATENATION OPERATORS - YouTube [720p]
select 'My name is ' || first_name as "First Name"
from employees;
select first_name || ' ' || last_name as "Employee Name"
from employees;
select concat('My first name is ', first_name)
from employees;  #Must use concat for MySQL
select city, state_province, concat(city,'-',state_province)
from locations;

#[ORACLE DATABASE TUTORIALS] LECTURE 16 ARITHMETIC EXPRESSIONS AND NULL VALUES - YouTube [720p]
select employee_id, salary, salary*12 as "Annual Salary"
from employees;
select hire_date, date_add(hire_date,interval 5 day) as "Add five days"
from employees;

#[ORACLE DATABASE TUTORIALS] LECTURE 17 USING WHERE CLAUSE - YouTube [720p]
select *
from employees;
select *
from employees
where salary > 10000;
select *
from employees
where job_id = 'IT_PROG';

#[ORACLE DATABASE TUTORIALS] LECTURE 18 COMPARISON OPERATORS - YouTube [720p]
select *
from employees
where hire_date > '1/1/2005';  #Incorrect
select *
from employees
where hire_date > '2005-01-01';  #Correct
select *
from employees
where hire_date = '2007-05-21';
select *
from employees
where manager_id != 100;
#or
select *
from employees
where manager_id <> 100;

#[ORACLE DATABASE TUTORIALS] LECTURE 19 BETWEEN ... AND OPERATOR - YouTube [720p]
select first_name, last_name, salary
from employees
where salary between 10000 and 15000; #10,000 and 15,000 are included
select *
from employees
where hire_date between '2002-01-02' and '2005-01-29';

#[ORACLE DATABASE TUTORIALS] LECTURE 20 IN OPERATOR - YouTube [720p]
select employee_id, first_name, last_name, salary, manager_id
from employees
where employee_id in (100, 105, 102, 200);
select *
from employees
where first_name in ('Steven','Peter','Adam','aa');
select *
from employees
where hire_date in ('2008-03-08','2005-01-30',sysdate);  #sysdate invalid in phpMyAdmin.  MySQL use curdate() for today's date.

#[ORACLE DATABASE TUTORIALS] LECTURE 21 LIKE OPERATOR - YouTube [720p]
select first_name, last_name
from employees
where first_name like 'A%';
select first_name
from employees
where first_name like '_r%'; #search first names the second character is lower case r.
select *
from employees
where job_id like 'SA%';

#[ORACLE DATABASE TUTORIALS] LECTURE 22 IS NULL OPERATOR - YouTube [720p]
#RM:  I needed to set Steven and employee_id 100 to NULL
update employees
set manager_id = NULL
where employee_id = 100;
select first_name
from employees
where manager_id is NULL;
select first_name
from employees
where manager_id = NULL;  #error message on phpMyAdmin
#RM:  I needed to set commission_pct to NULL for employees not earning a commission perceneteage
update employees
set commission_pct = NULL
where commission_pct = 0.00;
select *
from employees
where commission_pct is NULL;

#[ORACLE DATABASE TUTORIALS] LECTURE 23 LOGICAL OPERATORS (AND, OR, NOT) - YouTube [720p]
select *
from employees
where job_id = 'SA_REP'
and salary > 10000;
select *
from employees
where job_id = 'SA_REP'
or salary > 10000;
select first_name, last_name, salary, job_id
from employees
where job_id = 'IT_PROG'
and salary >= 5000;
select first_name, last_name, salary, job_id
from employees
where job_id = 'IT_PROG'
or salary >= 5000;
select *
from employees
where salary > 10000
and job_id not in ('SA_MAN','ST_CLERK','SH_CLERK');

#[ORACLE DATABASE TUTORIALS] LECTURE 24 RULES OF PRECEDENCE - YouTube [720p]
select first_name, last_name, job_id, salary
from employees
where job_id = 'IT_PROG'
or job_id = 'ST_CLERK'
and salary > 5000;
select first_name, last_name, job_id, salary
from employees
where (job_id = 'IT_PROG'
or job_id = 'ST_CLERK')
and salary > 5000;
select first_name, last_name, job_id, salary
from employees
where job_id = 'IT_PROG'
or (job_id = 'ST_CLERK'
and salary > 5000);

#[ORACLE DATABASE TUTORIALS] LECTURE 25 ORDER BY CLAUSE - YouTube [720p]
select first_name, last_name, salary
from employees
order by last_name;
select first_name, last_name, salary
from employees
order by salary desc;