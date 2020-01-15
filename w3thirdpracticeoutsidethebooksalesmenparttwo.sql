#RM:  open w3basicssecondpracticedatabases.sql for database tables
#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#https://www.w3resource.com/sql-exercises/joins-hr/index.php
#salesman
/* 
salesman_id  name        city        commission
-----------  ----------  ----------  ----------
5001         James Hoog  New York    0.15
5002         Nail Knite  Paris       0.13
5005         Pit Alex    London      0.11
5006         Mc Lyon     Paris       0.14
5003         Lauson Hen              0.12
5007         Paul Adam   Rome        0.13
*/

#orders
/*
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

#customer
/*
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
#company_mast
/*
COM_ID COM_NAME
------ -------------
    11 Samsung
    12 iBall
    13 Epsion
    14 Zebronics
    15 Asus
    16 Frontech
*/

#item_mast
/*
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

#emp_department
/*
DPT_CODE DPT_NAME        DPT_ALLOTMENT
-------- --------------- -------------
      57 IT                      65000
      63 Finance                 15000
      47 HR                     240000
      27 RD                      55000
      89 QC                      75000
*/

#emp_details
/*
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

#employees
/*
 emp_id | emp_name | job_name  | manager_id | hire_date  | salary  | commission | dep_id
--------+----------+-----------+------------+------------+---------+------------+--------
  68319 | KAYLING  | PRESIDENT |            | 1991-11-18 | 6000.00 |            |   1001
  66928 | BLAZE    | MANAGER   |      68319 | 1991-05-01 | 2750.00 |            |   3001
  67832 | CLARE    | MANAGER   |      68319 | 1991-06-09 | 2550.00 |            |   1001
  65646 | JONAS    | MANAGER   |      68319 | 1991-04-02 | 2957.00 |            |   2001
  67858 | SCARLET  | ANALYST   |      65646 | 1997-04-19 | 3100.00 |            |   2001
  69062 | FRANK    | ANALYST   |      65646 | 1991-12-03 | 3100.00 |            |   2001
  63679 | SANDRINE | CLERK     |      69062 | 1990-12-18 |  900.00 |            |   2001
  64989 | ADELYN   | SALESMAN  |      66928 | 1991-02-20 | 1700.00 |     400.00 |   3001
  65271 | WADE     | SALESMAN  |      66928 | 1991-02-22 | 1350.00 |     600.00 |   3001
  66564 | MADDEN   | SALESMAN  |      66928 | 1991-09-28 | 1350.00 |    1500.00 |   3001
  68454 | TUCKER   | SALESMAN  |      66928 | 1991-09-08 | 1600.00 |       0.00 |   3001
  68736 | ADNRES   | CLERK     |      67858 | 1997-05-23 | 1200.00 |            |   2001
  69000 | JULIUS   | CLERK     |      66928 | 1991-12-03 | 1050.00 |            |   3001
  69324 | MARKER   | CLERK     |      67832 | 1992-01-23 | 1400.00 |            |   1001
(14 rows)
*/

#department
/*
 dep_id |  dep_name  | dep_location
--------+------------+--------------
   1001 | FINANCE    | SYDNEY
   2001 | AUDIT      | MELBOURNE
   3001 | MARKETING  | PERTH
   4001 | PRODUCTION | BRISBANE
(4 rows)
*/

