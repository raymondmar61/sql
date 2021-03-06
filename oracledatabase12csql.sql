--Oracle Database 12c SQL by Jason Price
--Five types of SQL statements.  Query statements; Data Manipulation Language (DML) such as insert, update, delete; Data Definition Language (DDL) such as create, alter, drop, rename, truncate, Transaction Control (TC) such as commit, rollback, savepoint, and Data Control Language (DCL) such as grant and revoke.
--Foreign key references a column in another table.  The table containing the foreign key is known as the detail or child table.  The table that is referenced is known as the master or parent table. This type of relationship is known as a master-detail or parentchild relationship.
--Composite primary key when a primary key consists of multiple columns.  The combination of the multiple columns must be unique for each row.
--Double quotes for alias; otherwise single quotes.
--Shift+F4 opens Popup describe or table information window.  Cursor on table name.  Otherwise, click on table name in Connections window.  Click on the individual tabs.

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
select month, sum(amount), sum(sum(amount)) over (order by month rows between unbounded preceding and current row) as cumulativesum
from all_sales
group by month
order by month;  --cumulative sum
select month, sum(amount), avg(sum(amount)) over (order by month rows between 3 preceding and current row) as threemonthmovingaverage
from all_sales
group by month
order by month;  --moving average three months
select month, sum(amount), avg(sum(amount)) over (order by month rows between 1 preceding and 1 following) as monthmovingaverage
from all_sales
group by month
order by month;  --moving average previous month, current month, and next month
select month, sum(amount) as currentmonth, first_value(sum(amount)) over (order by month rows between 1 preceding and 1 following) as previousmonth, last_value(sum(amount)) over (order by month rows between 1 preceding and 1 following) as nextmonth
from all_sales
group by month
order by month;  --get first rows and last row and current row or get previous row and get next row
select month, sum(amount) as currentmonth, sum(amount)/first_value(sum(amount)) over (order by month rows between 1 preceding and 1 following) as currentdividepreviousmonth, sum(amount)/last_value(sum(amount)) over (order by month rows between 1 preceding and 1 following) as currentdividenextmonth
from all_sales
group by month
order by month;  --divides current month's sales/previous month's sales and divides current month's sales/next month's sales
select month, prd_type_id, sum(sum(amount)) over (partition by month) as totalmonthsum, sum(sum(amount)) over (partition by prd_type_id) as totalproducttypeamount
from all_sales
group by month, prd_type_id
order by month, prd_type_id;  --sum sales and sum by product type all by month
select month, prd_type_id, sum(amount) as producttypeamount, ratio_to_report(sum(amount)) over (partition by month) as producttyperatio
from all_sales
group by month, prd_type_id
order by month, prd_type_id; --sum of sales and the ratio of sales to the sum of sales by month
/*
The MODEL clause enables you to perform interrow calculations. The MODEL clause allows you to access a column in a row like a cell in an array. This provides the ability to perform calculations in a similar manner to spreadsheet
calculations.
*/
-- For example, the all_sales table contains sales information for the months in 2003. You can use the MODEL clause to calculate sales in future months based on sales in 2003.  Retrieves the sales amount for each month in 2003 made by employee #21 for product types #1 and #2 and predicts sales for January, February, and March of 2004 based on sales in 2003.
select prd_type_id, year, month, sales_amount
from all_sales
where prd_type_id between 1 and 2
and emp_id = 21
model
partition by (prd_type_id)
dimension by (month, year)
measures (amount sales_amount)
	(sales_amount[1, 2004] = sales_amount[1, 2003],
	sales_amount[2, 2004] = sales_amount[2, 2003] + sales_amount[3, 2003], 
	sales_amount[3, 2004] = round(sales_amount[3, 2003] * 1.25, 2)
)
order by prd_type_id, year, month;
--You can also use symbolic notation to explicitly indicate the meaning of the dimensions. For example, sales_amount[month=1, year=2004]
select prd_type_id, year, month, sales_amount
from all_sales
where prd_type_id between 1 and 2
and emp_id = 21
model
partition by (prd_type_id)
dimension by (month, year)
measures (amount sales_amount)
	(sales_amount[month = 1, year = 2004] = sales_amount[month = 1, year = 2003],
	sales_amount[month = 2, year = 2004] = sales_amount[month = 2, year = 2003] + sales_amount[month = 3, year = 2003], 
	sales_amount[month = 3, year = 2004] = round(sales_amount[month = 3, year = 2003] * 1.25, 2)
)
order by prd_type_id, year, month;  --no 2004 data.  I don't know why.
--You can access a range of cells using the BETWEEN and AND keywords. For example, the following expression sets the sales amount for January 2004 to the rounded average of the sales between January and March 2003
select prd_type_id, year, month, sales_amount
from all_sales
where prd_type_id between 1 and 2
and emp_id = 21
model
partition by (prd_type_id)
dimension by (month, year)
measures (amount sales_amount)
	(sales_amount[month = 1, year = 2004] = round(avg(sales_amount)[month between 1 and 3, year = 2003], 2)
)
order by prd_type_id, year, month;  --no 2004 data.  I don't know why.
--You can access all cells in an array using the ANY and IS ANY predicates. You use ANY with positional notation and IS ANY with symbolic notation. For example, the following expression sets the sales amount for January 2004 to the rounded sum of the sales for all months and years
select prd_type_id, year, month, sales_amount
from all_sales
where prd_type_id between 1 and 2
and emp_id = 21
model
partition by (prd_type_id)
dimension by (month, year)
measures (amount sales_amount)
	(sales_amount[month = 1, year = 2004] = round(sum(sales_amount)[any, year is any], 2)
)
order by prd_type_id, year, month;  --no 2004 data.  I don't know why.
--The CURRENTV() function returns the current value of a dimension. For example, the following expression sets the sales amount for the first month of 2004 to 1.25 times the sales of the same month in 2003. Notice the use of CURRENTV() to get the current month, which is 1.
select prd_type_id, year, month, sales_amount
from all_sales
where prd_type_id between 1 and 2
and emp_id = 21
model
partition by (prd_type_id)
dimension by (month, year)
measures (amount sales_amount)
	(sales_amount[month = 1, year = 2004] = round(sales_amount[currentv(), 2003] * 1.25, 2)
)
order by prd_type_id, year, month;  --no 2004 data.  I don't know why.
--You can access cells using a FOR loop. For example, the following expression sets the sales amount for the first three months of 2004 to 1.25 times the sales of the same months in 2003. Notice the use of the INCREMENT keyword, which specifies the amount to increment month by during each iteration of the loop.
select prd_type_id, year, month, sales_amount
from all_sales
where prd_type_id between 1 and 2
and emp_id = 21
model
partition by (prd_type_id)
dimension by (month, year)
measures (amount sales_amount)
	(sales_amount[for month from 1 to 3 increment 1, year = 2004] = round(sales_amount[currentv(), 2003] * 1.25, 2)
)
order by prd_type_id, year, month;  --no 2004 data.  I don't know why.
sales_amount[currentv(), 2003] is present --IS PRESENT returns true if the row specified by the cell reference existed prior to the execution of the MODEL clause
sales_amount[FOR month FROM 1 TO 3 INCREMENT 1, 2004] =
	CASE WHEN sales_amount[CURRENTV(), 2003] IS PRESENT THEN
		ROUND(sales_amount[CURRENTV(), 2003] * 1.25, 2)
