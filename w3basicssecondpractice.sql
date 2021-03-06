#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php
#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#https://www.w3resource.com/sql-exercises/subqueries/index.php
#https://www.w3resource.com/sql-exercises/union/sql-union.php
#1. Write a SQL statement to display all the information of all salesmen.
select *
from salesman;

#2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".
select 'This is SQL Exercise, Practice and Solution' as "columnname"
/*
columnname
This is SQL Exercise, Practice and Solution
*/

#3. Write a query to display three numbers in three columns.
select 40 as "column 40", 11 as "column 11", 100 as "column 100";
/*
column 40	column 11	column 100
40	11	100
*/

#4. Write a query to display the sum of two numbers 10 and 15 from RDMS sever.
select 10+15;

#5. Write a query to display the result of an arithmetic expression.
select 10 + 15 - 5 * 2;  #RM: returns 15

#6. Write a SQL statement to display specific columns like name and commission for all the salesmen.
select name, commission
from salesman;

#7. Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders.
select ord_date, salesman_id, ord_no, purch_amt
from orders;

#8. Write a query which will retrieve the value of salesman id of all salesmen, getting orders from the customers in orders table without any repeats.  #RM:  list all salesman_id
select distinct salesman_id
from orders;

#9. Write a SQL statement to display names and city of salesman, who belongs to the city of Paris.
select name, city
from salesman
where city = 'Paris';

#10. Write a SQL statement to display all the information for those customers with a grade of 200.
select *
from customers
where grade = 200;

#11. Write a SQL query to display the order number followed by order date and the purchase amount for each order which will be delivered by the salesman who is holding the ID 5001.
select ord_no, ord_date, purch_amt
from orders
where salesman_id = 5001;

#12. Write a SQL query to display the Nobel prizes for 1970.
select *
from nobel_win
where year = 1970;

#13. Write a SQL query to know the winner of the 1971 prize for Literature. 
select *
from nobel_win
where year = 1970
and subject = 'Literature';

#14. Write a SQL query to display the year and subject that won 'Dennis Gabor' his prize.
select year, subject
from nobel_win
where winner = 'Dennis Gabor';

#15. Write a SQL query to give the name of the 'Physics' winners since the year 1950.
select *
from nobel_win
where subject = 'Physics'
and year >= 1950;

#16. Write a SQL query to Show all the details (year, subject, winner, country ) of the Chemistry prize winners between the year 1965 to 1975 inclusive.
select *
from nobel_win
where subject = 'Chemistry'
and year >=1965 and year <=1975;

#17. Write a SQL query to show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin.
select *
from nobel_win
where year > 1972
and winner in ('Menachem Begin','Yitzhak Rabin');

#18. Write a SQL query to show all the details of the winners with first name Louis.
select *
from nobel_win
where winner like 'Louis%';

#19. Write a SQL query to show all the winners in Physics for 1970 together with the winner of Economics for 1971.
select *
from nobel_win
where (year = 1970 and subject = 'Physics')
or 
(year = 1971 and subject = 'Economics');
#official solution
select *
from nobel_win
where (subject ='Physics' and year=1970)
union
(select *
from nobel_win
where (subject ='Economics' and year=1971));

#20. Write a SQL query to show all the winners of nobel prize in the year 1970 except the subject Physiology and Economics.
select *
from nobel_win
where year = 1970
and subject not in ('Physiology','Economics');

#21. Write a SQL query to show the winners of a 'Physiology' prize in an early year before 1971 together with winners of a 'Peace' prize in a later year on and after the 1974.
select *
from nobel_win
where (subject = 'Physiology' and year < 1971)
or
(subject = 'Peace' and year >= 1974);

#22. Write a SQL query to find all details of the prize won by Johannes Georg Bednorz.
select *
from nobel_win
where winner = 'Johannes Georg Bednorz';

#23. Write a SQL query to find all the details of the nobel winners for the subject not started with the letter 'P' and arranged the list as the most recent comes first, then by name in order.
select *
from nobel_win
where subject not like 'P%'
order by year desc, winner;

#24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
#official solution
select *
from nobel_win
where year = 1970
order by case
	when subject in ('Economics','Chemistry') then 1 else 0 end asc,
subject, winner;

#25. Write a SQL query to find all the products with a price between Rs.200 and Rs.600.
select *
from item_mast
where pro_price > 200 and pro_price < 600;

#26. Write a SQL query to calculate the average price of all products of the manufacturer which code is 16.
select avg(pro_price)
from item_mast
where pro_com = 16;

#27. Write a SQL query to find the item name and price in Rs.  RM:  simple sql query return pro_name and pro_price
select pro_name, pro_price
from item_mast;

#28. Write a SQL query to display the name and price of all the items with a price is equal or more than Rs.250, and the list contain the larger price first and then by name in ascending order.
select pro_name, pro_price
from item_mast
where pro_price >= 250
order by pro_price desc, pro_name asc;

#29. Write a SQL query to display the average price of the items for each company, showing only the company code.
select pro_com, avg(pro_price)
from item_mast
group by pro_com

#30. Write a SQL query to find the name and price of the cheapest item(s).
select *
from item_mast
order by pro_price asc limit 1;  #RM:  partially correct.  There are two items priced cheapest.
select *
from item_mast
where pro_price = (
	select min(pro_price)
	from item_mast);  #RM:  correct answer

#31. Write a query in SQL to find the last name of all employees, without duplicates.
select distinct emp_lname
from emp_details;

#32. Write a query in SQL to find the data of employees whose last name is 'Snares'.
select *
from emp_details
where emp_lname = 'Snares';

