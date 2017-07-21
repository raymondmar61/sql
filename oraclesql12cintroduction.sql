/* Run a query shortcut keys are ctrl+enter and F9.  Use semicolons to terminate SQL statements.  Can write many SQL statements and execute one of the statements.  Semicolons separate many SQL statements.  Forward slash used below end SQL statement on new line  */
/* char() fixed-length character data.  Set char(100).  If data is 10, database saves data as 100. */
/* number(p,s) s is the decimal length to the right of decimal */
/* long variable-length character data up to 2GB. */
/* sql statements are not case sensitive. ctrl+shift+quote changes uppercase and lowercase and initial cap.  ctrl+d clears entire query builder.  However, it seems data is case sensitive; yes, matching with characters is case sensitive.  */
/* date format Tools-->Preferences-->Database-->NLS */
--comments are actually double hyphens
--Oracle database is a transactional database.

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
/* Using clause.  Joining with using clause is named equijoin */
select first_name, last_name, department_id
from employees join departments
using (department_id); /* must use parentheses */
select first_name, last_name, department_id
from employees join departments
using (department_id, manager_id); /* must use parentheses */
select first_name, last_name, department_name, e.manager_id
from employees e join departments d
using (department_id);
/* table alias invalid to a column that is using caluse or natural join; in other words, the column in using clause can't be used as an alias to a column in select statment and vice versa */
select first_name, last_name, department_name, e.manager_id
from employees e join departments d
using (manager_id); /* error message */
/* on clause join two tables with one or more columns. */
select e.first_name, e.last_name, d.manager_id, d.department_name
from employees e join departments d
on (e.department_id = d.department_id and e.manager_id = d.manager_id);
select e.first_name, e.last_name, manager_id, department_name
from employees e join departments d
using (department_id, manager_id); /* same query as above with using clause */
/* multiple join.  want employees, department, and city location.  link department_id with employees and departments, then link location_id with departments and locations. */
select first_name, last_name, d.department_name, l.city
from employees e join departments d
on (e.department_id = d.department_id)
join locations l
on (l.location_id = d.location_id);
/*restricting join restrict join where statement or and statement */
select first_name, last_name, d.department_name, l.city
from employees e join departments d
on (e.department_id = d.department_id)
join locations l
on (l.location_id = d.location_id)
where d.department_id = 100;
select first_name, last_name, d.department_name, l.city
from employees e join departments d
on (e.department_id = d.department_id)
join locations l
on (l.location_id = d.location_id)
and d.department_id = 100;
/* join unequal tables.  Can use between ... and, and comparison operators < > >= <= */
select *
from employees;
select *
from job_salaries;
select first_name, last_name, salary, job_title, min_salary, max_salary
from employees e join job_salaries j
on e.salary between j.min_salary and j.max_salary; /* join unequal SQL code returned multiple employees */
/* self join Join same table.  Combine table.  Combine same table.  In this case, we can find managerid's full name for each employee in employees table.  */
select worker.employee_id, worker.first_name, worker.last_name, manager.manager_id, manager.employee_id, manager.first_name, manager.last_name
from employees worker join employees manager
on (worker.manager_id = manager.employee_id);
/* outer join.  Join two tables resulting matched and unmatched rows is called outer join.  There are three:  left outer join retrives all matched rows or columns from the left table and unmatched rows of the right table, right outer join retives all matched rows or columns from the right table and unmatched rows of the left table, full outer join.  */
select first_name, last_name, department_name
from employees join departments
using (department_id); /* must have parantheses */
select first_name, last_name, department_name
from employees left outer join departments
using (department_id); /* must have parantheses */
/* or */
select e.first_name, e.last_name, d.department_name
from employees e left outer join departments d
on e.department_id=d.department_id;
select first_name, last_name, e.department_id, d.department_id, department_name
from employees e right outer join departments d
on e.department_id = d.department_id;
/* full outer join retrives all the columns or matching rows from both tables and nulls for the unmatched rows of both tables.  The union of left and router outer joins and unmatched rows of both tables are returned.  */
select first_name, last_name, e.department_id, d.department_id, department_name
from employees e full outer join departments d
on e.department_id = d.department_id;
/* cross join or cartesian product.  Each row of one table is joined with every row of another table. */
select first_name, last_name, department_name
from employees cross join departments;
select first_name, last_name, department_name, job_title
from employees cross join departments cross join jobs;
select e.first_name, e.last_name, e.department_id, d.department_id, d.department_name
from employees e cross join departments d;

