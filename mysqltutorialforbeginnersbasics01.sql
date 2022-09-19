#MySQL Tutorial for Beginners -Full Course-
#Run code in innova18_sql_hr database to access rows in innova18_sql_store database
use innova18_sql_store;
select *
from orders; #error message #1146 - Table 'innova18_sql_hr.orders' doesn't exist
#Run code in innova18_sql_hr database to access rows in innova18_sql_store database
use innova18_sql_store;
select *
from innova18_sql_store.orders; #code works
#Run code in innova18_sql_hr database to access rows in innova18_sql_store database
select *
from innova18_sql_store.products; #code works
select *
from customers
where customer_id between 1 and 5
order by first_name;
/*
customer_id	first_name   	last_name	birth_date	phone	address	city	state	points	
4	Ambur	Roseburgh	1974-04-14	407-231-8017	30 Arapahoe Terrace	Orlando	FL	457	
1	Babara	MacCaffrey	1986-03-28	781-932-9754	0 Sage Terrace	Waltham	MA	2273	
5	Clemmie	Betchley	1973-11-07	    NULL	5 Spohn Circle	Arlington	TX	3675	
3	Freddi	Boagey	1985-02-07	719-724-7869	251 Springs Junction	Colorado Springs	CO	2967	
2	Ines	Brushfield	1986-04-13	804-427-9456	14187 Commercial Trail	Hampton	VA	947	
*/
select first_name, last_name, points, (points+10)*100 as "calculating column"
from customers
where customer_id between 1 and 5
order by first_name;
/*
first_name   	last_name	points	calculating column	
Ambur	Roseburgh	457	46700	
Babara	MacCaffrey	2273	228300	
Clemmie	Betchley	3675	368500	
Freddi	Boagey	2967	297700	
Ines	Brushfield	947	95700	
*/
select distinct state as "unique states" #remove duplicates
from customers;
/*
unique states	
MA	
VA	
CO	
FL	
TX	
IL	
TN	
CA	
GA	
*/
select name, unit_price, round(unit_price*1.1,2) as newprice
from products;
/*
name	unit_price	newprice	
Foam Dinner Plate	1.21	1.33	
Pork - Bacon,back Peameal	4.65	5.12	
Lettuce - Romaine, Heart	3.35	3.69	
Brocolinni - Gaylan, Chinese	4.53	4.98	
Sauce - Ranch Dressing	1.63	1.79	
Petit Baguette	2.39	2.63	
Sweet Pea Sprouts	3.29	3.62	
Island Oasis - Raspberry	0.74	0.81	
Longan	2.26	2.49	
Broom - Push	1.09	1.20	
*/
select *
from customers
where birth_date > '1990-01-15';
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
6	Elka	Twiddell	1991-09-04	312-480-8498	7 Manley Drive	Chicago	IL	3073	
8	Thacher	Naseby	1993-07-17	941-527-3977	538 Mosinee Center	Sarasota	FL	205	
9	Romola	Rumgay	1992-05-23	559-181-3744	3520 Ohio Trail	Visalia	CA	1486	
*/
select *
from order_items
where order_id = 6 and unit_price*quantity>30; #calculation in where clause
/*
order_id product_id quantity unit_price
6	1	4	8.65
*/
select *
from customers
where state not in ('VA','FL','GA');
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
1	Babara	MacCaffrey	1986-03-28	781-932-9754	0 Sage Terrace	Waltham	MA	2273	
3	Freddi	Boagey	1985-02-07	719-724-7869	251 Springs Junction	Colorado Springs	CO	2967	
5	Clemmie	Betchley	1973-11-07	    NULL	5 Spohn Circle	Arlington	TX	3675	
6	Elka	Twiddell	1991-09-04	312-480-8498	7 Manley Drive	Chicago	IL	3073	
7	Ilene	Dowson	1964-08-30	615-641-4759	50 Lillian Crossing	Nashville	TN	1672	
9	Romola	Rumgay	1992-05-23	559-181-3744	3520 Ohio Trail	Visalia	CA	1486	
*/
select *
from customers
where points >=1000 and points <=3000;
--same as
select *
from customers
where points between 1000 and 3000;
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
1	Babara	MacCaffrey	1986-03-28	781-932-9754	0 Sage Terrace	Waltham	MA	2273	
3	Freddi	Boagey	1985-02-07	719-724-7869	251 Springs Junction	Colorado Springs	CO	2967	
7	Ilene	Dowson	1964-08-30	615-641-4759	50 Lillian Crossing	Nashville	TN	1672	
9	Romola	Rumgay	1992-05-23	559-181-3744	3520 Ohio Trail	Visalia	CA	1486	
*/
select *
from customers
where last_name like 'Brush%'; #wild card search.  Use underscore _ for a single character.  Use multiple underscore for multiple single characters; for example, ___ three underscores is three single characters.
#Regular expressions
select *
from customers
where last_name like '%field%';
--same as
select *
from customers
where last_name regexp 'field';
/*
2	Ines	Brushfield	1986-04-13	804-427-9456	14187 Commercial Trail	Hampton	VA	947	
*/
select *
from customers
where last_name regexp '^Brush';  --Caret represents the beginning of the string.  Search last_name column must begin with Brush.
select *
from customers
where last_name regexp 'field$';  --Dollar sign represents the end of the string.  Search last_name column must end with field.
select *
from customers
where last_name regexp 'field|mac|rose';  --Pipe represents or as multiple words.  Search last_name column for either field or mac or rose.
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
1	Babara	MacCaffrey	1986-03-28	781-932-9754	0 Sage Terrace	Waltham	MA	2273	
2	Ines	Brushfield	1986-04-13	804-427-9456	14187 Commercial Trail	Hampton	VA	947	
4	Ambur	Roseburgh	1974-04-14	407-231-8017	30 Arapahoe Terrace	Orlando	FL	457	
*/
select *
from customers
where last_name regexp '^field|mac|rose';  --The caret field word must be at the beginning of the string.  Field is not at the beginning.  Brushfield is excluded from the search results.
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
1	Babara	MacCaffrey	1986-03-28	781-932-9754	0 Sage Terrace	Waltham	MA	2273	
4	Ambur	Roseburgh	1974-04-14	407-231-8017	30 Arapahoe Terrace	Orlando	FL	457	
*/
select *
from customers
where last_name regexp 'field$|mac|rose$';  --The dollar sign field or rose must be at the end of the string.  Field is at the end of the string.  Rose is not at the end.  Roseburgh is excluded from the search results.
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
1	Babara	MacCaffrey	1986-03-28	781-932-9754	0 Sage Terrace	Waltham	MA	2273	
2	Ines	Brushfield	1986-04-13	804-427-9456	14187 Commercial Trail	Hampton	VA	947	
*/
select last_name as "last name includes ge, ie, or me"
from customers
where last_name regexp '[gim]e';  --Brackets is include the letter g, i, or m must be before the letter e.
/*
last name includes ge, ie, or me	
Brushfield	
Boagey	
*/
select last_name as "last name includes et, eb, or ey"
from customers
where last_name regexp 'e[tby]';  --Brackets is include the letter t, b, or y must be after the letter e.
/*
last name includes et, eb, or ey	
MacCaffrey	
Boagey	
Roseburgh	
Betchley	
Naseby	
Mynett	
*/
select last_name as "last name includes ae to he as a range a to h"
from customers
where last_name regexp '[a-h]e';  --Brackets and hyphen are include the letters from a to h must be before the letter e.
/*
last name includes ae to he as a range a to h	
Boagey	
Betchley	
Twiddell	
*/
select first_name as "first name includes fred or ache"
from customers
where first_name regexp 'fred|ache';
/*
first name includes elka or ambur	
Freddi	
Thacher	
*/
select last_name as "last name ends with ey or on"
from customers
where last_name regexp 'ey$|on$';
/*
last name ends with ey or on	
MacCaffrey	
Boagey	
Betchley	
Dowson	
*/
select last_name as "last name starts with my or contains se"
from customers
where last_name regexp '^my|se';
/*
last name starts with my or contains se	
Roseburgh	
Naseby	
Mynett	
*/
select last_name as "last name contains br or bu"
from customers
where last_name regexp 'b[ru]';  --where last_name regexp 'br|bu'; is valid, too
/*
last name contains br or bu	
Brushfield	
Roseburgh	
*/
select *
from customers
where phone is null;
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
5	Clemmie	Betchley	1973-11-07	    NULL	5 Spohn Circle	Arlington	TX	3675	
*/
select first_name, last_name
from customers
order by state desc, first_name asc;
/*
first_name   	last_name	
Ines	Brushfield	
Clemmie	Betchley	
Ilene	Dowson	
Babara	MacCaffrey	
Elka	Twiddell	
Levy	Mynett	
Ambur	Roseburgh	
Thacher	Naseby	
Freddi	Boagey	
Romola	Rumgay	
*/
select *, quantity*unit_price as totalpurchase
from order_items
where order_id between 5 and 8
order by totalpurchase; #order by quantity*unit_price; is valid
/*
order_id	product_id	quantity	unit_price	totalpurchase   	
6	5	1	3.45	3.45	
6	2	4	3.28	13.12	
8	5	2	6.94	13.88	
8	8	2	8.59	17.18	
5	2	3	9.89	29.67	
6	3	4	7.46	29.84	
6	1	4	8.65	34.60	
7	3	7	9.17	64.19	
*/
select *
from customers
limit 6, 3; #offset.  Return rows at a different starting point.  Print three rows starting at the sixth row.
/*
customer_id	first_name	last_name	birth_date	phone	address	city	state	points   	
5	Clemmie	Betchley	1973-11-07	    NULL 5 Spohn Circle	Arlington	TX	3675
6	Elka	Twiddell	1991-09-04	312-480-8498	7 Manley Drive	Chicago	IL	3073
3	Freddi	Boagey	1985-02-07	719-724-7869	251 Springs Junction	Colorado Springs	CO	2967	
*/
select order_id, orders.customer_id, first_name, last_name
from orders join customers
on orders.customer_id = customers.customer_id;
#better
select order_id, o.customer_id, first_name, last_name
from orders o join customers c
on o.customer_id = c.customer_id;
/*
order_id	customer_id	first_name	last_name	
1	6	Elka	Twiddell	
2	7	Ilene	Dowson	
3	8	Thacher	Naseby	
4	2	Ines	Brushfield	
5	5	Clemmie	Betchley	
6	10	Levy	Mynett	
7	2	Ines	Brushfield	
8	5	Clemmie	Betchley	
9	10	Levy	Mynett	
10	6	Elka	Twiddell	
*/
select *
from order_items oi join innova18_sql_inventory.products p
on oi.product_id = p.product_id; #products table is from another database named innova18_sql_inventory.  Query written in innova18_sql_inventory.store database.
use innova18_sql_inventory; #SQL code 1 of 2.  Explicitly state which database to run the query.  order_items table is in innova18_sql_store database.
select *
from innova18_sql_store.order_items oi join products p
on oi.product_id = p.product_id; #SQL code 2 of 2.  Explicitly state which database to run the query.  order_items table is in innova18_sql_store database.
use innova18_sql_hr; #However, for some reason I needed to mentioned the databasename for employees table even though I explicitly stated the database innova18_sql_hr.  Written in innova18_sql_store. SQL code 1 of 2.
select *
from innova18_sql_hr.employees; #However, for some reason I needed to mentioned the databasename for employees table even though I explicitly stated the database innova18_sql_hr.  Written in innova18_sql_store. SQL code 2 of 2.
select *
from employees;
/*
employee_id	first_name	last_name	job_title	salary	reports_to	office_id	
37270	Yovonnda	Magrannell	Executive Secretary	63996 NULL 10
33391	D'arcy	Nortunen	Account Executive	62871	37270	1
37851	Sayer	Matterson	Statistician III	98926	37270	1	
40448	Mindy	Crissil	Staff Scientist	94860	37270	1	
56274	Keriann	Alloisi	VP Marketing	110150	37270	1	
63196	Alaster	Scutchin	Assistant Professor	32179	37270	2	
67009	North	de Clerc	VP Product Management	114257	37270	2	
67370	Elladine	Rising	Social Worker	96767	37270	2	
68249	Nisse	Voysey	Financial Advisor	52832	37270	2	
72540	Guthrey	Iacopetti	Office Assistant I	117690	37270	3	
72913	Kass	Hefferan	Computer Systems Analyst IV	96401	37270	3	
75900	Virge	Goodrum	Information Systems Manager	54578	37270	3	
76196	Mirilla	Janowski	Cost Accountant	119241	37270	3	
80529	Lynde	Aronson	Junior Executive	77182	37270	4	
80679	Mildrid	Sokale	Geologist II	67987	37270	4	
84791	Hazel	Tarbert	General Manager	93760	37270	4	
95213	Cole	Kesterton	Pharmacist	86119	37270	4	
96513	Theresa	Binney	Food Chemist	47354	37270	5	
98374	Estrellita	Daleman	Staff Accountant IV	70187	37270	5	
115357	Ivy	Fearey	Structural Engineer	92710	37270	5	
*/
#Write a self join or join same table join.  Find the employees's manager which is in the same table.  RM:  there are 20 employees.   There's one manager Yovonnda Magrannell employee id 37270.  Really?!?  One manager?!?
select e.employee_id, e.first_name, e.last_name, m.employee_id, m.first_name, m.last_name
from employees e left join employees m
on m.employee_id = e.reports_to;
/*
employee_id	first_name	last_name	employee_id	first_name	last_name	
37270	Yovonnda	Magrannell NULL NULL NULL
33391	D'arcy	Nortunen	37270	Yovonnda	Magrannell
37851	Sayer	Matterson	37270	Yovonnda	Magrannell	
40448	Mindy	Crissil	37270	Yovonnda	Magrannell	
56274	Keriann	Alloisi	37270	Yovonnda	Magrannell	
63196	Alaster	Scutchin	37270	Yovonnda	Magrannell	
67009	North	de Clerc	37270	Yovonnda	Magrannell	
67370	Elladine	Rising	37270	Yovonnda	Magrannell	
68249	Nisse	Voysey	37270	Yovonnda	Magrannell	
72540	Guthrey	Iacopetti	37270	Yovonnda	Magrannell	
72913	Kass	Hefferan	37270	Yovonnda	Magrannell	
75900	Virge	Goodrum	37270	Yovonnda	Magrannell	
76196	Mirilla	Janowski	37270	Yovonnda	Magrannell	
80529	Lynde	Aronson	37270	Yovonnda	Magrannell	
80679	Mildrid	Sokale	37270	Yovonnda	Magrannell	
84791	Hazel	Tarbert	37270	Yovonnda	Magrannell	
95213	Cole	Kesterton	37270	Yovonnda	Magrannell	
96513	Theresa	Binney	37270	Yovonnda	Magrannell	
98374	Estrellita	Daleman	37270	Yovonnda	Magrannell	
115357	Ivy	Fearey	37270	Yovonnda	Magrannell	
*/
select o.order_id, o.order_date, c.first_name, c.last_name, os.name
from orders o join customers c
on o.customer_id = c.customer_id
join order_statuses os
on os.order_status_id = o.status;
/*
order_id	order_date	first_name	last_name	name	
1	2019-01-30	Elka	Twiddell	Processed	
3	2017-12-01	Thacher	Naseby	Processed	
4	2017-01-22	Ines	Brushfield	Processed	
6	2018-11-18	Levy	Mynett	Processed	
8	2018-06-08	Clemmie	Betchley	Processed	
2	2018-08-02	Ilene	Dowson	Shipped	
5	2017-08-25	Clemmie	Betchley	Shipped	
7	2018-09-22	Ines	Brushfield	Shipped	
9	2017-07-05	Levy	Mynett	Shipped	
10	2018-04-22	Elka	Twiddell	Shipped	
*/
select *
from payments;
/*
payment_id	client_id	invoice_id	date	amount	payment_method	
1	5	2	2019-02-12	8.18	1	
2	1	6	2019-01-03	74.55	1	
3	3	11	2019-01-11	0.03	1	
4	5	13	2019-01-26	87.44	1	
5	3	15	2019-01-15	80.31	1	
6	3	17	2019-01-15	68.10	1	
7	5	18	2019-01-08	32.77	1	
8	5	18	2019-01-08	10.00	2	
*/
select *
from payment_methods;
/*
payment_method_id	name	
1	Credit Card	
2	Cash	
3	PayPal	
4	Wire Transfer	
*/
select *
from clients;
/*
client_id	name	address	city	state	phone	
1	Vinte	3 Nevada Parkway	Syracuse	NY	315-252-7305	
2	Myworks	34267 Glendale Parkway	Huntington	WV	304-659-1170	
3	Yadel	096 Pawling Parkway	San Francisco	CA	415-144-6037	
4	Kwideo	81674 Westerfield Circle	Waco	TX	254-750-0784	
5	Topiclounge	0863 Farmco Road	Portland	OR	971-888-9129	
*/
select c.client_id, p.invoice_id, c.name, p.amount, pm.name
from clients c join payments p
on c.client_id = p.client_id
join payment_methods pm
on pm.payment_method_id = p.payment_method
order by 1, 3;
/*
client_id	invoice_id	name	amount	name	
1	6	Vinte	74.55	Credit Card	
3	15	Yadel	80.31	Credit Card	
3	11	Yadel	0.03	Credit Card	
3	17	Yadel	68.10	Credit Card	
5	18	Topiclounge	32.77	Credit Card	
5	2	Topiclounge	8.18	Credit Card	
5	18	Topiclounge	10.00	Cash	
5	13	Topiclounge	87.44	Credit Card	
*/
#compound join condition RM:  what's the point?
select *
from order_items oi join order_item_notes oin
on oi.order_id = oin.order_id
and oi.product_id = oin.product_id;
/*
MySQL returned an empty result set (i.e. zero rows).
*/
select *
from orders o join customers c
on o.customer_id = c.customer_id;
--also
select *
from orders o, customer c
where o.customer_id = c.customer_id; #implicit join syntax