#33. Write a query in SQL to display all the data of employees that work in the department 57.
select *
from emp_details
where emp_dept = 57;

#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#1. Write a query to display all customers with a grade above 100.
select *
from customer
where grade > 100;

#2. Write a query statement to display all customers in New York who have a grade value above 100.
select *
from customer
where city = 'New York'
and grade > 100;

#3. Write a SQL statement to display all customers, who are either belongs to the city New York or had a grade above 100.
select *
from customer
where city = 'New York'
or grade > 100;

#4. Write a SQL statement to display all the customers, who are either belongs to the city New York or not had a grade above 100.
select *
from customer
where city = 'New York'
or grade <= 100;

#5.Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
select *
from customer
where city <> 'New York'
or grade <= 100;  #RM:  incorrect.  It's a neither nor
select *
from customer
where not (city = 'New York' or grade > 100);  #RM:  correct.  It's neither nor.

#6. Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is 505 and below or those orders which purchase amount is 1000.00 and below.  #RM:  poorly written question.
select *
from orders
where (ord_date not in ('2012-09-10') and salesman_id > 5005)
or purch_amt <= 1000;
#official solution
select * 
from  orders 
where not ((ord_date ='2012-09-10' and salesman_id > 505)
or purch_amt > 1000.00);

#7. Write a SQL statement to display salesman_id, name, city and commission who gets the commission within the range more than 0.10% and less than 0.12%.
select *
from salesman
where commission > 0.10 and commission < 0.12;

#8. Write a SQL query to display all orders where purchase amount less than 200 or exclude those orders which order date is on or greater than 10th Feb,2012 and customer id is below 3009.  #RM:  poorly written question.
select *
from orders
where (purch_amt < 200
or ord_date <= '2012-02-01')
and customer_id < 3009;

#9. Write a SQL statement to exclude the rows which satisfy 1) order dates are 2012-08-17 and purchase amount is below 1000 2) customer id is greater than 3005 and purchase amount is below 1000.  #RM:  poorly written question.
select *
from orders
where not (ord_date = '2012-08-07' and purch_amt < 1000)
and not (customer_id > 3005 and purch_amt < 1000);

#10. Write a SQL query to display order number, purchase amount, achieved, the unachieved percentage for those order which exceeds the 50% of the target value of 6000.  #RM:  looked at solution.  #RM:  dumb question
select ord_no, purch_amt, (purch_amt/6000) as "achieved %", ((6000-purch_amt)/6000) as "unachieved % which is 1.0-achieved"
from orders
where (purch_amt/6000) > .50;

#11. Write a query in SQL to find the data of employees whose last name is Dosni or Mardy.
select *
from emp_details
where emp_lname in ('Dosni','Mardy');

#12. Write a query in SQL to display all the data of employees that work in department 47 or department 63.
select *
from emp_details
where emp_dept in (47, 63);

#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#1. Write a SQL statement to find those salesmen with all information who come from the city either Paris or Rome.
select *
from salesman
where city = 'Paris' or city = 'Rome';

#2. Write a query to filter those salesmen with all information who comes from any of the cities Paris and Rome.
select *
from salesman
where city in ('Paris','Rome');

#3. Write a query to produce a list of salesman_id, name, city and commission of each salesman who live in cities other than Paris and Rome.
select *
from salesman
where city not in ('Paris','Rome');

#4. Write a query to sort out those customers with all information whose ID value is within any of 3007, 3008 and 3009.
select *
from customers
where customer_id in (3007, 3008, 3009);

#5. Write a SQL statement to find those salesmen with all information who gets the commission within a range of 0.12 and 0.14.
select *
from salesman
where commission between 0.12 and 0.14;

#6. Write a query to filter all those orders with all information which purchase amount value is within the range 500 and 4000 except those orders of purchase amount value 948.50 and 1983.43.
select *
from orders
where purch_amt between 500 and 4000
and purch_amt not in (948.50, 1983.43);

#7. Write a SQL statement to find those salesmen with all other information and name started with any letter within 'A' and 'K'.  #RM:  find name starting with the letters between A and K.
select *
from salesman
where name between 'A' and 'K';
#my solution
select *
from salesman
where name between 'A%' and 'K%';
#oracle solution? from user
select *
from salesman
where name like '[a-k]%';

#8. Write a SQL statement to find those salesmen with all other information and name started with other than any latter within 'A' and 'L'.
select *
from salesman
where name between 'M%' and 'Z%';

#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from customer
where cust_name like 'B%';
#also
select *
from customer
where cust_name between 'A%' and 'C%';
#also
select *
from customer
where cust_name between 'A' and 'C';

#10. Write a SQL statement to find all those customers with all information whose names are ending with the letter 'n'.
select *
from customer
where cust_name like '%n';

#11. Write a SQL statement to find those salesmen with all information whose name containing the 1st character is 'N' and the 4th character is 'l' and rests may be any character.
select *
from salesman
where name like 'N__l%';

#12. Write a SQL statement to find those rows from the table testtable which contain the escape character underscore ( _ ) in its column 'col1'.  #RM:  underscore _ is a wildcard character.
select *
from testtable
where col1 like '%/_%' escape '/';
#RM:  Oracle SQl escape character http://www.dba-oracle.com/t_special_characters_like_sql_query.htm
/*
set escape '\'
select stuff
from mytable
where mycool like '%\_to\_%';
#also
select stuff
from mytable
where mycool like '%\_to\_%' escape '\';
*/

