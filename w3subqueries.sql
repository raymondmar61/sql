#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/subqueries/index.php

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

#1. Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
select *
from orders
where salesman_id = (
	select salesman_id
	from salesman
	where name = 'Paul Adams');

#2. Write a query to display all the orders for the salesman who belongs to the city London.
select *
from orders
where salesman_id = (
	select salesman_id
	from salesman
	where city = 'London');

#3. Write a query to find all the orders issued against the salesman who works for customer whose id is 3007.
select name
from salesman
where salesman_id = (
	select salesman_id
	from orders
	where customer_id = 3007);  #RM:  I interpret find the salesman who sold to customer_id 3007.
#official solution
select *
from orders
where salesman_id =
    (select distinct salesman_id 
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
where salesman_id = (
	select salesman_id
	from salesman
	where city = 'New York'); #official solution:  Using = instead of IN will produce the same result. But that does not make = equivalent to IN.

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
#6. Write a query to display the commission of all the salesmen servicing customers in Paris.
select commission
from salesman
where salesman_id = (
	select salesman_id
	from customer
	where city = 'Paris');

#7. Write a query to display all the customers whose id is 2001 bellow the salesman ID of Mc Lyon. #RM copied solution.
select *
from customer
where customer_id = (
	select salesman_id - 2001
	from salesman
	where name = 'Mc Lyon');

#8. Write a query to count the customers with grades above New York's average.
select count(customer_id)
from customer
where grade > (
	select avg(grade)
	from customer
	where city = 'New York');
#official solution want count breakdown by grade
select grade, count(distinct customer_id)
from customer
group by grade
having grade >
    (select avg(grade)
     from customer
     where city = 'New York');
#my way
select grade, count(customer_id)
from customer
where grade > (
	select avg(grade)
	from customer
	where city ='New York')
group by grade;

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

#12. Write a query to find all orders with order amounts which are above-average amounts for their customers.  RM:  subquery and join together.  subquery join subquery together.  join same table join.
select avg(o.purch_amt)
from orders o;
/*
avg
1461.7650000000000000
*/
select customer_id, avg(purch_amt)
from orders
group by customer_id
order by customer_id;
/*
customer_id	avg
3001	270.6500000000000000
3002	2956.9533333333333333
3003	75.2900000000000000
3004	1983.4300000000000000
3005	549.5000000000000000
3007	2400.6000000000000000
3008	250.4500000000000000
3009	1295.4500000000000000
*/
select *
from orders o
where o.purch_amt > (
	select avg(o.purch_amt)
	from orders o);
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70008	5760.00	2012-09-10	3002	5001
70013	3045.60	2012-04-25	3002	5001
70010	1983.43	2012-10-10	3004	5006
70005	2400.60	2012-07-27	3007	5001
70003	2480.40	2012-10-10	3009	5003
*/
#official solution
select *
from orders oa
where oa.purch_amt > (
	select avg(ob.purch_amt)
	from orders ob
	where oa.customer_id=ob.customer_id) #<-- take customers into account per official solution
order by customer_id;
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70008	5760.00	2012-09-10	3002	5001
70013	3045.60	2012-04-25	3002	5001
70007	948.50	2012-09-10	3005	5002
70003	2480.40	2012-10-10	3009	5003
*/

#13. Write a queries to find all orders with order amounts which are on or above-average amounts for their customers.
select *
from orders oa
where oa.purch_amt >= (
	select avg(ob.purch_amt)
	from orders ob
	where oa.customer_id=ob.customer_id) #<-- take customers into account per official solution
order by customer_id;
/*
ord_no	purch_amt	ord_date	customer_id	salesman_id
70009	270.65	2012-09-10	3001	5005
70013	3045.60	2012-04-25	3002	5001
70008	5760.00	2012-09-10	3002	5001
70011	75.29	2012-08-17	3003	5007
70010	1983.43	2012-10-10	3004	5006
70007	948.50	2012-09-10	3005	5002
70005	2400.60	2012-07-27	3007	5001
70012	250.45	2012-06-27	3008	5002
70003	2480.40	2012-10-10	3009	5003
*/

#14. Write a query to find the sums of the amounts from the orders table, grouped by date, eliminating all those dates where the sum was not at least 1000.00 above the maximum order amount for that date.  join same table join.
#official solution
select oa.ord_date, sum(oa.purch_amt)
from orders oa
group by oa.ord_date
having sum (oa.purch_amt) > (
	select 1000.00 + max(ob.purch_amt) 
	from orders ob 
	where oa.ord_date = ob.ord_date);
/*
ord_date	sum
2012-09-10	6979.15
2012-10-10	4463.83
*/

#15. Write a query to extract the data from the customer table if and only if one or more of the customers in the customer table are located in London.  join same table join.  #RM:  question is extract the customer table if one or more customer is from London.  There is a customer from London.
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

#16. Write a query to find the salesmen who have multiple customers.
select name
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) > 1);
#official solution
select * 
from salesman 
where salesman_id in (
   select distinct salesman_id 
   from customer a 
   where exists (
      select * 
      from customer b 
      where b.salesman_id=a.salesman_id 
      and b.cust_name<>a.cust_name));