ELSE
	0
END  --sets the sales amount for the first three months of 2004 to 1.25 multiplied by the sales of the same months in 2003
--The following query shows the use of this expression
SELECT prd_type_id, year, month, sales_amount
FROM all_sales
WHERE prd_type_id BETWEEN 1 AND 2
AND emp_id = 21
MODEL
PARTITION BY (prd_type_id)
DIMENSION BY (month, year)
MEASURES (amount sales_amount) (
	sales_amount[FOR month FROM 1 TO 3 INCREMENT 1, 2004] =
	CASE WHEN sales_amount[CURRENTV(), 2003] IS PRESENT THEN
		ROUND(sales_amount[CURRENTV(), 2003] * 1.25, 2)
	ELSE
		0
	END
)
ORDER BY prd_type_id, year, month;
PRESENTV(sales_amount[CURRENTV(), 2003], ROUND(sales_amount[CURRENTV(), 2003] * 1.25, 2), 0)  --The PRESENTV(cell, expr1, expr2) function returns the expression expr1 if the row specified by the cell reference existed prior to the execution of the MODEL clause. If the row doesn’t exist, the expression expr2 is returned.
--The following query shows the use of this expression
SELECT prd_type_id, year, month, sales_amount
FROM all_sales
WHERE prd_type_id BETWEEN 1 AND 2
AND emp_id = 21
MODEL
PARTITION BY (prd_type_id)
DIMENSION BY (month, year)
MEASURES (amount sales_amount) (
	sales_amount[FOR month FROM 1 TO 3 INCREMENT 1, 2004] =
		PRESENTV(sales_amount[CURRENTV(), 2003],
			ROUND(sales_amount[CURRENTV(), 2003] * 1.25, 2), 0)
)
ORDER BY prd_type_id, year, month;
PRESENTNNV(sales_amount[CURRENTV(), 2003], ROUND(sales_amount[CURRENTV(), 2003] * 1.25, 2), 0) --The PRESENTNNV(cell, expr1, expr2) function returns the expression expr1 if the row specified by the cell reference existed prior to the execution of the MODEL clause and the cell value is not null. If the row doesn’t exist or the cell value is null, the expression expr2 is returned.
/*
By default, the MODEL clause treats a cell that is missing a value as if it had a null value. A cell with a null value is also treated as a null value. You can change this default behavior by using IGNORE NAV, which returns one of the following values:
*0 for a cell with a missing or null numeric value
*An empty string for a cell with a missing or null string value
*01-JAN-2000 for a cell with a missing or null date value
*Null for a cell with a missing or null value of any other database type
You can also explicitly specify KEEP NAV, which is the default behavior. KEEP NAV returns null for a cell with a missing or null value.
*/
SELECT prd_type_id, year, month, sales_amount
FROM all_sales
WHERE prd_type_id BETWEEN 1 AND 2
AND emp_id = 21
MODEL IGNORE NAV
PARTITION BY (prd_type_id)
DIMENSION BY (month, year)
MEASURES (amount sales_amount) (
  sales_amount[FOR month FROM 1 TO 3 INCREMENT 1, 2004] =
    ROUND(sales_amount[CURRENTV(), 2003] * 1.25, 2)
)
ORDER BY prd_type_id, year, month;
--By default, if the cell referenced on the left side of an expression exists, then it is updated. If the cell doesn’t exist, then a new row in the array is created. You can change this default behavior using RULES UPDATE, which specifies that if the cell doesn’t exist, a new row will not be created.  The following query shows the use of RULES UPDATE:
SELECT prd_type_id, year, month, sales_amount
FROM all_sales
WHERE prd_type_id BETWEEN 1 AND 2
AND emp_id = 21
MODEL
PARTITION BY (prd_type_id)
DIMENSION BY (month, year)
MEASURES (amount sales_amount)
RULES UPDATE (
  sales_amount[FOR month FROM 1 TO 3 INCREMENT 1, 2004] =
    ROUND(sales_amount[CURRENTV(), 2003] * 1.25, 2)
)
ORDER BY prd_type_id, year, month;  --Because cells for 2004 don’t exist and RULES UPDATE is used, no new rows are created in the array for 2004. Therefore, the query doesn’t return rows for 2004.
--PIVOT rotates rows into columns in the output from a query and runs an aggregation function on the data. UNPIVOT does the opposite of PIVOT. UNPIVOT rotates columns into rows.
--The following query shows the total sales amount of product types #1, #2, and #3 for the first four months in 2003. The cells in the result set show the sum of the sales amounts for each product type in each month.
SELECT *
FROM (
	SELECT month, prd_type_id, amount
	FROM all_sales
	WHERE year = 2003
	AND prd_type_id IN (1, 2, 3)
)
PIVOT (
	SUM(amount) FOR month IN (1 AS JAN, 2 AS FEB, 3 AS MAR, 4 AS APR)
)
ORDER BY prd_type_id;
/*
SELECT *
FROM (
	inner_query
)
PIVOT (
	aggregate_function FOR pivot_column IN (list_of_values)
)
ORDER BY ...;
*There is an inner and outer query. The inner query gets the month, product type, and amount from the all_sales table and passes the results to the outer query.
*SUM(amount) FOR month IN (1 AS JAN, 2 AS FEB, 3 AS MAR, 4 AS APR) is the line within the PIVOT clause.  The SUM() function adds up the sales amounts for the product types in the first four months (the months are listed in the IN part). Instead of returning the months as 1, 2, 3, and 4 in the output, the AS part renames the numbers to JAN, FEB, MAR, and APR to make the months more readable in the output.  The month column from the all_sales table is used as the pivot column. This means that the months appear as columns in the output. The rows are rotated—or pivoted—to view the months as columns.
*At the very end of the example, the ORDER BY prd_type_id line orders the results by the product type.
*/
--To pivot on multiple columns, you place the columns in the FOR part of the PIVOT. The following example pivots on both the month and prd_type_id columns, which are referenced in the FOR part. The list of values in the IN part of the PIVOT contains a value for the month and prd_type_id columns.
SELECT *
FROM (
	SELECT month, prd_type_id, amount
	FROM all_sales
	WHERE year = 2003
	AND prd_type_id IN (1, 2, 3)
)
PIVOT (
	SUM(amount) FOR (month, prd_type_id) IN ( (1, 2) AS JAN_PRDTYPE2, (2, 3) AS FEB_PRDTYPE3, (3, 1) AS MAR_PRDTYPE1, (4, 2) AS APR_PRDTYPE2)
);
--In the following example, the values of the product types are changed in the IN part to get the sales for those product types for the specified months
SELECT *
FROM (
	SELECT month, prd_type_id, amount
	FROM all_sales
	WHERE year = 2003
	AND prd_type_id IN (1, 2, 3)
)
PIVOT (
	SUM(amount) FOR (month, prd_type_id) IN ((1, 1) AS JAN_PRDTYPE1, (2, 2) AS FEB_PRDTYPE2, (3, 3) AS MAR_PRDTYPE3, (4, 1) AS APR_PRDTYPE1)
);
--You can use multiple aggregate functions in a pivot. For example, the following query uses SUM() to get the total sales for the product types in January and February and AVG() to get the averages of the sales
SELECT *
FROM (
	SELECT month, prd_type_id, amount
	FROM all_sales
	WHERE year = 2003
	AND prd_type_id IN (1, 2, 3)
)
PIVOT (
	SUM(amount) AS sum_amount, AVG(amount) AS avg_amount FOR (month) IN (1 AS JAN, 2 AS FEB))
