--Sams Teach Yourself SQL In 10 Minutes by Ben Forta
--Primary key values can never be reused. (If a row is deleted from the table, its primary key may not be assigned to any new rows in the future.)
--Appendix E SQL Reserved Words list most common reserved words.

--Lesson 2 Retrieving Data 24 pdf page (13 book page)
--As a rule, you are better off not using the * wildcard unless you really do need every column in the table. Even though use of wildcards may save you the time and effort needed to list the desired columns explicitly, retrieving unnecessary columns usually slows down the performance of your retrieval and your application.
select prod_id, prod_name, prod_price
from products;

--Lesson 3 Sorting Retrieved Data 30 (19)
select prod_id, prod_price, prod_name
from products
order by prod_price desc, prod_name; --order by 2 desc, 3; also works sort prod_price and prod_name

--Lesson 4 Filtering Data 37 (26)
select trim(prod_name) as "prod_name", prod_price
from products
where prod_price = 3.49;
select trim(prod_name) as "prod_name", prod_price
from products
where prod_price < 10;
select vend_id, trim(prod_name)
from products
where vend_id <> 'DLL01';
select trim(prod_name), prod_price
from products
where prod_price between 3.49 and 10;  --between is inclusive
select vend_id
from vendors
where vend_state is null;

--Lesson 5 Advanced Data Filtering 44 (33)
select prod_id, prod_price, trim(prod_name)
from products
where vend_id = 'DLL01' and prod_price <=4;
select trim(prod_name), prod_price
from products
where vend_id = 'DLL01' or vend_id = 'BRS01';
/* order of evaluation. SQL processes AND operators before OR operators. */
select trim(prod_name), prod_price
from products
where (vend_id = 'DLL01' or vend_id = 'BRS01') and prod_price >=10;
select trim(prod_name), prod_price
from products
where vend_id in ('DLL01','BRS01')
order by prod_name;  --IN operators almost always execute more quickly than lists of OR operators.
select trim(prod_name), vend_id
from products
where vend_id not in ('DLL01')  --vend_id <> 'DLL01' also works
order by prod_name;

--Lesson 6 Using Wildcard Filtering 51 (40)
--Within a search string, % means match any number of occurrences of any character.  RM:  not asterik * for wildcard
select prod_id, trim(prod_name)
from products
where prod_name like 'Fish%';
select prod_id, trim(prod_name)
from products
where prod_name like '%bean bag%';
--The underscore (_) matches a single character
select prod_id, trim(prod_name)
from products
where prod_name like '__ inch teddy bear%';
--The brackets ([]) wildcard is used to specify a set of characters, any one of which must match a character in the specified position (the location of the wildcard).  RM:  doesn't work for Oracle
select cust_contact
from customers
where cust_contact like 'J%' or cust_contact like 'M%'
order by cust_contact;

--Lesson 7 Creating Calculated Fields 59 (48)
--Calculated fields don’t exist in database tables. Rather, a calculated field is created on-the-fly within a SQL SELECT statement.  It is far quicker to perform these operations on the database server than it is to perform them within the client application because DBMSs are built to perform this type of processing quickly and efficiently.
--You concatenate columns using a special operator which can be a plus sign (+) or two pipes (||).
select trim(vend_name) || ' (' || trim(vend_country) || ')' as vend_title
from vendors
order by vend_name;
select prod_id, quantity, item_price, quantity*item_price as expanded_price
from orderitems
where order_num = 20008;

--Lesson 8 Using Data Manipulation  Functions 68 (57)
select trim(vend_name), upper(trim(vend_name)) as uppercase, lower(trim(vend_name)) as lowercase
from vendors;
select trim(vend_name), length(vend_name), length(trim(vend_name)), upper(trim(vend_name)) as uppercase
from vendors; --length(vend_name) includes the spaces in calculation, length(trim(vend_name)) excludes the spaces in calculation
--SOUNDEX is an algorithm that converts any string of text into an alphanumeric pattern describing the phonetic representation of that text. SOUNDEX takes into account similar sounding characters and syllables, enabling strings to be compared by how they sound rather than how they have been typed.
select cust_name, cust_contact
from customers
where cust_contact = 'Michael Green';  --returns nothing
--RM:  however
select cust_name, cust_contact
from customers
where soundex(cust_contact) = soundex('Michael Green');  --returns Michelle Green as cust_contact
--Date and times are stored in tables using datatypes, and each DBMS uses its own special varieties.
select order_num, order_date
from orders
where order_date between to_date('01-01-2004') and to_date('12-31-2004');

