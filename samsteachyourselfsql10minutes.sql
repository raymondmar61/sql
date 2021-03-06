--Sams Teach Yourself SQL In 10 Minutes by Ben Forta
--Primary key values can never be reused. (If a row is deleted from the table, its primary key may not be assigned to any new rows in the future.)
--Appendix A 198 (187) lists the columns for all the tables
--Appenxis C 218 (207) lists most frequenty SQL statements or SQL operations
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
--Within a search string, % means match any number of occurrences of any character.  wild card.  RM:  not asterik * for wildcard
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

--Lesson 11 Working With Subqueries 95 (84)
--Suppose you wanted a list of all the customers who ordered item RGAN01. What would you have to do to retrieve this information? Here are the steps:
--1. Retrieve the order numbers of all orders containing item RGAN01.
select order_num
from orderitems
where prod_id = 'RGAN01';
--2. Retrieve the customer ID of all the customers who have orders listed in the order numbers returned in the previous step.
select cust_id
from orders
where order_num in (20007, 20008);
--3. Retrieve the customer information for all the customer IDs returned in the previous step.
select *
from customers
where cust_id in (1000000004, 1000000005);
--Each of these steps can be executed as a separate query. By doing so, you use the results returned by one SELECT statement to populate the WHERE clause of the next SELECT statement. You can also use subqueries to combine all three queries into one single statement. 
--RM create subquery now without further reading.  It worked.
select *
from customers
where cust_id In
	(select cust_id
	from orders
	where order_num in 
		(select order_num
		from orderitems
		where prod_id = 'RGAN01'));
/* Single Column Only Subquery SELECT statements can only retrieve a single column. Attempting to retrieve multiple columns will return an error.  Using subqueries is not always the most efficient way to perform this type of data retrieval; e.g. Joining Tables. */
--Suppose you want to display the total number of orders placed by every customer in your Customers table.
--1. Retrieve the list of customers from the Customers table.
select cust_id
from customers;
--2. For each customer retrieved, count the number of associated orders in the Orders table.
select *
from orders;
select cust_id, count(*)
from orders
where cust_id In
	(select Cust_Id
	from customers)
group by cust_id;
--or
select cust_name, cust_state, (select count(*) from orders where orders.cust_id = customers.cust_id) as orders
from customers
order by cust_name;  --This syntax—the table name and the column name separated by a period—must be used whenever there is possible ambiguity about column names. In this example, there are two cust_id columns, one in Customers and one in Orders.

--Lesson 12 Joining Tables 102 (91)
select *
from vendors;
select *
from products;
select *
from vendors v, products p
where v.vend_id = p.vend_id;  --equijoin is a join based on the testing of equality between two tables also called an inner join.
--also
select trim(vend_name), trim(prod_name), prod_price
from vendors, products
where vendors.vend_id = products.vend_id;
--or
select trim(vend_name), trim(prod_name), prod_price
from vendors inner join products
on vendors.vend_id = products.vend_id; --Per the ANSI SQL specification, use of the INNER JOIN syntax is preferable.
--SQL imposes no limit to the number of tables that may be joined in a SELECT statement
select trim(prod_name), trim(vend_name), prod_price, quantity
from orderitems, products, vendors
where products.vend_id = vendors.vend_id
and orderitems.prod_id = products.prod_id
and order_num = 20007;
select *
from customers
where cust_id In
	(select cust_id
	from orders
	where order_num in 
		(select order_num
		from orderitems
		where prod_id = 'RGAN01'));
--subquery above, join query below
select *
from customers c, orders o, orderitems oi
where c.cust_id = o.cust_id
and o.order_num = oi.order_num
and prod_id = 'RGAN01';
/* returning the data needed in the subquery requires the use of three tables. Here two joins are used to connect the tables. There are three WHERE clause conditions in the subquery. */

--Lesson 13 Creating Advanced Joins 112 (101)
/* Oracle does not support the AS keyword. To use aliases in Oracle, simply specify the alias without AS; e.g. Customers C instead of Customers AS C.  */
--Self Joins.  A table alias refers to the same table more than once in a single SELECT statement.
select *
from customers
where cust_contact = 'Jim Jones';
select *
from customers
where cust_name = 
	(select cust_name
	from customers
	where cust_contact = 'Jim Jones');