#13. Write a SQL statement to find those rows from the table testtable which does not contain the character underscore ( _ ) in its column 'col1'.
select *
from testtable
where col1 not like '%/_%' escape '/';

#14. Write a SQL statement to find those rows from the table testtable which contain the escape character ( / ) in its column 'col1'.
select *
from testtable
where col1 like '%//%' escape '/';

#15. Write a SQL statement to find those rows from the table testtable which does not contain the escape character ( / ) in its column 'col1'.
select *
from testtable
where col1 not like '%//%' escape '/';

#16. Write a SQL statement to find those rows from the table testtable which contain the string ( _/ ) in its column 'col1'.
select *
from testtable
where col1 like '%/_//%' escape '/';

#17. Write a SQL statement to find those rows from the table testtable which does not contain the string ( _/ ) in its column 'col1'.
select *
from testtable
where col1 not like '%/_//%' escape '/';

#18. Write a SQL statement to find those rows from the table testtable which contain the character ( % ) in its column 'col1'.
select *
from testtable
where col1 like '%/%%' escape '/';

#19. Write a SQL statement to find those rows from the table testtable which does not contain the character ( % ) in its column 'col1'.
select *
from testtable
where col1 not like '%/%%' escape '/';

#20. Write a SQL statement to find that customer with all information who does not get any grade except NULL.
select *
from customer
where grade is null;

#21. Write a SQL statement to find that customer with all information who gets a grade except NULL value.
select *
from customer
where grade is not null;

#22. Write a query in SQL to display all the data of employees whose last name begins with an 'D'.
select *
from emp_details
where emp_lname like 'D%';

#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#1. Write a SQL statement to find the total purchase amount of all orders.
select sum(purch_amt)
from orders;

#2. Write a SQL statement to find the average purchase amount of all orders.
select avg(purch_amt)
from orders;

#3. Write a SQL statement to find the number of salesmen currently listing for all of their customers.
select count(distinct salesman_id)
from orders;

#4. Write a SQL statement know how many customer have listed their names.  #RM:  assumption one customer per row.
select count(cust_name)
from customer;

#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance.
select count(grade)
from customer
where grade is not null;
#official solution
select count(all grade)
from customer;  #RM:  works for Oracle?

#6. Write a SQL statement to get the maximum purchase amount of all the orders.
select max(purch_amt)
from orders;

#7. Write a SQL statement to get the minimum purchase amount of all the orders.
select min(purch_amt)
from orders;

#8. Write a SQL statement which selects the highest grade for each of the cities of the customers.
select city, max(grade)
from customer
group by city;

#9. Write a SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.
select customer_id, max(purch_amt)
from orders
group by customer_id;

#10. Write a SQL statement to find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date;

#11. Write a SQL statement to find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.
select salesman_id, max(purch_amt)
from orders
where ord_date = '2018-08-07'
group by salesman_id;

#12. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000.  #RM:  find customers highest purchase amount greater than 2000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) > 2000;

#13. Write a SQL statement to find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) between 2000 and 6000;

#14. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount in a day is within the list 2000, 3000, 5760 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) in (2000, 3000, 5760, 6000);

#15. Write a SQL statement to find the highest purchase amount with their ID, for only those customers whose ID is within the range 3002 and 3007.
select customer_id, max(purch_amt)
from orders
where customer_id between 3002 and 3007
group by customer_id;

#16. Write a SQL statement to display customer details (ID and purchase amount) whose IDs are within the range 3002 and 3007 and highest purchase amount is more than 1000.
select customer_id, max(purch_amt)
from orders
where customer_id between 3002 and 3007
group by customer_id
having max(purch_amt) > 1000;

#17. Write a SQL statement to find the highest purchase amount with their ID, for only those salesmen whose ID is within the range 5003 and 5008.
select salesman_id, max(purch_amt)
from orders
where salesman_id between 5003 and 5008
group by salesman_id;

#18. Write a SQL statement that counts all orders for a date August 17th, 2012.
select count(*)
from orders
where ord_date = '2012-08-17';

#19. Write a SQL statement that count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified.
select city, count(*)
from salesman
group by city;

#20. Write a query that counts the number of salesmen with their order date and ID registering orders for each day.
select salesman_id, ord_date, count(*)
from orders
group by salesman_id, ord_date
order by salesman_id asc, ord_date desc;

#21. Write a SQL query to calculate the average price of all the products.
select avg(pro_price)
from item_mast;

#22. Write a SQL query to find the number of products with a price more than or equal to Rs.350.
select count(*)
from item_mast
where pro_price >= 350;

#23. Write a SQL query to display the average price of each company's products, along with their code.
select pro_com, avg(pro_price)
from item_mast
group by pro_com;
#also
select avg(pro_price), pro_com
from item_mast
group by pro_com;

#24. Write a query in SQL to find the sum of the allotment amount of all departments.
select sum(dpt_allotment)
from emp_department;

#25. Write a query in SQL to find the number of employees in each department along with the department code.
select emp_dept, count(*)
from emp_details
group by emp_dept;

#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php
#1. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.  #RM:  concatenate concat combine CONCAT() works for two arguments only.
select commission*100 || '%' as "Commission Percentage", salesman_id, name, city
from salesman;

#2. Write a SQL statement to find out the number of orders booked for each day and display it in such a format like "For 2001-10-10 there are 15 orders".
select 'For ' || ord_date || ' there are ' || count(*) || ' orders.' as "Orders"
from orders
group by ord_date
order by ord_date;

