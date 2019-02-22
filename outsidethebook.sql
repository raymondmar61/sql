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

#23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
select employee_id, first_name, last_name, (case when job_id = 'ST_MAN' then 'SALESMAN', when job_id = 'IT_PROG' then 'DEVELOPER' else job_id end) as "Job Title"
from employees;
#official solution no paranthesis required
select employee_id, first_name, last_name, case job_id when 'ST_MAN' then 'SALESMAN' when 'IT_PROG' then 'DEVELOPER' else job_id end as "Job Title"
from employees;

#24. Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.  #RM:  subquery inside a case or inside a if statement.
select employee_id, first_name, last_name, salary, case when salary > (select avg(salary) from employees) then 'HIGH' when salary < (select avg(salary) from employees) then 'LOW' else 'MATCH' end as "Salary Status"
from employees;

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

#SUM of grouped COUNT in SQL Query Stack Overflow
#http://stackoverflow.com/questions/12927268/sumofgroupedcountinsqlquery
#RM:  Add a row at the bottom of the count summing the counts or adding the numbers or add numbers
select name, count(name)
from expenses
group by name;
select name, count(name)
from expenses
group by name
union all
select 'sum' name, count(name)
from expenses;  #bottom row named 'sum' adds the count(name) by name
select name, count(name) as count, sum(count(name)) over() as "total count"
from expenses
group by name;  #adds the count(*) displayed each row under column "total count"
select sum(count)
  from (select name, count(name) as count
  from expenses
  group by Name); #prints the sum of count(name) only which is 1492
#start look at sql in .docx word files 05/15/2018

#Google SQL Prescreen Questions.docx 02/19/2018
#1 Given a Table with Customer ID, Country & Revenue, can you write a SQL query to get the Top 10 Customers per country in terms of Revenue?
with topten as
  (select country, customerid, sum(revenue) as totalsum, ntile(10) over (order by sum(revenue)) as toptenamount
  from table
  group by country, customerid)
select country, customerid, totalsum
from topten
where toptenamount = 10
order by totalsum desc;
#RM:  Given a table with place, city, and amount . . . .  Bonus create table, insert rows, and subquery join.  I can't multiple group top 10.
create table placecityamount (place varchar2(60), city varchar2(20), amount float);
insert into placecityamount (place, city, amount)
select p.personplace, p.city, e.amount
from expenses e, personplace p
where p.personplace=e.name
and city in (select p.city
  from expenses e, personplace p
  where p.personplace=e.name
  group by p.city
  having count(distinct e.name) >= 20); #insert 1051 rows.  Insert rows in placecityamount table from expenses e and personplace p table.  The cities are from the subquery getting the cities where I shopped at 20 or more places.
select city, place, sum(amount)
from placecityamount
group by city, place
order by city, sum(amount) desc;
select city, place, sum(amount), ntile (10) over (order by sum(amount))
from placecityamount
group by city, place
order by city, sum(amount) desc; #includes the nth tile position for each city and place
with topten as
  (select city, place, sum(amount) as totalsum, ntile(10) over (order by sum(amount)) as toptenamount
  from placecityamount
  group by city, place)
select city, place, toptenamount, totalsum
from topten
where toptenamount = 10
order by city, totalsum desc; #technically it's correct.  Return top ten sum amount for each city and place; e.g. one Santa Clara which is Costco-Santa Clara because the total sum is 10% of all Santa Clara and places shopped.
select p.city, p.personplace, sum(e.amount)
from expenses e, personplace p
where p.personplace=e.name
and city in (select city
  from personplace
  group by city
  having count(city) >= 20)
group by p.city, p.personplace
order by p.city, sum(e.amount) desc; #incorrect.  The subquery to find cities where I shopped 20 times or greater is incorrect.  The subquery is actually finding cities in personplace table where there are 20 or more cities.  The subquery is not finding cities in expenses table where I shopped 20 times or greater.
select p.city, p.personplace, sum(e.amount)
from expenses e, personplace p
where p.personplace=e.name
and city in (select p.city
  from expenses e, personplace p
  where p.personplace=e.name
  group by p.city
  having count(distinct e.name) >= 20)
group by p.city, p.personplace
order by p.city, sum(e.amount) desc; #correct.  The subqery is searching for cities where I shopped in expenses table 20 times or greater by counting the places name no duplicate places.  The cities are from personplace table.  The subquery returns the cities for the primary query.
#Google SQL Prescreen Questions.docx #2 05/15/2018

