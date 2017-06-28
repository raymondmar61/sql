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

/* number format math Number or numeric functions:  round, trunc truncates, ceil, floor, mod returns remainder*/
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

/* to_number convert character to number.  Change characters to a number with the given format. */
/* to_char convert number or date to character */
/* to_date convert character to date.  There are many format model to convert character to date; e.g. yyyy is full year in numbers, year is spelling the year, mm is two digit month, dd is two digit number day.  There are many format model to convert character to date; e.g. 9 represnts a number, 0 display 0, $ display a dollar sign, . display a decimal, , display a comma */
select first_name, last_name, hire_date, to_char(hire_date, 'yyyy')
from employees
where to_char(employee_id) = 100; /* really no need to convert employee_id to character */
select first_name, hire_date, to_char(hire_date,'mon-yyyy') as "2 digit month lowercase-4 digit year"
from employees;
select first_name, hire_date, to_char(hire_date,'mon-yyyy') as "mon abbrev jan-4 digit year"
from employees;
select first_name, hire_date, to_char(hire_date,'Mon-yyyy') as "mon abbrev Jan-4 digit year"
from employees;
select hire_date, to_char(hire_date, 'ddth-Mon-yyyy') as "ddth-Mon-yyyy 21st-Sep-2005"
from employees;
select hire_date, to_char(hire_date, 'ddth-Month-yyyy') as "ddth-Month full-yyyy 25th-June      -2005"
from employees;
select salary, to_char(salary, '$99.999.99') as "$24,000.00"
from employees;
select salary, commission_pct, to_char(salary*commission_pct, '$9.99')  
from employees
where commission_pct is not null; /* returns ####### because need more display numbers */
select salary, commission_pct, to_char(salary*commission_pct, '$9,999.99')
from employees
where commission_pct is not null;
select to_number('$6,152.21','$99,999.99')
from dual; #returns 6152.21  yes, no dollar sign, no comma.  Change characters to a number with the given format.
select first_name, last_name, to_char(hire_date, 'ddspth Month yyyy') as "Hire Date" #Hire Date twenty-fourth December    2005
from employees
where hire_date > to_date('Jun 25, 2005','Mon dd, YYYY');

/* nvl function null if null nvl(expression1, expression2) if expression1 is null, then return expression 2*/
select job_id, first_name, last_name, nvl(commission_pct,0) as nvlcommission, commission_pct
from employees
where job_id in ('SA_REP','IT_PROG');
select salary, commission_pct, salary + (salary*commission_pct), salary + (salary*nvl(commission_pct,0))
from employees;
/* above or below works same results*/
select salary, commission_pct, salary + (salary*commission_pct), nvl((salary + salary*commission_pct),salary)
from employees;
/* nvl2 function null if not null nvl(expression1, expression2, expression3) if expression1 is not null, then return expression 2; if expression1 is null, then return expression 3.  expression2 and expression3 must be the same data type. */
select salary, commission_pct, salary + (salary*commission_pct), nvl2(commission_pct,'has','has not')
from employees;
/* nullif function nullif(expression1, expression2) compares expression1 and expression2.  If equal, return null.  If not equal, return expression1 */
select first_name, last_name, length(first_name), length(last_name)
from employees
where nullif(length(first_name),length(last_name)) is null; /* lament terms, if length(first_name)=length(last_name), then return null */
/* coalesce function coalesce(expression1, expression2, expression3, . . . expressionx) advanced nvl function.  If expression1 is null, look at expression2.  If expression2 is null, look at expression3.  Continues until any un-null value or the last expression expressionx; i.e. returns the first non null value or expressionx if previous expressions are null. */
select state_province, city, coalesce(state_province, city, 'not has')
from locations;

/* case expression.  case expr when comparisonexpr1 then returnexpr1 [when comparisonexpr2 then returnexpr2 when comparisonexprn then returnexprn else elseexpr end].  Used for if then else or if else logic SQL. Can be used in select clause and where clause. returnexpr must be same data types */
select first_name, last_name, job_id, salary, hire_date, case job_id when 'ST_MAN' then salary*1.2 when 'SH_MAN' then salary*1.3 when 'SA_MAN' then salary * 1.4 else salary*1.0 end as "Updated Salary"
from employees
where job_id in ('ST_MAN','SH_MAN','SA_MAN');
select first_name, last_name, job_id, salary
from employees
where (case when job_id = 'IT_PROG' and salary > 5000 then 1
when job_id = 'SA_MAN' and salary > 10000 then 1
else 0
end) = 1; /* 1 is a resultholder.  return it_prog greater than 5000 and sa_man greater than 10000 employees */
/* above or below works same result.  above is complicated */
select first_name, last_name, job_id, salary
from employees
where (job_id = 'IT_PROG' and salary > 5000) or (job_id = 'SA_MAN' and salary > 10000);
/* decode function.  decode (columnname or expr search1, result1 ,[search2, result2, . . .,] [default]).  Oracle's specific, easy to use alternative of case expression.  if then else logic.  search and result must be same data type respectively.  expression can be different type. */
select first_name, last_name, job_id, salary, hire_date, decode(job_id, 'ST_MAN', salary*1.2, 'SH_MAN', salary*1.3, 'SA_MAN', salary*1.4, salary*1.0) as "Updated Salary"
from employees
where job_id in ('ST_MAN','SH_MAN','SA_MAN');