--Subquery subqueries.  The inner query is executed first and the result of the inner query is used as the input of the outer query.  The final result is returned after the outer query is executed.  Inner query is subquery enclosed in parantheses and outer query is main query.  Subquery can be used with select, where, having, from clauses.  There are three types of subqueries:  single-row returns one row from inner query, multiple-row returns more than one row from inner query in any all used with comparison operators used within from where or having clauses and can't use select clause, and multiple-column return more than one column in a row used from where or having clauses used with in operator
select salary
from employees
where employee_id = 201;  --return 13000
select *
from employees
where salary > 13000;
select *
from employees
where salary > (select salary
from employees
where employee_id = 201); --written as a subquery under where clause.  single-row subquery?  Yes.
select department_id
from employees
where employee_id = 201; --returns 20.  Next, it's the subquery
select *
from employees
where department_id = (select department_id
from employees
where employee_id = 201);
--or
select *
from employees
where department_id = 20;
select *
from employees
where department_id = (select department_id
from employees
where employee_id = 201)
and
salary < (select salary
from employees
where employee_id = 201);  --multi single-row subquery
select *
from employees
where hire_date = (select min(hire_date)
from employees);
select *
from employees
where hire_date = (select max(hire_date)
from employees);
--salary are changing.  Use multiple row subqueries.  Who earn the minimum salary for each department
select min(salary)
from employees
group by department_id;
select first_name, last_name, department_id, salary
from employees
where salary in (select min(salary)
from employees
group by department_id);  --answers are here
select salary
from employees
where job_id='SA_MAN';
select first_name, last_name, department_id, salary
from employees
where salary > any (select salary
from employees
where job_id='SA_MAN');
select first_name, last_name, department_id, salary
from employees
where salary > all (select salary
from employees
where job_id='SA_MAN');
select department_id, min(salary)
from employees
group by department_id;  --the 12 minimum salaries for each of the 12 departments
select first_name, last_name, department_id, salary
from employees
where (department_id, salary) in (select department_id, min(salary)
from employees
group by department_id);  --employees earned the minimum salaries in their department.  multiple column subquery.

--Set Operators combine the result of more than one query and return as one result.  Queries that set operators used are called compound queries.  Except union all operator, duplicate rows are eliminated automatically.  The column headings on the results are from the first query or top query.
--Union returns rows of both queries eliminating duplicate rows.  Union All returns rows of both queries including duplicate rows.  Intersect returns rows which exist in both queries.  Minus returns rows which exist in first query, but not in the second query or return rows exist in first table and not second table.
select *
from retired_employees;
select *
from employees;
select *
from retired_employees
union
select *
from employees;
select first_name, last_name, salary
from retired_employees
union
select *
from employees;  --error message because expressions and column names in both queries are mistmatch in number.
select first_name, last_name, salary
from retired_employees
union
select first_name, last_name, department_id
from employees;  --return first_name, last_name, salary with department_id data not salary data
select first_name, last_name, salary
from retired_employees
union
select first_name, last_name, salary
from employees;  --return first_name, last_name, salary with actual salary data
select *
from retired_employees
union
select *
from employees
where job_id = 'IT_PROG';
select first_name, last_name, email, hire_date, salary
from retired_employees
union
select first_name, last_name, email, department_id, salary
from employees;  --error message because hire_date and department_id are mismatch data type
select first_name, last_name, email, hire_date, salary
from retired_employees
union
select first_name, last_name, email, hire_date, salary
from employees  
order by salary desc;  --returned 109 records
select first_name, last_name, email, hire_date, salary
from retired_employees
union all
select first_name, last_name, email, hire_date, salary
from employees
order by salary desc;  --returned 114 records.  order by recognizes columns in first query and is written at the end of the compound query.
select first_name, last_name, email, hire_date, salary
from retired_employees
union all
select first_name, last_name, email, hire_date, salary
from employees
where department_id = 80
order by salary desc;  --returned 40 record..  order by recognizes columns in first query and is written at the end of the compound query.
select *
from retired_employees
intersect
select *
from employees;
select *
from retired_employees
minus
select *
from employees;  --returned one record which is in retired_employees table only.  If a record is in both retired_employees and employees or employees only, then record is not returned.
select *
from employees
minus
select *
from retired_employees;  --returned 103 records which are in employees table only.  If a record is in both employees and retired_employees or retired_employees only, then record is not returned.
--In set operations, if a column doesn't exist in another table, we can match these columns with null values.
select job_id, department_id, first_name, last_name
from employees
union
select job_id, department_id, null, null
from job_history;  --returned job_id, department_id, first_name, last_name as column headings
select first_name, last_name, salary s , department_id
from employees
union
select first_name, last_name, salary, department_id
from retired_employees
order by s;  --column aliases are recognized on first column only.  Never on second column.  Default sort is first column of the first query.

