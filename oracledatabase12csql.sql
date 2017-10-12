--Oracle Database 12c SQL by Jason Price
--Five types of SQL statements.  Query statements; Data Manipulation Language (DML) such as insert, update, delete; Data Definition Language (DDL) such as create, alter, drop, rename, truncate, Transaction Control (TC) such as commit, rollback, savepoint, and Data Control Language (DCL) such as grant and revoke.
--Foreign key references a column in another table.  The table containing the foreign key is known as the detail or child table.  The table that is referenced is known as the master or parent table. This type of relationship is known as a master-detail or parentchild relationship.
--Composite primary key when a primary key consists of multiple columns.  The combination of the multiple columns must be unique for each row.
--Double quotes for alias; otherwise single quotes.

--BONUS
select *
from tab;  --show tables and more tables?
select *
from tabs;  --show tables?

--CHAPTER 1 INTRODUCTION PAGE 1
describe customers;  --describe tablename.  Returns columns
insert into customers (customer_id, first_name, last_name, dob, phone)
values (6, 'Fred', 'Brown', 'Jan-01-1970', '800-555-1215');
insert into customers (customer_id, first_name, last_name, dob, phone)
values (7, 'Steve', 'Purple', 'Oct-25-1972', '800-555-1215');
update customers
set last_name = 'Orange'
where customer_id = 2;
delete from customers
where customer_id = 6;
rollback; --undo the changes.  It didn't work when I deleted customer_id = 6.

