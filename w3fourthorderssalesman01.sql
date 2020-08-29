#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php

#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#1. Write a SQL statement to display all the information of all salesmen.
select *
from salesman;

#2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".
select 'This is SQL Exercise, Practice and Solution';

#3. Write a query to display three numbers in three columns.
select 1, 2, 3;
#RM:  it doesn't work.  Query returned 3.

#4. Write a query to display the sum of two numbers 10 and 15 from RDMS sever.
select sum(10+15);
#or
select 10+15;

#5. Write a query to display the result of an arithmetic expression.
select 45-22;

#6. Write a SQL statement to display specific columns like name and commission for all the salesmen.
select name, commission
from salesman;

#7. Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders.
select ord_date, salesman_id, ord_no, purch_amt
from orders;

#8. Write a query which will retrieve the value of salesman id of all salesmen, getting orders from the customers in orders table without any repeats.  #RM:  just get distinct salesman ids.
select distinct salesman_id
from orders;

#9. Write a SQL statement to display names and city of salesman, who belongs to the city of Paris.
select name, city
from salesman
where city = 'Paris';

#10. Write a SQL statement to display all the information for those customers with a grade of 200.
select *
from customer
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
where year = 1971
and subject = 'Literature';

#14. Write a SQL query to display the year and subject that won 'Dennis Gabor' his prize.
select *
from nobel_win
where winner = 'Dennis Gabor';

#15. Write a SQL query to give the name of the 'Physics' winners since the year 1950.
select winner
from nobel_win
where subject = 'Physics'
and year >= 1950;

#16. Write a SQL query to Show all the details (year, subject, winner, country ) of the Chemistry prize winners between the year 1965 to 1975 inclusive.
select *
from nobel_win
where year between 1965 and 1975
and subject = 'Chemistry';

#17. Write a SQL query to show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin.
select *
from nobel_win
where winner in ('Menachem Begin','Yitzhak Rabin')
and year > 1972;

#18. Write a SQL query to show all the details of the winners with first name Louis.
select *
from nobel_win
where winner like 'Louis%';

#19. Write a SQL query to show all the winners in Physics for 1970 together with the winner of Economics for 1971.
select *
from nobel_win
where (subject = 'Physics' and year = 1970)
or (subject = 'Economics' and year = 1971);

#20. Write a SQL query to show all the winners of nobel prize in the year 1970 except the subject Physiology and Economics.
select *
from nobel_win
where year = 1970
and subject not in ('Physiology','Economics');

#21. Write a SQL query to show the winners of a 'Physiology' prize in an early year before 1971 together with winners of a 'Peace' prize in a later year on and after the 1974.
select *
from nobel_win
where (subject = 'Physiology' and year < 1971)
or (subject = 'Peace' and year >= 1974);

#22. Write a SQL query to find all details of the prize won by Johannes Georg Bednorz.
select *
from nobel_win
where winner = 'Johannes Georg Bednorz';

#23. Write a SQL query to find all the details of the nobel winners for the subject not started with the letter 'P' and arranged the list as the most recent comes first, then by name in order.
select *
from nobel_win
where subject not like 'P%'
order by year desc, winner asc;

#24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
select *
from nobel_win
where year = 1970
order by subject, winner;
#official solution
select *
from nobel_win
where year = 1970 
order by case
	when subject in ('Economics','Chemistry') then 1
	else 0 end asc, subject, winner;

#25. Write a SQL query to find all the products with a price between Rs.200 and Rs.600.
select *
from item_mast
where pro_price between 200 and 600;

#26. Write a SQL query to calculate the average price of all products of the manufacturer which code is 16.
select avg(pro_price)
from item_mast
where pro_com = 16;

#27. Write a SQL query to find the item name and price in Rs.
select pro_name, pro_price
from item_mast;

#28. Write a SQL query to display the name and price of all the items with a price is equal or more than Rs.250, and the list contain the larger price first and then by name in ascending order.
select *
from item_mast
where pro_price >= 250
order by pro_price desc, pro_name asc;

#29. Write a SQL query to display the average price of the items for each company, showing only the company code.
select pro_com, avg(pro_price)
from item_mast
group by pro_com;

#30. Write a SQL query to find the name and price of the cheapest item(s).
select *
from item_mast
where pro_price = (
	select min(pro_price)
	from item_mast);

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
where grade > 100
and city = 'New York';

#3. Write a SQL statement to display all customers, who are either belongs to the city New York or had a grade above 100.
select *
from customer
where grade > 100
or city = 'New York';

#4. Write a SQL statement to display all the customers, who are either belongs to the city New York or not had a grade above 100.
select *
from customer
where grade < 100
or city = 'New York';

#5. Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
select *
from customer
where grade < 100
or city <> 'New York';

