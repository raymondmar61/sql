#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php
#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
/*
Sample table: salesman
 salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14
        5007 | Paul Adam  | Rome     |       0.13
        5003 | Lauson Hen | San Jose |       0.12
Sample table: orders
ord_no      purch_amt   ord_date    customer_id  salesman_id
----------  ----------  ----------  -----------  -----------
70001       150.5       2012-10-05  3005         5002
70009       270.65      2012-09-10  3001         5005
70002       65.26       2012-10-05  3002         5001
70004       110.5       2012-08-17  3009         5003
70007       948.5       2012-09-10  3005         5002
70005       2400.6      2012-07-27  3007         5001
70008       5760        2012-09-10  3002         5001
70010       1983.43     2012-10-10  3004         5006
70003       2480.4      2012-10-10  3009         5003
70012       250.45      2012-06-27  3008         5002
70011       75.29       2012-08-17  3003         5007
70013       3045.6      2012-04-25  3002         5001
Sample table: customer
 customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
        3004 | Fabian Johnson | Paris      |   300 |        5006
        3009 | Geoff Cameron  | Berlin     |   100 |        5003
        3003 | Jozy Altidor   | Moscow     |   200 |        5007
        3001 | Brad Guzan     | London     |       |        5005
Sample table: nobel_win
YEAR SUBJECT                   WINNER                                        COUNTRY                CATEGORY
---- ------------------------- --------------------------------------------- ------------------------- ------------
1970 Physics                   Hannes Alfven                                 Sweden                 Scientist
1970 Physics                   Louis Neel                                    France                 Scientist
1970 Chemistry                 Luis Federico Leloir                          France                 Scientist
1970 Physiology                Ulf von Euler                                 Sweden                 Scientist
1970 Physiology                Bernard Katz                                  Germany                Scientist
1970 Literature                Aleksandr Solzhenitsyn                        Russia                 Linguist
1970 Economics                 Paul Samuelson                                USA                    Economist
1970 Physiology                Julius Axelrod                                USA                    Scientist
1971 Physics                   Dennis Gabor                                  Hungary                Scientist
1971 Chemistry                 Gerhard Herzberg                              Germany                Scientist
1971 Peace                     Willy Brandt                                  Germany                Chancellor
1971 Literature                Pablo Neruda                                  Chile                  Linguist
1971 Economics                 Simon Kuznets                                 Russia                 Economist
1978 Peace                     Anwar al-Sadat                                Egypt                  President
1978 Peace                     Menachem Begin                                Israel                 Prime Minister
1987 Chemistry                 Donald J. Cram                                USA                    Scientist
1987 Chemistry                 Jean-Marie Lehn                               France                 Scientist
1987 Physiology                Susumu Tonegawa                               Japan                  Scientist
1994 Economics                 Reinhard Selten                               Germany                Economist
1994 Peace                     Yitzhak Rabin                                 Israel                 Prime Minister
1987 Physics                   Johannes Georg Bednorz                        Germany                Scientist
1987 Literature                Joseph Brodsky                                Russia                 Linguist
1987 Economics                 Robert Solow                                  USA                    Economist
1994 Literature                Kenzaburo Oe                                  Japan                  Linguist
Sample table: item_mast
 PRO_ID PRO_NAME                   PRO_PRICE    PRO_COM
------- ------------------------- ---------- ----------
    101 Mother Board                    3200         15
    102 Key Board                        450         16
    103 ZIP drive                        250         14
    104 Speaker                          550         16
    105 Monitor                         5000         11
    106 DVD drive                        900         12
    107 CD drive                         800         12
    108 Printer                         2600         13
    109 Refill cartridge                 350         13
    110 Mouse                            250         12
Sample table: emp_details
 EMP_IDNO EMP_FNAME       EMP_LNAME         EMP_DEPT
--------- --------------- --------------- ----------
   127323 Michale         Robbin                  57
   526689 Carlos          Snares                  63
   843795 Enric           Dosio                   57
   328717 Jhon            Snares                  63
   444527 Joseph          Dosni                   47
   659831 Zanifer         Emily                   47
   847674 Kuleswar        Sitaraman               57
   748681 Henrey          Gabriel                 47
   555935 Alex            Manuel                  57
   539569 George          Mardy                   27
   733843 Mario           Saule                   63
   631548 Alan            Snappy                  27
   839139 Maria           Foster                  57
Sample table: emp_department
DPT_CODE DPT_NAME        DPT_ALLOTMENT
-------- --------------- -------------
      57 IT                      65000
      63 Finance                 15000
      47 HR                     240000
      27 RD                      55000
      89 QC                      75000
Sample table: testtable
col1
--------------------------
A001/DJ-402\44_/100/2015
A001_\DJ-402\44_/100/2015
A001_DJ-402-2014-2015
A002_DJ-401-2014-2015
A001/DJ_401
A001/DJ_402\44
A001/DJ_402\44\2015
A001/DJ-402%45\2015/200
A001/DJ_402\45\2015%100
A001/DJ_402%45\2015/300
A001/DJ-402\44
*/