--CHAPTER 2 RETRIEVING INFORMATION FROM DATABASE TABLES.  Also arithmetic, math. PAGE 27
select customer_id, first_name, last_name, dob, phone
from customers;
select *
from customers
where customer_id=2;
select rowid, customer_id
from customers;  --Each row has an 18 digit unique row identifier or rowid.  Retrieves the ROWID and customer_id.
describe customers;
select rownum customer_id, first_name, last_name, dob, phone
from customers;  --ROWNUM returns the row number
select 2+6, 2-6, 2*6, 2/6, to_date('10/2/2017')+2, to_date('10/2/2017')-3, to_date('10/2/2017')-to_date('9/15/2017')
from dual;  --display 8, -4, 12, 0.33333..., 10/04/2017, 09/29/2017, 17
select name, price, price + 2, (price*3)+1
from products;
select price, price*2 as doubleprice, price*2 as "Double Price"
from products;  --column alias doubleprice replace price*2 in column name.  as keyword is optional.  Double quotation for sentences.
select first_name, last_name, first_name || ' ' || last_name as "Customer Name"
from customers;  --concatenation operator || combine column values
select customer_id, first_name, last_name, dob, phone
from customers
where dob is null;
select customer_id, first_name, last_name, nvl(dob,'01/01/2000') as "null dates replace with a date", phone
from customers;  --use the nvl() function to determine a null value and a blank value.  nvl(columname, value returned if columnname is null)
select customer_id, first_name, last_name, nvl(phone, 'Unknown phone number') as phone_number
from customers;  --use the nvl() function to determine a null value and a blank value.  nvl(columname, value returned if columnname is null)
select distinct customer_id
from purchases;  --distinct suppresses the duplicate rows
select *
from customers
where customer_id <> 2;
--or
select *
from customers
where customer_id != 2;
select *
from customers
where customer_id > any (2, 3, 4); --The ANY operator compares a value with any of the values in a list. You must place an =, <>, <, >, <=, or >= operator before ANY.  Retrieves rows customer_id column is greater than any of the values 2, 3, or 4.  Returned customer_id 3, 4, and 5.
select *
from customers
where customer_id > all (2, 3, 4); --The ALL operator compares a value with all of the values in a list. You must place an =, <>, <, >, <=, or >= operator before ALL. Retrieves rows customer_id column is greater than all of the values 2, 3, and 4.  Returned customer_id 5.
select *
from customers
where first_name like '_o%';  --search the first_name column of the customers table for the pattern '_o%'.  Returned John and Doreen
select *
from customers
where first_name not like '_o%';  --search the first_name column of the customers table for the pattern not '_o%'.
--To search for actual underscore or percent characters in a string, you use the ESCAPE option to identify those characters.  The characters after ESCAPE indicate how to differentiate between the characters to search for and the wildcards.
select name
from promotions
where name like '%\%%' escape "\";  --\ is the wildcard.  Use single quotes ''.  Double quotes typed for editing.
select name
from promotions
where name like '%a%%' escape 'a';  --a is the wildcard
select *
from customers
where customer_id in (2, 3, 5);
select *
from customers
where customer_id not in (2, 3, 5);
select *
from customers
where customer_id between 1 and 3;  --between is inclusive
select *
from customers
where dob > '01/01/1970' and customer_id > 3;
select *
from customers
where dob > '01/01/1970' or customer_id > 3;
select *
from customers
order by last_name;
select *
from customers
order by first_name asc, last_name desc;
--To join two tables in a query, you include both tables in the query’s FROM clause and include the related columns from each table in the WHERE clause.  Formula the number of joins required in a query’s WHERE clause: Number of joins = number of tables in the query – 1
select *
from products, product_types
where products.product_type_id = product_types.product_type_id
and products.product_id = 3;
select products.name, product_types.name
from products, product_types
where products.product_type_id = product_types.product_type_id
and products.product_id = 3;  --returns Supernova Video
select products.name, product_types.name
from products, product_types
where products.product_type_id = product_types.product_type_id
order by products.name;
select p.name, pt.name
from products p, product_types pt
where p.product_type_id = pt.product_type_id
order by p.name;  --table aliases reduces the amount of text and reduces errors
/* If a join condition is missing from a query, the Oracle database software will join all rows from
one table with all the rows from the other table. The result set is known as a Cartesian product. Multiply rows from one table with the rows from second table. */
--Formula the number of joins required in a query’s WHERE clause: Number of joins = number of tables in the query – 1
/*Consider an example that retrieves customer purchase information from four tables:
*Customer purchases from the purchases table
*Customer first and last names from the customers table
*Product name from the products table
*Product type name from the product_types table 
Four tables are used.  Three joins are required. */
SELECT c.first_name, c.last_name, p.name AS PRODUCT, pt.name AS TYPE
FROM customers c, purchases pr, products p, product_types pt
WHERE c.customer_id = pr.customer_id
AND p.product_id = pr.product_id
AND p.product_type_id = pt.product_type_id
ORDER BY p.name;
--The multi-table queries above using the equality operator = in the join conditions are equijoins.
/* There are three different types of joins:
*Inner joins return a row only when the columns in the join contain values that satisfy the
join condition. This means that if a row has a null value in one of the columns in the join
condition, then that row isn’t returned. The examples you’ve seen so far have been inner
joins.
*Outer joins return a row even when one of the columns in the join condition contains a
null value.
*Self joins return rows joined on the same table. */
--A non-equijoin uses not equal <>, less than <, greater than >, less than or equal to <=, greater than or equal to >=, LIKE, IN, and BETWEEN.
select e.last_name, e.salary, sg.salary_grade_id
from employees e, salary_grades sg
where e.salary between sg.low_salary and sg.high_salary
order by sg.salary_grade_id;  --The BETWEEN operator returns true if the employee’s salary is between the low salary and the high salary for the salary grade. If true is returned for the salary range for that employee, then the salary grade ID for that employee can be located from the salary_grades table. For example, Fred Hobbs’ salary is $150,000. His salary is between the low salary of $1 and the high salary of $250,000 in the salary_grades table, and the salary_grade_id for that salary range is 1. Therefore, Fred Hobbs’ salary grade is 1.
/* An outer join retrieves a row even when one of the columns in the join contains a null value. You
perform an outer join by supplying the outer join operator in the join condition. */
select p.name, pt.name
from products p, product_types pt
where p.product_type_id = pt.product_type_id (+)  --The Oracle proprietary outer join operator is a plus character in parentheses (+).  You place the outer join operator (+) on the opposite side of the equality operator = from the column that contains the null value.
order by p.name;  -- RM:  The query is like a left outer join query everything in products p table and whatever matches product-types pt table.  Oracle: In a left outer join, the outer join operator (+) is actually on the right of the equality operator =.
/* A self join is a join made on the same table. To perform a self join, you must use a different table
alias to identify each reference to the table in the query. */
select w.first_name || ' ' || w.last_name || ' works for '|| m.first_name || ' ' || m.last_name
from employees w, employees m
where w.manager_id = m.employee_id
order by w.first_name;
--You can perform outer joins in combination with self joins. In the following query, an outer join is used with the self join shown in the previous example to retrieve the row for James Smith whose manager_id is null.
select w.last_name || ' works for ' || NVL(m.last_name, 'the shareholders')
from employees w, employees m
where w.manager_id = m.employee_id (+)
order by w.last_name;
/* Common joins which are ANSI SQL/86 standard page 57*/
select p.name, pt.name
from products p, product_types pt
where p.product_type_id = pt.product_type_id
order by p.name;
--query above same as query below
select p.name, pt.name
from products p inner join product_types pt
on p.product_type_id = pt.product_type_id
order by p.name;
select e.last_name, e.salary, sg.salary_grade_id
from employees e, salary_grades sg
where e.salary between sg.low_salary and sg.high_salary
order by sg.salary_grade_id;
--query above same as query below
select e.last_name, e.salary, sg.salary_grade_id
from employees e inner join salary_grades sg
on e.salary between sg.low_salary and sg.high_salary
order by sg.salary_grade_id;
/* The using clause with the requirements:  query must be an equijoin and columns in the equijoin must have the same name. */
select p.name, pt.name, pt.product_type_id
from products p, product_types pt
where p.product_type_id = pt.product_type_id
order by p.name;
--query above same as query below
select p.name, pt.name, pt.product_type_id
from products p inner join product_types pt
on p.product_type_id = pt.product_type_id
order by p.name;
--query above same as query below
select p.name, pt.name, product_type_id
from products p inner join product_types pt
using (product_type_id)
order by p.name;
SELECT c.first_name, c.last_name, p.name AS PRODUCT, pt.name AS TYPE
FROM customers c, purchases pr, products p, product_types pt
WHERE c.customer_id = pr.customer_id
AND p.product_id = pr.product_id
AND p.product_type_id = pt.product_type_id
ORDER BY p.name;
--query above same as query below
SELECT c.first_name, c.last_name, p.name AS PRODUCT, pt.name AS TYPE
FROM customers c INNER JOIN purchases pr
USING (customer_id)
INNER JOIN products p
USING (product_id)
INNER JOIN product_types pt
USING (product_type_id)
ORDER BY p.name;
/* If a join uses more than one column from the two tables, then you provide those columns in the
ON clause and you use the AND operator. For example, consider two tables named table1 and
table2. You want to join these tables using columns named column1 and column2 in both
tables. Your query would use the following structure: 
SELECT ...
FROM table1 INNER JOIN table2
ON table1.column1 = table2.column1
AND table1.column2 = table2.column2; */
select p.name, pt.name
from products p left outer join product_types pt
on p.product_type_id = pt.product_type_id
order by p.name;
--query above same as query below
select p.name, pt.name
from products p left outer join product_types pt
using(product_type_id)
order by p.name;
select p.name, pt.name
from products p right outer join product_types pt
on p.product_type_id = pt.product_type_id
order by p.name;
--query above same as query below
select p.name, pt.name
from products p right outer join product_types pt
using(product_type_id)
order by p.name;
--A full outer join uses all rows in the joined tables, including those that have null values in either of the columns used in the join.
select p.name, pt.name
from products p full outer join product_types pt
on p.product_type_id = pt.product_type_id
order by p.name;
--query above same as query below
select p.name, pt.name
from products p full outer join product_types pt
using(product_type_id)
order by p.name;
--Self Joins
select w.last_name || ' works for ' || NVL(m.last_name, 'the shareholders')
from employees w, employees m
where w.manager_id = m.employee_id
order by w.last_name;
--query above same as query below
select w.last_name || ' works for ' || NVL(m.last_name, 'the shareholders')
from employees w inner join employees m
on w.manager_id = m.employee_id
order by w.last_name;
/* Omitting a join condition between two tables produces a Cartesian product. By using the SQL/92 join syntax, you avoid producing a Cartesian product because you must always provide an ON or USING clause to join the tables.

If you really need a Cartesian product, the SQL/92 standard requires the usage of the CROSS JOIN keywords. In the following query, a Cartesian product between the product_types and products tables is produced using the CROSS JOIN keywords:
SELECT *
FROM product_types CROSS JOIN products; 
RM:  Book could have explained more on joins because joins are important.
*/

