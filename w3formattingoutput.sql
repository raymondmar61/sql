#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php

/*
Sample table : salesman
salesman_id  name        city        commission
-----------  ----------  ----------  ----------
5001         James Hoog  New York    0.15
5002         Nail Knite  Paris       0.13
5005         Pit Alex    London      0.11
5006         Mc Lyon     Paris       0.14
5003         Lauson Hen              0.12
5007         Paul Adam   Rome        0.13
*/
#1. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.  RM:  answer wants no decimal.  It's 15.00% not .15.
select salesman_id, name, city, (commission*100) || '%' as "commission"
from salesman;
#solution is misleading
select salesman_id,name,city,'%',commission*100
from salesman;

/*
Sample table : orders
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
*/
#2. Write a SQL statement to find out the number of orders booked for each day and display it in such a format like "For 2001-10-10 there are 15 orders".
select ord_date, 'For ' || ord_date || ' there are ' || count(*) || ' orders.' as "total orders per day"
from orders
group by ord_date; #RM:  don't need ord_date as first column.

#3. Write a query to display the orders according to the order number arranged by ascending order.
select *
from orders
order by ord_no asc; #RM:  asc is optional.  asc is default.

#4. Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates.
select *
from orders
order by ord_no desc;

#5. Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first.
select *
from orders
order by ord_no, purch_amt desc;

/*
Sample table: customer
customer_id  cust_name     city        grade       salesman_id
-----------  ------------  ----------  ----------  -----------
3002         Nick Rimando  New York    100         5001
3005         Graham Zusi   California  200         5002
3001         Brad Guzan    London                  5005
3004         Fabian Johns  Paris       300         5006
3007         Brad Davis    New York    200         5001
3009         Geoff Camero  Berlin      100         5003
3008         Julian Green  London      300         5002
3003         Jozy Altidor  Moscow      200         5007
*/
#6. Write a SQL statement to display the customer name, city, and grade, etc. and the display will be arranged according to the smallest customer ID.
select cust_name, city, grade
from customer
order by customer_id;

#7. Write a SQL statement to make a report with salesman ID, order date and highest purchase amount in such an arrangement that, the smallest salesman ID will come first along with their smallest order date.
select salesman_id, ord_date, purch_amt
from orders
order by salesman_id, ord_date;
#solution  RM:  I don't understand the answer to the question.
select salesman_id,ord_date,max(purch_amt)
from orders
group by salesman_id,ord_date
order by salesman_id,ord_date

#8. Write a SQL statement to display customer name, city and grade in such a manner that, the customer holding highest grade will come first.
select cust_name, city, grade
from customer
order by cust_name, grade desc;

#9. Write a SQL statement to make a report with customer ID in such a manner that, the largest number of orders booked by the customer will come first along with their highest purchase amount.
select customer_id, count(ord_no), max(purch_amt)
from orders
group by customer_id
order by count(ord_no) desc, max(purch_amt) desc; #RM:  order by 2 desc, 3 desc; also works

#10. Write a SQL statement to make a report with order date in such a manner that, the latest order date will come last along with the total purchase amount and total commission (15% for all salesmen) for that date.
select ord_date, purch_amt, (purch_amt*.15) as "total commission"
from orders
order by ord_date;
#solution RM:  group by ord_date for that date.  The last three words in the question.
select ord_date, sum(purch_amt), sum(purch_amt)*.15
from orders
group by ord_date
order by ord_date;