ORDER BY prd_type_id;
--The UNPIVOT clause rotates columns into rows. UNPIVOT does the opposite of PIVOT.
SELECT *
FROM pivot_sales_data;
SELECT *
FROM pivot_sales_data
UNPIVOT (
	amount FOR month IN (JAN, FEB, MAR, APR)
)
ORDER BY prd_type_id;  --The monthly sales totals are shown vertically in this result set. Compare this result set to the result set from the previous query, in which the monthly sales totals are shown horizontally.
/* Performing Top-N Queries.  A new feature in Oracle Database 12c is native support for performing top-N queries. Top-N queries contain a row-limiting clause. A row-limiting clause allows you to limit the retrieval of rows by specifying the following */
SELECT employee_id, first_name, last_name
FROM more_employees
ORDER BY employee_id DESC
FETCH FIRST 5 ROWS ONLY;  --FETCH FIRST to retrieve the five employees with the highest employee_id
SELECT employee_id, first_name, last_name
FROM more_employees
ORDER BY employee_id DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;  --You use the OFFSET clause to specify the number of rows to skip before row limiting begins. The query retrieves employees with employeed_id values starting at 8 and ending at 4 from the more_employees table.
SELECT product_id, name, price
FROM products
ORDER BY price DESC
FETCH FIRST 20 PERCENT ROWS ONLY;  --You use the PERCENT clause to specify the percentage of the total number of selected rows to return. The query retrieves the 20 percent of the products with the highest price from the products table.
SELECT employee_id, first_name, last_name, salary
FROM more_employees
ORDER BY salary
FETCH FIRST 10 PERCENT ROWS WITH TIES;  --Use WITH TIES to include additional rows with the same sort key value as the last row fetched.  The query retrieves the 10 percent of the employees with the lowest salary from the more_employees table using WITH TIES. The sort key is the salary column.  RM:  in lament terms, ties are included or all results with same salary included.
--RM:  Skipped A new feature in Oracle Database 12c is native support for finding patterns in data using the MATCH_RECOGNIZE clause. Finding patterns in data is useful in a variety of situations. For example, finding patterns in data is useful for finding trends in sales, detecting fraudulent credit card transactions, and discovering network intrusions. The examples in this section show how to find V-shaped and W-shaped patterns in the sales for a product over a period of days.