--Lesson 9 Summarizing Data 77 (66)
--You want a summary of the data, not the actual data itself.  Returning the actual table data would be a waste of time and processing resources.  SQL features a set of five aggregate functions, which are listed in Table 9.1. These functions enable you to perform all the types of retrieval just enumerated.  AVG(), COUNT(), MAX(), MIN(), SUM().
/*
AVG(), MAX(), MIN(), SUM() ignores null values.
COUNT(*) counts all rows including null.
COUNT(columnname) ignores null values.
*/
select round(avg(prod_price),2) as "avg rounded two decimal places", count(prod_price) as count, max(prod_price) as max, min(prod_price) as min, sum(prod_price) as sum, sum(item_price*quantity) as total_price
from products;
select sum(item_price*quantity) as total_price
from orderitems
where order_num = 20005;
--Performing Calculations on Multiple Columns. All the aggregate functions can be used to perform calculations on multiple columns using the standard mathematical operators.
select avg(distinct prod_price) as "distinct avg_price"
from products
where vend_id = 'DLL01'; --the DISTINCT argument is used so that the average only takes into account unique prices
--DISTINCT may only be used with COUNT() if a column name is specified. DISTINCT may not be used with COUNT(*). Similarly, DISTINCT must be used with a column name and not with a calculation or expression.

--Lesson 10 Grouping Data 86 (75)
--Grouping lets you divide data into logical sets so that you can perform aggregate calculations on each group.
select vend_id, count(*) as num_prods
from products
group by vend_id;
/*
The GROUP BY clause instructs the DBMS to group the data and then perform the aggregate on each group rather than on the entire result set.
GROUP BY clauses can contain as many columns as you want. This enables you to nest groups, providing you with more granular control over how data is grouped.
If you have nested groups in your GROUP BY clause, data is summarized at the last specified group. In other words, all the columns specified are evaluated together when grouping is established (so you won’t get data back for each individual column level).
Every column listed in GROUP BY must be a retrieved column or a valid expression (but not an aggregate function). If an expression is used in the SELECT, that same expression must be specified in GROUP BY. Aliases cannot be used.
Most SQL implementations do not allow GROUP BY columns with variable length datatypes (such as text or memo fields).
Aside from the aggregate calculations statements, every column in your SELECT statement must be present in the GROUP BY clause.
If the grouping column contains a row with a NULL value, NULL will be returned as a group. If there are multiple rows with NULL values, they’ll all be grouped together.
The GROUP BY clause must come after any WHERE clause and before any ORDER BY clause.
The ALL Clause Some SQL implementations (such as Microsoft SQL Server) support an optional ALL clause within GROUP BY. This clause can be used to return all groups, even those that have no matching rows (in which case the aggregate would return NULL). Refer to your DBMS documentation to see if it supports ALL.
*/
--WHERE filters rows.  HAVING filters groups.  All techniques and options in WHERE can be applied to HAVING.  Here’s another way to look it: WHERE filters before data is grouped, and HAVING filters after data is grouped.
select cust_id, count(*) as orders
from orders
group by cust_id
having count(*) >=2;
select vend_id, count(*) as num_prods
from products
where prod_price >=4
group by vend_id
having count(*) >=2;
select order_num, count(*) as items
from orderitems
group by order_num
having count(*) >=3
order by items, order_num;
--or
select order_num, count(*) as items
from orderitems
group by order_num
having count(*) >=3
order by count(*), order_num;
--start page 95