#locations
/*
+-------------+------------------------------------------+-------------+---------------------+-------------------+------------+
| LOCATION_ID | STREET_ADDRESS                           | POSTAL_CODE | CITY                | STATE_PROVINCE    | COUNTRY_ID |
+-------------+------------------------------------------+-------------+---------------------+-------------------+------------+
|        1000 | 1297 Via Cola di Rie                     | 989         | Roma                |                   | IT         |
|        1100 | 93091 Calle della Testa                  | 10934       | Venice              |                   | IT         |
|        1200 | 2017 Shinjuku-ku                         | 1689        | Tokyo               | Tokyo Prefecture  | JP         |
|        1300 | 9450 Kamiya-cho                          | 6823        | Hiroshima           |                   | JP         |
|        1400 | 2014 Jabberwocky Rd                      | 26192       | Southlake           | Texas             | US         |
|        1500 | 2011 Interiors Blvd                      | 99236       | South San Francisco | California        | US         |
|        1600 | 2007 Zagora St                           | 50090       | South Brunswick     | New Jersey        | US         |
|        1700 | 2004 Charade Rd                          | 98199       | Seattle             | Washington        | US         |
|        1800 | 147 Spadina Ave                          | M5V 2L7     | Toronto             | Ontario           | CA         |
|        1900 | 6092 Boxwood St                          | YSW 9T2     | Whitehorse          | Yukon             | CA         |
|        2000 | 40-5-12 Laogianggen                      | 190518      | Beijing             |                   | CN         |
|        2100 | 1298 Vileparle (E)                       | 490231      | Bombay              | Maharashtra       | IN         |
|        2200 | 12-98 Victoria Street                    | 2901        | Sydney              | New South Wales   | AU         |
|        2300 | 198 Clementi North                       | 540198      | Singapore           |                   | SG         |
|        2400 | 8204 Arthur St                           |             | London              |                   | UK         |
|        2500 | Magdalen Centre, The Oxford Science Park | OX9 9ZB     | Oxford              | Oxford            | UK         |
|        2600 | 9702 Chester Road                        | 9629850293  | Stretford           | Manchester        | UK         |
|        2700 | Schwanthalerstr. 7031                    | 80925       | Munich              | Bavaria           | DE         |
|        2800 | Rua Frei Caneca 1360                     | 01307-002   | Sao Paulo           | Sao Paulo         | BR         |
|        2900 | 20 Rue des Corps-Saints                  | 1730        | Geneva              | Geneve            | CH         |
|        3000 | Murtenstrasse 921                        | 3095        | Bern                | BE                | CH         |
|        3100 | Pieter Breughelstraat 837                | 3029SK      | Utrecht             | Utrecht           | NL         |
|        3200 | Mariano Escobedo 9991                    | 11932       | Mexico City         | Distrito Federal, | MX         |
+-------------+------------------------------------------+-------------+---------------------+-------------------+------------+
*/

#job_grades
/*
GRADE_LEVEL  LOWEST_SAL HIGHEST_SAL
------------ ---------- -----------
A              1000        2999
B              3000        5999
C              6000        9999
D             10000       14999
E             15000       24999
F             25000       40000
*/

#job_history
/*
+-------------+------------+------------+------------+---------------+
| EMPLOYEE_ID | START_DATE | END_DATE   | JOB_ID     | DEPARTMENT_ID |
+-------------+------------+------------+------------+---------------+
|         102 | 2001-01-13 | 2006-07-24 | IT_PROG    |            60 |
|         101 | 1997-09-21 | 2001-10-27 | AC_ACCOUNT |           110 |
|         101 | 2001-10-28 | 2005-03-15 | AC_MGR     |           110 |
|         201 | 2004-02-17 | 2007-12-19 | MK_REP     |            20 |
|         114 | 2006-03-24 | 2007-12-31 | ST_CLERK   |            50 |
|         122 | 2007-01-01 | 2007-12-31 | ST_CLERK   |            50 |
|         200 | 1995-09-17 | 2001-06-17 | AD_ASST    |            90 |
|         176 | 2006-03-24 | 2006-12-31 | SA_REP     |            80 |
|         176 | 2007-01-01 | 2007-12-31 | SA_MAN     |            80 |
|         200 | 2002-07-01 | 2006-12-31 | AC_ACCOUNT |            90 |
+-------------+------------+------------+------------+---------------+
*/

