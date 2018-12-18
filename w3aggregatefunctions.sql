#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php

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
#1. Write a SQL statement to find the total purchase amount of all orders.
select sum(purch_amt)
from orders;

#2. Write a SQL statement to find the average purchase amount of all orders.
select avg(purch_amt)
from orders;

#3. Write a SQL statement to find the number of salesmen currently listing for all of their customers.
select count(distinct salesman_id)
from orders;

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
#4. Write a SQL statement know how many customer have listed their names.
select count(distinct cust_name)
from customer;
#official solution
select count(*)
from customer;

#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance
select count(*)
from customer
where grade is not null;
#official solution
select count(all grade) 
from customer;

#6. Write a SQL statement to get the maximum purchase amount of all the orders.
select max(purch_amt)
from orders;

#7. Write a SQL statement to get the minimum purchase amount of all the orders.
select min(purch_amt)
from orders;

#8. Write a SQL statement which selects the highest grade for each of the cities of the customers. 
select city, max(grade)
from orders
group by city;

#9. Write a SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.
select customer_id, max(purch_amt)
from orders
group by customer_id;

#10. Write a SQL statement to find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount.  RM:  strike out on a particular date
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date;

#11. Write a SQL statement to find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.  RM:  there are two salesman_id.
select salesman_id, max(purch_amt)
from orders
where ord_date = '2012-08-07'
group by salesman_id;

#12. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000.
select customer_id, ord_date, max(purch_amt)
from orders
where purch_amt > 2000
group by customer_id, ord_date;
#official solution
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) > 2000;

#13. Write a SQL statement to find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
where purch_amt >= 2000 and purch_amt <=6000
group by customer_id, ord_date;
#official solution
select customer_id, ord_date, max(purch_amt) 
from orders 
group by customer_id, ord_date 
having max(purch_amt) between 2000 and 6000;

#14. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount in a day is within the list 2000, 3000, 5760 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
where purch_amt in (2000, 3000, 5760, 6000)
group by customer_id, ord_date;
#official solution
select customer_id,ord_date,max(purch_amt) 
from orders 
group by customer_id,ord_date 
having max(purch_amt) in(2000 ,3000,5760, 6000);

#15. Write a SQL statement to find the highest purchase amount with their ID, for only those customers whose ID is within the range 3002 and 3007.
select customer_id, max(purch_amt)
from orders
where customer_id >=3002 and customer_id <=3007 #RM:  also where customer_id between 3002 and 3007 between inclusive for numbers
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
where ord_date = '2012-08-07';

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
#19. Write a SQL statement that count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified.
select city, count(*)
from salesman
where city is not null
group by city;
#official solution
select count(*)
from salesman
where city is not null;

#20. Write a query that counts the number of salesmen with their order date and ID registering orders for each day.
select ord_date, salesman_id, count(*)
from orders
group by ord_date, salesman_id;

/*
sample table: item_mast
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
*/
#21. Write a SQL query to calculate the average price of all the products.
select avg(pro_price) as "Average Price"
from item_mast;

#22. Write a SQL query to find the number of products with a price more than or equal to Rs.350.  RM:  price greater than or equal to 350.
select count(*) as "Number of Products"
from item_mast
where pro_price >= 350;

#23. Write a SQL query to display the average price of each company's products, along with their code.  RM:  average price for each pro_com or company's products
select avg(pro_price) as "Average Price", pro_com as "Company ID"
from item_mast
group by pro_com;

/*
Sample table: emp_department
DPT_CODE DPT_NAME        DPT_ALLOTMENT
-------- --------------- -------------
      57 IT                      65000
      63 Finance                 15000
      47 HR                     240000
      27 RD                      55000
      89 QC                      75000
*/
#24. Write a query in SQL to find the sum of the allotment amount of all departments.
select sum(dpt_allotment)
from emp_department;
#sum of the allotment amount for each departments by name
select dpt_name, sum(dpt_allotment)
from emp_department
group by dpt_name;

/*
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
*/
#25. Write a query in SQL to find the number of employees in each department along with the department code.  RM:  grouped by department code or emp_dept
select emp_dept, count(*)
from emp_details
group by emp_dept