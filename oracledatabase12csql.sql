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

--CHAPTER 1 INTRODUCTION
describe customers;  --describe tablename.  Returns columns
insert into customers (customer_id, first_name, last_name, dob, phone)
values (6, 'Fred', 'Brown', 'Jan-01-1970', '800-555-1215');
update customers
set last_name = 'Orange'
where customer_id = 2;
delete from customers
where customer_id = 6;
rollback; --undo the changes.  It didn't work when I deleted customer_id = 6.

--CHAPTER 2 RETRIEVING INFORMATION FROM DATABASE TABLES.  Also arithmetic, math.
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

--CHAPTER 3 USING SQL*Plus
describe customers;  --table information view the structure of a table describe tablename;
--query above same as query below
desc customers;

--CHAPTER 4 USING SIMPLE FUNCTIONS
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
--start page 137 Chapter 5