#jobs
/*
+------------+---------------------------------+------------+------------+
| JOB_ID     | JOB_TITLE                       | MIN_SALARY | MAX_SALARY |
+------------+---------------------------------+------------+------------+
| AD_PRES    | President                       |      20080 |      40000 |
| AD_VP      | Administration Vice President   |      15000 |      30000 |
| AD_ASST    | Administration Assistant        |       3000 |       6000 |
| FI_MGR     | Finance Manager                 |       8200 |      16000 |
| FI_ACCOUNT | Accountant                      |       4200 |       9000 |
| AC_MGR     | Accounting Manager              |       8200 |      16000 |
| AC_ACCOUNT | Public Accountant               |       4200 |       9000 |
| SA_MAN     | Sales Manager                   |      10000 |      20080 |
| SA_REP     | Sales Representative            |       6000 |      12008 |
| PU_MAN     | Purchasing Manager              |       8000 |      15000 |
| PU_CLERK   | Purchasing Clerk                |       2500 |       5500 |
| ST_MAN     | Stock Manager                   |       5500 |       8500 |
| ST_CLERK   | Stock Clerk                     |       2008 |       5000 |
| SH_CLERK   | Shipping Clerk                  |       2500 |       5500 |
| IT_PROG    | Programmer                      |       4000 |      10000 |
| MK_MAN     | Marketing Manager               |       9000 |      15000 |
| MK_REP     | Marketing Representative        |       4000 |       9000 |
| HR_REP     | Human Resources Representative  |       4000 |       9000 |
| PR_REP     | Public Relations Representative |       4500 |      10500 |
+------------+---------------------------------+------------+------------+
*/

#departments
/*
+---------------+----------------------+------------+-------------+
| DEPARTMENT_ID | DEPARTMENT_NAME      | MANAGER_ID | LOCATION_ID |
+---------------+----------------------+------------+-------------+
|            10 | Administration       |        200 |        1700 |
|            20 | Marketing            |        201 |        1800 |
|            30 | Purchasing           |        114 |        1700 |
|            40 | Human Resources      |        203 |        2400 |
|            50 | Shipping             |        121 |        1500 |
|            60 | IT                   |        103 |        1400 |
|            70 | Public Relations     |        204 |        2700 |
|            80 | Sales                |        145 |        2500 |
|            90 | Executive            |        100 |        1700 |
|           100 | Finance              |        108 |        1700 |
|           110 | Accounting           |        205 |        1700 |
|           120 | Treasury             |          0 |        1700 |
|           130 | Corporate Tax        |          0 |        1700 |
|           140 | Control And Credit   |          0 |        1700 |
|           150 | Shareholder Services |          0 |        1700 |
|           160 | Benefits             |          0 |        1700 |
|           170 | Manufacturing        |          0 |        1700 |
|           180 | Construction         |          0 |        1700 |
|           190 | Contracting          |          0 |        1700 |
|           200 | Operations           |          0 |        1700 |
|           210 | IT Support           |          0 |        1700 |
|           220 | NOC                  |          0 |        1700 |
|           230 | IT Helpdesk          |          0 |        1700 |
|           240 | Government Sales     |          0 |        1700 |
|           250 | Retail Sales         |          0 |        1700 |
|           260 | Recruiting           |          0 |        1700 |
|           270 | Payroll              |          0 |        1700 |
+---------------+----------------------+------------+-------------+
*/

#countries
/*
+------------+--------------------------+-----------+
| COUNTRY_ID | COUNTRY_NAME             | REGION_ID |
+------------+--------------------------+-----------+
| AR         | Argentina                |         2 |
| AU         | Australia                |         3 |
| BE         | Belgium                  |         1 |
| BR         | Brazil                   |         2 |
| CA         | Canada                   |         2 |
| CH         | Switzerland              |         1 |
| CN         | China                    |         3 |
| DE         | Germany                  |         1 |
| DK         | Denmark                  |         1 |
| EG         | Egypt                    |         4 |
| FR         | France                   |         1 |
| IL         | Israel                   |         4 |
| IN         | India                    |         3 |
| IT         | Italy                    |         1 |
| JP         | Japan                    |         3 |
| KW         | Kuwait                   |         4 |
| ML         | Malaysia                 |         3 |
| MX         | Mexico                   |         2 |
| NG         | Nigeria                  |         4 |
| NL         | Netherlands              |         1 |
| SG         | Singapore                |         3 |
| UK         | United Kingdom           |         1 |
| US         | United States of America |         2 |
| ZM         | Zambia                   |         4 |
| ZW         | Zimbabwe                 |         4 |
+------------+--------------------------+-----------+
*/