#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#1. Write a SQL statement to display all the information of all salesmen.
select *
from salesman;

#2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".
/*
columnname
This is SQL Exercise, Practice and Solution
*/
select 'This is SQL Exercise, Practice and Solution' as "columnname"
from salesman;

#3. Write a query to display three numbers in three columns.
/*
column 40	column 11	column 100
40	11	100
*/
select 40 as "column 40", 11 as "column 11", 100 as "column 100"
from salesman;

#4. Write a query to display the sum of two numbers 10 and 15 from RDMS sever.
select 10+15 as "addition"
from salesman;

#5. Write a query to display the result of an arithmetic expression.
select 10 + 15 - 5 * 2
from salesman;  #RM: returns 15

#6. Write a SQL statement to display specific columns like name and commission for all the salesmen.
select name, commission
from salesman;

#7. Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders.
select ord_date, salesman_id, ord_no, purch_amt
from orders;

#8. Write a query which will retrieve the value of salesman id of all salesmen, getting orders from the customers in orders table without any repeats.    #RM:  list all salesman_id without repeats
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
select year, subject
from nobel_win
where winner = 'Dennis Gabor';

#15. Write a SQL query to give the name of the 'Physics' winners since the year 1950.
select winner
from nobel_win
where subject = 'Physics'
and year >= 1950;

#16. Write a SQL query to Show all the details (year, subject, winner, country ) of the Chemistry prize winners between the year 1965 to 1975 inclusive.  #RM:  between statement is inclusive between statement.
select *
from nobel_win
where subject = 'Chemistry'
and year between 1965 and 1975;

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
where (subject in ('Physiology') and year < 1971)
or (subject = 'Peace' and year >= 1974);

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
where pro_price between 200 and 600;

#26. Write a SQL query to calculate the average price of all products of the manufacturer which code is 16.
select avg(pro_price)
from item_mast
where pro_com = 16;

#27. Write a SQL query to find the item name and price in Rs.
select pro_name, pro_price
from item_mast;

#28. Write a SQL query to display the name and price of all the items with a price is equal or more than Rs.250, and the list contain the larger price first and then by name in ascending order.
select pro_name, pro_price
from item_mast
where pro_price >= 250
order by pro_price desc, name asc;

#29. Write a SQL query to display the average price of the items for each company, showing only the company code.  #RM:  average price for each company code.
select pro_com, avg(pro_price)
from item_mast
group by pro_com;

#30. Write a SQL query to find the name and price of the cheapest item(s).
select pro_name, pro_price
from item_mast
where pro_price = (
	select min(pro_price)
	from item_mast);
#also
select *
from item_mast
order by pro_price asc limit 1;  #RM:  partially correct.  There are two items priced cheapest.

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
or grade <= 100;  #RM:  incorrect.  It's a neither nor.  It appears first SQL is incorrect.
select *
from customer
where not (city = 'New York' or grade > 100);  #RM:  correct.  It's neither nor.

