/* Using store database in Oracle 12c */
/* Shift + F4 opens pop-up window describe table columns or popup describe */
/* Joey Blue SQL Training Online sqltrainingonline.com 1 Select Clause, 2 Distinct, 3 Where, 4 And Or Statements, 5 In Filter, 6 Between, 7 Wildcard Filter, 8 Like Filter, 9 Order By, 10 Functions, 11 Average Function, 12 Count Function, 13 Max Function, 14 Min Function, 15 Sum Function, 16 Group By, 17 Having, 18 Alias, 19 As Statement, 20 Inner Join, 21 Outer Join, 22 Right Outer Join, 23 Left Outer Join, 24 Round Function, 25 Cast Function, 26 Convert Function, 27 Concatenate, 28 Substring, 29 CharIndex Instring, 30 trim Rtrim Ltrim, 31 Length Function */

select *
from customers
select first_name, last_name
from customers

select distinct description
from product_changes

/* where clause filter's data */
select *
from products
where PRODUCT_TYPE_ID = 4
select *
from products
where name = 'Tank War' /* single quotes.  Double quotes error message */
select *
from products
where PRODUCT_TYPE_ID != 3 /* <> also works for not equal */
select *
from products
where DESCRIPTION like '%best%' /* Oracle 12c ues % instead of * */

select *
from products
where name = 'Modern Science' or name = 'Space Force 9'
select *
from products
where name In ('Modern Science','Space Force 9','Pop 3')
select *
from products
where PRODUCT_TYPE_ID = 1 and name = 'Chemistry'

select *
from products
where name In ('Modern Science','Space Force 9','Pop 3')

select *
from employees2
where salary between 140000 and 250000 /* 140000 and 250000 are included */

select *
from employees2
where first_name like 'T%' /* t% does't work.  Seems like is case-sensitive */
select *
from employees2
where first_name like '%rr%'
select *
from employees2
where first_name like '_r%' /* Returned Fred, Frank, Tracy */
select *
from employees2
where first_name like '__r%' /* Returned Doreen, Mark, Terry, Gerald, Sarah . . . . Two underscores.  */

select *
from employees2
where first_name like 'S%'
select *
from employees2
where first_name like 'T%y' /* Returned Tony, Tracey, Terry */
select *
from employees2
where first_name like '_e%' /* Returned Jean, Heyson, Trenton . . . */

/* order by is a sort */
select *
from employees2
order by first_name /* asc is default.  No need to mention asc for ascending */
select *
from employees2
order by first_name desc
select *
from employees2
order by job_id, first_name
select *
from employees2
order by job_id, last_name desc
select *
from employees2
order by 3, 5 desc /* column numbers are valid.  job_id column number is 3, last_name column number is 5 */
select first_name, last_name
from employees2
order by employee_id /* can sort by a column not in the select clause */
select division_id, first_name, last_name
from employees2
order by division_id, last_name, first_name
select division_id, first_name, last_name, concat(first_name,last_name) as concatenateexample
from employees2
order by division_id, last_name, first_name
/* select division_id, first_name, last_name, concat(division_id,first_name,last_name) as concatenateexample #error message when I concatenate three columns
from employees2
order by division_id, last_name, first_name */

select avg(salary) AS Average_Salary
from employees2
select avg(salary) AS Average_Salary, max(salary) as Max_Salary, min(salary) as Min_Salary, count(salary) as Count_Salary
from employees2

/* avg() function ignores null data.  0 is included in average calculation. */
select avg(salary) AS Average_Salary
from employees2
select avg(salary) AS Average_Salary_Managers, 1000/4 as Perform_Math
from employees2
where job_id = 'MGR'

select count(*) /* counts number of records */
from employees2
select count(*)
from employees2
where job_id = 'WOR'
select count(JOB_ID) /* looked for columns which have a value.  Nulls are excluded. */
from employees2
select count(distinct(JOB_ID)) /* looked for distinct data in the column job_id which have a value.  Nulls are excluded. */
from employees2

select max(salary)
from employees2
select max(salary)
from employees2
where JOB_ID = 'WOR'
select max(salary)
from employees2
where JOB_ID In('WOR','MGR')

select min(salary)
from employees2
select min(salary)
from employees2
where JOB_ID In('MGR')

select sum(salary)
from employees2
where JOB_ID In('MGR')
select sum(salary) as sumsalary, count(salary) as countsalary
from employees2
select sum(salary) as sumsalary, count(salary) as countsalary, avg(salary) as averagesalary, sum(salary)/count(salary) as performingmath
from employees2

select division_id, sum(salary)
from employees2
group by DIVISION_ID
select division_id, sum(salary), min(salary), max(salary), count(salary)
from employees2
group by DIVISION_ID

