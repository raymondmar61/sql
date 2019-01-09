#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php

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
#1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city.
select s.name, c.cust_name, s.city
from customer c join salesman s
on c.city = s.city;

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
#2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000.
select o.ord_no, o.purch_amt, c.cust_name, c.city
from orders o left outer join customer c
on o.customer_id = c.customer_id
where o.purch_amt between 500 and 2000;

#3. Write a SQL statement to know which salesman are working for which customer.
select s.name as "Salesman", c.cust_name as "Customer"
from customer c left outer join salesman s
on c.salesman_id = s.salesman_id;
#official solution
select a.cust_name as "customer name", a.city, b.name as "salesman", b.commission 
from customer a inner join salesman b 
on a.salesman_id=b.salesman_id;

#4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%.
select c.cust_name
from customer c left outer join salesman s
on c.salesman_id = s.salesman_id
where s.commission > 0.12;
#official solution
select a.cust_name as "customer name", a.city, b.name as "salesman", b.commission 
from customer a inner join salesman b 
on a.salesman_id=b.salesman_id 
where b.commission>.12;

#5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12%.
select c.cust_name
from customer c left outer join salesman s
on c.salesman_id = s.salesman_id
where c.city <> s.city
and s.commission > 0.12;

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
#6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.
select o.ord_no, o.ord_date, o.purch_amt, c.cust_name, s.name, s.commission
from orders o left outer join customer c
on o.customer_id = c.customer_id
left outer join salesman s
on c.salesman_id = s.salesman_id;

#7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
select o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id, c.cust_name, c.city, c.grade, s.name, s.city, s.commission
from orders o left outer join customer c
on o.customer_id = c.customer_id
left outer join salesman s
on c.salesman_id = s.salesman_id;
#official solution
select * 
from orders natural join customer
natural join salesman;

#8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own.
select c.cust_name, s.name
from customer c left outer join salesman s
on c.salesman_id = s.salesman_id
order by c.cust_name;

#9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own.
select c.cust_name, c.grade, s.name
from customer c left outer join salesman s
on c.salesman_id = s.salesman_id
where c.grade < 300
order by c.cust_name;

#10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c left outer join orders o
on c.customer_id = o.customer_id
order by o.ord_date;

#11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.  RM:  confusing question.  Last part want all orders and orders placed by salesman.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission
from customer c left outer join orders o
on c.customer_id = o.customer_id
left outer join salesman s
on o.salesman_id = s.salesman_id;

#12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.
select s.name, c.cust_name
from salesman s left outer join customer c
on s.salesman_id = c.salesman_id
order by s.name;
#official solution
select a.cust_name, a.city, a.grade, b.name as "salesman", b.city 
from customer a right outer join salesman b 
on b.salesman_id=a.salesman_id 
order by b.salesman_id;