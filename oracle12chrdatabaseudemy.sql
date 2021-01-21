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