#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city.
select s.name, c.cust_name, c.city
from salesman s join customer c
on s.salesman_id = c.salesman_id
where s.city = c.city;
#also
select s.name, c.cust_name, c.city
from customer c, salesman s
where c.city = s.city;

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
select c.cust_name, s.name
from customer c join salesman s
on c.salesman_id = s.salesman_id;
#also
select c.cust_name, s.name
from customer c, salesman s
where c.salesman_id = s.salesman_id;

#4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%.
select c.cust_name
from customer c, salesman s
where c.salesman_id = s.salesman_id
and s.commission > .12;

#5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, and gets a commission is above 12%.
select c.cust_name
from customer c, salesman s
where c.salesman_id = s.salesman_id
and s.commission > .12
and c.city <> s.city;

#6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and how much commission he gets for an order.
select o.ord_no, o.ord_date, o.purch_amt, c.cust_name, s.name, s.commission
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on s.salesman_id = c.salesman_id;
#official solution
on o.salesman_id = s.salesman_id;

#7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
select o.*, c.*, s.*
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on o.salesman_id = s.salesman_id;
#official solution
select *
from orders
natural join customer
natural join salesman;  #user feedback:  Because NATURAL JOIN will compare ALL matched columns (with same column name), in this case both salesman_id and city will take into account, so that only 6 records are left, this is because city column has only three same cities: four records of NY, one London and one Paris.

#8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own.
select c.cust_name
from customer c left join salesman s
on c.salesman_id = s.salesman_id
order by c.cust_name;

#9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own.
select c.cust_name
from customer c left join salesman s
on c.salesman_id = s.salesman_id
where c.grade < 300
order by c.cust_name;

#10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from orders o right join customer c
on o.customer_id = c.customer_id
order by o.ord_date;

#11. Write a SQL statement to make a report with customer name, city, order number, order date, order amount salesman name and commission to find that either any of the existing customers have placed no order or placed one or more orders by their salesman or by own.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission
from customer c left join orders o
on c.customer_id = o.customer_id
left join salesman s
on c.salesman_id = s.salesman_id;

#12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.
select *
from customer c right join salesman s
on c.salesman_id = s.salesman_id
order by s.salesman_id; 

#13. Write a SQL statement to make a list for the salesmen who works either for one or more customer or not yet join under any of the customers who placed either one or more orders or no order to their supplier.
select s.*
from customer c right join salesman s
on c.salesman_id = s.salesman_id
left join orders o
on c.customer_id = o.customer_id;

#14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select s.*
from customer c right join salesman s
on c.salesman_id = s.salesman_id
left join orders o
on c.customer_id = o.customer_id
where (o.purch_amt >= 2000
and c.grade is not null)
or o.purch_amt is null;

#15. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c right join orders o
on c.customer_id = o.customer_id;

#16. Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade.
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
from customer c right join orders o
on c.customer_id = o.customer_id
where (c.grade is not null
and o.purch_amt is not null)
or (c.grade is null
and o.purch_amt is null);

#17. Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa.
select s.*, c.*
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
#easy solution each company's most expensive price
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
  where i.pro_com = c.com_id);  #RM:  subquery need practice

#26. Write a query in SQL to display all the data of employees including their department.
select emp_department.*, emp_details.*
from emp_department, emp_details
where emp_department.dpt_code = emp_details.emp_dept;

#27. Write a query in SQL to display the first name and last name of each employee, along with the name and sanction amount for their department. 
select emp_details.emp_fname, emp_details.emp_lname, emp_department.dpt_name, emp_department.dpt_allotment
from emp_department, emp_details
where emp_department.dpt_code = emp_details.emp_dept;