--Data Manipulation Language (DML)  Add, delete, update data from database.  A collection of DML statements is called transaction.  Transaction starts with the first execution of a DML statement and finishes with a commit, rollback operation or a system failure.  Transaction is for data security.
insert into jobs(job_id, job_title, min_salary, max_salary)
values('GR_LDR','Group Leader',8500,17000);
insert into jobs(job_id, job_title, min_salary, max_salary)
values('PR_MGR','Project Manager',500,15000);
insert into jobs
values('PR_CRD','Project Coordinator',4000,18000);  --order of values match columns from left to right
insert into jobs(job_id, job_title, min_salary)
values('PR_CRD2','Project Coordinator2',4000);
insert into jobs(job_id, job_title)
values('PR_CRD3','Project Coordinator2');
insert into departments
values(280,'Customer Relations',null,null);  --department_id, department_name, manager_id, location_id
insert into jobs
values('PR_CRD4','Project Coordinator2',null,19000);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
values(200,to_date('10/24/03', 'mm/dd/yy'),sysdate,'IT_PROG',60);
insert into employees_copy
select *
from employees;  --copy a table into another table
insert into employees_copy
select *
from employees
where job_id like 'IT_PROG';  --copy specific values from a table into another table
insert into employees_copy (employee_id, first_name, last_name, email, hire_date, job_id, salary)
select employee_id, first_name, last_name, email, hire_date, job_id, salary
from employees
where job_id like 'IT_PROG';  --copy specific values from a table into another table
insert into employee_addresses
select employee_id, first_name, last_name, city || ' ' || street_address
from employees
join departments using (department_id)
join locations using (location_id); --insert values from multiple tables

update employees_copy
set salary = 500;  --update all salary records to 500
update employees_copy
set salary = 50000
where job_id = 'IT_PROG';
update employees_copy
set salary = 5, department_id = null
where job_id = 'IT_PROG';
update employees_copy
set (salary, commission_pct) = (select max(salary), max(commission_pct)
from employees)
where job_id = 'IT_PROG';  --update columns with a subquery

delete from employees_copy;  --delete all data in a table
delete from employees_copy
where job_id = 'IT_PROG';
delete employees_copy
where department_id in (select department_id
from employees
where job_id like 'SA%');  --delete records with a subquery