--CHAPTER 9 CHANGING TABLE CONTENTS page 285
insert into customers (customer_id, first_name, last_name, dob, phone)
values (6, 'Fred','Brown','JAN-01-1970','800-555-1215');
insert into customers
values (7, 'Jane','Green','JAN-01-1970','800-555-1216');  --When you omit the column list, the order of the values must match the order of the columns.
insert into customers
values (8, 'Sophie','White',null, null);
insert into customers
values (9, 'Kyle','O''Malley',null, null);
insert into products
values (13, 1, 'The ''Great'' Gatsby',null, 12.99);  --'Great' in table
insert into products
values (14, 1, 'The "Great" Gatsby',null, 12.99);  --"Great" in table
insert into customers (customer_id, first_name, last_name)
select 10, first_name, last_name
from customers
where customer_id = 1;  --copy row from one table to another.  In the example copy row from one table to same table and assigning customer_id to 10.
update customers
set last_name = 'Orange'
where customer_id = 2;
update products
set price = price * 1.20, name = lower(name)
where price >= 20;
--Oracle Database 10g introduced the RETURNING clause to return the value from an aggregate function such as AVG().
variable averageproductprice number
update products
set price = price * 0.75
returning avg(price) into :averageproductprice;  --RM  error message
delete from customers
where customer_id = 10;
create table order_status (order_status_id integer constraint defaultexamplepk primary key, status varchar2(20) default 'Order placed' not null, last_modified date default sysdate);
insert into order_status (order_status_id)
values (11);  --status column is default Order placed.  last_modified column is default today's date.
insert into order_status (order_status_id, status, last_modified)
values (2, 'Order shipped', 'JUN-10-2004');  --status column is default Order shipped.  last_modified column is JUN-10-2004
update order_status
set status = default
where order_status_id = 2;  --You can set a column back to the default using the DEFAULT keyword in an UPDATE statement
--The MERGE statement allows you to merge rows from one table into another. For example, you might want to merge changes to products listed in one table into the products table.  Combine rows one table to another table.
select product_id, product_type_id, name, price
from product_changes;
--you want to merge the rows from the product_changes table into the products table.
merge into products p
using product_changes pc
on (p.product_id = pc.product_id)
when matched then
	update
	set p.product_type_id = pc.product_type_id,
	p.name = pc.name,
	p.description = pc.description, 
	p.price = pc.price