#3. Write a query to display the orders according to the order number arranged by ascending order.
select *
from orders
order by ord_no;

#4. Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates.
select *
from orders
order by ord_no desc;

#5. Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first.
select *
from orders
order by ord_no desc, purch_amt desc;

#6. Write a SQL statement to display the customer name, city, and grade, etc. and the display will be arranged according to the smallest customer ID.
select cust_name, city, grade
from orders
order by customer_id;

#7. Write a SQL statement to make a report with salesman ID, order date and highest purchase amount in such an arrangement that, the smallest salesman ID will come first along with their smallest order date.
select salesman_id, ord_date, max(purch_amt)
from orders
group by salesman_id, ord_date
order by salesman_id, ord_date;

#8. Write a SQL statement to display customer name, city and grade in such a manner that, the customer holding highest grade will come first.
select cust_name, city, grade
from orders
order by grade desc;

#9. Write a SQL statement to make a report with customer ID in such a manner that, the largest number of orders booked by the customer will come first along with their highest purchase amount.  #RM:  get number of orders per customer and get the maximum purchase amount per customer sort by number of orders per customer highest to smallest.
select customer_id, count(distinct ord_no) max(purch_amt)
from orders
group by customer_id
order by count(distinct ord_no) desc;

#10. Write a SQL statement to make a report with order date in such a manner that, the latest order date will come last along with the total purchase amount and total commission (15% for all salesmen) for that date.  #RM:  sum purchase amount per date and calculate the total commission which is 15% of purchase amount sort date earlest to latest.
select ord_date, sum(purch_amt), sum(purch_amt*15) as "Total Commission"
from orders
group by ord_date
order by ord_date;

#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#1. Write a query to find those customers with their name and those salesmen with their name and city who lives in the same city.
select cust_name, name, c.city
from customer c, salesman s
where c.salesman_id = s.salesman_id
and c.city = s.city; #incorrect, want to match customer city and salesmen city only.
#correct solution
select c.cust_name, s.name, c.city
from customer c, salesman s
where c.city = s.city;
#user solution
select c.cust_name, s.name, c.city
from customer c inner join salesman s
on c.city = s.city;

#2. Write a SQL statement to find the names of all customers along with the salesmen who works for them.
select c.cust_name, s.name
from customer c, salesman s
where c.salesman_id = s.salesman_id;

#3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
select o.*
from orders o inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on c.city <> s.city;  #incorrect.  Cartesian return.
select o.*
from orders o inner join customer c
and o.customer_id = c.customer_id
inner join salesman s
on s.salesman_id = c.salesman_id
and c.city <> s.city;    #incorrect.  Return nothing.
#official solution
select o.*
from salesman s, customer c, orders o
where c.city <> s.city
and o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;  #correct
#user solution
select o.*
from orders o inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on o.salesman_id = s.salesman_id
where c.city <> s.city;

#RM:  Review questions 1-3.  I need more practice on joins.
#4. Write a SQL statement that finds out each order number followed by the name of the customers who made the order.
select o.ord_no, c.cust_name
from orders o, customer c
where o.customer_id = c.customer_id;
#also
select o.ord_no, c.cust_name
from orders o join customer c
on o.customer_id = c.customer_id;

#5. Write a SQL statement that sorts out the customer and their grade who made an order. Each of the customers must have a grade and served by at least a salesman, who belongs to a city.
select c.cust_name, c.grade, o.ord_no
from customer c join orders o
on c.customer_id = o.customer_id
join salesman s
on c.salesman_id = s.salesman_id
where s.city is not null
and c.grade is not null;
#also
select c.cust_name, c.grade, o.ord_no
from customer c, orders o, salesman s
where c.customer_id = o.customer_id
and c.salesman_id = s.salesman_id
and s.city is not null
and c.grade is not null;

#6. Write a query that produces all customers with their name, city, salesman and commission, who served by a salesman and the salesman works at a rate of the commission within 12% to 14%.
select c.cust_name, c.city, s.name, s.commission
from customer c, salesman s
where c.salesman_id = s.salesman_id
and s.commission between 0.12 and 0.14;
#also
select c.cust_name, c.city, s.name, s.commission
from customer c join salesman s
on c.salesman_id = s.salesman_id
where s.commission between 0.12 and 0.14;

#7. Write a SQL statement that produces all orders with the order number, customer name, commission rate and earned commission amount for those customers who carry their grade is 200 or more and served by an existing salesman.
select c.cust_name, c.grade, s.name, s.commission, (s.commission*o.purch_amt) as "earned commission", o.ord_no
from customer c join salesman s
on c.salesman_id = s.salesman_id
join orders o
on c.customer_id = o.customer_id
where c.grade >= 200;
#also
select c.cust_name, c.grade, s.name, s.commission, (s.commission*o.purch_amt) as "earned commission", o.ord_no
from customer c, salesman s, orders o
where c.salesman_id = s.salesman_id
and c.customer_id = o.customer_id
and c.grade >= 200;

#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city.
select s.name, c.cust_name, c.city
from customer c, salesman s
where c.city = s.city;
#also
select s.name, c.cust_name, c.city
from customer c inner join salesman s
on c.city = s.city;

#2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000.
select o.ord_no, o.purch_amt, c.cust_name, c.city
from orders o, customer c
where o.customer_id = c.customer_id
and o.purch_amt between 500 and 2000;
#also
select o.ord_no, o.purch_amt, c.cust_name, c.city
from orders o join customer c
on o.customer_id = c.customer_id
where o.purch_amt between 500 and 2000;

