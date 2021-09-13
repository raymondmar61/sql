#36 multiple choice questions from an assessment test.  I summarized the question to the point and provided the answer.

#1 Code uses WHERE clause incorrectly?
select itemid, quantity
from orders
where quantity = NULL;

#2 SQL syntax is false?
#SQL keywords can be split across lines.

#3 NULL value statement is false?
#A NULL value is the same as zero or a blank space.

#4 Correct statement for column heading to read TOTAL COST.
select costprice, costprice * 0.065 as "TOTAL COST"
from products;

#5 Clause restricts rows within a table which are returned by the query.
#The answer is where.

#6 Which [quantity] values are returned from the following SQL statement?
select price, quantity
from orders
where quantity between 50 and 75;
#55 is yes, 72 is yes, 75 is yes.  RM:  Between is inclusive.

#7 Which SQL statement is a DDL (Data Definition Language)?
#The answer is alter.  RM:  DDL statements are create, alter, drop, rename, and truncate.  select, insert, update, delete, and merge are DML (Data Manipulation Language).

#8 Incorrect statement for sorting.
#When sorting is done by multiple columns, ASC or DESC has to be the same for both columns.

#9 SQL function to return the numeric position of a named string.
#The answer is instr.

#10 What value is returned from the following SQL statement?
select trunc(55.945,-1)
from dual;
#The answer is 0

#11 Which date manipulation function returns a numeric value?
#The answer is months_between.  #RM:  months_between('03-SEP-15','18-FEB-15') returns 6.51612903225

#12 Single row function statement is false?
#The answer is single row functions cannot be nested.  RM:  Single row functions gets only one row and returns a value for every row.  Accepts one or more arguments and returns one value.  Returns a value for each row returned.  Can be used alone or nested.  A column or an expression can be used as arguments.  Character, numeric, date, conversion, and general are the five types of single row functions.

#13 Data type conversion functions statement is false?
#The answer is to_number function converts a number to a character.  to_number function actually converts a character to a number.

#14 AVG and SUM group functions can be used for which data type?
#The answer is numeric.

#15 MIN and MAX group functions can be used for which data type?
#The answer is character, data, and numeric.

#16 True or false.  Group functions ignore null values in the processed column.
#The answer is true.  RM:  Null values ignored by default.  NULL values are ignored except nvl, nvl2, coalesce, case, or decode to handle null values.

#17 What is the syntax error for the following SQL statement?
select productid, regionid, count(orderdate)
from orders
group by productid
order by productid, regionid;
#The answer is The columns in the SELECT clause not referenced by a group function have to be included in the GROUP BY clause.

#18 Correct SQL statement.
select sportid, equipmentid,
avg(salesamount)
from sportssales
where sportid in (10,30,50,70,90)
group by sportid, equipmentid
having avg(salesamount) > 500
order by sportid;

#19 True or false.  The GROUP BY column must be in the select clause.
#The answer is false.
#RM:  examples below
select avg(salary)
from employees
group by job_id;
select avg(salary), sum(salary), min(salary), max(salary), count(*)
from employees
group by department_id
order by avg(salary);

#20 Statement is true for the following SQL statement.
select p.productid, p.productname, c.categoryname
from products p left outer join categories c
on (p.categoryid=c.categoryid);
#The answer is all the products from the PRODUCTS table matched with those in the CATEGORIES table as well as all unmatched ones in the PRODUCTS table are retrieved.

#21 In order to join 3 tables, how many join conditions are needed?
#The answer is 2.

#22 Comparison operator not valid for a multiple row subquery?
#The answer is like.  RM:  in, any, and all are valid for a multiple-row subquery.

#23 Clauses can use a subquery?
#The answer is from, where, and having.

#24 True or false.  The UNION ALL operator retrieves rows from both queries after eliminating duplicates, whereas the UNION operator retrieves rows from both queries including duplicates.
#The answer is false.  RM:  UNION eliminates duplicate rows.  UNION ALL includes duplicate rows.

#25 SQL command to delete data from a table is not a DDL (Data Definition Language)?
#The answer is DELETE.  RM:  Data Definition Language DDL define database structure.  Create objects in the database, alter the structure of the database, drop which is delete objects from the database, truncate remove records from a table including all spaces allocated for the records are removed, comment add comments to the data dictionary, rename renames an object.

#26 DDL (Data Definition Language) command to delete all rows and deallocates storage space.
#The answer is TRUNCATE.  #RM:  drop tablename removes table tablename with all the data and moves it to the recycle bin.

#27 What value is returned from the following SQL statement if the unitprice is $5.00?
select 12* unitprice+3.5
from products
where productid = 15;
#The answer is 63.5.  RM  12*(5.00)+3.5-->60+3.5-->63.5

#28 What value is returned from the following SQL statement if the TAX column has a NULL value, whereas unitcost =3 and quantity = 10?
select (unitcost x quantity x tax) as "Final Cost"  #RM:  Use x instead of * to represent multiplicaation!?!
from orders
where orderid = 1583;
#The answer is null.
#RM:  Dumb question because orderid 1583 can have the null value in tax column which returns null value.  Or can have zero in tax column which returns zero.

#29 True or false.  The concatenator operator || can be used only once in a SELECT statement?
#The answer is false

#30 Correct SQL statement for non-null and non-duplicate values of the producttype column?
select count(distinct producttype)
from orders;

#31 What value not returned from the following SQL statement?
select gamename
from toys
where gamename like '_a%';
#My answer is Toad.  RM:  Operators are % percentage sign, _ underscore.  % is 0 or more characters.  _ is exactly one character.

#32 Comparison operator not valid.
#My answer is not any.  not null, not like, and not in are valid.

#33 Correct SQL statement return 0 if the shippingcost column has a NULL value?
select orderid, nvl(shippingcost,0)
from orders;
#RM:
select job_id, first_name, last_name, commission_pct, nvl(commission_pct,0) as "Display 0 if commission_pct is null"
from employees;
#mysql
select job_id, first_name, last_name, commission_pct, ifnull(commission_pct,0) as "Display 0 if commission_pct is null"
from employees;
select job_id, first_name, last_name, commission_pct, nvl2(commission_pct,"There is a commission_pct","There is no commission_pct") as "If not null, then first quote, else second quote"
from employees;

#34 SQL function for if-then-else logic?
#My answer is case.

#35 Set operator to retrieve all rows common to multiple queries?
#My answer is intersect.  RM:  UNION returns rows of both queries without duplicates.  UNION ALL returns rows of both queries including duplicates.  INTERSECT returns rows which must be in both queries.  MINUS returns all rows in the first query which doesn't exist in the second query.

#36 True or false.  If one of the values returned by a multiple-row subquery is a null value, the other query will return no rows.
#The answer is true.  RM:  And the answer is false.
#https://sqldatabasetutorials.com/sql-db/multiple-row-subqueries/
#If ALL is used, the outer query returns no rows because ALL compares the outer query row with every value returned by the subquery, including the null.  And comparing anything with null results in null.
select lastname, employeeid
from employees
where employeeid <= all (
    select managerid
    from employees); #returns no rows
#If IN or ANY are used, the outer query will return rows which match the non-null values.
select lastname, employeeid
from employees
where employeeid in (
    select managerid
    from employees); #returns lastname and employeeid in managerid table including the null row from managerid table