#6. Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is 505 and below or those orders which purchase amount is 1000.00 and below.
select *
from orders
where (ord_date <> '2012-09-10' and salesman_id <= 505)
or purch_amt < 1000;
#official solution
select * 
from  orders 
where not ((ord_date ='2012-09-10' and salesman_id > 505)
or purch_amt > 1000.00);

#7. Write a SQL statement to display salesman_id, name, city and commission who gets the commission within the range more than 0.10% and less than 0.12%.
select *
from salesman
where commission > 0.10 and commission < 0.12;

#8. Write a SQL query to display all orders where purchase amount less than 200 or exclude those orders which order date is on or greater than 10th Feb,2012 and customer id is below 3009.
select *
from orders
where (purch_amt < 200 or ord_date < '2012-02-10')
and customer_id < 3009;

#9. Write a SQL statement to exclude the rows which satisfy 1) order dates are 2012-08-17 and purchase amount is below 1000 2) customer id is greater than 3005 and purchase amount is below 1000.
select *
from orders
where (ord_date <> '2012-08-17' and purch_amt >= 1000)
and (customer_id <= 3005 and purch_amt >= 1000);


#10. Write a SQL query to display order number, purchase amount, achieved, the unachieved percentage for those order which exceeds the 50% of the target value of 6000.#RM:  looked at solution.  #RM:  dumb question
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
where city = 'Paris'
or city = 'Rome';

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
where commission between 0.12 and 0.14;

#6. Write a query to filter all those orders with all information which purchase amount value is within the range 500 and 4000 except those orders of purchase amount value 948.50 and 1983.43.
select *
from orders
where purch_amt between 500 and 4000
and purch_amt not in (948.50, 1983.43);

#7. Write a SQL statement to find those salesmen with all other information and name started with any letter within 'A' and 'K'.  #RM:  find name starting with the letters between A and K.
select *
from salesman
where name between like 'A%' and like 'K%';  #does it work?  No.  It appears like is invalid.
select *
from salesman
where name between 'A%' and 'K%';  #does it work?  Yes.  Like is invalid.  Exclude in between statement.
#official solution
select *
from salesman
where name between 'A' and 'K';
#oracle solution? from user
select *
from salesman
where name like '[a-k]%';

#8. Write a SQL statement to find those salesmen with all other information and name started with other than any latter within 'A' and 'L'. 
select *
from salesman
where name not between 'A%' and 'L%';  #RM:  Like is invalid.  Exclude in between statement.

#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from customer
where cust_name like 'B%';

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
where col1 like '%/_//%' escape '/'; #RM:  need two escape /.  One for the _.  Second for the /.

#17. Write a SQL statement to find those rows from the table testtable which does not contain the string ( _/ ) in its column 'col1'.
select *
from testtable
where col1 not like '%/_//%' escape '/'; #RM:  need two escape /.  One for the _.  Second for the /.

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
select count(name)
from salesman;

#4. Write a SQL statement know how many customer have listed their names.
select count(cust_name)
from customer;

#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance.
select count(grade)
from customer
where grade is not null;

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
where ord_date = '2012-08-17'
group by salesman_id;

#12. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000.
select ord_date, ord_no, max(purch_amt)
from orders
group by ord_date, ord_no
having max(purch_amt) > 2000;
#official solution
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
select customer_id, max(purch_amt)
from orders
where salesman_id between 5003 and 5008
group by customer_id;

#18. Write a SQL statement that counts all orders for a date August 17th, 2012.
select count(*)
from orders
where ord_date = '2012-08-17';

#19. Write a SQL statement that count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified.
select city, count(city)
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

#23. Write a SQL query to display the average price of each company's products, along with their code.  #RM:  code is pro_com
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
select commission*100 || '%' as "Commission Percentage double quote", salesman_id, name, city
from salesman;