#6. Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is 5005 and below or those orders which purchase amount is 1000.00 and below.
select *
from orders
where (ord_date <> '2012-09-10'
and salesman_id <= 5005)
or purch_amt <= 1000;

#7. Write a SQL statement to display salesman_id, name, city and commission who gets the commission within the range more than 0.10% and less than 0.12%.
select *
from salesman
where commission > 0.10 and commission < 0.12;

#8. Write a SQL query to display all orders where purchase amount less than 200 or exclude those orders which order date is on or greater than 10th Feb,2012 and customer id is below 3009.
select *
from orders
where purch_amt < 200 or (ord_date < '2012-o2-10' and customer_id >= 3009);

#9. Write a SQL statement to exclude the rows which satisfy 1) order dates are 2012-08-17 and purchase amount is below 1000 2) customer id is greater than 3005 and purchase amount is below 1000.
select *
from orders
where (ord_date <> '2012-08-17'and purch_amt >= 1000)
and 
(customer_id <= 3005 and purch_amt >= 1000);
#official solution
select * 
from orders 
where not ((ord_date ='2012-08-17' or customer_id > 3005)
and purch_amt < 1000);

#10. Write a SQL query to display order number, purchase amount, achieved, the unachieved percentage for those order which exceeds the 50% of the target value of 6000.  RM:  confusing
#official solution
select ord_no, purch_amt, (100*purch_amt)/6000 as "Achieved %", (100*(6000-purch_amt)/6000) as "Unachieved %" 
from orders 
where (100*purch_amt)/6000>50;

#11. Write a query in SQL to find the data of employees whose last name is Dosni or Mardy.
select *
from emp_details
where emp_lname in ('Dosni','Mardy');

#12. Write a query in SQL to display all the data of employees that work in department 47 or department 63.
select *
from emp_details
where emp_dept in (47,63);

#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#1. Write a SQL statement to find those salesmen with all information who come from the city either Paris or Rome.
select *
from salesman
where city in ('Paris','Rome');

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
from customer
where customer_id in (3007,3008,3009);

#5. Write a SQL statement to find those salesmen with all information who gets the commission within a range of 0.12 and 0.14.
select *
from salesman
where commission is between 0.12 and 0.14;

#6. Write a query to filter all those orders with all information which purchase amount value is within the range 500 and 4000 except those orders of purchase amount value 948.50 and 1983.43.
select *
from orders
where (purch_amt > 500 and purch_amt < 4000)
and purch_amt not in (948.50,1983.43);
#also
select *
from orders
where (purch_amt > 500 and purch_amt < 4000)
and (purch_amt <> 948.50 and purch_amt <> 1983.43);  #RM:  does work
#and (purch_amt <> 948.50 or purch_amt <> 1983.43);  #RM:  doesn't work.

#7. Write a SQL statement to find those salesmen with all other information and name started with any letter within 'A' and 'K'.  #RM:  Name between A and K inclusive
select *
from salesman
where name between 'A' and 'K';

#8. Write a SQL statement to find those salesmen with all other information and name started with other than any latter within 'A' and 'L'.  #RM:  Name between A and K inclusive
select *
from salesman
where name not between 'A' and 'L';

#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from salesman
where cust_name like 'B%';

#10. Write a SQL statement to find all those customers with all information whose names are ending with the letter 'n'.
select *
from customer
where cust_name like '%n';

#11. Write a SQL statement to find those salesmen with all information whose name containing the 1st character is 'N' and the 4th character is 'l' and rests may be any character.
select *
from salesman
where name like 'N__l%';

#12. Write a SQL statement to find those rows from the table testtable which contain the escape character underscore ( _ ) in its column 'col1'.
select *
from testtable
where col1 like '%\_%';
#official solution
select *
from testtable
where col1 like '%/_%' escape '/';

#13. Write a SQL statement to find those rows from the table testtable which does not contain the character underscore ( _ ) in its column 'col1'.
select *
from testtable
where col1 not like '%\_%';
#official solution
select *
from testtable
where col1 not like '%/_%' escape '/';

#14. Write a SQL statement to find those rows from the table testtable which contain the escape character ( / ) in its column 'col1'.

#15. Write a SQL statement to find those rows from the table testtable which does not contain the escape character ( / ) in its column 'col1'.

#16. Write a SQL statement to find those rows from the table testtable which contain the string ( _/ ) in its column 'col1'.

#17. Write a SQL statement to find those rows from the table testtable which does not contain the string ( _/ ) in its column 'col1'. 

#18. Write a SQL statement to find those rows from the table testtable which contain the character ( % ) in its column 'col1'.

#19. Write a SQL statement to find those rows from the table testtable which does not contain the character ( % ) in its column 'col1'.

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

#3. Write a SQL statement to find the number of salesmen currently listing for all of their customers.  #RM:  count the number of salesmen.
select count(distinct salesman_id)
from orders;