#28. Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000.
select emp_details.emp_fname, emp_details.emp_lname
from emp_department, emp_details
where emp_department.dpt_code = emp_details.emp_dept
where emp_department > 50000;

#29. Write a query in SQL to find the names of departments where more than two employees are working.
select emp_department.dpt_name
from emp_department
where dpt_code in (
  select emp_dept
  from emp_details
  group by emp_dept
  having count(emp_dept) > 2);
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

#https://www.w3resource.com/sql-exercises/joins-hr/index.php
#1. Write a query in SQL to display the first name, last name, department number, and department name for each employee.
select e.first_name, e.last_name, e.department_id, e.department_name
from employees e, departments d
where e.department_id = d.department_id;
#also
select e.first_name, e.last_name, e.department_id, e.department_name
from employees e join departments d
on e.department_id = d.department_id;

#2. Write a query in SQL to display the first and last name, department, city, and state province for each employee.
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

#3. Write a query in SQL to display the first name, last name, salary, and job grade for all employees.  /* join unequal tables.  Can use between ... and, and comparison operators < > >= <= RM:  also <> */
select e.first_name, e.last_name, e.salesman_id, j.grade_level
from employees e, job_grades j
where e.salary between j.lowest_sal and j.highest_sal;
#also
select e.first_name, e.last_name, e.salary, j.grade_level
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal;

#4. Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.
select e.first_name, e.last_name, e.department_id, e.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.department_id in (80,40);

#5. Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and (e.first_name like '%z%' or e.first_name like 'Z%');

#6. Write a query in SQL to display all departments including those where does not have any employee.  RM:  SQL technical question no practical sense.
select distinct d.department_name
from departments d; #RM:  display all department_name departments; although, there are no duplicate department names.  No distinct required.
#RM:  return a table of employees and their departments.  Also include departments which don't have employees.
select e.first_name, e.last_name, d.department_id, d.department_name
from departments d left outer join employees e
on d.department_id = e.department_id;
#official solution
select e.first_name, e.last_name, d.department_id, d.department_name
from employee e right outer join departments d
on e.department_id = d.department_id;

#7. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.  #RM:  self-join self join.
select first_name, last_name, salary
from employees
where salary < (
	select salary
	from employees
	where employee_id = 182);
#self-join table looked at solution
select e1.first_name, e1.last_name, e1.salary
from employees e1, employees e2
where e1.employee_id = e2.employee_id
and (e1.salary < e2.salary
and e2.employee_id = 182);

#8. Write a query in SQL to display the first name of all employees including the first name of their manager.
select e.first_name as "employee first name", m.first_name as "manager first name"
from employees e, employees m
where m.employee_id = e.manager_id;

#9. Write a query in SQL to display the department name, city, and state province for each department.
select d.department_name, l.city, l.state_province
from departments d, locations l
where d.location_id = l.location_id;

#10. Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e left join departments d
on e.department_id = d.department_id;

#11. Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager.
select e.first_name, m.first_name
from employees e left join employees m
on m.employee_id = e.manager_id;

#12. Write a query in SQL to display the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
select first_name, last_name, department_id
from employees
where department_id = (
  select department_id
  from employees
  where last_name = 'Taylor');
#official solution
select e.first_name, e.last_name, e.department_id 
from employees e join employees same
on e.department_id = same.department_id
and same.last_name = 'Taylor';

#13. Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997.
select j.job_title, d.department_name, e.first_name, e.last_name, jh.start_date
from jobs j join departments d
on j.department_id = d.department_id
join employees e
on e.department_id = d.department_id
join job_history jh
on jh.employee_id = e.employee_id
where jh.start_date >= '1993-01-01' and jh.start_date <= '1997-08-31';
#correct solution from user
select j.job_title, d.department_name, e.first_name || ' ' || e.last_name as "Full Name", jobhistory.start_date
from jobs j join employees e
on j.job_id = e.job_id
join departments d
on e.department_id = d.department_id
join job_history jobhistory
on e.employee_id = jobhistory.employee_id  #RM:  I can link a join from a table not next to each other.  employee e is second table and job_history jobhistory is last table.
where jobhistory.start_date >= '1993-01-01' and jobhistory.start_date <= '1997-08-31';