select JOB_ID, sum(salary)
from employees2
group by JOB_ID
having sum(salary) > 250000  /*  where clause filters the initial set of data.  Some data are removed for which it should have been included.  Having filters after the group by or the grouping.   */
select JOB_ID, sum(salary)
from employees2
where JOB_ID In ('ENG','WOR','TEC')
group by JOB_ID
having sum(salary) > 250000

select FIRST_NAME, LAST_NAME, JOB_ID, SALARY, salary + 19, salary + 19 AS columnaliasBonus19
from employees2
/* not in store database below */
select employee_name, job, salary + isnull(commission,0) as total_salary /* if commission is null, then add 0 to as total_salary*/
from employee
select FIRST_NAME, LAST_NAME, JOB_ID, SALARY, salary + 19, salary + 19 AS Bonus19
from employees2 tablealiasemployees2 /* table alias no "as" key word required */

select *
from employees2 tablealiasemployees2
select tablealiasemployees2.*
from employees2 tablealiasemployees2
select tablealiasemployees2.JOB_ID, sum(tablealiasemployees2.SALARY) as sum_salary
from employees2 tablealiasemployees2
group by TABLEALIASEMPLOYEES2.JOB_ID

select * /* columns from employees2 appears first, then jobs columns second */
from employees2 inner join jobs
on employees2.job_id = jobs.job_id
select jobs.name, employees2.*
from employees2 inner join jobs
on employees2.job_id = jobs.job_id
select jobs.*, employes2.employee_id, employees2.first_name, employees2.last_name
from employees2 inner join jobs
on employees2.job_id = jobs.job_id
select j.*, e.employee_id, e.first_name, e.last_name
from employees2 e inner join jobs j
on e.job_id = j.job_id
select e.*, s.sales_amount
from employees2 e inner join all_sales s
on e.employee_id = s.emp_id

/* Videos 22 Outer Join, 23 Right Outer Join, 24 Left Outer Join */
select *  /* columns from PRODUCT_TYPES appears first, then products columns second */
from PRODUCT_TYPES right outer join products /* want all data in the right table products even if they don't exist in the left table PRODUCT_TYPES */  /* left outer join valid, too */
on PRODUCT_TYPES.product_type_id = products.product_type_id
select product_types.name as Type, products.Name as Title, products.description, products.price
from PRODUCT_TYPES right outer join products /* left outer join valid, too */
on PRODUCT_TYPES.product_type_id = products.product_type_id

/* average salary no rounding is 240027.027027027... */
select round(avg(salary),5)
from employees2 /* returns 240027.02703 */

select sales_amount, cast(sales_amount as int) /* cast as int rounds up decimals numbers */
from all_sales
select sales_amount, cast(sales_amount as varchar(3)) /* we can convert sales_amount to a varchar; however, the number of varchar characters must be set to the minimum amount of characters.  varchar(3) results in an error because the sales_amount minimum amount of characters is 5. It seems the minimum amount of characters is 5 is all to the left of the decimal.  */
from all_sales
select sales_amount, cast(sales_amount as varchar(8))
from all_sales
/* concatenate a string and a number to be converted to a varchar doesn't work in Oracle 12c */
select first_name + cast(salary as varchar(6)) 
from employees2
/* however, using the concat() works */
select concat(first_name,cast(salary as varchar2(10)))
from employees2

/* convert invalid in oracle 12c */
select convert(int, sales_amount)
from all_sales
select convert(varchar, sales_amount) /* default varchar is 30 */
from all_sales

select concat(first_name, last_name)
from employees2
select first_name  + '-' + last_name as employee_name /* can't do in Oracle 12c */
from employees2
select first_name + ' ' + last_name + ' ' + cast(salary as varchar(7)) /* can't do in Oracle 12c */
from employees2

select substring(first_name,1,3) /* can't do in Oracle 12c.  I want three characters starting at the first position */
from employees2
select substring(first_name,2,3) /* can't do in Oracle 12c.  I want three characters starting at the second position */
from employees2

select charindex('r',first_name) /* can't do in Oracle 12c.  I want to find the letter r in first_name column.  0 means no r in the record.  Any other number indiciates which character position r is located; e.g. a 3 means the third character is a r. */
from employees2
select substring(employee_name,charindex('r',employee_name),1), first_name /* can't do in Oracle 12c.  Display the r in first_name.  charindex finds the r, substring want one character at employee-name column. */
from employees2

select rtrim('   hello    ') /* can't do in Oracle 12c.  returns '   hello' */
select ltrim('   hello    ') /* can't do in Oracle 12c.  returns 'hello   ' */
select rtrim(ltrim('   hello    ')) /* can't do in Oracle 12c.  returns 'hello' */

select len(FIRST_NAME) /* can't do in Oracle 12c find the length of each first_name record */
from employees2
select length(FIRST_NAME), first_name /* however, we must spell out length.  Works in oracle 12c */
from employees2
select sales_amount, length(sales_amount) /* decimal is counted in the length */
from all_sales
select max(length(sales_amount)) /* returns the highest length count */
from all_sales