--Oracle database is a transactional database.
--We see changes before making them permanent.  Other uses see the old data.
--Transaction starts with the first execution of a DML statement.  Finishes with a commit, rollback operaetions, system failure, DDL Data Definition Language, and DCL Data Control Language statements.
--The affected rows are locked and nobody can update or delete the affected rows when DML operations is executed.
--There are three transactional control statements:  commit saves the changes into the database and makes changes permanent and ends the transaction, rollback undoes all changes on data and restores data to previous state, and savepoint.
--Nobody else can see the changes before commit or rollback.  Everyone can see the permanent changes after committing DML operations.  The locked rows are released and anyone can change these rows after commit or rollback.
rollback;  --undoes all changes on data and restores data to previous state
commit; --saves the changes into the database and makes changes permanent and ends the transaction.  rollback doesn't unsave after commit.
--Commit automatically executed after a DDL or DCL statements; for instance, create table, delete rows of a table.
--Sometimes we make lots of changes and don't want to rollback them all.  We need to rollback to some point.  After rollback to an earlier savepoint, the next ones are deleted but laters stay.
savepoint A; --saves the state of the transaction A and we can rollback to that state.
savepoint B; --saves the state of the transaction B and we can rollback to that state.
savepoint C; --saves the state of the transaction C and we can rollback to that state.
savepoint D; --saves the state of the transaction D and we can rollback to that state.
rollback to B;  --If I turn back to savepoint B, savepoint C and savepoint D are deleted and can't turn to these savepoints again.  savepoint A stays.
--using rollback without savepoint which typing rollback without "to *savepoint name*" deletes all savepoints.  For instance, type rollback; instead of type rollback to D, all savepoints are gone.
--for update locks all rows returned from query.  Lock is released with commit or rollback statements.
--if a rows we want to lock is locked by somebody else, then we wait until the lock releases.
--However, to perform quick execution we write nowait keyword.  In this time control of locked rows passes from the other user to us.
select *
from employees
where job_id = 'IT_PROG'
for update nowait;
select first_name, last_name, salary
from employees e join departments
using (department_id)
where location_id = 1400
for update; --with joins rows for all tables are locked
select first_name, last_name, salary
from employees e join departments
using (department_id)
where location_id = 1400
for update of first_name, last_name; --we can use for update of *column name* to specify columns we want to lock.  We can prevent to lock all the tables.  Table for which these columns are returned are locked.  In this case, first_name and last_name both from employees table are locked.  Employees table is locked.  Also, the returning row from employees table will be locked.  department_id not locked because we didn't use any column from departments table.
for update wait 10;  --Oracle Database waits for 10 seconds and after that gives control to us.

--DDL Data Definition Language used to define database structure.  create, alter, drop deletes objects, truncate removes all records from table including all spaces allocated for the records are removed, comment adds comments to the data dictionary, rename renames an object.
describe employees;
--or
desc employees;  --returns the structure of a table.  Describe table.
create table my_employees
	(employee_id number(3),first_name varchar2(50), last_name varchar2(50), hire_date date default sysdate); --if date entered is null, then Oracle enters today's date in date field.
create table employees_copy
	as select * from employees;  --copy table with data using a subquery
create table employees_copynodata
	as select * from employees
	where 1=2;  --copy table without data using a subquery.  1 doesn't equal 2.
create table employees_copyitprogonly
	as select * from employees
	where job_id = 'IT_PROG';  --copy table wit data using a subquery it programmers only
create table employees_copysalarytable(first_name, last_name, dollarsalary)
	as select first_name, last_name, salary from employees;  --copy table wit data using a subquery it programmers only.  We can give different column names while creating new table at create table new table name.
--Not null constraint is the only constraint inherited to the new table.  All other constraints must be added explicitly.
alter table employees_copy
add birth_date date; --add birth_date column date datatype to employees_copy table.  add column.
alter table employees_copy
add (fax_number number, fathers_name varchar2(50), password varchar2(10) default 'abc123');  --add columns.  add multiple columns.
alter table employees_copy
modify fathers_name varchar2(100);  --edit column or modify column.  change varchar2(50) to varchar2(100)
alter table employees_copy
modify (fax_number varchar2(11), password varchar2(10) default 'abc1234');  --edit columns or modify multiple columns.  Modifying a column to a new default value affects the new records.  Existing rows are not modified.  However, datatype is modified.
alter table employees_copy
drop column fathers_name; --drop column or delete column
alter table employees_copy
drop (fax_number, password);  --drop columns or delete multiple columns.  Note column word is excluded.
--dropping or delete a column(s) can't be recovered
drop table employees_copy;  --drop table statement removes the table with all the data from the database and moves it to the recycle bin.  Delete table.  All objects related with the drop table are invalid.  Can delete one table or drop one table at a time.  Can be rollback.
truncate table employees_copy; --truncate statement empties whole table in one step.  Delete removes data row by row.  Truncate rmoves data in one step and commits.  Truncate faster than drop table.
comment on column employees.job_id is 'Abbreviated job title'; --We can add a comment to a table's column
comment on table employees is 'Employees Table'; --We can add a comment to a table itself
--comment can't be deleted.  Instead, comment with something empty such as ''
select *
from user_tab_comments; --we can query these comments from user_tab_comments or user_col_comments
select *
from user_tab_comments
where table_name = 'EMPLOYEES';  --returned Employees Table.  Table name must be in caps
select *
from user_col_comments
where table_name = 'EMPLOYEES';  --returned Employees Table with table_name, column_name, and comments.  Table name must be in caps
alter table employees_copy
rename column birth_date to birthdate;  --rename column.  Change the name of a table's column.
rename employees_copy to employees_copy99; --rename table.  Change the name of a table.
--or
alter table employees_copy
rename to employees_copy99;  --rename table.  Change the name of a table.