#2. Write a SQL statement to find out the number of orders booked for each day and display it in such a format like "For 2001-10-10 there are 15 orders".
select 'For ' || ord_date || ' there are ' || count(*) || ' orders.' as "Orders"
from orders
group by ord_date
order by ord_date;
#SQL code below doesn't work.  Returns second column only such as 2 orders and 1 orders.
select 'For ' || ord_date || ' there are ', count(*) || ' orders.'
from orders
group by ord_date;

#3. Write a query to display the orders according to the order number arranged by ascending order.
select *
from orders
order by ord_no;

#4. Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates.
select *
from orders
order by ord_date desc;

#5. Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first.
select *
from orders
order by ord_date asc, purch_amt desc;

#6. Write a SQL statement to display the customer name, city, and grade, etc. and the display will be arranged according to the smallest customer ID.
select cust_name, city, grade
from customer
order by customer_id;

#7. Write a SQL statement to make a report with salesman ID, order date and highest purchase amount in such an arrangement that, the smallest salesman ID will come first along with their smallest order date.
select salesman_id, ord_date, max(purch_amt)
from orders
order by salesman_id, ord_date;

#8. Write a SQL statement to display customer name, city and grade in such a manner that, the customer holding highest grade will come first.
select cust_name, city, grade
from customer
order by grade desc;

#9. Write a SQL statement to make a report with customer ID in such a manner that, the largest number of orders booked by the customer will come first along with their highest purchase amount.  #RM:  multiple aggregate multiple aggregate functions
select customer_id, count(*), max(purch_amt)
from orders
group by customer_id
order by count(*) desc;

#10. Write a SQL statement to make a report with order date in such a manner that, the latest order date will come last along with the total purchase amount and total commission (15% for all salesmen) for that date.
select ord_date, sum(purch_amt), sum(purch_amt*.15) as "total commission 15%"
from orders
group by ord_date
order by ord_date;

#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#1. Write a query to find those customers with their name and those salesmen with their name and city who lives in the same city.
select c.cust_name, s.name
from customers c join salesman s
on c.salesman_id = s.salesman_id
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
from customers c join salesman s
on c.salesman_id = s.salesman_id;
#also
select c.cust_name, s.name
from customer c, salesman s
where c.salesman_id = s.salesman_id;

#3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
select o.*
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on s.salesman_id = c.salesman_id
and s.city <> c.city;  #incorrect.  Return nothing.
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

#4. Write a SQL statement that finds out each order number followed by the name of the customers who made the order.
select o.ord_no, c.cust_name
from orders o join customer c
on o.customer_id = c.customer_id;
#also
select o.ord_no, c.cust_name
from orders o, customer c
where o.customer_id = c.customer_id;

#5. Write a SQL statement that sorts out the customer and their grade who made an order. Each of the customers must have a grade and served by at least a salesman, who belongs to a city.
select c.cust_name, c.grade, s.name
from customer c join orders o
on c.customer_id = o.customer_id
join salesman_id s
on s.salesman_id = o.salesman_id
and s.city is not null
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
from customer c join salesman s
on c.salesman_id = s.salesman_id
where commission between 0.12 and 0.14;
#also
select c.cust_name, c.city, s.name, s.commission
from customer c, salesman s
where c.salesman_id = s.salesman_id
and s.commission between 0.12 and 0.14;

#7. Write a SQL statement that produces all orders with the order number, customer name, commission rate and earned commission amount for those customers who carry their grade is 200 or more and served by an existing salesman.
select o.ord_no, c.cust_name, s.commission, (s.commission*o.purch_amt) as "Earned Commission"
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on s.salesman_id = c.salesman_id
where c.grade >= 200;
#also
select c.cust_name, c.grade, s.name, s.commission, (s.commission*o.purch_amt) as "earned commission", o.ord_no
from customer c, salesman s, orders o
where c.salesman_id = s.salesman_id
and c.customer_id = o.customer_id
and c.grade >= 200;