--CHAPTER 3 USING SQL*Plus PAGE 63
describe customers;  --table information view the structure of a table describe tablename;
--query above same as query below
desc customers;

--CHAPTER 4 USING SIMPLE FUNCTIONS PAGE 89
--There are two functions.  Single-row functions operate on one row at a time and return one row of output for each input row; e.g. CONCAT(x, y) appends y to x and returns the resulting string.  Aggregate functions operate on multiple rows at the same time known as group functions and return one row of output; e.g. AVG(x) returns the average value of x.
--Single-row functions:  character, numeric, conversion, date, regular expression to search data.
--RM:  There are many functions.  I highlight selected functions.
select concat(first_name, last_name)
from customers;  --The concatenation operator does not permit spaces.  https://docs.oracle.com/cd/B12037_01/server.101/b10759/functions022.htm
select name, instr(name, 'Science')
from products;  --instring searches for string returns the position
select name, instr(name, 'e',1,2)
from products;  --find e starting at first position find the second occurrence 'e' returns the position
select name, instr(name, 'e',-1,2)
from products;  --find e starting at last position find the third occurrence 'e' returns the position
select name, length(name)
from products;  --length returns the number of characters
select first_name, upper(first_name), last_name, lower(last_name)
from customers;  --upper and lower converts the ltters to uppercase and lowercase
--LTRIM(x [, trim_string]) and RTRIM(x [, trim_string]) removes characters from the left or right of x. You can provide an optional trim_string, which specifies the characters to remove. If no trim_string is provided, spaces are removed by default.
SELECT LTRIM(' Hello Kathy Lindsey!')
FROM dual;  --return Hello Kathy Lindsey!
SELECT RTRIM('Hi Doreen Oakley!abcabc', 'abc')
FROM dual;  --return Hi Doreen Oakley!
--TRIM([trim_char FROM) x) removes characters from the left and right of x. You can provide an optional trim_char, which specifies the characters to remove. If no trim_ char is provided, spaces are removed by default.
SELECT TRIM('0' FROM '000Hey Steve Button!00000')
FROM dual;  --return Hey Steve Button!
select customer_id, nvl(phone, 'Unknown Phone Number')
from customers;  --phone field is null 'Unknown Phone Number' is returned
select customer_id, nvl2(phone, 'field is not null','Unknown Phone Number')
from customers;  --phone 'field is not null' is not null, 'Unknown Phone Number' is null
select name, replace(name, 'Science','replace Science with Physics')
from products;  --search for 'Science' replaces with 'replace Science with Physics'
select name, substr(name,2, 7)
from products;  --substring returns name start at second position seven characters
select name, substr(name,-5, 3)
from products;  --substring returns name start at fifth position from end three characters
SELECT name, UPPER(SUBSTR(name, 2, 8))
FROM products;  --example combinting functions
SELECT ABS(10), ABS(-10)
FROM dual;  --absolute value
SELECT CEIL(5.8), CEIL(-5.2)
FROM dual;  --ceiling returns 6, -5
SELECT FLOOR(5.8), FLOOR(-5.2)
FROM dual;  --floor returns 5, -6
SELECT GREATEST(3, 4, 1)
FROM dual;  --returns 4
SELECT LEAST(3, 4, 1)
FROM dual;  --returns 1
SELECT POWER(2, 1), POWER(2, 3)
FROM dual;  --returns 2, 8 exponent
SELECT ROUND(5.75), ROUND(5.75, 1), ROUND(5.75, -1)
FROM dual;  --returns 6, 5.8, 10
SELECT TRUNC(5.75), TRUNC(5.75, 1), TRUNC(5.75, -1)
FROM dual;  --returns 5, 5.7, 0, truncate default is zero decimal places
--TO_CHAR(x [, format]) converts x to a string. An optional format indicates the format of x. The structure format depends on whether x is a number or date.  RM:  there are many format options starting on page 114 like Excel Custom Numerber; e.g. C999 returns USD999, rn returns roman numerials, FM90.9 removes leading and trailing spaces
SELECT TO_CHAR(12345.67)
FROM dual;  --returns 12345.67
SELECT TO_CHAR(12345.67, '99,999.99')
FROM dual;  --returns 12,345.67
SELECT TO_CHAR(8712345.675, '99,999,999.99')
FROM dual;  --returns 8,712,345.68
--TO_NUMBER(x [, format]) converts x to a number. An optional format to indicate the format of x. The format string can use the same parameters as TO_CHAR.
SELECT TO_NUMBER('970.13')
FROM dual;
SELECT TO_NUMBER('970.13') + 25.5
FROM dual;  --return 995.63
SELECT TO_NUMBER('-$12,345.67', '$99,999.99')
FROM dual;  --return -12345.67
SELECT TO_NUMBER('-12,345.67', '99999.99')
FROM dual;  --return -12345.67
--Regular expressions and their associated Oracle database functions allow you to search for a pattern of characters in a string. For example, let’s say you want to obtain the years 1965 through 1968 from the following list of years.  Regular expression is ^196[5-8]$.  ^ matches the beginning position of a string.  [5-8] matches characters between 5 and 8.  $ matches the end position of a string.
--RM:  There are many regular expressions formats starting on page 119.
/*
REGEXP_LIKE(x, pattern [, match_option]) searches x for the regular expression defined
in the pattern parameter. You can also provide an optional match_option that can be set to
one of the following characters:
■■ 'c', which specifies case-sensitive matching (the default)
■■ 'I', which specifies case-insensitive matching
■■ 'n', which allows you to use the match-any-character operator
■■ 'm', which treats x as a multiple line
*/
SELECT customer_id, first_name, last_name, dob
FROM customers
WHERE REGEXP_LIKE(TO_CHAR(dob, 'YYYY'), '^196[5-8]$');  --retrieves customers whose date of birth is between 1965 and 1968
SELECT customer_id, first_name, last_name, dob
FROM customers
WHERE REGEXP_LIKE(first_name, '^j', 'i');  --retrieves customers whose first name starts with J or j.  ^j and the match option is i (i indicates case-insensitive matching)
/*
REGEXP_INSTR(x, pattern [, start [, occurrence [, return_option [, match_ option]]]]) searches x for pattern. The function returns the position at which pattern occurs (positions start at 1).
REGEXP_REPLACE(x, pattern [, replace_string [, start [, occurrence [, match_option]]]]) searches x for pattern and replaces it with replace_string.
REGEXP_SUBSTR(x, pattern [, start [, occurrence [, match_option]]]) returns a substring of x that matches pattern. The search begins at the position specified by start.
REGEXP_COUNT() was introduced in Oracle Database 11g. REGEXP_COUNT(x, pattern [, start [, match_option]]) searches x for pattern and returns the number of times pattern is found in x. You can provide an optional start number to indicate the character in x to begin searching for pattern and an optional match_option string to indicate the match option.
*/
select avg(price), avg(price)+2
from products;
select count(product_id)
from products;
select max(price), min(price)
from products;
select sum(price)
from products;
select product_type_id
from products
group by product_type_id;
select product_id, customer_id
from purchases
group by product_id, customer_id;  --You can specify multiple columns in a GROUP BY clause. the product_id and customer_id columns
select product_type_id, avg(price)
from products
group by product_type_id;
select product_type_id, round(avg(price),2)
from products
group by product_type_id;
select product_type_id, count(rowid)
from products
group by product_type_id;  --count number of product_type_ids
SELECT product_type_id, AVG(price)
FROM products
WHERE AVG(price) > 20
GROUP BY product_type_id;  --error message.  use the WHERE clause to filter individual rows, not groups of rows. To filter groups of rows, you use the HAVING clause.  HAVING clause filters groups of rows placed after the GROUP BY clause.
select product_type_id, avg(price)
from products
group by product_type_id
having avg(price) > 20;
--You can use the WHERE and GROUP BY clauses together in the same query. WHERE clause first filters the rows returned.  The GROUP BY clause groups the remaining rows into blocks.
select product_type_id, avg(price)
from products
where price < 15
group by product_type_id;
--You can use the WHERE, GROUP BY, and HAVING clauses together in the same query. WHERE clause filters the rows, GROUP BY clause groups the remaining rows into blocks, and HAVING clause filters the row groups.
select product_type_id, avg(price)
from products
where price < 15
group by product_type_id
having avg(price) > 13;