--subquery above, join query below
select c1.cust_id, c1.cust_name, c1.cust_contact
from customers c1, customers c2
where c1.cust_name = c2.cust_name
and c2.cust_contact = 'Jim Jones';
/*Self joins are often used to replace statements using subqueries. Many DBMSs process joins far more quickly than they do subqueries.*/
--Natural Joins.  It eliminates multiple occurrences of same columns for which only one of each column is returned.
select c.*, o.order_num, o.order_date, oi.prod_id, oi.quantity, oi.item_price
from customers c, orders o, orderitems oi
where c.cust_id = o.cust_id
and oi.order_num = o.order_num
and prod_id = 'RGAN01';  --a wildcard is used for the first table only. All other columns are explicitly listed so that no duplicate columns are retrieved.
--Outer Joins.  Includes table rows that have no associated rows in the related table.
select customers.cust_id, orders.order_num
from customers inner join orders
on customers.cust_id = orders.cust_id;  --Inner Join retrieves a list of all customers and their orders
select customers.cust_id, orders.order_num
from customers left outer join orders
on customers.cust_id = orders.cust_id;  --Left Outer Join retrives all customers includes customers who didn't place an order
select customers.cust_id, orders.order_num
from orders right outer join customers
on orders.cust_id = customers.cust_id;  --Right Outer Join retrives all customers includes customers who didn't place an order
select customers.cust_id, orders.order_num
from orders full outer join customers
on orders.cust_id = customers.cust_id;  --Full Outer Join retrieves all rows from both tables and relates those that can be related.  Includes unrelated rows from both tables.  FYI:  The FULL OUTER JOIN syntax is not supported by Access, MySQL, SQL Server, or Sybase.
select c.cust_id, count(o.order_num)
from customers c inner join orders o
on c.cust_id = o.cust_id
group by c.cust_id;
select c.cust_id, count(o.order_num)
from customers c left outer join orders o
on c.cust_id = o.cust_id
group by c.cust_id;

--Lesson 14 Combining Queries 122 (111)
--SQL enables you to perform multiple queries (multiple SELECT statements) and return the results as a single query result set. These combined queries are usually known as unions or compound queries.  There are basically two scenarios in which you’d use combined queries:  To return similarly structured data from different tables in a single query and to perform multiple queries against a single table returning the data as one query.
--Combining Queries and Multiple WHERE Conditions.  For the most part, combining two queries to the same table accomplishes the same thing as a single query with multiple WHERE clause conditions. In other words, any SELECT statement with multiple WHERE clauses can also be specified as a combined query.  With more complex filtering conditions, or if the data is being retrieved from multiple tables (and not just a single table), the UNION could [make] process much simpler.
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_state in ('IL','IN','MI');
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_name = 'Fun4All';
--with or
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_name = 'Fun4All'or cust_state in ('IL','IN','MI');
--with union
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_state in ('IL','IN','MI');
union
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_name = 'Fun4All';
/*
There are a few rules governing exactly which can be combined:
• A UNION must be comprised of two or more SELECT statements, each separated by the keyword UNION (so, if combining four SELECT statements there would be three UNION keywords used).
• Each query in a UNION must contain the same columns, expressions, or aggregate functions (although columns need not be listed in the same order).
• Column datatypes must be compatible: They need not be the exact same type, but they must be of a type that the DBMS can implicitly convert (for example, different numeric types or different date types).
*/
--with union all, duplicates are included
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_state in ('IL','IN','MI');
union all
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_name = 'Fun4All';
--UNION ALL is the form of UNION that accomplishes what cannot be done with WHERE clauses. If you do, in fact, want all occurrences of matches for every condition (including duplicates), you must use UNION ALL and not WHERE.
select trim(cust_name) as custname, trim(cust_contact) as custcontact, trim(cust_email)
from customers
where cust_state in ('IL','IN','MI')
union
select trim(cust_name), trim(cust_contact), trim(cust_email)
from customers
where cust_name = 'Fun4All'
order by custname, custcontact;  --only one ORDER BY clause may be used, and it must occur after the final SELECT statement
--EXCEPT (sometimes called MINUS) can be used to only retrieve the rows that exist in the first table but not in the second, and INTERSECT can be used to retrieve only the rows that exist in both tables. In practice, however, these UNION types are rarely used as the same results can be accomplished using joins.