when not matched then
	insert (p.product_id, p.product_type_id, p.name, p.description, p.price)
	values (pc.product_id, pc.product_type_id, pc.name, pc.description, pc.price);
--To permanently record the results made by SQL statements in a transaction, you perform a COMMIT. To undo the results, you perform a ROLLBACK, which resets all the rows back to what they were before the transaction began.
--You perform a DDL statement, such as a CREATE TABLE statement, which automatically performs a COMMIT.
--You perform a DCL statement, such as a GRANT statement, which automatically performs a COMMIT.
--If you exit SQL*Plus normally, by entering the EXIT command, a COMMIT is automatically performed for you.
--If SQL*Plus terminates abnormally—for example, if the computer on which SQL*Plus was running were to crash—a ROLLBACK is automatically performed.
--Tip:  It is poor practice not to explicitly commit or roll back your transactions, so perform a COMMIT or ROLLBACK at the end of your transactions.
--You can set a savepoint at any point within a transaction. This allows you to roll back changes to that savepoint. Savepoints are useful for breaking up very long transactions, because if you make a mistake after you’ve set a savepoint, you don’t have to roll back the transaction all the way to the start. However, you should use savepoints sparingly: it might be better to restructure your transaction into smaller transactions.  The procedure is the following:  SAVEPOINT savepointname;  To roll back to a savepoint established earlier:  ROLLBACK TO SAVEPOINT savepointname;
/*
Database theory’s more rigorous definition of a transaction states that a transaction has four fundamental properties, known as ACID properties:
*Atomic Transactions are atomic, meaning that the SQL statements contained in a transaction make up a single unit of work.
*Consistent Transactions ensure that the database state remains consistent, meaning that the database is in a consistent state when a transaction begins and the database is in another consistent state when the transaction finishes.
*Isolated Separate transactions should not interfere with each other.
*Durable After a transaction is committed, the database changes are preserved, even if the computer on which the database software is running crashes later.
*/
--RM:  Skipped Transaction Isloation Levels Phantom reads Nonrepeatable reads Dirty Reads, Query Flashbacks.
--RM:  Skipped Chapter 10 Users Privileges, and Roles