#2 Given 2 tables, Table1 with Customer_ID, Product_ID, Date, Country & Revenue & Table2 with Product_ID & Product_Name can you write a SQL query to get the Total Revenue by Product_Name and Country?
select t2.product_name as "Product Name", t1.country as "Country", sum(t1.revenue) as "Total Revenue"
from table1 t1 left outer join table2 t2
on t1.product_id = t2.product_id
group by t2.product_name, t1.country;

#3 Given a Table with Customer ID, Country, Year & Revenue, can you write a SQL query to get the Total Revenue by Country for the year 2017?
select country, sum(revenue)
from sales
where year = 2017
group by country;

#4 Is there anything wrong with this query? If yes, what would you suggest?
select customer_id, year(date) as year_date, sum(revenue) as revenue_sum
from customer
where year(date) in (2015);
#yes.  My answer is below
select customer_id, extract(year from date) as year_date, sum(revenue) as revenue_sum
from customer
where extract(year from date) as year_date = 2015
group by 1, 2; #partially correct.  RM:  somehow group by 1, 2 doesn't work in Oracle
#RM:  correct answer using my expenses table
select name, sum(amount) as "Total Spent"
from expenses
where extract(year from expensedate) = 2015
group by name
order by sum(amount) desc;

#Google Screening Questions SQL.docx 09/26/2016
#5.  There is a database with three fields: user_id, timestamp and a transaction_number. Write SQL to show the user_ids that had transactions in December, but not in January.
select user_id, count(user_id)
from mydatabase
where timestamp >='12/1/2015' and timestamp <='12/31/2015'
group by user_id
order by count(user_id) desc;
#RM:  using my expenses table
select name, count(name)
from expenses
where expensedate >='12/1/2017' and expensedate<='12/31/2017'
group by name
order by count(name) desc;

#Group By Percentage Of Total
#https://stackoverflow.com/questions/13721093/oracle-how-to-get-percent-of-total-by-a-query
#https://stackoverflow.com/questions/46909494/percentage-from-total-sum-after-group-by-sql-server
select sum(availablesf)
from availablelease;
select b.city, sum(a.availablesf) as "Total Avail SF By City", sum(sum(a.availablesf)) over() as "Grand Total Avail SF", round(100*(sum(a.availablesf)/sum(sum(a.availablesf)) over ()),2) as "City % Of Grand Total"
from availablelease a left outer join building b
on a.buildingid = b.buildingid
group by b.city
order by b.city;

#https://www.w3resource.com/sql-exercises/joins-hr/index.php
#3. Write a query in SQL to display the first name, last name, salary, and job grade for all employees.  RM:  copied solution.  Also job_grades table lists grade, lowest salary and highest salary three columns
/* join unequal tables.  Can use between ... and, and comparison operators < > >= <= RM:  also <> */
select e.first_name, e.last_name, e.salary, j.grade_level
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal;

#https://www.w3resource.com/sql-exercises/joins-hr/index.php
#25. Write a query in SQL to display full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
select e.first_name || ' ' || e.last_name as "Full Name", j.job_title, jobhistory.start_date, jobhistory.end_date
from employees e join job_history jobhistory
on e.employee_id = jobhistory.employee_id
join jobs j
on jobhistory.job_id = j.job_id
where e.commission_pct = 0;  #RM:  problem is there are two employees with two job_id in job_history table.  We want the latest job or the job with the latest date; e.g. start date 9/21/97 or 10/28/01 we want 10/28/01.

select e.first_name || ' ' || e.last_name as "Full Name", j.job_title, jobhistoryspecial.*
from employees e join (
  select max(start_date), max(end_date), employee_id
  from job_history
  group by employee_id) jobhistoryspecial
on e.employee_id = jobhistoryspecial.employee_id
join jobs j
on j.job_id = e.job_id
where e.commission_pct = 0;
/*
employee_name   job_title     starting_date ending_date employee_id
Neena Kochhar   Administration Vice President 2001-10-28  2005-03-15  101
Lex De Haan   Administration Vice President 2001-01-13  2006-07-24  102
Den Raphaely    Purchasing Manager    2006-03-24  2007-12-31  114
Payam Kaufling    Stock Manager     2007-01-01  2007-12-31  122
Jennifer Whalen   Administration Assistant  2002-07-01  2006-12-31  200
Michael Hartstein Marketing Manager   2004-02-17  2007-12-19  201
*/