--Lesson 15 Inserting Data 129 (118)
insert into customers
values('1000000006','Toy Land','123 Any Street','New York','NY','11111','USA',NULL,NULL);  --The columns must be populated in the order in which they appear in the table definition.insert into customers
insert into customers (cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
values('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA', NULL, NULL);
insert into customers(cust_id, cust_contact, cust_email, cust_name, cust_address, cust_city, cust_state, cust_zip)
values('1000000006', NULL, NULL, 'Toy Land', '123 Any Street', 'New York', 'NY', '11111');
insert into customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country)
values('1000000006', 'Toy Land', '123 Any Street', 'New York', 'NY', '11111', 'USA');
insert into customers(cust_id,cust_contact,cust_email,cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country)
select cust_id,cust_contact,cust_email,cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country
from custnew;  --insert select to import all the data from custnew into customers.  WHERE clause can be use to filter data to be inserted.  Insert data from one table to another table.  Insert data into a table from another table.
--To copy the contents of a table into a brand new table (one that is created on-the-fly) you can use the SELECT INTO statement.
select *
into custcopy
from customers;  --This SELECT statement creates a new table named custcopy and copies the entire contents of the Customers table into it.
create table custcopy as
select *
from customers;  --MySQL and Oracle use a slightly different syntax copy a table to a new table which is created automatically
/*
Here are some things to consider when using SELECT INTO:
• Any SELECT options and clauses may be used including WHERE and GROUP BY.
• Joins may be used to insert data from multiple tables.
• Data may only be inserted into a single table regardless of how many tables the data was retrieved from.
*/

--Lesson 16 Updating and Deleting Data 138 (127)
update customers
set cust_email = 'kim@thetoystore.com'
where cust_id = '1000000005';
update customers
set cust_contact = 'Sam Roberts', cust_email = 'kim@thetoystore.com'
where cust_id = '1000000005';
--Subqueries may be used in UPDATE statements, enabling you to update columns with data retrieved with a SELECT statement.
update customers
set cust_email = NULL
where cust_id = '1000000005'; --to delete a column’s value or delete value, you can set it to NULL
delete from customers
where cust_id = '1000000006';
--If you really do want to delete all rows from a table, don’t use DELETE. Instead, use the TRUNCATE TABLE statement which accomplished the same thing but does it much quicker (because data changes are not logged).

--Lesson 17 Createing and Manipulating Tables 144 (133)
create table products (prod_id CHAR(10) NOT NULL, vend_id CHAR(10) NOT NULL, prod_name CHAR(254) NOT NULL, prod_price DECIMAL(8,2) NOT NULL,prod_desc VARCHAR(1000) NULL);
create table OrderItems(order_num INTEGER NOT NULL,order_item INTEGER NOT NULL,prod_id CHAR(10) NOT NULL,quantity INTEGER NOT NULL DEFAULT 1,item_price DECIMAL(8,2) NOT NULL);  --adding the text DEFAULT 1 to the column description instructs the DBMS to use a quantity of 1 if no quantity is specified.
alter table vendors
add vend_phone char(20);  --insert column
alter table vendors
drop column vend_phone;  --delete column
drop table custcopy;  --delete table
--Rename table is supported differently by each DBMS. There is no hard and fast standard for this operation. DB2, MySQL, Oracle, and PostgreSQL users can use the RENAME statement.