#17. Write a query to find all the salesmen who worked for only one customer.
select name
from salesman
where salesman_id in (
	select salesman_id
	from customer
	group by salesman_id
	having count(salesman_id) = 1);
#official solution
select * 
from salesman 
where salesman_id in (
   select distinct salesman_id 
   from customer a 
   where not exists (
      select * 
      from customer b 
      where b.salesman_id=a.salesman_id 
      and b.cust_name<>a.cust_name));

#18. Write a query that extract the rows of all salesmen who have customers with more than one orders.
select *
from salesman
where salesman_id in (
	select salesman_id
	from customer
	where customer_id in (
		select customer_id
		from orders
		group by customer_id
		having count(customer_id) > 1));
#official solution
select * 
from salesman a 
where exists
   (select *
   	from customer b
    where a.salesman_id = b.salesman_id
	and 1 < (
	 	select count (*)
		from orders
		where orders.customer_id = b.customer_id));

#19. Write a query to find salesmen with all information who lives in the city where any of the customers lives.
select distinct s.*
from salesman s, customer c
where s.salesman_id=c.salesman_id
and s.city=c.city;  #RM:  incorrect.  Want salesmen lives in a city where ANY of the customers live.  Not matching salesman and customer city.
#official solution
select *
from salesman
where city = any (
	select city
	from customer);
#I like the comment solution
select *
from salesman a
where a.city in (
	select city
	from customer
	where a.city=city);
#I like the comment solution
select *
from salesman sa
where exists (
	select *
	from customer cu
	where sa.city = cu.city);

#20. Write a query to find all the salesmen for whom there are customers that follow them.  RM:  I don't understand the question.
#official solution
select *
from salesman
where city in (
	select city
	from customer);
#comment section says official solution is incorrect
select s.*
from salesman s
where s.salesman_id in (
	select salesman_id
	from customer);

#21. Write a query to display the salesmen which name are alphabetically lower than the name of the [their] customers.  RM:  I believe question is salesman name is below their customer's name
#official solution
select *
from salesman a
where exists (
	select *
	from customer b
	where a.name < b.cust_name);

#22. Write a query to display the customers who have a greater gradation than any customer who belongs to the alphabetically lower than the city New York.
select ca.*
from customer ca
where ca.grade > any (
	select cb.grade
	from customer cb
	where cb.city < 'New York');

#23. Write a query to display all the orders that had amounts that were greater than at least one of the orders on September 10th 2012.
select oa.*
from orders oa
where purch_amt > any (
	select ob.purch_amt
	from orders ob
	where ob.ord_date = '2012-09-10');

#24. Write a query to find all orders with an amount smaller than any amount for a customer in London.
select oa.*
from orders oa
where purch_amt < any (
	select ob.purch_amt
	from orders ob, customer c
	where ob.customer_id = c.customer_id
	and c.city='London');

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
	where cb.city = 'New York');

#27. Write a query to find only those customers whose grade are, higher than every customer to the city New York.  RM:  official solution same as #26.
select ca.*
from customer ca
where ca.grade > all ( #RM:  every customer means all customers
	select cb.grade
	from customer cb
	where cb.city = 'New York');

#28. Write a query to get all the information for those customers whose grade is not as the grade of customer who belongs to the city London.
select ca.*
from customer ca
where ca.grade not in ( #RM:  not in is invalid because there is a customer in London grade is null
	select cb.grade
	from customer cb
	where cb.city = 'London');
#official solution
select ca.*
from customer ca
where ca.grade <> any (
	select cb.grade
	from customer cb
	where cb.city = 'London');