--CHAPTER 5 STORING AND PROCESSING DATES AND TIMES PAGE 137
--to_char(x, [,format]) convert x to a string; in this case, convert datetime to a string.  RM:  page 141 lists parameters
--to_date(x, [,format]) convert string to a date
select customer_id, to_char(dob, 'MONTH DD, YYYY')
from customers;  --JANUARY   01, 1965
select customer_id, to_char(dob, 'MM/DD/YYYY')
from customers;  --01/01/1965
SELECT TO_CHAR(SYSDATE, 'MONTH DD, YYYY, HH24:MI:SS')
FROM dual; --OCTOBER   06, 2017, 15:05:01
SELECT TO_CHAR(SYSDATE, 'MONTH DD, YYYY, HH:MI AM')
FROM dual; --OCTOBER   06, 2017, 03:07 PM
SELECT TO_DATE('JUL-04-2012')
FROM dual;  --07/04/2012.  RM:  My Oracle default format is month, day, year.
SELECT TO_DATE('July 4, 2012', 'MONTH DD, YYYY')
FROM dual;  --04-JUL-12.  My computer returns 07/04/2012
SELECT TO_DATE('7.4.12', 'MM.DD.YY')
FROM dual;  --04-JUL-12. My computer returns 07/04/2012
INSERT INTO customers (customer_id, first_name, last_name, dob, phone)
VALUES (6, 'Fred', 'Brown', TO_DATE('05-FEB-1968 19:32:36', 'DD-MON-YYYY HH24:MI:SS'), '800-555-1215');  --dob column for the new row is set to the datetime returned by TO_DATE().
select customer_id, dob, to_char(dob, 'DD-MON-YYYY HH24:MI:SS')
from customers;  --2 02/05/1968	05-FEB-1968 00:00:00  --to_char converts dob to another date format as a string
/*
The default date format is specified in the NLS_DATE_FORMAT database parameter.  You can also set the NLS_DATE_FORMAT parameter for your own SQL*Plus session using the ALTER SESSION command.  e.g. ALTER SESSION SET NLS_DATE_FORMAT = 'MONTH-DD-YYYY';  Any changes you make using the ALTER SESSION statement last only for
that particular session. When you disconnect, you lose the change.
*/
/*
An Oracle database stores all four digits of the year. If only two digits are supplied when adding
or updating rows, the database software will interpret the century according to whether the YY or
RR format is used.  You should always specify all four digits of the year.
*/
select customer_id, dob, add_months(dob,6)
from customers;  --adds six months to dob.  Can subtract months using negative.
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('01-JAN-2012 19:15:26', 'DD-MON-YYYY HH24:MI:SS'), 2), 'DD-MON-YYYY HH24:MI:SS')
FROM dual;  --convert the returned datetime from ADD_MONTHS() to a string using TO_CHAR() with the format DD-MON-YYYY HH24:MI:SS and add two months.
select customer_id, dob, last_day(dob)
from customers;  --returns the date of the last day of dob's month
SELECT MONTHS_BETWEEN('MAY-25-2012', 'JAN-15-2012')
FROM dual;  --returns 4.32258065
SELECT MONTHS_BETWEEN('JAN-15-2012', 'MAY-25-2012')
FROM dual;;  --returns -4.32258065
SELECT ROUND(TO_DATE('OCT-25-2012'), 'YYYY')
FROM dual;  --returns 01/01/2013
SELECT ROUND(TO_DATE('MAY-25-2012'), 'MM')
FROM dual;  --returns 06/01/2012
SELECT TRUNC(TO_DATE('MAY-25-2012'), 'YYYY')
FROM dual;  --return 01/01/2012
SELECT TRUNC(TO_DATE('MAY-25-2012'), 'MM')
FROM dual;  --return 05/01/2012
--RM:  Skipped Timestamps A timestamp stores all four digits of a year, plus the month, day, hour, minute, second, fractional second, and time zone.  Time Intervals A time interval stores a length of time. An example time interval is 1 year 3 months.