select *
from orders o join customers c
on o.customer_id = c.customer_id
/*
order_id	customer_id	order_date	status	comments	shipped_date	shipper_id	customer_id	first_name	last_name	birth_date	phone	address	city	state	points	
1	6	2019-01-30	1	NULL	NULL	NULL	6	Elka	Twiddell	1991-09-04	312-480-8498	7 Manley Drive	Chicago	IL	3073	
2	7	2018-08-02	2	NULL	2018-08-03	4	7	Ilene	Dowson	1964-08-30	615-641-4759	50 Lillian Crossing	Nashville	TN	1672	
3	8	2017-12-01	1	NULL	NULL	NULL	8	Thacher	Naseby	1993-07-17	941-527-3977	538 Mosinee Center	Sarasota	FL	205	
4	2	2017-01-22	1	NULL	NULL	NULL	2	Ines	Brushfield	1986-04-13	804-427-9456	14187 Commercial Trail	Hampton	VA	947	
5	5	2017-08-25	2		2017-08-26	3	5	Clemmie	Betchley	1973-11-07	NULL	5 Spohn Circle	Arlington	TX	3675	
6	10	2018-11-18	1	Aliquam erat volutpat. In congue.	NULL	NULL	10	Levy	Mynett	1969-10-13	404-246-3370	68 Lawn Avenue	Atlanta	GA	796	
7	2	2018-09-22	2	NULL	2018-09-23	4	2	Ines	Brushfield	1986-04-13	804-427-9456	14187 Commercial Trail	Hampton	VA	947	
8	5	2018-06-08	1	Mauris enim leo, rhoncus sed, vestibulum sit amet,...	NULL	NULL	5	Clemmie	Betchley	1973-11-07	NULL	5 Spohn Circle	Arlington	TX	3675	
9	10	2017-07-05	2	Nulla mollis molestie lorem. Quisque ut erat.	2017-07-06	1	10	Levy	Mynett	1969-10-13	404-246-3370	68 Lawn Avenue	Atlanta	GA	796	
10	6	2018-04-22	2	NULL	2018-04-23	2	6	Elka	Twiddell	1991-09-04	312-480-8498	7 Manley Drive	Chicago	IL	3073	
*/
select c.customer_id, c.first_name, o.order_id
from customers c join orders o
on c.customer_id = o.customer_id
order by c.customer_id;
/*
customer_id   	first_name	order_id	
2	Ines	4	
2	Ines	7	
5	Clemmie	8	
5	Clemmie	5	
6	Elka	1	
6	Elka	10	
7	Ilene	2	
8	Thacher	3	
10	Levy	9	
10	Levy	6	
*/
select c.customer_id, c.first_name, o.order_id
from customers c left join orders o
on c.customer_id = o.customer_id
order by c.customer_id; #outer in left outer join optional
/*
customer_id   	first_name	order_id	
1	Babara	NULL	
2	Ines	4	
2	Ines	7	
3	Freddi	NULL	
4	Ambur	NULL	
5	Clemmie	8	
5	Clemmie	5	
6	Elka	1	
6	Elka	10	
7	Ilene	2	
8	Thacher	3	
9	Romola	NULL	
10	Levy	9	
10	Levy	6	
*/
select c.customer_id, c.first_name, o.order_id
from customers c right join orders o
on c.customer_id = o.customer_id
order by c.customer_id; #outer in right outer join optional
/*
customer_id   	first_name	order_id	
2	Ines	4	
2	Ines	7	
5	Clemmie	8	
5	Clemmie	5	
6	Elka	1	
6	Elka	10	
7	Ilene	2	
8	Thacher	3	
10	Levy	9	
10	Levy	6	
*/
select *
from products;
/*
product_id	name	quantity_in_stock	unit_price	
1	Foam Dinner Plate	70	1.21	
2	Pork - Bacon,back Peameal	49	4.65	
3	Lettuce - Romaine, Heart	38	3.35	
4	Brocolinni - Gaylan, Chinese	90	4.53	
5	Sauce - Ranch Dressing	94	1.63	
6	Petit Baguette	14	2.39	
7	Sweet Pea Sprouts	98	3.29	
8	Island Oasis - Raspberry	26	0.74	
9	Longan	67	2.26	
10	Broom - Push	6	1.09	
*/
select *
from order_items;
/*
order_id	product_id	quantity	unit_price	
1	4	4	3.74	
2	1	2	9.10	
2	4	4	1.66	
2	6	2	2.94	
3	3	10	9.12	
4	3	7	6.99	
4	10	7	6.40	
5	2	3	9.89	
6	1	4	8.65	
6	2	4	3.28	
6	3	4	7.46	
6	5	1	3.45	
7	3	7	9.17	
8	5	2	6.94	
8	8	2	8.59	
9	6	5	7.28	
10	1	10	6.01	
10	9	9	4.28
*/
select p.product_id, p.name, oi.quantity
from products p left join order_items oi
on p.product_id = oi.product_id;
/*
product_id	name	quantity	
1	Foam Dinner Plate	2	
1	Foam Dinner Plate	4	
1	Foam Dinner Plate	10	
2	Pork - Bacon,back Peameal	3	
2	Pork - Bacon,back Peameal	4	
3	Lettuce - Romaine, Heart	10	
3	Lettuce - Romaine, Heart	7	
3	Lettuce - Romaine, Heart	4	
3	Lettuce - Romaine, Heart	7	
4	Brocolinni - Gaylan, Chinese	4	
4	Brocolinni - Gaylan, Chinese	4	
5	Sauce - Ranch Dressing	1	
5	Sauce - Ranch Dressing	2	
6	Petit Baguette	2	
6	Petit Baguette	5	
7	Sweet Pea Sprouts	NULL	
8	Island Oasis - Raspberry	2	
9	Longan	9	
10	Broom - Push	7	
*/
select *
from shippers
/*
shipper_id	name	
1	Hettinger LLC	
2	Schinner-Predovic	
3	Satterfield LLC	
4	Mraz, Renner and Nolan	
5	Waters, Mayert and Prohaska	
*/
select c.customer_id, c.first_name, o.order_id, sh.name
from customers c left join orders o
on c.customer_id = o.customer_id
left join shippers sh
on o.shipper_id = sh.shipper_id
order by c.customer_id;
/*
customer_id   	first_name	order_id	name	
1	Babara	    NULL    NULL
2	Ines	7	Mraz, Renner and Nolan	
2	Ines	4	    NULL
3	Freddi	    NULL    NULL
4	Ambur	    NULL    NULL
5	Clemmie	5	Satterfield LLC	
5	Clemmie	8	    NULL
6	Elka	10	Schinner-Predovic	
6	Elka	1	    NULL
7	Ilene	2	Mraz, Renner and Nolan	
8	Thacher	3	    NULL
9	Romola	    NULL    NULL
10	Levy	6	    NULL
10	Levy	9	Hettinger LLC	
*/
select o.order_date, o.order_id, c.first_name, sh.name
from orders o join customers c
on o.customer_id = c.customer_id
left join shippers sh
on o.shipper_id = sh.shipper_id;
/*
order_date	order_id	first_name	name	
2019-01-30	1	Elka	NULL
2018-08-02	2	Ilene	Mraz, Renner and Nolan	
2017-12-01	3	Thacher	NULL
2017-01-22	4	Ines	NULL
2017-08-25	5	Clemmie	Satterfield LLC	
2018-11-18	6	Levy	NULL
2018-09-22	7	Ines	Mraz, Renner and Nolan	
2018-06-08	8	Clemmie	NULL
2017-07-05	9	Levy	Hettinger LLC	
2018-04-22	10	Elka	Schinner-Predovic	
*/
select *
from order_statuses
/*
order_status_id	name	
1	Processed	
2	Shipped	
3	Delivered	
*/
select o.order_date, o.order_id, c.first_name, sh.name as shipper, os.name as "status order"
from orders o join customers c
on o.customer_id = c.customer_id
left join shippers sh
on o.shipper_id = sh.shipper_id
join order_statuses os
on o.status = os.order_status_id
order by os.name, o.order_id;
/*
order_date	order_id	first_name	shipper	status order	
2019-01-30	1	Elka	NULL	Processed	
2017-12-01	3	Thacher	NULL	Processed	
2017-01-22	4	Ines	NULL	Processed	
2018-11-18	6	Levy	NULL	Processed	
2018-06-08	8	Clemmie	NULL	Processed	
2018-08-02	2	Ilene	Mraz, Renner and Nolan	Shipped	
2017-08-25	5	Clemmie	Satterfield LLC	Shipped	
2018-09-22	7	Ines	Mraz, Renner and Nolan	Shipped	
2017-07-05	9	Levy	Hettinger LLC	Shipped	
2018-04-22	10	Elka	Schinner-Predovic	Shipped	
*/
#Self outer join
select e.employee_id, e.first_name, m.first_name as "Manager and review self join"
from employees e join employees m
on e.reports_to = m.employee_id;
/*
employee_id	first_name	Manager and review self join	
33391	D'arcy	Yovonnda	
37851	Sayer	Yovonnda	
40448	Mindy	Yovonnda	
56274	Keriann	Yovonnda	
63196	Alaster	Yovonnda	
67009	North	Yovonnda	
67370	Elladine	Yovonnda	
68249	Nisse	Yovonnda	
72540	Guthrey	Yovonnda	
72913	Kass	Yovonnda	
75900	Virge	Yovonnda	
76196	Mirilla	Yovonnda	
80529	Lynde	Yovonnda	
80679	Mildrid	Yovonnda	
84791	Hazel	Yovonnda	
95213	Cole	Yovonnda	
96513	Theresa	Yovonnda	
98374	Estrellita	Yovonnda	
115357	Ivy	Yovonnda	
*/
select e.employee_id, e.first_name, m.first_name as "Manager"
from employees e left join employees m
on e.reports_to = m.employee_id;
/*
employee_id	first_name	Manager and review self join	
37270	Yovonnda	NULL
33391	D'arcy	Yovonnda	
37851	Sayer	Yovonnda	
40448	Mindy	Yovonnda	
56274	Keriann	Yovonnda	
63196	Alaster	Yovonnda	
67009	North	Yovonnda	
67370	Elladine	Yovonnda	
68249	Nisse	Yovonnda	
72540	Guthrey	Yovonnda	
72913	Kass	Yovonnda	
75900	Virge	Yovonnda	
76196	Mirilla	Yovonnda	
80529	Lynde	Yovonnda	
80679	Mildrid	Yovonnda	
84791	Hazel	Yovonnda	
95213	Cole	Yovonnda	
96513	Theresa	Yovonnda	
98374	Estrellita	Yovonnda	
115357	Ivy	Yovonnda	
*/
select o.order_id, c.first_name
from orders o join customers c
using (customer_id);
/*
order_id	first_name	
1	Elka	
2	Ilene	
3	Thacher	
4	Ines	
5	Clemmie	
6	Levy	
7	Ines	
8	Clemmie	
9	Levy	
10	Elka	
*/
select o.order_id, c.first_name, sh.name as shipper
from orders o join customers c
using (customer_id)
left join shippers sh
using (shipper_id);
/*
order_id	first_name	shipper	
1	Elka	NULL	
2	Ilene	Mraz, Renner and Nolan	
3	Thacher	NULL	
4	Ines	NULL	
5	Clemmie	Satterfield LLC	
6	Levy	NULL	
7	Ines	Mraz, Renner and Nolan	
8	Clemmie	NULL	
9	Levy	Hettinger LLC	
10	Elka	Schinner-Predovic	
*/
select *
from order_items oi join order_item_notes oin
on oi.order_id and oin.order_id
and oi.product_id = oin.product_id;
/*
order_id	product_id	quantity	unit_price	note_id	order_Id	product_id	note	
5	2	3	9.89	1	1	2	first note	
6	2	4	3.28	1	1	2	first note	
5	2	3	9.89	2	1	2	second note	
6	2	4	3.28	2	1	2	second note	
*/
select *
from order_items oi join order_item_notes oin
using(order_id,product_id);
/*
MySQL returned an empty result set
*/
select p.date, c.name as client, p.amount, pm.name as "payment method"
from innova18_sql_invoicing.payments p join innova18_sql_invoicing.clients c
using (client_id)
join innova18_sql_invoicing.payment_methods pm
on p.payment_method = pm.payment_method_id;
/*
date	client	amount	payment method	
2019-02-12	Topiclounge	8.18	Credit Card	
2019-01-03	Vinte	74.55	Credit Card	
2019-01-11	Yadel	0.03	Credit Card	
2019-01-26	Topiclounge	87.44	Credit Card	
2019-01-15	Yadel	80.31	Credit Card	
2019-01-15	Yadel	68.10	Credit Card	
2019-01-08	Topiclounge	32.77	Credit Card	
2019-01-08	Topiclounge	10.00	Cash	
*/
#Natural join.  Easy to code.  The database figures out the join.  User has no control.  Instructor doesn't recommend.
select o.order_id, c.first_name
from orders o natural join customers c;
/*
order_id	first_name	
1	Elka	
2	Ilene	
3	Thacher	
4	Ines	
5	Clemmie	
6	Levy	
7	Ines	
8	Clemmie	
9	Levy	
10	Elka	
*/
#Cross join.  Combine or join every record on the first table to every record on the second table.  Instructor said an example is one table with sizes small, medium, and large combine with a second table with colors.  Red small, red medium, red large, white small, white medium, white large, blue small, blue medium, blue large, etc.
select c.first_name, p.name
from customers c cross join products p
order by c.first_name;
#Union.  Combine two queries.  Combine multiple queries.
select order_id, order_date, 'Active' as "Custom column print Active"
from orders
where order_date >= '2019-01-01';
/*
order_id order_date Custom column print Active
1   2019-01-30  Active  
*/
select order_id, order_date, 'Archived' as "Custom column print Archived"
from orders
where order_date < '2019-01-01';
/*
order_id    order_date  Custom column print Archived    
2   2018-08-02  Archived    
3   2017-12-01  Archived    
4   2017-01-22  Archived    
5   2017-08-25  Archived    
6   2018-11-18  Archived    
7   2018-09-22  Archived    
8   2018-06-08  Archived    
9   2017-07-05  Archived    
10  2018-04-22  Archived    
*/
select order_id, order_date, 'Active' as "Custom column print Active"
from orders
where order_date >= '2019-01-01'
union
select order_id, order_date, 'Archived' as "Custom column print Archived"
from orders
where order_date < '2019-01-01';
/*
order_id    order_date  Custom column print Active  
1   2019-01-30  Active  
2   2018-08-02  Archived    
3   2017-12-01  Archived    
4   2017-01-22  Archived    
5   2017-08-25  Archived    
6   2018-11-18  Archived    
7   2018-09-22  Archived    
8   2018-06-08  Archived    
9   2017-07-05  Archived    
10  2018-04-22  Archived    
*/
#Can combine different columns names from different tables.  The number of columns must be the same for all tables.  RM:  Data types must be the same.
select first_name as "First query is column name"
from customers
union
select name
from shippers;
/*
First query is column name  
Babara  
Ines    
Freddi  
Ambur   
Clemmie 
Elka    
Ilene   
Thacher 
Romola  
Levy    
Hettinger LLC   
Schinner-Predovic   
Satterfield LLC 
Mraz, Renner and Nolan  
Waters, Mayert and Prohaska 
*/
select customer_id, first_name, points, 'Bronze' as type
from customers
where points > 0 and points < 2000
union
select customer_id, first_name, points, 'Silver' as type
from customers
where points >= 2000 and points < 3000
union
select customer_id, first_name, points, 'Gold' as type
from customers
where points >=3000
order by first_name;
/*
customer_id first_name      points  type    
4   Ambur   457 Bronze  
1   Babara  2273    Silver  
5   Clemmie 3675    Gold    
6   Elka    3073    Gold    
3   Freddi  2967    Silver  
7   Ilene   1672    Bronze  
2   Ines    947 Bronze  
10  Levy    796 Bronze  
9   Romola  1486    Bronze  
8   Thacher 205 Bronze  
*/
#Insert row, insert record
#default keyword for an auto increment column MySQL generates the unique value number for the auto increment column.  Also default keyword works for columns accepting null values.  And default keyword works for the column to accept the default value.  No need to include the column names for default and NULL values.  Columns for which values SQL inserted by default or use the default value are excluded from insert into values.  See the next SQL code.
insert into customers
values (default, 'John','Smith','1990-01-01',NULL,'address insert row','city','CA',default);
/*
customer_id first_name  last_name   birth_date  phone   address city    state   points  
11  John    Smith   1990-01-01      NULL    address insert row  city    CA  0   
*/
#Also work.  Columns for which values SQL inserted by default or use the default value are excluded from insert into values.  Remove default, NULL, and default since no column name mentioned in insert into tablename.  Indicate the column names to match the values from left to right.
insert into customers (first_name, last_name, birth_date,address,city,state)
values ('John','Smith','1990-01-01','address insert row','city','CA');
insert into shippers (name)
values ('Shipper 1 insert'),('Shipper 2 multiple'),('Shipper 3 values');
insert into products(name, quantity_in_stock,unit_price)
values ('Product1 no insert',10,1.95),('Product2 auto increment',20,2.95),('Product3 column product_id',30,3.95);
/*
product_id  name    quantity_in_stock   unit_price  
1   Foam Dinner Plate   70  1.21    
2   Pork - Bacon,back Peameal   49  4.65    
3   Lettuce - Romaine, Heart    38  3.35    
4   Brocolinni - Gaylan, Chinese    90  4.53    
5   Sauce - Ranch Dressing  94  1.63    
6   Petit Baguette  14  2.39    
7   Sweet Pea Sprouts   98  3.29    
8   Island Oasis - Raspberry    26  0.74    
9   Longan  67  2.26    
10  Broom - Push    6   1.09    
11  Product1 no insert  10  1.95    
12  Product2 auto increment 20  2.95    
13  Product3 column product_id  30  3.95    
*/
#Insert multiple rows in multiple tables at the same time
insert into orders (customer_id, order_date, status)
values (1,'2019-01-02',1);
/*
order_id    customer_id order_date  status  comments    shipped_date    shipper_id  
11  1   2019-01-02  1   NULL    NULL    NULL
*/
select last_insert_id(); #return 11
insert into orders (customer_id, order_date, status)
values (1,'2019-01-02',1); #inserted in orders table is order id 12
insert into order_items
values (last_insert_id(),1,1,2.95),(last_insert_id(),2,1,3.95);
/*
order_id    customer_id order_date  status  comments    shipped_date    shipper_id  
12  1   2019-01-02  1   NULL    NULL    NULL

order_id    product_id  quantity    unit_price  
12  1   1   2.95    
12  2   1   3.95    
*/
#Copy data to a new table.  First, create a new table.  The new table is a copy from an existing table.
create table orders_archived as
select * from orders;  #The orders_archived table no primary key and no auto increment attributes copied to orders_archived table.
#RM:  Trunicate table means delete all data or delete all rows.  Table remains.  Table not deleted.
insert into orders_archived
select *
from orders
where order_date < '2019-01-01';
#Update row, update data
update invoices
set payment_total = 10, payment_date = '2019-03-01'
where invoice_id = 1; #update multiple columns in one row
#RM:  pretend an error.  invoice_id = 1 should be invoice_id = 3.  Restore invoice_id = 1 to its default payment_total 0.00 and set payment_date to NULL.
update invoices
set payment_total = default, payment_date = NULL
where invoice_id = 1;
update invoices
set payment_total = invoice_total*.50, payment_date = due_date
where invoice_id = 3; #update multiple columns in one row using data from other columns
#Update multiple rows, update multiple data
update invoices
set payment_total = invoice_total*.50, payment_date = due_date
where client_id in (3,4);
update customers
set points = points + 50
where birth_date < '1990-01-01'; #Add 50 points to customers born before 1990
update invoices
set payment_total = invoice_total*.50, payment_date = due_date
where client_id = (
    select client_id
    from clients
    where name = 'Myworks');
update invoices
set payment_total = invoice_total*.50, payment_date = due_date
where client_id in (
    select client_id
    from clients
    where state in ('CA','NY'));
update orders
set comments = 'Add comment Gold customer for customers greater than 3,000 points'
where customer_id in (
    select customer_id
    from customers
    where points > 3000);
#Delete rows
#delete from *tablename* deletes all rows in a table or deletes all data
delete from invoices
where invoice_id = 1;
delete from invoices
where client_id = (
    select client_id
    from clients
    where name = 'Myworks');