#https://www.w3resource.com/sql-exercises/subqueries/index.php
#RM:  joins subquery joins subqueries joins join subquery join together
#9. Write a query to display all customers with orders on October 5, 2012.
select *
from customer
where customer_id in (
  select customer_id
  from orders
  where ord_date = '2012-10-05');
#official solution
select *
from customer a, orders  b 
where a.customer_id=b.customer_id 
and b.ord_date='2012-10-05';

#10. Write a query to display all the customers with orders issued on date 17th August, 2012.
select *
from customer
where customer_id in (
  select customer_id
  from orders
  where ord_date = '2012-08-17');
#official solution
select b.*, a.cust_name
from orders b, customer a
where a.customer_id=b.customer_id
and b.ord_date='2012-08-17';

#11. Write a query to find the name and numbers of all salesmen who had more than one customer.
select *
from salesman
where salesman_id in (
  select salesman_id
  from customer
  group by salesman_id
  having count(salesman_id) >= 2);
#official solution
select salesman_id,name 
from salesman a 
where 1 < 
    (select count(*) 
     from customer 
     where salesman_id=a.salesman_id);

#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.  RM:  subquery and join together.  subquery join subquery together.
#official solution
select *
from orders oa
where oa.purch_amt > (
  select avg(ob.purch_amt)
  from orders ob
  where oa.customer_id=ob.customer_id) #<-- take customers into account per official solution
order by customer_id;
/*
ord_no  purch_amt ord_date  customer_id salesman_id
70008 5760.00 2012-09-10  3002  5001
70013 3045.60 2012-04-25  3002  5001
70007 948.50  2012-09-10  3005  5002
70003 2480.40 2012-10-10  3009  5003
*/

#13. Write a queries to find all orders with order amounts which are on or above-average amounts for their customers.
select *
from orders oa
where oa.purch_amt >= (
  select avg(ob.purch_amt)
  from orders ob
  where oa.customer_id=ob.customer_id) #<-- take customers into account per official solution
order by customer_id;

#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
#official solution
select oa.ord_date, sum(oa.purch_amt)
from orders oa
group by oa.ord_date
having sum (oa.purch_amt) > (
  select 1000.00 + max(ob.purch_amt) 
  from orders ob 
  where oa.ord_date = ob.ord_date);
/*
ord_date  sum
2012-09-10  6979.15
2012-10-10  4463.83
*/

#15. Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.
#RM:  question is extract the customer table if one or more customer is from London.  There is a customer from London.
#official solution
select *
from customer
where exists (
  select *
    from customer 
    where city = 'London');
#also from comment section
select *
from customer ca
where 1 >= (
  select count(distinct cb.city)
  from customer cb
  where ca.customer_id=cb.customer_id
  and cb.city='London');

#22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.
select ca.*
from customer ca
where ca.grade > any (
  select cb.grade
  from customer cb
  where cb.city < 'New York');

#25. Write a query to display all orders with an amount smaller than any amount for a customer in London.  #RM:  I don't understand the question becuase it's the same as #24.  The differrence is max() in the subquery orders ob, customer c.
select oa.*
from orders oa
where purch_amt < any (
  select max(ob.purch_amt)
  from orders ob, customer c
  where ob.customer_id = c.customer_id
  and c.city='London');