--Constraints restrict data entry such as insert, update, and delete to prevent invalid entries.  Constraints prevent dropping a table dependent on another table.  There are five types of constraints:  not null, unique, primary key, foreign key, check.
--Oracle Server default names constraints with SYS_C... format.
create table managers
(employee_id number [constraint constraint_name] constrainttype, first_name varchar2(50), last_name varchar2(50), department_id number, [constraint constraint_name] constrainttype (columnname1, columnname2, ...));  --[constraint constraint_name] constrainttype (columnname1, columnname2, ...) is table level constraint
create table managers
(employee_id number not null, first_name varchar2(50), last_name varchar2(50) constraint lname_cons not null, department_id number not null);  --last_name varchar2(50) constraint lname_cons not null is a column level constraint.  lname_cons is the constraint name.
--highlight table name in query builder.  Press shift+F4.
--unique constraint no dpulicate values can be inserted in a column.  Creating unique with more than one column is called composite unique key.  Create it with table level.
create table managers
(employee_id number not null, first_name varchar2(50) unique, last_name varchar2(50) constraint lname_cons unique, department_id number not null, phone_number varchar2(11) unique not null, constraint department_cons unique (department_id), constraint composed_unique unique (employee_id, first_name, last_name));  --first_name varchar2(50) unique, last_name varchar2(50) constraint lname_cons unique, department_id number not null, phone_number varchar2(11) unique not null are column level constraints.  constraint department_cons unique (department_id) and constraint composed_unique unique (employee_id, first_name, last_name) are table level constraints.
--primary key is unique keys designed for identifying all table records and uniqueness of a row.  It's like ID's of rows.  There can only be one primary key in a table.  not null constraint is automatically created on a primary key creation.  We can create composite primary key on multiple column.
create table managers
(employee_id number constraint pk_managers primary key, first_name varchar2(50), last_name varchar2(50));
--or
create table managers
(employee_id number, first_name varchar2(50), last_name varchar2(50), constraint pk_managers primary key (employee_id));
--primary key can also be created after creating a table
alter table managers add constraint pk_managers primary key(employee_id);
--a foreign key establishes a relationsihp between a parent table's primary key or unique key and its child's table primary key.
--a foreign key constraint can be defined as column level or table level.
--a composite foreign key must be created by table level.
create table managers
(manager_id number constraint pk_managers primary key, first_name varchar2(50), last_name varchar2(50), department_id number, constraint emp_man_fk foreign key (manager_id) references employees (employee_id));  --constraint emp_man_fk foreign key (manager_id) references employees (employee_id)  --foreign key constraint.  manager_id is a foreign key and references at the IDs employee_id.  manager_id is both primary key and foreign key.  manager_id has a relationship between employee's table employee_id.  Every manager should be an employee.
--on delete cascade keyword deletes dependent rows in the child table when a related row in the parent table is deleted.
--on delete set null updates dependent row in the child table to null when a related row in the parent table is deleted
--check constraint enforces a condition each row must satisfy; e.g. salary must be greater than zero.  table constraint.  table restrictions.  table condition.
create table managers
(manager_id number constraint pk_managers primary key, first_name varchar2(50), last_name, department_id number, salary number, email varchar2(50), constraint min_salary check (salary>0));