#3. Write a SQL statement to know which salesman are working for which customer.
select s.name, c.cust_name
from customer c, salesman s
where c.salesman_id = s.salesman_id;

#4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%.
select c.cust_name, s.name, s.commission
from customer c join salesman s
on c.salesman_id = s.salesman_id
where s.commission > .12;

#5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12%.
select c.cust_name, c.city, s.name, s.city, s.commission
from customer c, salesman s
where c.salesman_id = s.salesman_id
and c.city <> s.city
and s.commission > .12;

#6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.
select o.ord_no, o.ord_date, o.purch_amt, c.cust_name, s.name, s.commission
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on o.salesman_id = s.salesman_id;

#7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
select o.*, c.*, s.*
from orders o, customer c, salesman s
where o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;  #RM:  printed all orders no duplicate matching columns from two or more tables
#official solution
select *
from orders
natural join customer
natural join salesman;  #user feedback:  Because NATURAL JOIN will compare ALL matched columns (with same column name), in this case both salesman_id and city will take into account, so that only 6 records are left, this is because city column has only three same cities: four records of NY, one London and one Paris.

#8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own.
select c.*, s.*
from customer c left join salesman s
on c.salesman_id = s.salesman_id
order by c.customer_id;

#9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own.
select c.*, s.*
from customer c, salesman s
where c.salesman_id >= s.salesman_id
order by c.customer_id;  #incorrect.  Returns a caratesian.
select c.*, s.*
from customer c left join salesman s
on c.salesman_id = s.salesman_id
where grade < 300
order by c.customer_id;  #correct

#10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from orders o right join customer c
on o.customer_id = c.customer_id
order by o.ord_date;

#11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission
from orders o right join customer c
on o.customer_id = c.customer_id
right join salesman s
on s.salesman_id = o.salesman_id
order by o.ord_date;
#also
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission
from orders o right join customer c
on o.customer_id = c.customer_id
right join salesman s
on o.salesman_id = s.salesman_id; #RM:  no difference in seoncd on statement "on s.salesman_id = o.salesman_id" and "on o.salesman_id = s.salesman_id"

#12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.
select s.name, c.cust_name
from salesman s left join customer c
on s.salesman_id = c.salesman_id
order by s.salesman_id;

#13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier.
select s.name, c.cust_name
from salesman s left join customer c
on s.salesman_id = c.salesman_id
left join orders o
on c.customer_id = o.customer_id;

#14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select s.name, c.cust_name
from salesman s left join customer c
on s.salesman_id = c.salesman_id
left join orders o
on c.customer_id = o.customer_id
where (o.purch_amt >= 2000
and c.grade is not null)
or o.purch_amt is null;

#15. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c left join orders o
on c.customer_id = o.customer_id;

#16. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c left join orders o
on c.customer_id = o.customer_id
where (grade is not null
and purch_amt is not null)
or (grade is null
and purch_amt is null);

#17. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa.
select *
from salesman s, customer c;
#official solution
select *
from salesman s cross join customer c

#18. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that customer who belongs to a city.  #RM:  copied solution
select *
from salesman s cross join customer c
where s.city is not null;

#19. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade.
select *
from salesman s cross join customer c
where s.city is not null
and c.grade is not null;

#20. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade.
select *
from salesman s cross join customer c
where s.city is not null
and c.grade is not null
and s.city <> c.city;

#21. Write a SQL query to display all the data from the item_mast, including all the data for each item's producer company.
select i.*, c.*
from company_mast c, item_mast i
where c.com_id = i.pro_com;

#22. Write a SQL query to display the item name, price, and company name of all the products.
select i.pro_name, i.pro_price, c.com_name
from company_mast c, item_mast i
where c.com_id = i.pro_com;

