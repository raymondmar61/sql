/* Run a query shortcut keys are ctrl+enter and F9.  Use semicolons to terminate SQL statements.  Can write many SQL statements and execute one of the statements.  Semicolons separate many SQL statements.  Forward slash used below end SQL statement on new line  */
/* char() fixed-length character data.  Set char(100).  If data is 10, database saves data as 100. */
/* number(p,s) s is the decimal length to the right of decimal */
/* long variable-length character data up to 2GB. */
/* sql statements are not case sensitive. ctrl+shift+quote changes uppercase and lowercase and initial cap.  ctrl+d clears entire query builder.  However, it seems data is case sensitive  */

select *
from employees
/
describe employees;
desc employees; /*describe or desc works to display table's columns and its type */
select first_name, last_name, email
from employees;
select first_name as name, last_name as surname, email /* column aliases.  "as" is actually optional */
from employees;
select first_name as "My Name", last_name as surname, email as "@email" /* Use double quotes for spaces, special characters, case sensitivity */
from employees;

select *
from dual; /* oracle default database with one entry X in DUMMY column */
select 'My name is Raymond'
from dual; /* column name 'MYNAMEISRAYMOND' data entry My name is Raymond */
/* q'[enter text]' quotation mark increase readability and usability.  Any character as quotation mark delimter other than brackets. */
select q'[My name is Raymond]' as my_name
from dual;
select q'[First name that''s the way I like it]', last_name as surname, email as "@email"
from employees; /* returned Q'[FIRSTNAMETHAT'STHEWAYILIKEIT]' as column heading with each data entry First name that's the way I like it.  Raymond added double single quotes for organization.  Single single quote is real. */
select 'It''s my pen' /* double single quote cancellation works */
from dual;

select distinct job_id /* distinct elimates duplicate rows.  distinct is row-based. One distinct operator in query. */
from employees;
select distinct job_id, department_id, first_name
from employees;

select 'My name is ' || first_name /* concatenate use two veritcal bars and two pip */
from employees;
select first_name || ' ' || last_name as "My Name"
from employees;
select 'Commission percentage is ' || nz(commission_pct,0.0) /* null nz() function doesn't work */
from employees;

select employee_id, salary, salary*12 as "Annual Salary"
from employees;
select sysdate+3 /* sysdate returns computer today's date mm/dd/yyyy */
from dual;
select employee_id, salary, salary*12 as "Annual Salary"
from employees;
select hire_date, sysdate, sysdate-hire_date
from employees;
/* arithmetic operations with null values returns null */
select salary, commission_pct, salary*commission_pct
from employees;

/* <> is not equal, != is not equal, between (lower and upper limits included), in, like, is null, and, or, not operators valid in where clause */
/* null is unassigned, unavailable, unknown value, nothing */
select *
from employees
where salary > 10000;
select *
from employees
where job_id = 'IT_PROG'; /* job_id field IT_PROG case sensitive */
select *
from employees
where hire_date > '01/01/2005';
select *
from employees
where manager_id <> 100;
select first_name, last_name, salary
from employees
where salary between 12000 and 15000;
select *
from employees
where hire_date between '06/02/2007' and '01/29/2008';
select *
from employees
where employee_id in (100,105,102,200,50,55,210);
select *
from employees
where first_name in ('Steven','Peter','Adam','aa');
select *
from employees
where hire_date in ('03/08/2008','01/30/2005',sysdate);
select *
from employees
where job_id like 'SA%'; /* % and _ are used with like operator */
select *
from employees
where first_name like '_r%';
select *
from employees
where manager_id is null;
select *
from employees
where commission_pct is not null;
