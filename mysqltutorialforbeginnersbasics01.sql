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