#23. Write a SQL query to display the average price of items of each company, showing the name of the company.
select c.com_name, avg(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name;

#24. Write a SQL query to display the names of the company whose products have an average price larger than or equal to Rs. 350.
select c.com_name, avg(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name
having avg(i.pro_price) >= 350;

#25. Write a SQL query to display the name of each company along with the ID and price for their most expensive product.
select c.com_name, max(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name;
#official solution
select c.com_name, i.pro_id, i.pro_name, i.pro_price
from company_mast c, item_mast i
where c.com_id = i.pro_com
and i.pro_price = (
	select max(i.pro_price)
	from item_mast i
	where i.pro_com = c.com_id);

#26. Write a query in SQL to display all the data of employees including their department.
select emp_details.*, emp_department.dpt_name
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code;

#27. Write a query in SQL to display the first name and last name of each employee, along with the name and sanction amount for their department.
select emp_details.emp_fname, emp_details.emp_lname, emp_department.dpt_name, emp_department.dpt_allotment
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code;

#28. Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000.
select emp_details.emp_fname, emp_details.emp_lname
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
and emp_department.dpt_allotment > 50000;

#29. Write a query in SQL to find the names of departments where more than two employees are working.
select emp_department.dpt_name, count(emp_details.emp_dept)
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
group by emp_details.emp_dept;  #returns nothing
select emp_department.dpt_name, count(emp_details.emp_dept)
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
group by emp_department.dpt_name
order by 2 desc;  #correct
select emp_department.dpt_name, count(emp_details.emp_dept)
from emp_details, emp_department
where emp_details.emp_dept = emp_department.dpt_code
group by emp_department.dpt_name
having count(emp_details.emp_dept) > 2
order by 2 desc;  #correct answering question

#https://www.w3resource.com/sql-exercises/subqueries/index.php
#1. Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
select *
from orders
where salesman_id = (
	select salesman_id
	from salesman
	where name = 'Paul Adam');
#also
select o.*
from orders o, salesman s
where o.salesman_id = s.salesman_id
and s.name = 'Paul Adam';

#2. Write a query to display all the orders for the salesman who belongs to the city London.
select *
from orders
where salesman_id in (
	select salesman_id
	from salesman
	where city = 'London');

#3. Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007.
select *
from orders
where salesman_id in (
	select salesman_id
	from orders
	where customer_id = 3007);

#4. Write a query to display all the orders which values are greater than the average order value for 10th October 2012.
select *
from orders
where purch_amt > (
	select avg(purch_amt)
	from orders
	where ord_date = '2012-10-10');

#5. Write a query to find all orders attributed to a salesman in New york.
select *
from orders
where salesman_id in (
	select salesman_id
	from salesman
	where city = 'New York');
#also
select o.*
from orders o, salesman s
where o.salesman_id = s.salesman_id
and s.city = 'New York';

#6. Write a query to display the commission of all the salesmen servicing customers in Paris.
select commission
from salesman
where salesman_id in (
	select salesman_id
	from customer
	where city = 'Paris');

#7. Write a query to display all the customers whose id is 2001 bellow the salesman ID of Mc Lyon.  #RM:  correction id is 2001 and salesman ID is less than salesman ID of Mc Lyon.
select *
from customer
where customer_id = 3001
and salesman_id <= (
	select salesman_id
	from salesman
	where name = 'Mc Lyon');

#8. Write a query to count the customers with grades above New York's average.
select count(*)
from customer
where grade > (
	select avg(grade)
	from customer
	where city = 'New York');
#question wants group-by grade which makes no sense
select grade, count (*)
from customer
group by grade
having grade > (
	select avg(grade)
	from customer
	where city = 'New York');

#9. Write a query to display all customers with orders on October 5, 2012.
select *
from customer
where customer_id in (
	select customer_id
	from orders
	where ord_date = '2012-10-05');
#also
select c.*
from customer c, orders o
where c.customer_id = o.customer_id
and o.ord_date = '2012-10-05';
#incorrect
select c.*
from customer c, orders o
where c.salesman_id = o.salesman_id
and o.ord_date = '2012-10-05';

#10. Write a query to display all the customers with orders issued on date 17th August, 2012.
select cust_name
from customer
where customer_id in (
	select customer_id
	from orders
	where ord_date = '2012-08-17');
#also
select cust_name
from customer c, orders o
where c.salesman_id = o.salesman_id
and o.ord_date = '2012-08-17';

#11. Write a query to find the name and numbers of all salesmen who had more than one customer.
select salesman_id, name
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) > 1);
#official solution
select salesman_id,name 
from salesman a 
where 1 < (
	select count(*)
	from customer 
	where salesman_id=a.salesman_id);
#also
select s.salesman_id, s.name 
from salesman s
where 1 < (
	select count(*)
	from customer c
	where c.salesman_id=s.salesman_id);

#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.
select *
from orders
where purch_amt > (
	select avg(purch_amt)
	from orders);
#official solution.  Find customer's orders above average for each customer
select * 
from orders a
where purch_amt > (
	select avg(purch_amt)
	from orders b
	where b.customer_id = a.customer_id);

#13. Write a queries to find all orders with order amounts which are on or above-average amounts for their customers
select * 
from orders a
where purch_amt >= (
	select avg(purch_amt)
	from orders b
	where b.customer_id = a.customer_id);

#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.
select ord_date, sum(purch_amt)
from orders a
group by ord_date
having sum(purch_amt) > (
	select max(purch_amt) + 1000
	from orders b
	where a.ord_date = b.ord_date);

#15. Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.  #RM:  if question.  If there is one or more customers from London, then print the entire customer table.
select *
from customer a
where 1 <= (
	select count(*)
	from customer b
	where a.customer_id = b.customer_id
	and b.city = 'London');  #returns all customers from London
#official solutions returns all the rows in customer table
select customer_id,cust_name, city
from customer
where exists (
	select *
	from customer 
	where city='London');
#another solution
select *
from customer a
where 2 >= (
	select count(*)
	from customer b
	where a.customer_id = b.customer_id
	and b.city = 'London');

#16. Write a query to find the salesmen who have multiple customers.
select s.name, c.salesman_id, count(c.salesman_id)
from customer c join salesman s
on c.salesman_id = s.salesman_id
group by s.name, c.salesman_id
having count(c.salesman_id) >= 2;
#user solution
select *
from salesman s
where 1 < (
	select count(*)
	from customer a
	where s.salesman_id = a.salesman_id);

#17. Write a query to find all the salesmen who worked for only one customer.
select *
from salesman s
where 1 = (
	select count(*)
	from customer a
	where s.salesman_id = a.salesman_id);

#18. Write a query that extract the rows of all salesmen who have customers with more than one orders.
select *
from salesman s
where 1 < (
	select count(customer_id)
	from orders o
	where s.salesman_id = o.salesman_id);

#19. Write a query to find salesmen with all information who lives in the city where any of the customers lives.
select distinct s.*
from salesman s, customer c
where s.city = c.city;  #it works
select *
from salesman
where salesman_id in (
	select s.salesman_id
	from salesman s, customer c
	where s.city = c.city);
#official solution
select *
from salesman
where city = any (
	select city
	from customer);

#20. Write a query to find all the salesmen for whom there are customers that follow them.
#some users says official solution is incorrect
select *
from salesman
where salesman_id in (
	select salesman_id
	from customer);
#another user solution
select s.*
from salesman s
where s.salesman_id in (
	select salesman_id
	from customer);

#21. Write a query to display the salesmen which name are alphabetically lower than the name of the customers.
#RM:  looked at solution
select *
from salesman a
where exists (
	select *
	from customer b
	where a.name < b.cust_name);

#22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.
select *
from customer
where grade > any (
	select grade
	from customer
	where city < 'New York');

#23. Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012.
select *
from orders
where purch_amt > any (
	select purch_amt
	from orders
	where ord_date = '2012-09-10');

#24. Write a query to find all orders with an amount smaller than any amount for a customer in London.
select *
from orders
where purch_amt < any (
	select o.purch_amt
	from orders o, customer c
	where o.customer_id = c.customer_id
	and c.city = 'London');

#25. Write a query to display all orders with an amount smaller than any amount for a customer in London.  #RM:  solution says dispaly all orders greater than the highest purchase amount in London.
select *
from orders
where purch_amt < (
	select max(o.purch_amt)
	from orders o, customer c
	where o.customer_id = c.customer_id
	and c.city = 'London');

#26. Write a query to display only those customers whose grade are, in fact, higher than every customer in New York.
select *
from customer
where grade > all (
	select grade
	from customer
	where city = 'New York');

#27. Write a query to find only those customers whose grade are, higher than every customer to the city New York.
select *
from customer
where grade > all (
	select grade
	from customer
	where city = 'New York');

#28. Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London.
select *
from customer
where grade <> any (
	select grade
	from customer
	where city = 'London');

#29. Write a query to find all those customers whose grade are not as the grade, belongs to the city Paris.
select *
from customer
where grade not in (
	select grade
	from customer
	where city = 'Paris');

#30. Write a query to find all those customers who hold a different grade than any customer of the city Dallas.
select *
from customer
where grade not in (
	select grade
	from customer
	where city = 'Dallas');

#31. Write a SQL query to find the average price of each manufacturer's products along with their name.
select company.com_name, avg(item.pro_price)
from item_mast item, company_mast company
where item.pro_com = company.com_id
group by company.com_name;

#32. Write a SQL query to display the average price of the products which is more than or equal to 350 along with their names.
select company.com_name, avg(item.pro_price)
from item_mast item, company_mast company
where item.pro_com = company.com_id
group by company.com_name
having avg(item.pro_price) >= 350;

#33. Write a SQL query to display the name of each company, price for their most expensive product along with their Name.
select company.com_name, max(item.pro_price)
from item_mast item, company_mast company
where item.pro_com = company.com_id
group by company.com_name;  #partially correct.  Need the product name matching the most expensive product.
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb
	where item.pro_id = itemb.pro_id);  #incorrect.  Returns all items.