/* group functions.  Operate with multiple rows and return one result per group.  Used after select keyword.  Multiple group functions can be used in one select.  Null values ignored.  Can use nvl, nvl2, coalesce, case, or decode functions to handle null values.  distinct and all are used with the function to consider duplicate values. all is default value.  group functions:  avg average, count returns number of rows, max, min, sum.*/
select avg(salary), avg(all salary), avg(distinct salary)
from employees;
select avg(salary), avg(all salary), avg(distinct salary)
from employees
where job_id = 'IT_PROG';
select avg(salary), avg(all salary), avg(distinct salary), salary
from employees
where job_id = 'IT_PROG'; /* column without group function.  Error message. groups are results of groups.  column is individual rows.  */
select count(*)
from employees;  /* all rows with null are included using asterik */
select count(*), count(manager_id), count(all manager_id), count(distinct manager_id)
from employees;
select count(*), count(commission_pct), count(distinct commission_pct), count(nvl(commission_pct,0)), count(distinct nvl(commission_pct,0))
from employees;
select max(salary), max(hire_date), max(first_name)
from employees;
select min(commission_pct), min(nvl(commission_pct,0)), min(hire_date)
from employees;
select sum(salary), sum(all salary), sum(distinct salary)
from employees;
select min(salary), max(hire_date), avg(salary), count(*)
from employees;

/* Grouping data group by clause.  Divide rows into smaller groups.  Can use more than one column in group by clause.  Select clause can't have any different columns then used in GROUP BY clause. No column aliases.  Use where clause to restrict resulting data.  */
select department_id, avg(salary)
from employees
group by department_id
order by avg(salary);  /* column 1 department_id, column 2 average salaries for each department_id which includes a column for null department_id */
select job_id, avg(salary)
from employees
group by job_id;
select job_id, department_id, avg(salary)
from employees
group by department_id
order by avg(salary); /* error message because job_id is not in group by statement */
select job_id, department_id, avg(salary)
from employees
group by department_id, job_id
order by avg(salary); /* valid sql statement  because job_id is in group by statement */
select job_id, department_id, manager_id, avg(salary)
from employees
group by department_id, job_id, manager_id;
select department_id, avg(salary), sum(salary), min(salary), max(salary), count(*)
from employees
group by department_id
order by avg(salary);
select department_id as "Departments", avg(salary)
from employees
group by department_id
order by "Departments"; /* column aliases can be used in order by clause */
select job_id, department_id as "Departments", avg(salary)
from employees
where job_id in ('ST_MAN','SH_CLERK','ST_CLERK')
group by job_id, department_id
order by "Departments"; /* column aliases can be used in order by clause */
select job_id, avg(salary)
from employees
group by job_id
having avg(salary) > 10000; /* having statement is like a where statement.  It's for the group function.  Can't use group function with where clause.  where clause restricts rows.  having clause restricts groups.  order by clause is the last statement.  */
select job_id, avg(salary)
from employees
where job_id in ('IT_PROG','SA_MAN','FI_MGR')
group by job_id
having avg(salary) > 10000
order by avg(salary) desc; /* IT_PROG didn't return in results */
select job_id, avg(salary)
from employees
where hire_date > '05/28/09'
group by job_id
having avg(salary) > 10000
order by avg(salary) desc;
/* nesting group functions.  Nesting group functions can't be used with any columns.  Can only nest group functions. */
select department_id, avg(salary)
from employees
group by department_id; /* error message "not a single-group group function" */
select max(avg(salary))
from employees
group by department_id; /* return 19333.333333.  However, what's the department with the highest average salary? */

/* Joining multiple tables.  Combine tables.  Join.  Natural join, join with using clause, join with on clause, outer joins left outer join, right outer join, full outer join, cross join (cartesian product)  */
select *
from employees e, departments d
where e.department_id = d.department_id;
select e.first_name, e.last_name, d.department_id
from employees e, departments d
where e.department_id = d.department_id
order by first_name;
/* Natural join.  Join two tables with columns with the same name.  select rows from two tables which have equal values in the same name columns; for example, the two queries below two rows of many are returned because both tables have manager_id 100 and department_id 90.  Another example is manager_id 114 and department_id 40.  Steven King doesn't return because there's no manager_id null and department_id 90.  If two columns with same name and different data type results in error.  */
select *
from employees natural join departments;
select first_name, last_name, department_id
from employees natural join departments
order by first_name;