#26. Write a query to display only those customers whose grade are, in fact, higher than every customer in New York.
select ca.*
from customer ca
where ca.grade > all ( #RM:  every customer means all customers
  select cb.grade
  from customer cb

#33. Write a SQL query to display the name of each company, price for their most expensive product along with their ID.
select c.com_name, max(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name; #RM:  display company name and most expensive product
#official solution
select c.com_name, i.pro_price, i.pro_name
from company_mast c, item_mast i
where c.com_id = i.pro_com
and i.pro_price = (
  select max(i.pro_price)
  from item_mast i
  where c.com_id = i.pro_com);  #RM:  aggregate function itself in a subquery and a join aggregate function join.

#38. Write a query in SQL to find the names of departments with more than two employees are working.
select *
from emp_department
where dpt_code in (
  select emp_dept
  from emp_details
  group by emp_dept
  having count(emp_dept) > 2);

#39. Write a query in SQL to find the first name and last name of employees working for departments which sanction amount is second lowest.
select emp_fname, emp_lname
from emp_details
where emp_dept in (
  select dpt_code from (
    select dpt_code, rank() over (order by dpt_allotment asc) rank from emp_department) neednamehere
  where rank = 2);  #returns Alan Snappy and George Mardy

#https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php
#10. Write a query to display all the information of the employees whose salary is within the range of smallest salary and 2500.
select *
from employees
where salary between (
  select min(salary)
  from employees) and 2500;

#12. Write a query to display all the information for those employees whose id is any id who earn the second highest salary.
select *
from (
  select employees.*, rank() over (order by salary desc) rank 
  from employees) employee_rank
  where rank = 2
#also
select *
from employees
where employee_id in (
  select employee_id from (
    select employee_id, rank() over (order by salary desc) rank 
  from employees) employee_rank
  where rank = 2);

#15. Write a query to display the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.  #RM:  two subqueries in one query.  Two subqueries combined with and statement.
select employee_id, first_name || ' ' last_name as "Name", salary
from employees
where employee_id in (
  select employee_id
  from employees
  where salary > (
    select avg(salary)
    from employees))
and first_name like '%J%';  #returns nothing
select employee_id, first_name, salary  
from employees  
where salary > (
  select avg (salary)  
  from employees)
and department_id in (
  select department_id  
  from employees  
  where first_name like '%J%');

#17. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.  #RM:  there is one MK_MAN.
select employee_id, first_name, last_name, job_id
from employees
where salary < any (
  select salary
  from employees
  where job_id = 'MK_MAN');

#19. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.  #RM:  official answer says salary > all (...  Questions asked for any salary.
select employee_id, first_name, last_name, job_id
from employees
where salary > all (
  select salary
  from employees
  where job_id = 'PU_MAN')
and job_id <> 'PU_MAN';

#20. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
select employee_id, first_name, last_name, job_id
from employees
where salary > all (
  select avg(salary)
  from employees
  group by department_id);

#22. Write a query to display the department id and the total salary for those departments which contains at least one employee.
select department_id, sum(salary)
from employees
group by department_id
having count(department_id) > 1
order by department_id;
#official solution using inner join
select departments.department_id, result1.total_amt 
from departments, (
  select employees.department_id, sum(employees.salary) total_amt  
  from employees  
  group by department_id) result1 
where result1.department_id = departments.department_id;
#comments subquery
select department_id, sum(salary), count(employee_id)
from employees 
where 0 < any (
  select count(employee_id)
  from employees,departments
  where departments.department_id = employees.employee_id)
group by department_id
order by department_id;

#26. Write a subquery that returns a set of rows to find all departments that do actually have one or more employees assigned to them.
select department_id, count(department_id)
from employees
group by department_id
having count(department_id) >= 1
order by department_id;
#official solution  #RM:  returned department names
select department_name 
from departments 
where department_id in (
  select distinct(department_id) 
  from employees);
#another solution  #RM:  returned department names and employee count.
select d.department_name, count(e.department_id)
from employees e, departments d
where e.department_id = d.department_id
group by e.department_id, d.department_name
having count(e.department_id) >= 1
order by e.department_id;

#31. Write a query which is looking for the names of all employees whose salary is greater than 50% of their department’s total salary bill.
select *
from employees e, employeessalary es
where e.department_id = es.department_id
and e.salary > (
  select department_id, sum(salary)*.50 as salary
  from employees es
  group by department_id); #incorrect
select *
from employees e, employees es
where e.department_id = es.department_id
and e.salary > (
  select es.department_id, sum(es.salary)*.50 as salary
  from employees es
  group by es.department_id); #incorrect
select *
from employees e
where e.salary > (
  select sum(es.salary)*.50 as salary
  from employees es
  where e.department_id = es.department_id
  group by es.department_id); #correct
#official solution
select e1.first_name, e1.last_name 
from employees e1 
where salary > (
  select (sum(salary))*.5 
  from employees e2 
  where e1.department_id=e2.department_id);

#34. Write a query to display the employee id, name ( first name and last name ), salary, department name and city for all the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  RM:  as I expected.  Find the employees making the highest salary hired between January 1, 2002 and December 31, 2003.  #RM:  two subqueries 2 subquery where and
select e.employee_id, e.first_name, e.last_name, e.salary, d.department_name, l.city
from employees e, departments d, locations l
where salary = (
  select max(e.salary)
  from employees e
  where hire_date is between '2002-01-01' and '2003-12-31')
and e.department_id = d.department_id
and d.location_id = l.location_id;

#48. Write a query in SQL to display the the details of those departments which max salary is 7000 or above for those employees who already done one or more jobs.  #RM:  should be greater than one jobs.
select *
from departments
where department_id in (
  select department_id
  from employees
  where employee_id in (
    select employee_id
    from job_history
    group by employee_id
    having count(employee_id) > 1) #employee id's 101, 176, 200
  group by department_id
  having max(salary) > 7000);  #department id's 90, 80

#54. Write a query in SQL to display the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.  #RM:  subquery returns two or more columns.  Subquery two columns.
#comment solution
select department_id, first_name || ' ' || last_name as employee_name, salary
from employees
where (department_id, salary) in (
  select department_id, max(salary) 
  from employees
  group by department_id);
#official solution
select ea.department_id, ea.first_name || ' ' || ea.last_name as employee_name, ea.salary 
from employees ea
where ea.salary = (
  select max(eb.salary) 
  from employees eb 
  where eb.department_id = ea.department_id);  #RM:  Partially correct.  What if two or more departments have same maximum salary?  My guess is the where eb.department_id = ea.department_id prevents the same maximum salary?

#https://www.w3resource.com/sql-exercises/union/sql-union.php

#5. Write a query to make a report of which salesman produce the largest and smallest orders on each date and arranged the orders number in smallest to the largest number.
select s.salesman_id, s.name, o1.ord_no, 'Highest Number', o1.ord_date
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
  select max(o2.purch_amt)
  from orders o2
  where o2.ord_date=o1.ord_date)
union
(select s.salesman_id, s.name, o1.ord_no, 'Lowest Number', o1.ord_date
from salesman s, orders o1
where s.salesman_id = o1.salesman_id
and o1.purch_amt = (
  select min(o2.purch_amt)
  from orders o2
  where o2.ord_date=o1.ord_date))
order by ord_no;

#7. Write a query to that appends strings to the selected fields, indicating whether or not a specified salesman was matched to a customer in his city.
select s.salesman_id, s.name, s.city as "Salesman City", c.city as "Customer City", 'Match'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city = c.city
union
(select s.salesman_id, s.name, s.city as "Salesman City", c.city as "Customer City", 'No Match'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city <> c.city;

#8. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words "High Rating", while the others will have the words "Low Rating".
select cust_name, city, grade, (case when grade >=200 then 'High Rating' else 'Low Rating' end) as "Unknown Rating"
from customer;
#official solution
select cust_name, city, grade, 'High Rating'
from customer
where grade >=200
union
(select cust_name, city, grade, 'Low Rating'
from customer
where grade <200);

#https://www.w3resource.com/sql-exercises/movie-database-exercise/basic-exercises-on-movie-database.php
#5. Write a query in SQL to return the name of all reviewers and name of movies together in a single list.  #RM:  returns one column containing movie names and reviewer names.
#official solution
select reviewer.rev_name
from reviewer
union
(select movie.mov_title
from movie);

#7. Write a query in SQL to find the titles of all movies that have no ratings.  #RM:  analysis paralysis.  does not include.
#official solution
select mov_title
from movie
where mov_id not in (
  select mov_id
  from rating);

#https://www.w3resource.com/sql-exercises/movie-database-exercise/subqueries-exercises-on-movie-database.php
#5. Write a query in SQL to find the titles of all movies directed by the director whose first and last name are Woddy Allen.
select *
from movie
where mov_id in (
  select mov_id
  from movie_direction
  where dir_id = (
    select dir_id
    from director
    where dir_fname = 'Woody' and dir_lname = 'Allen'));
#also
select movie.*
from movie, movie_direction, director
where movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id
and director.dir_fname = 'Woody' and dir_lname = 'Allen';

#9. Write a query in SQL to return the reviewer name, movie title, and stars for those movies which reviewed by a reviewer and must be rated. Sort the result by reviewer name, movie title, and number of stars.
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer, rating, movie
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and reviewer.rev_name is not null
and rating.rev_stars is not null
order by reviewer.rev_name, movie.mov_title, rating.rev_stars;
#also
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer inner join rating
on reviewer.rev_id = rating.rev_id
inner join movie
on rating.mov_id = movie.mov_id
where reviewer.rev_name is not null
and rating.rev_stars is not null
order by reviewer.rev_name, movie.mov_title, rating.rev_stars;

#11. Write a query in SQL to find the movie title, and the highest number of stars that movie received and arranged the result according to the group of a movie and the movie title appear alphabetically in ascending order.
select mov_id, count(rev_stars)
from rating
group by mov_id; #RM:  stupid question because all mov_id count is 1 or 0.
#pretend movies have many stars.  Use max()
select movie.mov_title, MAX(rating.rev_stars)
from movie, rating
where movie.mov_id = rating.mov_id
and rating.rev_stars is not null
group by movie.mov_title
order by movie.mov_title;

#12. Write a query in SQL to find the names of all reviewers who rated the movie American Beauty.
select rev_name
from reviewer
where rev_id in (
    select rev_id
    from rating
    where mov_id in (
        select mov_id
        from movie
        where mov_title = 'American Beauty'));
#also and official solution
select rev_name
from reviewer, rating, movie
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and movie.mov_title = 'American Beauty';

#13. Write a query in SQL to find the titles of all movies which have been reviewed by anybody except by Paul Monks.  #RM:  something to think about.  First query returns all movies with a reviewer.  Second query official query returns all movies in reviewer table rev_name null or not null.
select mov_title
from movie, rating, reviewer
where movie.mov_id = rating.mov_id
and rating.rev_id = reviewer.rev_id
and rev_name <> 'Paul Monks';
#official solution subquery includes movies where rev_name in rating table is null
select movie.mov_title
from movie 
where movie.mov_id in(
    select mov_id 
    from rating 
    where rev_id not in (
        select rev_id 
        from reviewer 
        where rev_name='Paul Monks'));

#https://www.w3resource.com/sql-exercises/movie-database-exercise/joins-exercises-on-movie-database.php
#8. Write a query in SQL to list all the movies with year, genres, and name of the director.
select movie.mov_title, movie.mov_year, genres.gen_title, director.dir_fname, director.dir_lname
from movie, genres, movie_genres, director, movie_direction
where movie.mov_id = movie_genres.mov_id
and movie_genres.gen_id = genres.gen_id
and movie.mov_id = movie_direction.mov_id
and movie_direction.dir_id = director.dir_id;
#also
select mov_title, mov_year, gen_title, dir_fname, dir_lname
from movie
natural join genres
natural join movie_genres
natural join movie_direction
natural join director;

#9. Write a query in SQL to list all the movies with title, year, date of release, movie duration, and first and last name of the director which released before 1st january 1989, and sort the result set according to release date from highest date to lowest.
select m.mov_title, m.mov_year, m.mov_dt_rel, m.mov_time, d.dir_fname, d.dir_lname
from movie m inner join movie_direction md
on m.mov_id = md.mov_id
inner join director d
on md.dir_id = d.dir_id
where m.mov_dt_rel < '1989-01-01'
order by m.mov_dt_rel desc;
#also
select mov_title, mov_year, mov_dt_rel, mov_time, dir_fname, dir_lname
from movie
natural join movie_direction
natural join director
where mov_dt_rel < '1989-01-01'
order by mov_dt_rel desc;

#10. Write a query in SQL to compute a report which contain the genres of those movies with their average time and number of movies for each genres.
select g.gen_title, count(g.gen_title), avg(m.mov_time)
from movie m inner join movie_genres mg
on m.mov_id = mg.mov_id
inner join genres g
on mg.gen_id = g.gen_id
group by g.gen_title;
#also
select g.gen_title, count(g.gen_title), avg(m.mov_time)
from movie m
natural join movie_genres mg
natural join genres g
group by g.gen_title;

#11. Write a query in SQL to find those lowest duration movies along with the year, director's name, actor's name and his/her role in that production.
select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role
from movie
natural join actor
natural join director
natural join movie_direction
natural join movie_cast
where mov_time = (
  select min(mov_time)
  from movie);

#12. Write a query in SQL to find all the years which produced a movie that received a rating of 3 or 4, and sort the result in increasing order.  #RM:  dumb question.  There are two movies with a rating 3 or 4.  Same year which is 1997.
select distinct mov_year
from movie
natural join rating
where rev_stars in (3, 4)
order by mov_year;