--Lesson 18 Using Views 154 (143)
--Views are virtual tables.  Views simply contain queries that dynamically retrieve data when used.
select cust_name, cust_contact
from customers, orders, orderitems
where customers.cust_id = orders.cust_id
and orderitems.order_num = orders.order_num
and prod_id = 'RGAN01';
/*
Imagine that you could wrap that entire query in a virtual table called ProductCustomers.  ProductCustomers is a view, and as a view, it does not contain any columns or data. Instead it contains a query—the same query used above to join the tables properly.
*/
select cust_name, cust_contact
from productcustomers
where prod_id = 'RGAN01';
--Before you create views yourself, there are some restrictions of which you should be aware. Unfortunately, the restrictions tend to be very DBMS specific, so check your own DBMS documentation before proceeding.  RM:  Page 156 (145) the restriction list is long.
create view productcustomers as
select cust_name, cust_contact, prod_id
from customers, orders, orderitems
where customers.cust_id = orders.cust_id
and orderitems.order_num = orders.order_num;
select *
from productcustomers;
select cust_name, cust_contact
from productcustomers
where prod_id = 'RGAN01';
--Another common use of views is for reformatting retrieved data.
select trim(vend_name) || '(' || trim(vend_country) || ')' as vend_title
from vendors
order by vend_name;  --RM:  Oracle concatenate or combine text is ||, not +
--Suppose that you regularly needed results in this format. Rather than perform the concatenation each time it was needed, you could create a view and use that instead.
create view vendorlocations as
select trim(vend_name) || '(' || trim(vend_country) || ')' as vend_title
from vendors;
--This statement creates a view using the exact same query as the previous SELECT statement. To retrieve the data to create all mailing labels, simply do the following:
select *
from vendorlocations;
create view customeremaillist as
select trim(cust_id) as "must name", trim(cust_name) as "expression", trim(cust_email) as "column alias"
from customers
where cust_email is not null;  --RM:  it seems column alias required when filtering data
select *
from customeremaillist;
select prod_id, quantity, item_price, quantity*item_price as expanded_price
from orderitems
where order_num = 20008;
create view orderitemsexpanded as
select order_num, prod_id, quantity, item_price, quantity*item_price as expanded_price
from orderitems;
select *
from orderitemsexpanded
where order_num = 20008;
--To remove a view, the DROP statement is used. The syntax is simply DROP VIEW viewname;. To overwrite (or update) a view you must first DROP it and then recreate it.  Delete view.

--Lesson 19 Working With Stored Procedures 164 (153)
--Stored procedures are simply collectionsof one or more SQL statements saved for future use. You can think of them as batch files, although in truth they are more than that.
/* 
There’s a Lot More to It. Stored procedures are complex, and full coverage of the subject requires more space than can be allocated here. This lesson will not teach you all you need to know about stored procedures. Rather, it is intended simply to introduce the subject so that you are familiar with what they are and what they can do. As such, the examples presented here provide syntax for Oracle and SQL Server only.
*/
--Stored procedure example below named AddNewProduct is executed adds a new product to the Products table.
execute AddNewProduct('JTS01', 'Stuffed Eiffel Tower', 6.49, 'Plush stuffed toy with the text La Tour Eiffel in red white and blue')
--To ensure that primary key numbers are generated properly, it is safer to have that process automated (and not rely on end users).
--writing a stored procedure is not trivial. To give you a taste for what is involved, let’s look at a simple example—a stored procedure that counts the number of customers in a mailing list who have email addresses.
create procedure mailinglistcount
(listcount out number)
is
begin
select *
from customers
where not cust_email is null;
listcount := sql%rowcount;
end;  --RM: error message appeared

--Lesson 20 Managing Transaction Processing 172 (161)
--Transaction Processing is a mechanism used to manage sets of SQL operations that must be executed in batches so as to ensure that databases never contain the results of partial operations. With Transaction Processing, you can ensure that sets of operations are not aborted midprocessing—-they either execute in their entirety or not at all (unless explicitly instructed otherwise).
/*
When working with transactions and transaction processing, there are a few keywords that’ll keep reappearing. Here are the terms you need to
know:
• Transaction: A block of SQL statements
• Rollback: The process of undoing specified SQL statements
• Commit:  Writing unsaved SQL statements to the database tables
• Savepoint: A temporary placeholder in a transaction set to which you can issue a rollback (as opposed to rolling back an entire transaction)
*/
--Oracle is savepoint samepointname;
--Oracle is rollback to samepointname;
--The More Savepoints the Better. You can have as many savepoints as you’d like within your SQL code, and the more the better. Why? Because the more savepoints you have the more flexibility you have in managing rollbacks exactly as you need them.