--CHAPTER 6 SUBQUERIES PAGE 177
/*
There are two basic types of subqueries:
■■ Single-row subqueries return zero rows or one row to the outer SQL statement. There is
a special case of a single-row subquery that contains exactly one column. This type of
subquery is called a scalar subquery.
■■ Multiple-row subqueries return one or more rows to the outer SQL statement.
In addition, there are three subtypes of subqueries that can return single or multiple rows:
■■ Multiple-column subqueries return more than one column to the outer SQL statement.
■■ Correlated subqueries reference one or more columns in the outer SQL statement. These
are called correlated subqueries because they are related to the outer SQL statement
through the same columns.
■■ Nested subqueries are placed within another subquery.
*/
--A single-row subquery returns zero rows or one row to the outer SQL statement. You can place a subquery in a WHERE clause, a HAVING clause, or a FROM clause of a SELECT statement.
select customer_id
from customers
where last_name = 'Brown';  --return 1
select first_name, last_name
from customers
where customer_id = 
	(select customer_id
	from customers
	where last_name = 'Brown');  --return 1, return John Brown
select avg(price)
from products;  --return 19.73083333333333333333333333333333333333
select product_id, name, price
from products
where price >
	(select avg(price)
	from products);
select max(avg(price))
from products
group by product_type_id;  --return 26.22
select product_type_id, avg(price)
from products
group by product_type_id
order by product_type_id;
select product_type_id, avg(price)
from products
group by product_type_id
having avg(price) <
	(select max(avg(price))
	from products
	group by product_type_id)
order by product_type_id;
select product_id
from products
where product_id < 3;
select product_id
from
	(select product_id
	from products
	where product_id < 3);
select product_id, count(product_id)
from purchases
group by product_id;
select product_id, price
from products;
select prds.product_id, price, purchs.product_count
from products prds, 
	(select product_id, count(product_id) product_count
	from purchases
	group by product_id) purchs
where prds.product_id = purchs.product_id;  --The subquery retrieves the product_id and COUNT(product_id) from the purchases table and returns them to the outer query. The output from the subquery is just another source of data to the FROM clause of the outer query.
--A multiple-row subquery returns one or more rows to an outer SQL statement. To process the multiple rows returned by a subquery, an outer query can use the IN, ANY, or ALL operators.
select product_id
from products
where name like '%e%';
select product_id, name
from products
where product_id in
	(select product_id
	from products
	where name like '%e%');
SELECT product_id, name
FROM products
WHERE product_id NOT IN
	(SELECT product_id
	FROM purchases)
ORDER BY product_id;  --Uses NOT IN to retrieve the products that are not in the purchases table.
select low_salary
from salary_grades;
select employee_id, last_name
from employees
where salary < any
	(select low_salary
	from salary_grades)
order by employee_id;  --The ANY operator compares one value with any value in a list. You must place an =, <>, <, >, <=, or >= operator before ANY in your query.
select high_salary
from salary_grades;
select employee_id, last_name
from employees
where salary > any
	(select high_salary
	from salary_grades)
order by employee_id;  --The ANY operator compares one value with any value in a list. You must place an =, <>, <, >, <=, or >= operator before ANY in your query.
select high_salary
from salary_grades;
select employee_id, last_name
from employees
where salary > all
	(select high_salary
	from salary_grades)
order by employee_id;  --The ALL operator compares one value with all values in a list. You must place an =, <>, <, >, <=, or >= operator before ALL in your query.
--A subquery can return multiple columns.
select product_type_id, min(price)
from products
group by product_type_id;
select product_id, product_type_id, name, price
from products
order by product_id;
select product_id, product_type_id, name, price
from products
where (product_type_id, price) in
	(select product_type_id, min(price)
	from products
	group by product_type_id)
order by product_id;  --The subquery returns the product_type_id and the minimum price for each group of products. The product_type_id and minimum price for each group are compared in the outer query’s WHERE clause with the product_type_id and price for each product. The products with the lowest price for each product type group are displayed.
--A correlated subquery references one or more columns in the outer SQL statement. These are called correlated subqueries because they are related to the outer SQL statement through the same columns.  A correlated subquery can resolve null values.
select product_type_id, avg(price)
from products
group by product_type_id;
select product_id, product_type_id, name, price
from products;
select product_id, product_type_id, name, price
from products outer
where price >
	(select avg(price)
	from products inner
	where inner.product_type_id = outer.product_type_id);
order by product_id;  --retrieves the products that have a price greater than the average price for their product type
/*
I’ve used the alias outer to label the outer query and the alias inner for the inner subquery. The reference to the product_type_id column in both the inner and outer parts is what makes the inner subquery correlated with the outer query. Also, the subquery returns a single row containing the average price for the product.

The outer query retrieves each row from the products table and passes it to the inner query. Each row is read by the inner query, which calculates the average price for each product where the product_type_id in the inner query is equal to the product_type_id in the outer query.
*/
--You use the EXISTS operator to check for the existence of rows returned by a subquery. Although you can use EXISTS with non-correlated subqueries, EXISTS is typically used with correlated subqueries.  NOT EXISTS does the logical opposite of EXISTS. NOT EXISTS checks if rows do not exist in the results returned by a subquery.
select *
from employees;
SELECT *
FROM employees outer
WHERE EXISTS
	(SELECT employee_id
	FROM employees inner
	WHERE inner.manager_id = outer.employee_id)