select company.com_name, item.pro_name, item.pro_price
from item_mast item, company_mast company
where item.pro_com = company.com_id
and item.pro_price = (
	select max(itemb.pro_price)
	from item_mast itemb
	where itemb.pro_com = company.com_id
	group by itemb.pro_com);  #correct

#34. Write a query in SQL to find all the details of employees whose last name is Gabriel or Dosio.
select *
from emp_details
where emp_lname in ('Gabriel','Dosio');

#35. Write a query in SQL to display all the details of employees who works in department 89 or 63.
select *
from emp_details
where emp_dept in (89, 63);

#36. Write a query in SQL to display the first name and last name of employees working for the department which allotment amount is more than Rs.50000.
select *
from emp_details
where emp_dept in (
	select dpt_code
	from emp_department
	where dpt_allotment > 50000);
#also
select details.*
from emp_details details join emp_department department
on details.emp_dept = department.dpt_code
where department.dpt_allotment > 50000;

#37. Write a query in SQL to find the departments which sanction amount is larger than the average sanction amount of all the departments.
select *
from emp_department
where dpt_allotment > (
	select avg(dpt_allotment)
	from emp_department);

#38. Write a query in SQL to find the names of departments with more than two employees are working.
select *
from emp_department
where dpt_code in (
	select emp_dept
	from emp_details
	group by emp_dept
	having count(emp_dept) > 2);
#also
select *
from emp_department
where 2 < (
	select count(*)
	from emp_details
	where emp_department.dpt_code=emp_details.emp_dept);

#39. Write a query in SQL to find the first name and last name of employees working for departments which sanction amount is second lowest.
select *
from emp_details
where emp_dept in (
	select dpt_code from (
		select dpt_code, rank() over (order by dpt_allotment asc) rank from emp_department) neednamehere
		where rank = 2);
#user solution
select *
from emp_details
where emp_dept = (
	select dpt_code
	from emp_department
	order by dpt_allotment limit 1 offset 1);

#https://www.w3resource.com/sql-exercises/union/sql-union.php
#UNION operator shows only distinct rows, duplicate row appears once.  UNION ALL includes any duplicates when sets of data are added.
#The MINUS operator returns the difference between two sets. Effectively, you use it to subtract one set from another set.
#The INTERSECT operator determines the common values between two sets.
--Set Operators combine the result of more than one query and return as one result.  Queries that set operators used are called compound queries.  Except union all operator, duplicate rows are eliminated automatically.  The column headings on the results are from the first query or top query.
--Union returns rows of both queries eliminating duplicate rows.  Union All returns rows of both queries including duplicate rows.  Intersect returns rows which exist in both queries.  Minus returns rows which exist in first query, but not in the second query or return rows exist in first table and not second table.
/*
UNION ALL Returns all the rows retrieved by the queries, including duplicate rows
UNION Returns all non-duplicate rows retrieved by the queries
INTERSECT Returns rows that are retrieved by both queries
MINUS Returns the remaining rows when the rows retrieved by the second query are subtracted from the rows retrieved by the first query
*/
#1. Write a query to display all salesmen and customer located in London.
select name, salesman_id, 'Salesman'
from salesman
where city = 'London'
union
(select cust_name, customer_id, 'Customer'
from customer
where city = 'London');