--Lesson 21 Using Cursors 179 (168)
/*
Sometimes there is a need to step through rows forward or backward and one or more at a time. This is what cursors are used for. A cursor is a
database query stored on the DBMS server—not a SELECT statement, but the result set retrieved by that statement. Once the cursor is stored, applications can scroll or browse up and down through the data as needed.
*/
DECLARE CURSOR CustCursor
IS
SELECT * FROM Customers
WHERE cust_email IS NULL; --error message
--RM:  skipped rest of lesson.

--Lesson 22 Understanding Advanced SQL Features 185 (174)
/* Constraints Rules that govern how database data is inserted or manipulated. */
/* A primary key is a special constraint that is used to ensure that values in a column (or set of columns) are unique and never change, in other words, a column (or columns) in a table whose values uniquely identify each row in the table. Side note:  Primary key values can never be reused. If a row is deleted from the table, its primary key must not be assigned to any new rows.*/
create table vendors
(vend_id char(10) not null primary key, vend_name char(50) not null, vend_address char(50) null, vend_city char(50) null, vend_state char(5) null, 
vend_zip char(10) null, vend_country char(50) null);
alter table vendors
add constraint primary key (vend_id);
/* A foreign key is a column in a table whose values must be listed in a primary key in another table. Foreign keys are an extremely important part
of ensuring referential integrity. */
create table orders
(order_num integer not null primary key, order_date datetime not null, cust_id char(10) not null references customers(cust_id));  --the REFERENCES keyword to state that any values in cust_id must be in cust_id in the Customers table.
alter table customers
add constraint foreign key (cust_id) references customers (cust_id);  --the REFERENCES keyword to state that any values in cust_id must be in cust_id in the Customers table.
/* Unique constraints are used to ensure that all data in a column (or set of columns) is unique. Null values are okay.  e.g. social security numbers.  The syntax for unique constraints is similar to that for other constraints.  Either the UNIQUE keyword is defined in the table definition or a separate CONSTRAINT is used. */
/* Check constraints are used to ensure that data in a column (or set of columns) meets a set of criteria that you specify. It's like a column restriction, data requirement, column requirement, column constraint. */
--The following example applies a check constraint to the OrderItems table to ensure that all items have a quantity greater than 0:
create table orderitems
(order_num integer not null, order_item integer not null, prod_id varchar(10) not null, quantity integer not null check (quantity > 0), item_price integer not null);
add constraint check (gender like '[mf]');  --column name gender contains only m or f in an alter table statement
/* Indexes are used to sort data logically to improve the speed of searching and sorting operations. The best way to understand indexes is to envision the index at the back of a book (this book, for example). You may define an index on one or more columns so that the DBMS keeps a sorted list of the contents for its own use. After an index is defined, the DBMS uses it in much the same way as you would use a book index. It searches the sorted index to find the location of any matches and then retrieves those specific rows.*/
create index prod_name_ind
on products (prod_name);  --Every index must be uniquely named. Here the name prod_name_ind is defined after the keywords CREATE INDEX. ON is used to specify the table being indexed, and the columns to include in the index (just one in this example) are specified in parentheses after the table name.
/* Triggers are special stored procedures that are executed automatically when specific database activity occurs. Triggers might be associated with
INSERT, UPDATE, and DELETE operations (or any combination thereof) on specific tables. e.g. converting all state
names to uppercase during an INSERT or UPDATE operation, making sure a customer’s available credit has not been exceeded and blocking the insertion if it has, calculating computed column values or updating timestamps */
create trigger customer_state
after insert or update
for each row
begin
update customers
set cust_state = upper(cust_state)
where customers.cust_id = :old.cust_id
end;
--Constraints Are Faster Than Triggers. As a rule, constraints are processed more quickly than triggers, so whenever possible, use constraints instead.  RM:  which explains past SQL tutorials triggers not taught.

--Appenxis C 218 (207) lists most frequenty SQL statements or SQL operations
/*
alter table
commit
create index
create procedure
create table
create view
delete
drop
insert
insert select
rollback
select
update
*/