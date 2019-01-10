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

#13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier.
select s.name, o.ord_no
from salesman s left outer join customer c
on s.salesman_id = c.salesman_id
left outer join orders o
on c.customer_id = o.customer_id;
#official solution
select a.cust_name, a.city, a.grade, b.name as "salesman", c.ord_no, c.ord_date, c.purch_amt 
from customer a right outer join salesman b 
on b.salesman_id=a.salesman_id 
right outer join orders c 
on c.customer_id=a.customer_id;

#14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select s.name, o.ord_no
from salesman s left outer join customer c
on s.salesman_id = c.salesman_id
left outer join orders o
on c.customer_id = o.customer_id
where o.purch_amt >=2000 and c.grade is not null;
#official solution
select a.cust_name, a.city, a.grade, b.name as "salesman", c.ord_no, c.ord_date, c.purch_amt 
from customer a right outer join salesman b 
on b.salesman_id=a.salesman_id 
left outer join orders c on c.customer_id=a.customer_id 
where c.purch_amt>=2000 and a.grade is not null;

#15. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c right outer join orders o
on c.customer_id = o.customer_id;

#16. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders, or which order(s) have been placed by the customer who is neither in the list not have a grade.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c full outer join orders o
on c.customer_id = o.customer_id
where c.grade is not null;
/* full outer join retrives all the columns or matching rows from both tables and nulls for the unmatched rows of both tables.  The union of left and router outer joins and unmatched rows of both tables are returned. */

#17. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa.
select s.name, c.cust_name
from salesman s cross join customer c;

#18. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for that customer who belongs to a city.  RM:  confusing on city.  Official solution says print the salesman's city.
select s.name, c.cust_name
from salesman s cross join customer c
where s.city is not null;

#19. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade.
select s.name, c.cust_name
from salesman s cross join customer c
where s.city is not null and c.grade is not null;

#20. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer and the customers should have an own grade.  RM:  salesmen must have a city, salemen city is different than customer city, and customer must have a grade.
select s.name, c.cust_name
from salesman s cross join customer c
where s.city is not null and s.city <> c.city and c.grade is not null;

/*
Sample table:  company_mast
COM_ID COM_NAME
------ -------------
    11 Samsung
    12 iBall
    13 Epsion
    14 Zebronics
    15 Asus
    16 Frontech

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
*/
#21. Write a SQL query to display all the data from the item_mast, including all the data for each item's producer company.
select *
from item_mast i left outer join company_mast c
on i.pro_com = c.com_id;
#official solution
select *
from item_mast inner join company_mast
on item_mast.pro_com= company_mast.com_id;

#22. Write a SQL query to display the item name, price, and company name of all the products.
select i.pro_name, i.pro_price, c.com_name
from item_mast i inner join company_mast c
on i.pro_com = c.com_id;

#23. Write a SQL query to display the average price of items of each company, showing the name of the company.  RM:  I interpret adding the item to the group by average price
select i.pro_name, c.com_name, avg(i.pro_price)
from item_mast i inner join company_mast c
on i.pro_com = c.com_id
group by i.pro_name, c.com_name;
#official solution
select avg(pro_price), company_mast.com_name
from item_mast inner join company_mast
on item_mast.pro_com= company_mast.com_id
group by company_mast.com_name;

#24. Write a SQL query to display the names of the company whose products have an average price larger than or equal to Rs. 350.
select c.com_name
from item_mast i inner join company_mast c
on i.pro_com = c.com_id
where i.pro_price >= (
	select avg(i.pro_price)
	from item_mast i);
#official solution  RM:  official solution is correct.  Different SQL query for different question.  I misread question.
select avg(pro_price), company_mast.com_name
from item_mast inner join company_mast
on item_mast.pro_com= company_mast.com_id
group by company_mast.com_name
having avg(pro_price) >= 350;

#25. Write a SQL query to display the name of each company along with the ID and price for their most expensive product.
select c.com_name, c.com_id, max(i.pro_price)
from item_mast i inner join company_mast c
on i.pro_com = c.com_id
group by c.com_name, c.com_id;
#official solution RM:  too complex
select a.pro_name, a.pro_price, f.com_name
from item_mast a inner join company_mast f
on a.pro_com = f.com_id
and a.pro_price = (
	select max(a.pro_price)
	from item_mast a
	where a.pro_com = f.com_id);

/*
Sample table:  emp_department
DPT_CODE DPT_NAME        DPT_ALLOTMENT
-------- --------------- -------------
      57 IT                      65000
      63 Finance                 15000
      47 HR                     240000
      27 RD                      55000
      89 QC                      75000

Sample table:  emp_details
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
#26. Write a query in SQL to display all the data of employees including their department.
select *
from emp_details detail inner join emp_department depart
on detail.emp_dept = depart.dpt_code;

#27. Write a query in SQL to display the first name and last name of each employee, along with the name and sacntion amount for their department.
select detail.emp_fname, detail.empt_lname, depart.dpt_name, depart.dpt_allotment
from emp_details detail inner join emp_department depart
on detail.emp_dept = depart.dpt_code;

#28. Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000.
select detail.emp_fname, detail.empt_lname, depart.dpt_name, depart.dpt_allotment
from emp_details detail inner join emp_department depart
on detail.emp_dept = depart.dpt_code
where depart.dpt_allotment > 50000;

#29. Write a query in SQL to find the names of departments where more than two employees are working.
select depart.dpt_name, count(detail.emp_dept)
from emp_details detail inner join emp_department depart
on detail.emp_dept = depart.dpt_code
group by depart.dpt_name
having count(detail.emp_dept) > 2;
#official solution
select emp_department.dpt_name
from emp_details inner join emp_department
on emp_dept =dpt_code
group by emp_department.dpt_name
having count(*) > 2;