#city London must have a grade.  not in is valid because all customers in London must have a grade
select ca.*
from customer ca
where ca.grade not in (
	select cb.grade
	from customer cb
	where cb.city = 'London'
	and cb.grade is not null);

#29. Write a query to find all those customers whose grade are not as the grade, belongs to the city Paris.
select ca.*
from customer ca
where ca.grade not in (
	select cb.grade
	from customer cb
	where cb.city = 'Paris');

#30. Write a query to find all those customers who hold a different grade than any customer of the city Dallas.  #RM:  reading the comments the question is find customers don't have a grade from Dallas.  There are no customers in Dallas.  Stupid question.  Practice using where not.
#official solution
select ca.*
from customer ca
where not ca.grade = any (
	select cb.grade
	from customer cb
	where cb.city = 'Dallas');

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

#31. Write a SQL query to find the average price of each manufacturer's products along with their name.
select c.com_name, avg(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name;
#comments section use a subquery
select com_name as compname, (
	select avg(pro_price)
	from item_mast
	where pro_com = com_id) as avgprice
from company_mast;

#32. Write a SQL query to display the average price of the products which is more than or equal to 350 along with theri names.
select c.com_name, avg(i.pro_price)
from company_mast c, item_mast i
where c.com_id = i.pro_com
group by c.com_name
having avg(i.pro_price) >= 350;
#comments section use a subquery
select com_name as compname, (
	select avg(pro_price)
	from item_mast
	where pro_com = com_id
	having avg(pro_price) >= 350) as avgprice
from company_mast;  #RM:  Zebronics average price less than 350 appears on results showing null under avgprice
#comments section use a subquery
select compname, avgprice
from (
	select com_name as compname, (
		select avg(pro_price)
		from item_mast
		where pro_com = com_id) as avgprice
	from company_mast) tmp
where avgprice >= 350;

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

/*
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
#34. Write a query in SQL to find all the details of employees whose last name is Gabriel or Dosio.
select *
from emp_details
where emp_lname in ('Gabriel','Dosio');
#subquery
select *
from emp_details
where emp_lname in (
	select emp_lname
	from emp_details
	where emp_lname in ('Gabriel','Dosio'));

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
#35. Write a query in SQL to display all the details of employees who works in department 89 or 63.
select *
from emp_details
where emp_dept in (89, 63);
#same as
select empdet.*
from emp_details empdet, emp_department empdep
where empdet.emp_dept = empdep.dpt_code
and empdep.dpt_code in (89, 63);
#same as
select empdet.*
from emp_details empdet inner join emp_department empdep
on empdet.emp_dept = empdep.dpt_code
where empdep.dpt_code in (89, 63);

#36. Write a query in SQL to display the first name and last name of employees working for the department which allotment amount is more than Rs.50000.
select emp_fname, emp_lname
from emp_details
where emp_dept in (
	select dpt_code
	from emp_department
	where dpt_allotment > 50000);

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

#39. Write a query in SQL to find the first name and last name of employees working for departments which sanction amount is second lowest.
select emp_fname, emp_lname
from emp_details
where emp_dept in (
	select dpt_code
	from emp_department
	group by dpt_code
	having dpt_allotment > min(dpt_allotment)); #RM:  incorrect SQL doesn't answer the question.  Want second lowest amount.

select emp_fname, emp_lname
from emp_details
where emp_dept in (
	select dpt_code
	from emp_department
	where dpt_allotment > (
		select min(dpt_allotment)
		from emp_department)); #RM:  incorrect SQL doesn't answer the question.  Want second lowest amount.

select emp_fname, emp_lname
from emp_details
where emp_dept in (
	select dpt_code
	from emp_department
	where dpt_allotment = (
		select dpt_allotment
		from (
			select dpt_allotment, rank() over (order by dpt_allotment asc) as rnk
			from emp_department)
		where rnk = 2)); #RM:  no result

select emp_fname, emp_lname
from emp_details
where emp_dept in (
	select dpt_code
	from emp_department
	where dpt_allotment = (
			select dpt_allotment, rank() over (order by dpt_allotment asc) as rnk
			from emp_department
			where rnk = 2)); #RM:  no result

select emp_fname, emp_lname
from emp_details
where emp_dept in (
	select dpt_code from (
		select *, rank() over (order by dpt_allotment) rank from emp_department)
	where rank=2);