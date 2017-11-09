--Sams Teach Yourself SQL In 10 Minutes by Ben Forta
--Primary key values can never be reused. (If a row is deleted from the table, its primary key may not be assigned to any new rows in the future.)
--Appendix E SQL Reserved Words list most common reserved words.

--Lesson 2 Retrieving Data 24 pdf page (13 book page)
--As a rule, you are better off not using the * wildcard unless you really do need every column in the table. Even though use of wildcards may save you the time and effort needed to list the desired columns explicitly, retrieving unnecessary columns usually slows down the performance of your retrieval and your application.
select prod_id, prod_name, prod_price
from products;

--Lesson 3 Sorting Retrieved Data 30 (19)
select prod_id, prod_price, prod_name
from products
order by prod_price desc, prod_name; --order by 2 desc, 3; also works sort prod_price and prod_name

--Lesson 4 Filtering Data 37 (26)
select trim(prod_name) as "prod_name", prod_price
from products
where prod_price = 3.49;
select trim(prod_name) as "prod_name", prod_price
from products
where prod_price < 10;
select vend_id, trim(prod_name)
from products
where vend_id <> 'DLL01';
select trim(prod_name), prod_price
from products
where prod_price between 3.49 and 10;  --between is inclusive
select vend_id
from vendors
where vend_state is null;

--Lesson 5 Advanced Data Filtering 44 (33)
select prod_id, prod_price, trim(prod_name)
from products
where vend_id = 'DLL01' and prod_price <=4;
select trim(prod_name), prod_price
from products
where vend_id = 'DLL01' or vend_id = 'BRS01';
/* order of evaluation. SQL processes AND operators before OR operators. */
select trim(prod_name), prod_price
from products
where (vend_id = 'DLL01' or vend_id = 'BRS01') and prod_price >=10;
select trim(prod_name), prod_price
from products
where vend_id in ('DLL01','BRS01')
order by prod_name;  --IN operators almost always execute more quickly than lists of OR operators.
select trim(prod_name), vend_id
from products
where vend_id not in ('DLL01')  --vend_id <> 'DLL01' also works
order by prod_name;

--Lesson 6 Using Wildcard Filtering 51 (40)
--Within a search string, % means match any number of occurrences of any character.  RM:  not asterik * for wildcard
select prod_id, trim(prod_name)
from products
where prod_name like 'Fish%';
select prod_id, trim(prod_name)
from products
where prod_name like '%bean bag%';
--The underscore (_) matches a single character
select prod_id, trim(prod_name)
from products
where prod_name like '__ inch teddy bear%';
--The brackets ([]) wildcard is used to specify a set of characters, any one of which must match a character in the specified position (the location of the wildcard).  RM:  doesn't work for Oracle
select cust_contact
from customers
where cust_contact like 'J%' or cust_contact like 'M%'
order by cust_contact;
--start page 59 pdf