ORDER BY employee_id;  --retrieve employees who manage other employees
select *
from products;
select *
from purchases;
SELECT product_id, name
FROM products outer
WHERE EXISTS
	(SELECT 1  --1 is a placeholder returns columns product_id, name
	FROM purchases inner
	WHERE inner.product_id = outer.product_id)
ORDER BY product_id;  --uses EXISTS to retrieve products that have been purchased
SELECT product_id, name
FROM products outer
WHERE NOT EXISTS
	(SELECT 1  --1 is a placeholder returns columns product_id, name
	FROM purchases inner
	WHERE inner.product_id = outer.product_id)
ORDER BY product_id;  --uses NOT EXISTS to retrieve products that haven’t been purchased
/*
The IN operator checks if a value is contained in a list of values. EXISTS is different from IN. EXISTS
checks for the existence of rows, whereas IN checks for actual values.
*/
SELECT product_type_id, name
FROM product_types outer
WHERE NOT EXISTS
	(SELECT 1
	FROM products inner
	WHERE inner.product_type_id = outer.product_type_id)
ORDER BY product_type_id;  --uses NOT EXISTS to retrieve the product types that don’t have any products of that type in the products table.  Returned 5 Magazine.
SELECT product_type_id, name
FROM product_types
WHERE product_type_id NOT IN
	(SELECT product_type_id
	FROM products)