--CHAPTER 11 CREATING TABLES, SEQUENCES, INDEXES, AND VIEWS 335
create table order_status2 (id integer constraint order_status2_pk primary key, status varchar2(10), last_modified date default sysdate);
create global temporary table order_status_temp (id integer, status varchar2(10), last_modified date default sysdate)
on commit preserve rows; --creates a temporary table named order_status_temp whose rows will be kept until the end of a user session (ON COMMIT PRESERVE ROWS)
insert into order_status_temp
values(1,'New',sysdate);
select table_name, tablespace_name, temporary
from user_tables
where table_name in ('ORDER_STATUS2', 'ORDER_STATUS_TEMP');  --table names must be upper case.  Get table information.
select *
from all_tables;  --retrieve all table information in database
select column_name, data_type, data_length, data_precision, data_scale
from user_tab_columns
where table_name = 'PRODUCTS';  --table name must be upper case.  Retrieve column information in a table from the user_tab_columns view.
select *
from all_tab_columns
where table_name = 'PRODUCTS';  --table name must be upper case.  retrieve all column information in a table.
alter table order_status2
add modified_by integer; --add column modified_by
alter table order_status2
add initially_created date default sysdate not null;  --add column initially_created default and not null
--A virtual column is a column that refers only to other columns already in the table. For example, the following ALTER TABLE statement adds a virtual column named average_salary to the salary_grades table
alter table salary_grades
add (average_salary as ((low_salary + high_salary) / 2));  --like a temporary column temp column
alter table order_status2
modify status varchar2(15);  --increases the maximum length of the status column to 15 characters or modify table
alter table order_status2
modify id number(5); --changes the precision of id column to 5 or modify table
alter table order_status2
modify status char(15);  --changes the data type of status column to char or modify table
alter table order_status2
modify last_modified default sysdate - 1;  --changes the default value of last_modified column to sysdate-1 or modify table.  The default value applies only to new rows added to the table. New rows will get their last_modified column set to the current date minus one day.
alter table order_status2
drop column initially_created;  --delete column
alter table order_status2
add constraint order_status2_status_ck
check (status in ('placed','pending','shipped'));  --update column status for which status column has three choices placed, pending, or shipped.  order_status2_status_ck is the name of the constraint.
insert into order_status2 (id, status, last_modified, modified_by)
values (1, 'pending', '01/01/2005',1);
alter table order_status2
add constraint order_status2_id_ck check (id > 0); --update column id for which id must be greater than zero.  order_status2_id_ck is the name of the constraint.
alter table order_status2
modify status constraint order_status2_status_nn not null;  --update column status for which status must be not null.  order_status2_status_nn is the name of the constraint.
alter table order_status2
add constraint order_status_modified_by_fk
modified_by references employees(employee_id); --add column modified_by with constraint modified_by is a foreign key to employee_id in employees table.  order_status_modified_by_fk is name of the constraint.
--You use the ON DELETE CASCADE clause with a FOREIGN KEY constraint to specify that when a row in the parent table is deleted, any matching rows in the child table are also deleted.
alter table order_status2
add constraint order_status_modified_by_fk
modified_by references employees(employee_id) on delete cascade;
--You use the ON DELETE SET NULL clause with a FOREIGN KEY constraint to specify that when a row in the parent table is deleted, the foreign key column for any rows in the child table are set to null.
alter table order_status2
add constraint order_status_modified_by_fk
modified_by references employees(employee_id) on delete set null;
alter table order_status2
add constraint order_status2_status_uq unique (status);  --status column has a unique constraint.  Any existing or new rows must always be unique in status column.
alter table order_status2
drop constraint order_status2_status_uq;  --delete constraint or remove constraint.  drop the constraint's name.
--To enable a constraint, all the rows in the table must satisfy the constraint.  You can apply a constraint to new data only by specifying ENABLE NOVALIDATE and the name of the constraint--not name of the column.  Constraint new data.
alter table order_status2
enable nonvalidate constraint order_status2_status_uq;
--You can retrieve information on your constraints by querying the user_constraints view.  Constraints query.  Search constraints.
select constraint_name, constraint_type, status, deferrable, deferred
from user_constraints
where table_name = 'ORDER_STATUS2'
order by constraint_name;  --table_name must be in upper case.
select *
from all_constraints;  --retrieve information on all the constraints you have access to by querying the all_constraints view.  All constraints.
SELECT constraint_name, column_name
FROM user_cons_columns
WHERE table_name = 'ORDER_STATUS2'
ORDER BY constraint_name;  --retrieve information on the constraints for a column by querying the user_cons_columns view.  Search column constraints.
SELECT
ucc.column_name, ucc.constraint_name,
uc.constraint_type, uc.status
FROM user_constraints uc, user_cons_columns ucc
WHERE uc.table_name = ucc.table_name
AND uc.constraint_name = ucc.constraint_name
AND ucc.table_name = 'ORDER_STATUS2'
ORDER BY ucc.constraint_name;  --The next query joins user_constraints and user_cons_columns to get the column_name, constraint_name, constraint_type, and status
/* Page 342 table 11-3 lists constraint type */
select *
from all_cons_columns;  --retrieve information on all the column constraints you have access to
rename order_status2 to order_state;  --rename table
comment on table order_status2 is 'order_status2 stores the state of an order';  --add comment to table
comment on column order_status2.last_modified is 'last_modified stores the date and time the order was modified last';  --add comment to column
select *
from user_tab_comments
where table_name = 'ORDER_STATUS2';  --retrieve table comments
select *
from user_col_comments
where table_name = 'ORDER_STATUS2';  --retrieve column comments
truncate table order_status2;  --removes all rows and resets the storage area.  Delete all rows.
/*
If you need to remove all the rows from a table, you should use TRUNCATE rather than DELETE. This is because TRUNCATE resets the storage area for a table. A TRUNCATE statement doesn’t require any undo space in the database, and you don’t have to run a COMMIT to make the delete permanent. Undo space is an area that the database software uses to record database changes.

New for Oracle Database 12c is the CASCADE clause for TRUNCATE, which truncates the specified table, plus any child tables, grandchild tables, and so on. All tables that reference the specified table using an enabled ON DELETE CASCADE constraint are truncated. For example, if you had a table named parent_table, then TRUNCATE TABLE parent_table CASCADE would truncate any child tables, grandchild tables, and so on.
*/
drop table order_status2;  --delete table
--The DEFAULT ON NULL column clause assigns a default value to a column when an INSERT statement supplies a null value for that column.
create table tempnulldefault (reference integer, quantity integer default on null 1 not null);
insert into tempnulldefault
values (1, 3);
insert into tempnulldefault
values (123,null);
/*
New for Oracle Database 12c is the ability to define visible and invisible columns in a table. You use VISIBLE to indicate that a column is visible, and INVISIBLE to indicate that a column is invisible. If neither is specified for a column, then the column is visible by default.

RM:  skipped section.
*/
/*
A sequence is a database item that generates a sequence of integers. You typically use the integers generated by a sequence to populate a numeric primary key column.
*/
CREATE SEQUENCE s_test;  --Because this CREATE SEQUENCE statement omits the optional parameters, the default values are used. This specifies that start_num and increment_num are set to the default of 1.
create sequence sequencename
start with 10 increment by 5
minvalue 10 maxvalue 20
cycle cache 2 order;
create sequence sequencename2
start with 10 increment by -1
minvalue 1 maxvalue 10
cycle cache 5 order;
--retrieve information on your sequences from the user_sequences view
column sequence_name format a13
select sequence_name, min_value, max_value, increment_by, cycle_flag, order_flag, cache_size, last_number
from user_sequences
order by sequence_name;
--A sequence contains two pseudo columns named CURRVAL and NEXTVAL that you use to get the current value and the next value from the sequence.
--Before retrieving the current value, you must first initialize the sequence by retrieving the next value. When you select sequencename.NEXTVAL, the sequence is initialized to 10.  The first value in the sequencename sequence is 10. Once the sequence is initialized, you can get the current value from the sequence by retrieving CURRVAL.  When you retrieve CURRVAL, NEXTVAL remains unchanged. The value for NEXTVAL only changes when you retrieve NEXTVAL to get the next value.  The maximum value for sequencename is 20, and the sequence was created with the CYCLE option, meaning that the sequence will cycle back to 10 once it reaches the maximum of 20.
select sequencename.nextval
from dual;
select sequencename.currval
from dual;
create sequence sequenceorderstatus2 nocache;
--When using a sequence to populate a primary key column, you should typically use NOCACHE to avoid gaps in the sequence of numbers (gaps occur because cached values are lost when the database is shut down). However, using NOCACHE reduces performance. If you are absolutely sure that gaps in the primary key values are not a problem for your application, then consider using CACHE.
--RM:  stop learning sequences.
/* Index or Indexes
When looking for a particular subject in a book, you can either scan the whole book or use the index to find the location. An index for a database table is similar in concept to a book index, except that database indexes are used to find specific rows in a table. The downside of indexes is that when a row is added to the table, additional time is required to update the index for the new row.
Generally, you should create an index on a column when you are retrieving a small number of rows from a table containing many rows. A simple rule for when to create indexes is Create an index when a query retrieves <= 10 percent of the total rows in a table.
This means the column for the index should contain a wide range of values. These types of indexes are called B-tree indexes, a name that comes from a tree data structure used in computer science. A good candidate for B-tree indexing would be a column containing a unique value for each row (for example, a Social Security number). A poor candidate for B-tree indexing would be a column that contains only a small range of values (for example, N, S, E, W or 1, 2, 3, 4, 5, 6).
An Oracle database automatically creates a B-tree index for the primary key of a table and for columns included in a unique constraint. For columns that contain a small range of values, you can use a bitmap index.
*/
--The following CREATE INDEX statement creates an index named i_customers_last_ name on the last_name column of the customers table (I always put i_ at the start of index names):
CREATE INDEX i_customers_last_name ON customers(last_name);
--You can enforce uniqueness of column values using a unique index. For example, the following statement creates a unique index named i_customers_phone on the customers.phone column:
CREATE UNIQUE INDEX i_customers_phone ON customers(phone);
--You can also create a composite index on multiple columns. For example, the following statement creates a composite index named i_employees_first_last_name on the first_name and last_name columns of the employees table:
CREATE INDEX i_employees_first_last_name ON employees(first_name, last_name);
--The following retrieves some of the columns from user_indexes for the customers and employees tables.
SELECT index_name, table_name, uniqueness, status
FROM user_indexes
WHERE table_name IN ('CUSTOMERS', 'EMPLOYEES')
ORDER BY index_name;
--You can retrieve information on the indexes on a column by querying the user_ind_columns view.
COLUMN table_name FORMAT a15
COLUMN column_name FORMAT a15
SELECT index_name, table_name, column_name
FROM user_ind_columns
WHERE table_name IN ('CUSTOMERS', 'EMPLOYEES')
ORDER BY index_name;
--You modify index or edit index using ALTER INDEX. The following example renames the i_customers_phone index to i_customers_phone_number:
ALTER INDEX i_customers_phone RENAME TO i_customers_phone_number;
--You drop index or delete index using the DROP INDEX statement. The following example drops the i_customers_phone_number index:
DROP INDEX i_customers_phone_number;
/*
Bitmap Index or Bitmap Indexes
Bitmap indexes are often used in data warehouses, which are databases containing very large amounts of data. Data warehouses are used by organizations for business intelligence analysis, like monitoring sales trends and examining customer behaviors. The data warehouse is typically read using complex queries, but the data are not constantly being updated. The data might only be updated at the end of each day, week, or other scheduled period.
A candidate for a bitmap index is a column that has the following properties:  Is referenced in many queries and contains only a small range of values.  Example ranges of values include the following: N, S, E, W; 1, 2, 3, 4, 5, 6; PLACED, PENDING, SHIPPED, REMOVED.
*/
/*
Views or View
A view is a predefined query on one or more tables (known as base tables). Retrieving information from a view is done in the same manner as retrieving information from a table: You include the view in the FROM clause of a query. With some views, you can also perform Data Manipulation Language (DML) operations on the base tables.
Views don’t store rows. Rows are always stored in tables. Views return the rows stored in tables.
*/
--RM:  Skipped writing SQL views.  I may learn it later if the situation tells me I learn it.