#14. Write a query in SQL to display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee.
select j.job_title, e.first_name, e.last_name, j.max_salary, e.salary, (j.max_salary - e.salary) as "difference"
from jobs j, employees e
where j.job_id = e.job_id;

#15. Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.
select d.department_name, avg(e.salary), count(e.department_id)
from departments d join employees e
on d.department_id = e.department_id
where e.commission_pct > 0
group by d.department_name;

#16. Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary differences to their own job for those employees who is working in the department ID 80.  #RM:  take the maximum salary of each employee ans subtract from the employee's salary.
select e.first_name, e.last_name, j.job_title, j.max_salary, e.salary, j.max_salary-e.salary as "salary difference"
from employees e join jobs j
on e.job_id = j.job_id
where department_id = 80;
#official solution
select job_title, first_name || ' ' || last_name as employee_name, max_salary-salary as salary_difference
from employees natural join jobs 
where department_id  = 80;

#17. Write a query in SQL to display the name of the country, city, and the departments which are running there.
select c.country_name, l.city, d.department_name
from countries c, locations l, departments d
where c.country_id = l.country_id
and l.location_id = d.location_id;
#also
select c.country_name, l.city, d.department_name
from countries c join locations l #RM:  right outer join returned a department without a country
on c.country_id = l.country_id
join departments d
on l.location_id = d.location_id;
#official solution
select country_name,city, department_name 
from countries 
join locations using (country_id) 
join departments using (location_id);

#18. Write a query in SQL to display department name and the full name (first and last name) of the manager.
select d.department_name, e.first_name, e.last_name
from departments d, employees e
where d.manager_id = e.employee_id;

#19. Write a query in SQL to display job title and average salary of employees.
select j.job_title, avg(e.salary)
from jobs j, employees e
where j.job_id = e.job_id
group by j.job_title;
#also
select j.job_title, avg(e.salary)
from jobs j join employees e
on j.job_id = e.job_id
group by j.job_title;
#official solution
select job_title, avg(salary)
from employees natural join jobs
group by job_title;

#20. Write a query in SQL to display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000.  #RM:  find the jobs in the job_history table for which the employee_id earns a salary 12,000 or greater.
select j.*
from job_history j, employees e
where j.employee_id = e.employee_id
and e.salary > 12000;
#also
select j.*
from job_history j join employees e 
on j.employee_id = e.employee_id
where e.salary >= 12000;

#21. Write a query in SQL to display the country name, city, and number of those departments where at leaste 2 employees are working.
select c.country_name, l.city, d.department_name
from countries c, locations l, departments d
where c.country_id = l.country_id
and l.location_id = d.location_id
and d.department_id in (
  select department_id
  from employees
  group by department_id
  having count(department_id) > 2);
#official solution modified
select c.country_name, l.city, count(d.department_id)
from countries c join locations l
on c.country_id = l.country_id
join departments d
on l.location_id = d.location_id
where d.department_id in (
    select e.department_id
    from employees e
    group by e.department_id
    having count(e.department_id)>=2) #RM:  use department_id to count employees instead of employee_id because need department_id in where clause
group by c.country_name, l.city;
#official solution
select country_name,city, count(department_id)
from countries 
join locations using (country_id) 
join departments using (location_id) 
where department_id in (
  select department_id 
  from employees 
  group by department_id 
  having count(department_id)>=2)
group by country_name,city;

#22. Write a query in SQL to display the department name, full name (first and last name) of manager, and their city.
#23. Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.
#24. Write a query in SQL to display the full name (first and last name), and salary of those employees who working in any department located in London.
#25. Write a query in SQL to display full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
#26. Write a query in SQL to display the department name and number of employees in each of the department.
#27. Write a query in SQL to display the full name (firt and last name ) of employee with ID and name of the country presently where (s)he is working.