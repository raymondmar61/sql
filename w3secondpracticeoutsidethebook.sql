#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
#official solution
select *
from nobel_win
where year = 1970
order by case
	when subject in ('Economics','Chemistry') then 1 else 0 end asc,
subject, winner;

#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#5.Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
select *
from customer
where city <> 'New York'
or grade <= 100;  #RM:  incorrect.  It's a neither nor
select *
from customer
where not (city = 'New York' or grade > 100);  #RM:  correct.  It's neither nor.

#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from customer
where cust_name like 'B%';
#also
select *
from customer
where cust_name between 'A%' and 'C%';
#also
select *
from customer
where cust_name between 'A' and 'C';

#12. Write a SQL statement to find those rows from the table testtable which contain the escape character underscore ( _ ) in its column 'col1'.  #RM:  underscore _ is a wildcard character.
select *
from testtable
where col1 like '%/_%'escape '/';
#RM:  Oracle SQl escape character http://www.dba-oracle.com/t_special_characters_like_sql_query.htm
/*
set escape '\'
select stuff
from mytable
where mycool like '%\_to\_%';
#also
select stuff
from mytable
where mycool like '%\_to\_%' escape '\';
*/

#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance.
select count(grade)
from customer
where grade is not null;
#official solution
select count(all grade)
from customer;  #RM:  works for Oracle?

#23. Write a SQL query to display the average price of each company's products, along with their code.  #groupby group by group-by aggregate function before aggregate function first
select pro_com, avg(pro_price)
from item_mast
group by pro_com;
#also
select avg(pro_price), pro_com
from item_mast
group by pro_com;

#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php
#1. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.  #RM:  concatenate concat combine.  CONCAT() works for two arguments only.
select commission*100 || '%' as "Commission Percentage", salesman_id, name, city
from salesman;

#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
select o.*
from orders o inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on c.city <> s.city;  #incorrect.  Cartesian return.
select o.*
from orders o inner join customer c
and o.customer_id = c.customer_id
inner join salesman s
on s.salesman_id = c.salesman_id
and c.city <> s.city;    #incorrect.  Return nothing.
#official solution
select o.*
from salesman s, customer c, orders o
where c.city <> s.city
and o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;  #correct
#user solution
select o.*
from orders o inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on o.salesman_id = s.salesman_id
where c.city <> s.city;

#https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
#7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a form that the same column of each table will appear once and only the relational rows will come.
select o.*, c.*, s.*
from orders o, customer c, salesman s
where o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;  #RM:  printed all orders no duplicate matching columns from two or more tables
#official solution
select *
from orders
natural join customer
natural join salesman;  #user feedback:  Because NATURAL JOIN will compare ALL matched columns (with same column name), in this case both salesman_id and city will take into account, so that only 6 records are left, this is because city column has only three same cities: four records of NY, one London and one Paris.

#14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select s.name, c.cust_name
from salesman s left join customer c
on s.salesman_id = c.salesman_id
left join orders o
on c.customer_id = o.customer_id
where (o.purch_amt >= 2000
and c.grade is not null)
or o.purch_amt is null;

#25. Write a SQL query to display the name of each company along with the ID and price for their most expensive product.
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
	where i.pro_com = c.com_id);