--Chapter 16 SQL Tuning 583
--Use a WHERE Clause to Filter Rows
select *
from customers;
select *
from customers
where customer_id in (1, 2);
--Use Table Joins Rather than Multiple Queries
select name, product_id, product_type_id
from products
where product_id = 1;
select name, product_type_id
from product_types
where product_type_id = 1;
select p.name, pt.name
from products p, product_types pt
where p.product_type_id=pt.product_type_id
and p.product_id = 1;
--Use Fully Qualified Column References When Performing Joins
select p.name, pt.name, description, price
from products p, product_types pt
where p.product_type_id=pt.product_type_id
and p.product_id = 1;
select p.name, pt.name, p.description, p.price
from products p, product_types pt
where p.product_type_id=pt.product_type_id
and p.product_id = 1;
--Use CASE Expressions Rather than Multiple Queries
select count(*)
from products
where price < 13;
select count(*)
from products
where price >= 13 and price <= 15;  --WHERE price BETWEEN 13 AND 15; <--also works
select count(*)
from products
where price > 15;
select count(case when price < 13 then 1 else null end) as low, count(case when price between 13 and 15 then 1 else null end) as medium, count(case when price > 15 then 1 else null end) as high
from products;
--Add Indexes to Tables
/*
When looking for a particular topic in a book, you can either scan the whole book or use the index to find the location. An index for a database table is similar in concept to a book index, except that database indexes are used to find specific rows in a table. The downside of indexes is that when a row is added to the table, additional time is required to update the index for the new row.
Normally, a database administrator is responsible for creating indexes. However, as an application developer, you’ll be able to provide the database administrator with feedback on which columns are good candidates for indexing, because you might know more about the application than the database administrator.
Chapter 11 described the following types of indexes:  B-tree indexes and bitmap indexes.
*/
--Use WHERE Rather than HAVING
select product_type_id, avg(price)
from products
group by product_type_id
having product_type_id in (1, 2);
select product_type_id, avg(price)
from products
where product_type_id in (1, 2)
group by product_type_id;
--Use UNION ALL Rather than UNION
--You use UNION ALL to get all the rows retrieved by two queries, including duplicate rows; you use UNION to get all non-duplicate rows retrieved by the queries. Because UNION removes duplicate rows (which takes some time to do), you should use UNION ALL whenever possible.  RM:  get duplicates in UNION might as well use UNION ALL.
select product_id, product_type_id, name
from products
union
select prd_id, prd_type_id, name
from more_products;
select product_id, product_type_id, name
from products
union all
select prd_id, prd_type_id, name
from more_products;
--Use EXISTS Rather than IN
select product_id
from purchases;
select product_id, name
from products;
select product_id, name
from products
where product_id in (
	select product_id
	from purchases);
select product_id, name
from products outer
where exists
	(select 1
	from purchases inner
	where inner.product_id = outer.product_id);
--Use EXISTS Rather than DISTINCT
select pr.product_id, pr.name
from products pr, purchases pu
where pr.product_id = pu.product_id;
select distinct pr.product_id, pr.name
from products pr, purchases pu
where pr.product_id = pu.product_id;
select product_id, name
from products outer
where exists
	(select 1
	from purchases inner
	where outer.product_id = inner.product_id);
--RM stop page 592 rest chapter beyond my current SQL skills.