ORDER BY product_type_id;  --The next example rewrites the previous query to use NOT IN. No rows are returned.
--No rows are returned because the subquery returns a list of product_id values, one of which is null (the product_type_id for product #12 is null). Because of this, NOT IN in the Chapter 6: Subqueries 189 outer query returns false, and therefore no rows are returned. You must use the NVL() function to convert nulls to a value. In the following example, NVL() is used to convert null product_type_id values to 0:
SELECT product_type_id, name
FROM product_types
WHERE product_type_id NOT IN
	(SELECT NVL(product_type_id, 0)
	FROM products)
ORDER BY product_type_id;  --Returned 5 Magazine
--You can nest subqueries inside other subqueries.
SELECT product_type_id, AVG(price)
FROM products
GROUP BY product_type_id
HAVING AVG(price) <
	(SELECT MAX(AVG(price))
	FROM products
	WHERE product_type_id IN  --Second.  This subquery returns the maximum average price for the products returned by the nested subquery.
		(SELECT product_id
		FROM purchases
		WHERE quantity > 1)  --First.  This nested subquery returns the product_id for the products that have been purchased more than once.
	GROUP BY product_type_id)
ORDER BY product_type_id;  --Finally.  This query returns the product_type_id and average price of products that are less than the average price returned by the subquery.
--You can place subqueries inside UPDATE and DELETE statements.
UPDATE employees
SET salary =
	(SELECT AVG(high_salary)
	FROM salary_grades)
WHERE employee_id = 4;  --The update increases employee #4’s salary from $500,000 to $625,000. ($625,000 is the average of the high salaries from the salary_grades table.)
DELETE FROM employees
WHERE salary >
	(SELECT AVG(high_salary)
	FROM salary_grades);  --the following DELETE statement removes the employee whose salary is greater than the average of the high salary grades returned by a subquery
--You can place subqueries inside a WITH clause and reference those subqueries outside of the WITH clause. This is known as subquery factoring.
select cu.customer_id, sum(pr.price * pu.quantity) as purchase_total
from customers cu, purchases pu, products pr
where cu.customer_id = pu.customer_id
and pu.product_id = pr.product_id
group by cu.customer_id;
with
	customer_purchases as (
		select cu.customer_id, sum(pr.price * pu.quantity) as purchase_total
		from customers cu, purchases pu, products pr
		where cu.customer_id = pu.customer_id
		and pu.product_id = pr.product_id
		group by cu.customer_id)
select *
from customer_purchases
order by customer_id;
--RM:  the with was unnecessary.  SQL code above returns same result.
with
	customer_purchases as (
		select cu.customer_id, sum(pr.price * pu.quantity) as purchase_total
		from customers cu, purchases pu, products pr
		where cu.customer_id = pu.customer_id
		and pu.product_id = pr.product_id
		group by cu.customer_id),
	average_purchase as (
		select sum(purchase_total)/count(*) as average
		from customer_purchases)
select *
from customer_purchases
where purchase_total <
	(select average
	from average_purchase)
order by customer_id;  --The customer_purchases subquery retrieves the customer IDs, the sum total of their purchases, and the average of the totals. The main query outside of the WITH clause returns the customer ID and purchase total for the customers whose purchase total is less than the average of the purchase totals.

--CHAPTER 7 ADVANCED QUERIES page 195
/*
UNION ALL Returns all the rows retrieved by the queries, including duplicate rows
UNION Returns all non-duplicate rows retrieved by the queries
INTERSECT Returns rows that are retrieved by both queries
MINUS Returns the remaining rows when the rows retrieved by the second query are subtracted from the rows retrieved by the first query
*/
select product_id, product_type_id, name
from products;
select prd_id, prd_type_id, name
from more_products;
select product_id, product_type_id, name
from products
union all
select prd_id, prd_type_id, name
from more_products;
select product_id, product_type_id, name
from products
union
select prd_id, prd_type_id, name
from more_products;
select product_id, product_type_id, name
from products
intersect
select prd_id, prd_type_id, name
from more_products;
select product_id, product_type_id, name
from products
minus
select prd_id, prd_type_id, name
from more_products;  --The rows from more_products are subtracted from products
select product_id, product_type_id, name
from product_changes;
	(SELECT product_id, product_type_id, name
	FROM products
	UNION
	SELECT prd_id, prd_type_id, name
	FROM more_products)
INTERSECT
SELECT product_id, product_type_id, name
FROM product_changes;  --UNION combines results from products and more_products.  INTERSECT combine results from previous UNION with results from product_changes.  Parentheses indicate order of evaluation.
SELECT product_id, product_type_id, name
FROM products
UNION
	(SELECT prd_id, prd_type_id, name
	FROM more_products
	INTERSECT
	SELECT product_id, product_type_id, name
	FROM product_changes);  --parentheses set so that the INTERSECT is performed first. Different results are returned by the query compared with the previous example
--The CASE expression performs if then else or if else or if-then-else logic.  Simple CASE expressions, which use expressions to determine the returned value.  Searched CASE expressions, which use conditions to determine the returned value.
select product_id, product_type_id, case product_type_id when 1 then 'Book' when 2 then 'Video' when 3 then 'DVD' when 4 then 'CD' else 'Magazine' end as "simple case alias"
from products;
select product_id, product_type_id, case when product_type_id=1 then 'Book' when product_type_id=2 then 'Video' when product_type_id=3 then 'DVD' when product_type_id=4 then 'CD' else 'Magazine' end as "searched case alias"
from products;
select product_id, price, case when price > 15 then 'Expensive' else 'Cheap' end as "operators searched case alias"
from products;
--You can use the CONNECT BY and START WITH clauses of a SELECT statement to perform hierarchy or hierarchical queries.
select *
from more_employees;
select employee_id, manager_id, first_name, last_name
from more_employees;
select employee_id, manager_id, first_name, last_name
from more_employees
start with employee_id = 1
connect by prior employee_id = manager_id;
select level, employee_id, manager_id, first_name, last_name
from more_employees
start with employee_id = 1
connect by prior employee_id = manager_id
order by level, employee_id;  --LEVEL is a pseudo column that indicates the level of the tree. LEVEL returns 1 for a root node, 2 for a child of the root, and so on.
--You can format the results from a hierarchical query using LEVEL and the LPAD() function.  LPAD() left-pads values with characters.  The following query uses LPAD(' ', 2 * LEVEL - 1) to left-pad a total of 2 * LEVEL - 1 spaces. This indents an employee’s name with spaces based on their LEVEL. LEVEL 1 isn’t padded, LEVEL 2 is padded by two spaces, LEVEL 3 by four spaces, and so on.
SET PAGESIZE 999
COLUMN employee FORMAT A25
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || first_name || ' ' || last_name AS employee
FROM more_employees
START WITH employee_id = 1
CONNECT BY PRIOR employee_id = manager_id;
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || first_name || ' ' || last_name AS employee
FROM more_employees
START WITH last_name = 'Jones'
CONNECT BY PRIOR employee_id = manager_id;  --Starts with Susan Jones. Notice that LEVEL returns 1 for Susan Jones, 2 for Jane Brown, and so on.
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || first_name || ' ' || last_name AS employee
FROM more_employees
START WITH employee_id = 
	(SELECT employee_id
	FROM more_employees
	WHERE first_name = 'Kevin'
	AND last_name = 'Black')
CONNECT BY PRIOR employee_id = manager_id;  --You can use a subquery in a START WITH clause. The following example uses a subquery to select the employee_id whose name is Kevin Black.
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || first_name || ' ' || last_name AS employee
FROM more_employees
START WITH last_name = 'Blue'
CONNECT BY PRIOR manager_id = employee_id;  --You can traverse a tree upward from child to parent. You do this by switching the child and parent columns in the CONNECT BY PRIOR clause.
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || first_name || ' ' || last_name AS employee
FROM more_employees
WHERE last_name != 'Johnson'
START WITH employee_id = 1
CONNECT BY PRIOR employee_id = manager_id;  --You can eliminate a particular node from a query tree using a WHERE clause. The following query eliminates Ron Johnson from the results using WHERE last_name != 'Johnson'.
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || first_name || ' ' || last_name AS employee
FROM more_employees
START WITH employee_id = 1
CONNECT BY PRIOR employee_id = manager_id
AND last_name != 'Johnson';  --To eliminate an entire branch of nodes from the results of a query, you add an AND clause to the CONNECT BY PRIOR clause. The following example uses AND last_name != 'Johnson'.
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || first_name || ' ' || last_name AS employee, salary
FROM more_employees
WHERE salary <= 50000
START WITH employee_id = 1
CONNECT BY PRIOR employee_id = manager_id;  --You can include other conditions in a hierarchical query using a WHERE clause. The following example uses a WHERE clause to show only employees whose salaries are less than or equal to $50,000
--RM Skipped Using Recursive Subquery Factoring to Query Hierarchical Data Page 215.  It's better than CONNECT BY.  Place a subquery inside a WITH clause.
select *
from divisions;
select *
from jobs;
select *
from employees2;
select division_id, sum(salary)
from employees2
group by division_id;
select division_id, sum(salary)
from employees2
group by rollup(division_id);  --the additional row at the end of the output, which shows the total salaries for all groups or adds the rows add rows.  Subtotals row subtotal rows.
select division_id, job_id, sum(salary)
from employees2
group by rollup(division_id, job_id);  --ROLLUP returns a row with the sum of the salaries in each division_id, plus a grand total of salaries at the end of the result set
select division_id, job_id, avg(salary)
from employees2
group by rollup(division_id, job_id);  --You can use any of the aggregate functions with ROLLUP.  Example use avg()
select division_id, job_id, sum(salary)
from employees2
group by cube(division_id, job_id)
order by division_id, job_id;  --The CUBE clause extends GROUP BY to return rows containing a subtotal for all combinations of columns, plus a row containing the grand total.  RM: order by makes query easier to read.
--The GROUPING() function accepts a column and returns 0 or 1. GROUPING() returns 1 when the column value is null and returns 0 when the column value is non-null. GROUPING() is used only in queries that use ROLLUP or CUBE. GROUPING() is useful when you want to display a value when a null would otherwise be returned.
select division_id, sum(salary)
from employees2
group by rollup(division_id);
select grouping(division_id), division_id, sum(salary)
from employees2
group by rollup(division_id);  --GROUPING() returns 0 for the rows that have non-null division_id values and returns 1 for the last row that has a null division_id.
select case grouping(division_id) when 1 then 'All divisions' else division_id end as div, sum(salary)
from employees2
group by rollup(division_id);
select case grouping(division_id) when 1 then 'All divisions' else division_id end as div, case grouping(job_id) when 1 then 'All jobs' else job_id end as job, sum(salary)
from employees2
group by rollup(division_id, job_id);  --Replaces null values in a ROLLUP containing multiple columns division_id and job_id
select case grouping(division_id) when 1 then 'All divisions' else division_id end as div, case grouping(job_id) when 1 then 'All jobs' else job_id end as job, sum(salary)
from employees2
group by cube(division_id, job_id)
order by division_id, job_id;  --Replaces null values in a CUBE containing multiple columns division_id and job_id
--You use the GROUPING SETS clause to obtain the subtotal rows. The following example uses GROUPING SETS to obtain the subtotals for salaries by division_id and job_id.  RM:  There are no subtotal breakdowns.  No grand total.
select division_id, job_id, sum(salary)
from employees2
group by grouping sets(division_id, job_id)
order by division_id, job_id;  --Only the subtotals for the division_id and job_id columns are returned.
--RM:  In lament terms, use grouping_id() to filter rows not null.  Use grouping_id() in the having clause.  Exclude rows without a subtotal or total.
select division_id, job_id, grouping_id(division_id, job_id) as groupid, sum(salary)
from employees2
group by cube(division_id, job_id)
having grouping_id(division_id, job_id) > 0
order by division_id, job_id;
--You can use a column many times in a GROUP BY clause. This allows you to reorganize your data or report on different groupings of data. The following query contains a GROUP BY clause that uses division_id twice, once to group by division_id and again in a ROLLUP
SELECT division_id, job_id, SUM(salary)
FROM employees2
GROUP BY division_id, ROLLUP(division_id, job_id);
--You can use the GROUP_ID() function to remove duplicate rows returned by a GROUP BY clause.  If n duplicates exist for a particular grouping, GROUP_ID() returns numbers in the range 0 to n – 1.
SELECT division_id, job_id, GROUP_ID(), SUM(salary)
FROM employees2
GROUP BY division_id, ROLLUP(division_id, job_id);
SELECT division_id, job_id, GROUP_ID(), SUM(salary)
FROM employees2
GROUP BY division_id, ROLLUP(division_id, job_id);  --The duplicate rows group_id() returns 1
SELECT division_id, job_id, GROUP_ID(), SUM(salary)
FROM employees2
GROUP BY division_id, ROLLUP(division_id, job_id)
HAVING GROUP_ID() = 0;  --Set group_id() = 0 in having statement remove duplicate rows
--New for Oracle Database 12c are CROSS APPLY and OUTER APPLY, which compare the rows returned by two SELECT statements and return the matching rows in one merged result set.
select *
from divisions;
select *
from employees3;
select *
from divisions d, employees3 e
where d.division_id = e.division_id;
select *
from divisions d
cross apply
	(select *
	from employees3 e
	where e.division_id = d.division_id);
--OUTER APPLY returns a merge of the rows from two SELECT statements, including non-matching rows returned by the outer SELECT.
select *
from divisions;
select *
from employees3;
select *
from divisions d left outer join employees3 e
on d.division_id = e.division_id;
select *
from divisions d
outer apply
	(select *
	from employees3 e
	where e.division_id = d.division_id);
--New for Oracle Database 12c is LATERAL, which provides a subquery as an inline view. An inline view retrieves data from one or more tables to produce a temporary table that an outer SELECT can use as a source of data.  LATERAL cannot provide null columns for non-matching rows, used with PIVOT AND UNPIVOT, and contain a left correlation to the first table in a right outer join or full outer join.
select *
from divisions d,
lateral
	(select *
	from employees3 e
	where e.division_id = d.division_id);  --note the comma after from divisions d

--CHAPTER 8 ANALYZING DATA page 237
--RM:  There are many analytic functions.  I make a judgement call practice the common analytic functions.  Also, take it slow.
select *
from all_sales;
--RANK() and DENSE_RANK() rank items in a group. The difference between these two functions is in the way they handle items that tie: RANK() leaves a gap in the sequence when there is a tie, but DENSE_RANK() leaves no gaps.
select prd_type_id, sum(amount), rank() over (order by sum(amount) desc) as rank
from all_sales
where amount is not null
group by prd_type_id;
select prd_type_id, sum(amount), rank() over (order by sum(amount) desc nulls last) as rank
from all_sales
group by prd_type_id;  --null values are lowest rank
--You use the PARTITION BY clause with the analytic functions when you need to divide the groups into subgroups.
select prd_type_id, month, sum(amount), rank() over (partition by month order by sum(amount) desc) as rank
from all_sales
where amount is not null
group by prd_type_id, month;
--The ROLLUP, CUBE, and GROUPING SETS operators can be used with the analytic functions.
select prd_type_id, sum(amount), rank() over (order by sum(amount) desc) as rank
from all_sales
where amount is not null
group by rollup(prd_type_id);  --rollup from chapter 7.  The additional row at the end of the output, which shows the total salaries for all groups or adds the rows add rows.  Subtotals row subtotal rows.
select prd_type_id, emp_id, sum(amount), rank() over (order by sum(amount) desc) as rank
from all_sales
group by cube(prd_type_id, emp_id)
order by prd_type_id, emp_id; --uses CUBE and RANK() to get all rankings of sales by product type ID and
employee ID
select prd_type_id, emp_id, sum(amount), rank() over (order by sum(amount) desc) as rank
from all_sales
group by grouping sets(prd_type_id, emp_id)
order by prd_type_id, emp_id;
--start page 246.