#2. Write a query to display distinct salesman and their cities.
select salesman_id, city
from salesman
union
(select salesman_id, city
from customer);

#3. Write a query to display all the salesmen and customer involved in this inventory management system.
select customer_id, salesman_id
from orders
union
(select customer_id, salesman_id
from customer);

#4. Write a query to make a report of which salesman produce the largest and smallest orders on each date.
select s.name, o.purch_amt
from salesman s, orders o
where s.salesman_id = o.salesman_id
order by o.purch_amt asc limit 1 offset 0
union
(select s.name, o.purch_amt
from salesman s, orders o
where s.salesman_id = o.salesman_id
order by o.purch_amt desc limit 1 offset 0);  #RM: order by doesn't work.  Order By . . . limit 1 statement doesn't work in union.  Use subquery.
select s.name, o.purch_amt
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select min(purch_amt)
	from orders)
union
(select s.name, o.purch_amt
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select max(purch_amt)
	from orders));  #RM:  partially correct.  Smallest and largest orders all-time.
select s.name, o.purch_amt, 'highest on', o.ord_date
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select max(o2.purch_amt)
	from orders o2
	where o2.ord_date = o.ord_date)
union
(select s.name, o.purch_amt, 'lowest on', o.ord_date
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select min(o2.purch_amt)
	from orders o2
	where o2.ord_date = o.ord_date))
order by ord_date, purch_amt desc;  #RM:  correct.  Exclude the table alias at the order by statement.

#5. Write a query to make a report of which salesman produce the largest and smallest orders on each date and arranged the orders number in smallest to the largest number.
select o.ord_no, s.name, o.purch_amt, 'highest on', o.ord_date
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select max(o2.purch_amt)
	from orders o2
	where o2.ord_date = o.ord_date)
union
(select o.ord_no, s.name, o.purch_amt, 'lowest on', o.ord_date
from salesman s, orders o
where s.salesman_id = o.salesman_id
and o.purch_amt = (
	select min(o2.purch_amt)
	from orders o2
	where o2.ord_date = o.ord_date))
order by ord_no;  #RM:  Exclude the table alias at the order by statement.  Column in order by statement must be included in select statement.  And Order By . . . limit 1 statement doesn't work in union.  Use subquery.

#6. Write a query to list all the salesmen, and indicate those who do not have customers in their cities, as well as whose who do.
#official solution
select salesman.salesman_id, name, cust_name, commission
from salesman, customer
where salesman.city = customer.city
union
(select salesman_id, name, 'no match', commission
from salesman
where not city = any
	(select city
	from customer))
order by 2 desc;
#user solution
select s.salesman_id, name, s.city as "Salesman City", c.city as "Customer City", commission, customer_id
from salesman s join customer c
on s.city=c.city
union
(select s.salesman_id, name, 'NO MATCH', c.city as "Customer City", commission, customer_id
from salesman s join customer c
on s.salesman_id = c.salesman_id
and s.city<>c.city);

#7. Write a query to that appends strings to the selected fields, indicating whether or not a specified salesman was matched to a customer in his city.  #RM:  I don't understand the question.  Looked at solution.  Check all salesman in salesman table.  Do the salesman match their customer's city.  Yes or No, or Match or No Match.
#official solution incorrect
select s.salesman_id, s.name, s.city, 'Match'
from salesman s, customer c
where s.salesman_id = c.salesman_id
and s.city = c.city
union
(select s.salesman_id, s.name, s.city, 'No Match'
from salesman s
where not s.city = any (
	select c2.city
	from customer c2));
#user solution for which I was correct
select s.salesman_id, s.name, s.city, 'Match'
from salesman s join customer c
on s.city = c.city 
union
(select s.salesman_id, s.name, s.city,'NO MATCH'
from salesman s join customer c 
on s.salesman_id = c.salesman_id 
and s.city not in (
	select c2.city
	from customer c2));

#8. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words "High Rating", while the others will have the words "Low Rating".
select cust_name, city, grade, 'High Rating'
from customer
where grade >= 200
union
(select cust_name, city, grade, 'Low Rating'
from customer
where grade < 200);

#9. Write a command that produces the name and number of each salesman and each customer with more than one current order. Put the results in alphabetical order.
#customers with more than one order 3002, 3009, 3005
select c.customer_id, c.cust_name
from customer c
where c.customer_id in (
	select customer_id
	from orders
	group by customer_id
	having count(customer_id) > 1);
#salesman with more than one order 5002, 5003, 5001
select s.salesman_id, s.name
from salesman s
where s.salesman_id in (
	select salesman_id
	from orders
	group by salesman_id
	having count(salesman_id) > 1);
#union
select c.customer_id as "ID Number", c.cust_name as "Name", 'Customer'
from customer c
where c.customer_id in (
	select customer_id
	from orders
	group by customer_id
	having count(customer_id) > 1)
union
(select s.salesman_id, s.name, 'Salesman'
from salesman s
where s.salesman_id in (
	select salesman_id
	from orders
	group by salesman_id
	having count(salesman_id) > 1))
order by 2 asc;
