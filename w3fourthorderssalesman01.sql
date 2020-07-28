#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php

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