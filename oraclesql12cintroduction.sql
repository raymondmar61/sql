/* Run a query shortcut keys are ctrl+enter and F9.  Use semicolons to terminate SQL statements.  Can write many SQL statements and execute one of the statements.  Semicolons separate many SQL statements.  Forward slash used below end SQL statement on new line  */
/* char() fixed-length character data.  Set char(100).  If data is 10, database saves data as 100. */
/* number(p,s) s is the decimal length to the right of decimal */
/* long variable-length character data up to 2GB. */
/* sql statements are not case sensitive. ctrl+shift+quote changes uppercase and lowercase and initial cap.  ctrl+d clears entire query builder.  However, it seems data is case sensitive; yes, matching with characters is case sensitive.  */
/* date format Tools-->Preferences-->Database-->NLS */

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

select *
from employees
where job_id = 'SA_REP'
and salary > 10000;
select *
from employees
where job_id = 'SA_REP'
or salary > 10000;
/* not null is null */
select last_name, job_id, salary
from employees
where salary > 10000 and job_id NOT IN ('SA_MAN','ST_CLERK','SH_CLERK');

/* order of execution from high priority to low priority:  Arithmtic, concatenation, comparison, is [not] null, like, [not] in, [not] between, not equal to, NOT, AND, OR.  Use parahtheses to avoid logical order confusion. */
select first_name, last_name, job_id, salary
from employees
where job_id = 'IT_PROG'
or job_id = 'ST_CLERK'
and salary > 5000;  /* returned six results */
select first_name, last_name, job_id, salary
from employees
where (job_id = 'IT_PROG'
or job_id = 'ST_CLERK')
and salary > 5000;  /* return two results */

select *
from employees
order by last_name;
select first_name, last_name, salary
from employees
order by first_name,last_name;
select first_name, last_name, salary*12 as s
from employees
order by first_name, s desc;
/* nulls are displayed last in ascending order */
select first_name, salary, commission_pct
from employees
order by commission_pct;
select first_name, salary, commission_pct
from employees
order by commission_pct nulls first; /* nulls are displayed first then commission_pct ascending */
select first_name, salary, commission_pct
from employees
order by 2 desc; /*sorting can be done with columns numeric position */
select first_name, last_name
from employees
order by 1 desc, 2 asc;

/* There are five types of single-row functions:  numeric, date, conversion, general, character */
/* Two types of character functions:  case conversion lower, upper, initcap and character manipulation substr substring, length, concat concatenate or ||, instr instring, trim, ltrim, rtrim, replace, lpad left pad or rpad right pad. */
select lower(first_name), upper(last_name), initcap(job_id)
from employees;
select first_name, lower(first_name) as lowerfirstname
from employees;
select first_name, upper(first_name), lower(last_name), initcap(email), upper('My name is Ellen')
from employees;
select first_name, upper(first_name), lower(last_name), initcap(email), upper('My name is Ellen')
from employees
where upper(last_name) = 'KING';  /* Data is case sensitive; yes, matching with characters is case sensitive.  */
select length(first_name), first_name, substr(first_name,1,5), last_name, substr(last_name,3,6)
from employees; /* last name start at 3, display 6 characters inclusive */
select first_name, last_name, concat(first_name, last_name)
from employees; /* concat() concatenates two parameters only */ 
select first_name, last_name, concat(first_name, last_name), first_name||last_name, first_name||' '||last_name
from employees;
select first_name, instr(first_name,'e')
from employees /* if there are more than one e in first_name, the first e number position is returned */
select trim('              good  ')
from dual; /* trim removes white space */
select job_id, replace(job_id,'CLERK','specialist'), first_name, replace(first_name,'a','-')
from employees; /* all a characters in first_name are replaced, not like instr instring returning first number position */
/* lpad and rpad.  lpad('sql',10,'-')  I want ten characters as a result, and if there are not 10 characters in my input string, fill them into 10 characters with a - from the left--> -------sql   If first_name below has 11 or more characters, then the first 10 characters are returned.  */
select first_name, lpad(first_name,10,'*')
from employees;

/* math Number or numeric functions:  round, trunc truncates, ceil, floor, mod returns remainder*/
/* ceil and floor get one argument */
select round(12.136,2) from dual; /* returns 12.14 */
select round(12.136,3) from dual; /* returns 12.136 */
select round(12.136,1) from dual; /* returns 12.1 */
select round(12.136) from dual; /* returns 12 */
select round(12.536) from dual; /* returns 13 */
select trunc(12.536,2) from dual; /* returns 12.53 */
select trunc(12.536) from dual; /* returns 12 */
select ceil(12.536) from dual; /* returns 13 */
select ceil(12.001) from dual; /* returns 13 */
select ceil(12.999) from dual; /* returns 13 */
select floor(12.001) from dual; /* returns 12 */
select mod(1800,23) from dual; /* returns 6 */

/* nesting functions use a function into another function. */
select first_name, last_name, lpad(upper(concat(first_name,last_name)),20,'*') as nesting
from employees;
select substr('Omer Dagasan',instr('Omer Dagasan',' ')+1) from dual; /* extract part of data same as below*/
select substr('Omer Dagasan',instr('Omer Dagasan',' ')+1,length('Omer Dagasan')) from dual; /* extract part of data same as above */

/* Date */
/* SYSDATE returns the system's date */
/* CURRENT_DATE returns current date from the user's session */
/* SESSIONTIMEZONE returns timezone of the user's session */
/* CURRENT_TIMESTAMP returns current date and time from user's session */
select current_date, sessiontimezone, current_timestamp
from dual;
select sysdate, sysdate+4, sysdate-4
from dual;
select employee_id, sysdate, hire_date, sysdate-hire_date, trunc(sysdate-hire_date), round(trunc(sysdate-hire_date)/365,2) AS "Number Of Years"
from employees;
/* ADD_MONTHS add specific month to specified date.  Use negative number to subtract specific month. */
/* MONTHS_BETWEEN number of months between two dates */
/* ROUND, TRUNC, NEXT_DAY returns next specified day, LAST_DAY returns last day of the month */
select add_months('06/20/2017',2)
from dual; /* returns 08/20/2017 */
select months_between('09/03/2015', '02/18/2015')
from dual; /* returns 6.51612903225 */
select round(sysdate, 'MONTH')
from dual; /* returns 07/01/2017 ran on 06/20/17 */
select trunc(sysdate, 'YEAR')
from dual; /* return 01/01/2017 ran on 06/20/17 */
select next_day('06/20/2017','Wednesday')
from dual; /* return 06/21/2017 which is a Wednesday ran on Tuesday 06/20/17 */
select last_day('06/20/2017')
from dual; /* return 06/30/2017 ran on 06/20/17 */

/* to_number convert character to number */
/* to_char convert number or date to character */
/* to_date convert character to date.  There are many format model to convert character to date; e.g. yyyy is full year in numbers, year is spelling the year, mm is two digit month, dd is two digit number day. */
select first_name, last_name, hire_date, to_char(hire_date, 'yyyy')
from employees
where to_char(employee_id) = 100; /* really no need to convert employee_id to character */
select first_name, hire_date, to_char(hire_date,'mon-yyyy') as "2 digit month lowercase-4 digit year"
from employees;
select first_name, hire_date, to_char(hire_date,'mon-yyyy') as "mon abbrev jan-4 digit year"
from employees;
select first_name, hire_date, to_char(hire_date,'Mon-yyyy') as "mon abbrev Jan-4 digit year"
from employees;