#4. Write a SQL statement know how many customer have listed their names.
select count(cust_name)
from customer;

#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance.
select count(grade)
from customer;

#6. Write a SQL statement to get the maximum purchase amount of all the orders.
select max(purch_amt)
from customer;

#7. Write a SQL statement to get the minimum purchase amount of all the orders.
select min(purch_amt)
from customer;

#8. Write a SQL statement which selects the highest grade for each of the cities of the customers.
select city, max(grade)
from customer
group by city;

#9. Write a SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.
select customer_id, max(purch_amt)
from orders
group by customer_id
order by customer_id;

#10. Write a SQL statement to find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount.  #RM:  question is highest purchase by customer id and by date
select customer_id, ord_date, max(purch_amt)
from orders
group by customer, ord_date;
#bonus highest customer purchase include all information
select *
from orders
where purch_amt in (
	select max(purch_amt)
	from orders
	group by customer_id); #incorrect
select *
from orders mainorders
where purch_amt in (
	select max(purch_amt)
	from orders
	where mainorders.customer_id = orders.customer_id
	group by customer_id);

#11. Write a SQL statement to find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.  #RM:  analysis paralysis.  Find the highest purchase maount group by salesman on 08/17/2012.
select salesman_id, max(purch_amt)
from orders
where ord_date = '2012-08-17'
group by salesman_id;
#all information returned
select *
from orders mainorders
where purch_amt = (
	select max(suborders.purch_amt)
	from orders suborders
	where suborders.ord_date = '2012-08-17'
	and mainorders.salesman_id = suborders.salesman_id
	group by suborders.salesman_id);

#12. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) > 2000;

#13. Write a SQL statement to find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) > 2000
and max(purch_amt) < 6000;

#14. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount in a day is within the list 2000, 3000, 5760 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) in (2000,3000,5760,6000);

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

#19. Write a SQL statement that count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified.  #RM:  I answered the question count salesman by city.
select count(*)
from salesman
where city is not null;
select city, count(*)
from salesman
group by city;

#20. Write a query that counts the number of salesmen with their order date and ID registering orders for each day.
select salesman_id, ord_date, count(*)
from orders
group by salesman_id, ord_date;

#21. Write a SQL query to calculate the average price of all the products.
select avg(pro_price)
from item_mast;

#22. Write a SQL query to find the number of products with a price more than or equal to Rs.350.
select count(*)
from item_mast
where pro_price >=350;

#23. Write a SQL query to display the average price of each company's products, along with their code.
select pro_com, avg(pro_price)
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
#1. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.
select salesman_id, name, city, commission || '%' as "commission%", concat(commission*100,'%') as "concat"
from salesman;

#2. Write a SQL statement to find out the number of orders booked for each day and display it in such a format like "For 2001-10-10 there are 15 orders".
select ord_date, count(ord_date), 'For ' || ord_date || ' there are ' || count(ord_date) || ' orders.' as "Multiple counts"
from orders
group by ord_date;

#3. Write a query to display the orders according to the order number arranged by ascending order.
select *
from orders
order by ord_no asc;

#4. Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates.
select *
from orders
order by ord_date desc;

#5. Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first.
select *
from orders
order by ord_date asc, purch_amt desc;

#6. Write a SQL statement to display the customer name, city, and grade, etc. and the display will be arranged according to the smallest customer ID.
select *
from customer
order by customer_id;

#7. Write a SQL statement to make a report with salesman ID, order date and highest purchase amount in such an arrangement that, the smallest salesman ID will come first along with their smallest order date.  #RM:  Find the salesman's highest purchase amount for each date.  Sort by salesman_id lowest to highest and then order date earlest to latest.
select *
from orders
order by salesman_id, ord_date;
#correction
select salesman_id, ord_date, max(purch_amt)
from orders
group by salesman_id, ord_date
order by salesman_id, ord_date;

#8. Write a SQL statement to display customer name, city and grade in such a manner that, the customer holding highest grade will come first.
select *
from customer
group by grade desc;

#9. Write a SQL statement to make a report with customer ID in such a manner that, the largest number of orders booked by the customer will come first along with their highest purchase amount.
select customer_id, count(customer_id), max(purch_amt)
from orders
group by customer_id
order by 2 desc;

#10. Write a SQL statement to make a report with order date in such a manner that, the latest order date will come last along with the total purchase amount and total commission (15% for all salesmen) for that date.  #RM:  total the orders by date ascending earliest to latest and total the commission 15%
select *, round(purch_amt*.15,2) as "Total commission 15%"
from orders
order by ord_date, purch_amt;
#correction
select ord_date, sum(purch_amt), round(sum(purch_amt)*.15,2) as "Total commission 15%"
from orders
group by ord_date
order by ord_date asc;