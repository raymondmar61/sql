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

#Google SQL Test Sep 2017 Adecco Contract Position sqlreportinganalystquiz.sql
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
#05/08/18: .pdf folder search SQL

#oracle - Escaping ampersand (&) character in SQL string - Stack Overflow.pdf
#https://stackoverflow.com/questions/12961215/escaping-ampersand-character-in-sql-string
select *
from personplace
where personplace in 'Barnes \& Noble-Stevens Creek'; #unsuccessful
select *
from personplace
where personplace in 'Barnes ' ||chr(38)|| ' Noble-Stevens Creek'; #success.  38 is the ascii code for ampersand.
select *
from personplace
where personplace like 'Barnes _ Noble-Stevens Creek'; #success.  Use like and underscore single character.
#Ampersand is the SQL*Plus marker; but you can , or more usefully in your case turn it off completely, with: set define off
set define off
select *
from personplace
where personplace in 'Barnes & Noble-Stevens Creek';
set define on

#Select top 10 percentage | Oracle Community (Top ten percentage)
#https://community.oracle.com/thread/2539806
with topten as 
  (select expensedate, name, amount, ntile(10) over (order by amount) as "top ten amount"
  from expenses
  where name not in ('Charles Schwab-Hamilton'))
select expensedate, name, amount
from topten
where "top ten amount" = 10
order by amount desc;
select expensedate, name, amount
from expenses
where name not in ('Charles Schwab-Hamilton')
order by amount desc
fetch first 10 percent rows with ties;  --also works using fetch first 10 percent rows

 with topten as 
  (select expensedate, name, amount, ntile(100) over (order by amount) as "top 12"
  from expenses
  where name not in ('Charles Schwab-Hamilton'))
select expensedate, name, amount
from topten
where "top 12" >= 100 - 12
order by amount desc; #top 12 not accurate
with bottomten as 
  (select expensedate, name, amount, ntile(100) over (order by amount) as "bottom 12"
  from expenses
  where amount > 0)
select expensedate, name, amount
from bottomten
where "bottom 12" <= 12
order by amount asc; #bottom 12 not accurate

with gotanalyticstop12 as
  (select expensedate, name, amount, row_number() over (order by amount desc) as rownumber, count(*) over() as numberofrows
  from expenses
  where name not in ('Charles Schwab-Hamilton'))
select expensedate, name, amount
from gotanalyticstop12
where rownumber/numberofrows <=12/100
order by amount desc; #more accurate 1490*.12=178.8 or 1,490 rows multiply 12% equals 178.8.  Get 178 rows.
with gotanalyticstop12 as
  (select expensedate, name, amount, row_number() over (order by amount desc) as rownumber, count(*) over() as numberofrows
  from expenses
  where name not in ('Charles Schwab-Hamilton'))
select expensedate, name, amount
from gotanalyticstop12
where rownumber <= round(numberofrows * 12/100)
order by amount desc; #more accurate want the extra row since 1490*.12=178.8 or 1,490 rows multiply 12% equals 178.8.  Get 179 rows.

#bonus.  Top ten total expenses summed spent grouped by name
select name, sum(amount)
from expenses
group by name
order by sum(amount) desc;
with topten as
  (select name, sum(amount), ntile(10) over (order by sum(amount)) as toptenamount
  from expenses
  group by name)
select name, sum(amount)
from topten
where toptenamount = 10
group by name
order by sum(amount) desc; #unsuccessful
with topten as
  (select name, sum(amount) as totalsum, ntile(10) over (order by sum(amount)) as toptenamount
  from expenses
  group by name)
select name, totalsum
from topten
where toptenamount = 10
order by totalsum desc; #successful
with gotanalyticstop12 as
  (select name, sum(amount) as totalsum, row_number() over (order by sum(amount) desc) as rownumber, count(*) over() as numberofrows
  from expenses  
  where name not in ('Charles Schwab-Hamilton')
  group by name)
select name, totalsum
from gotanalyticstop12
where rownumber <= round(numberofrows * 12/100)
order by totalsum desc; #top twelve total expenses summed spent grouped by name

#How can I set a custom date time format in Oracle SQL Developer?
#https://stackoverflow.com/questions/8134493/how-can-i-set-a-custom-date-time-format-in-oracle-sql-developer
#1. From Oracle SQL Developer's menu go to: Tools > Preferences.
#2. From the Preferences dialog, select Database > NLS from the left panel.
#3. From the list of NLS parameters, enter DD-MON-RR HH24:MI:SS into the Date Format field.
#4. Save and close the dialog, done!

#SQL pre-screen.pdf 07/17/2017
#1. How many unique users viewed 1 or more ads on Feb 7, 2017?  RM:  How many unique places I shopped on Aug 25, 2014.
select distinct name
from expenses
where expensedate in '08/25/2014'
order by name;
#2 Which ad got the most clicks in the month of January?  RM:  Which places I shopped the most in January 2015?  Top places I shopped.
select name, count(*)
from expenses
where expensedate >='01/01/2015' and expensedate <='01/31/2015'
group by name
order by count(*) desc
fetch first 1 percent rows with ties;
#3. Which ad has the highest click through rate of all time?  RM:  Which places I shopped the most in a given month and year?  Top places I shopped.
select to_char(expensedate,'Month') || ' ' || to_char(expensedate,'yyyy') as monthyear, count(*)
from expenses
group by to_char(expensedate,'Month') || ' ' || to_char(expensedate,'yyyy')
order by count(*) desc
fetch first 1 percent rows with ties;
#4. Generate a list of all user_ids. Label each user as either "viewer only" (for users who have viewed ads but never clicked an ad) or "clicker" (for users who have ever clicked on an ad). Result will be a 2 column table (RM:  added third column for tutorial reasons).  #RM:  two tables in myexpenses database 05/11/2018.
select v.user_id as "v", c.user_id as "c"
from
  (select distinct user_id
  from views) v
  full outer join
  (select distinct user_id
  from clicks) c
  on v.user_id=c.user_id;  #get distinct user_id from views table and distinct user_id from clicks table
select v.user_id as "v", c.user_id as "c", (case
  when c.user_id is null then 'viewer' else 'clicker' end) as "viewer or clicker"
from
  (select distinct user_id
  from views) v
  full outer join
  (select distinct user_id
  from clicks) c
  on v.user_id=c.user_id; #if c.user_id is null, print viewer in viewer or clicker column
#RM:  start SUM of grouped COUNT in SQL Query - Stack Overflow.pdf .pdf file 05/10/2018 .pdf sql search sorted date descending.

#remember look at sql in .docx word files