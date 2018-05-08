#find duplicates in a column
select cust_name
from customers
group by cust_name
having count(cust_name) > 1;

#find duplicates in a row
select trim(vend_id), trim(prod_price)
from products;
select trim(vend_id), trim(prod_price)
from products
group by vend_id, prod_price
having count(*) > 1;

#insert data from one table to another table
insert into tabletobecopiedortargettable
select * from tablecopysource;
insert into tabletobecopiedortargettable (column1, column2)
select (column1, column2) from tablecopysource;
insert into tabletobecopiedortargettable (column1, column2)
select (column1, column2) from tablecopysource
where column1 = 5;

#CASE expression which is if then else in select statement if statement
--There are two CASE expression.  1 simple case and 2 search case.
/* 1 simple case
(case searchexpression
	when inputexpression1 then result1
	when inputexpression2 then result2
	when inputexpression3 then result3
	when inputexpressionn then resultn
	else elseresult
end)
*/
select name, (case name
  when 'Modern Science' then '001'
  when 'Chemistry' then '002'
  else '005'
end) as "case alias", price
from products;
select (case 'dog'
	when 'cat' then '1 False'
	when 'dog' then '2 True'
	when 'cow' then '3 False'
	when 'dog' then '4 True'
	else 'sorry'
end)
from dual; --returns 2 True
select (case 'dog'
	when 'cat' then '1 False'
	when 'Monkey' then '2 True'
	when 'cow' then '3 False'
	when 'Frog' then '4 True'
	else 'sorry'
end)
from dual; --returns sorry
/* 2 search case
(case 
	when condition1 then result1
	when condition2 then result2
	when condition3 then result3
	when conditionn then resultn
	else elseresult
end)
*/
select firstname, lastname, (case 
	when firstname = 'Tony' and lastname = 'Stark' then 'Ironman',
	when firstname = 'Bruce' and lastname = 'Wayne' then 'Batman',
	when firstname = 'Clark' and lastname = 'Kent' then 'Superman',
	when firstname = 'Peter' and lastname = 'Parker' then 'Spiderman'
	else 'sorry'
end) as "superhero", bornonearthyorn
from superheroestable;
select first_name, salary, (case
	when salary <=9000 then 'case 1'
	when last_name = 'King' and manager_id is null then 'case 2'
	when salary between 10000 and 13500 then 'case 3'
	when salary in (14000,17000,24000) then 'case 4'
	else 'sorry'
end) as "cases comparsion operations", last_name
from employees
where salary >= 8500;

#Import data from Excel to Oracle SQL Developer
create table jobsearchlog (dateapplied date, wherejobfound varchar(100), applyjobat varchar(100), company varchar(100), position varchar(100), jobid varchar(50), comments varchar(250), userid varchar(50), password varchar(50));  --RM create table at hrpdborcl
drop table jobsearchlog; --RM: needed increase varchar length.  delete table and update create table sql statement

#Google SQL Test Sep 2017 Adecco Contract Position sqlreportinganalystquiz.sql
#Q1: Table ‘Items’ has columns order_id and item_id. Each item_id is associated with an item. An order_id can have multiple associated items. For example, if a customer ordered cookies, chocolate, and bread, there would be 3 rows in the ‘Items’ table for this order, one for each of the 3 items. Find the number of orders of each order size, where order size is the number of items in an order. In the above example, order size would be 3 (cookies, chocolate, and bread). The output of your query would be something like 100 orders had 1 item, 70 orders had 2 items, 30 orders had 3 items, and so on
select orderid, count(itemid)
from items
group by orderid
order by orderid;  --return orderid and the count of orders for each itemid

#Q2: Table ‘Orders’ has columns order_id and total_value. Find the number of orders whose total value is in each of the following ranges: $0-$50, $51-$100, over $101. Column total_value has been rounded to integers.
select MyTable2.ranges as "Total Value Range", count(*) as "Number of Orders Range"
from (
	select case
		when total_value >=0 and total_value <=50 then '0-50'
		when total_value >=51 and total_value <=100 then '51-100'
		else 'greater 101+' end as ranges
	from Orders) MyTable2
group by MyTable2.ranges
order by MyTable2.ranges;

#List all tables in Oracle.  https://stackoverflow.com/questions/205736/get-list-of-all-tables-in-oracle
#tabs, dba_tables, all_tables, user_tables are data dictionary views
select owner, table_name
from dba_tables;
select owner, table_name
from all_tables; #all tables user's account has access
select table_name
from user_tables;  #tables user owns
select table_name, column_name
from cols; #view tables and their given column names
select *
from tab;
select *
from tabs;
select *
from dba_tab_columns; #table columns using table name
select *
from dba_source; #text source of the objects

#Find Distinct values in two tables https://stackoverflow.com/questions/7731406/sql-query-to-find-distinct-values-in-two-tables
#RM:  table1distinct and table2distinct exists in myexpenses database.
select t1.code, t2.code
from table1distinct t1, table2distinct t2
where t1.code=t2.code; #incorrect.  Returns codes matching both tables A and C
select code
from table1distinct
union
select code
from table2distinct; #incorrect.  Returns codes from each table A, B, C, D printed once
select code
from table1distinct
union all
select code
from table2distinct; #incorrect.  Returns codes from each table A, B, C, D printed all
select code
from table1distinct
intersect
select code
from table2distinct; #partially correct.  Returns matching codes from each table A, C printed once
select t1.code as "t1", t2.code as "t2"
from
  (select distinct code
  from table1distinct) t1
  full outer join
  (select distinct code
  from table2distinct) t2
  on t1.code=t2.code; #correct.  prints first column t1 A, B, C, null second column t2 A, null, C, D
--full outer join retrives all the columns or matching rows from both tables and nulls for the unmatched rows of both tables.
#RM: .pdf folder search SQL