#Subqueries in SQL [720p]
select max(capacity)
from roomsdatabase
where roomname like 'CAS%'; #return 500
select roomname, capacity
from roomsdatabase
where roomname like 'CAS%'
and capacity = (
    select max(capacity)
    from roomsdatabase
    where roomname like 'CAS%'); #return roomname(s) in CAS% with capacity 500
select name
from student
where id not in (
    select student_id
    from enrolled
    where coursename = 'CS 105'); #Set membership using in and not in

#SQL JOINS vs Subqueries [720p]
select *
from customers
where customerid not in (
    select customerid
    from orders);
#same as
select *
from customers c left join orders o
on c.customerid = o.customerid
where o.customerid is null;

#SQL Correlated Subqueries [720p]
select *
from customers
where customerid not in (
    select customerid
    from orders);  #return customers who didn't order
select *
from customers
where customerid not in (
    select distinct customerid
    from orders);  #instructor doesn't recommend distinct keyword
select customername, orderdate
from customers c join orders o
on c.customerid = o.customerid;
select customername, orderdate
from customers c join orders o
on c.customerid = o.customerid
where orderdate = (
    select max(orderdate)
    from orders subqueryo
    where subqueryo.customerid = c.customerid);  #return each customername and customername's latest orderdate in one row

#SQL_ Update using correlated subquery [720p]
create table heroes
    (id integer(3), name varchar(15), power varchar(20), city varchar(10), age integer(2), salary decimal(7,1));
insert into heroes
values(100,'Sarcastro','Razor wit','Akron',28,12);
insert into heroes
values(101,'Colin Mockery','Baldness','Toronto',45,30000);
insert into heroes
values(102,'Bathman','All wet','Chicago',6,240);
insert into heroes
values(104,'Sewer Man','Smells','Akron',25,35000);
insert into heroes
values(105,'American Maid','Partner in Grime','Chicago',38,7000);
insert into heroes
values(106,'Visible Man','Reflects photons','Berkeley',72,200000);
insert into heroes
values(107,'Sierra Girl','Keg Stands','West Sac',21,300);
insert into heroes
values(103,'Paperboy','Breaking windows','West Sac',14,5.5);
insert into heroes
values(108,'Sandman','','Toronto',null,5001);
insert into heroes
values(110,'Diaper Baby','Demand attention','Liverpool',0,200000);
insert into heroes
values(111,'Awesome Girl','Ambiguity','West Sac',28,55000);
create table raises
    (city varchar(10), raiseamt integer(3));
insert into raises
values('West Sac',100);
insert into raises
values('Toronto',50);
insert into raises
values('Akron',200);
insert into raises
values('Chicago',-10);
insert into raises
values('Liverpool',400);
insert into raises
values('Berkeley',250);
update heroes
set salary = salary + (
    select raiseamt
    from raises
    where raises.city = heroes.city);
select *
from heroes;
/*
id  name    power   city    age salary  
100 Sarcastro   Razor wit   Akron   28  212.0   
101 Colin Mockery   Baldness    Toronto 45  30050.0 
102 Bathman All wet Chicago 6   230.0   
104 Sewer Man   Smells  Akron   25  35200.0 
105 American Maid   Partner in Grime    Chicago 38  6990.0  
106 Visible Man Reflects photons    Berkeley    72  200250.0    
107 Sierra Girl Keg Stands  West Sac    21  400.0   
103 Paperboy    Breaking windows    West Sac    14  105.5   
108 Sandman     Toronto 
    NULL
    5051.0  
110 Diaper Baby Demand attention    Liverpool   0   200400.0    
111 Awesome Girl    Ambiguity   West Sac    28  55100.0 
*/

#Oracle SQL Subqueries [720p]
#Single row uncorrelated.  No performance problems.
select productname, to_char(suggestedprice, '$9,999.99') as price
from products
where suggestedprice >= (
    select avg(suggestedprice)
    from products);
#Single row uncorrelated having clause
select customers.firstname || ' ' || customers.lastname as customer, count(*)
from customers inner join orders using (customerid)
inner join orderlineitems using (orderid)
group by customers.firstname, customers.lastname
having count(*) > (
    select avg(count(*))
    from orders ordersubquery inner join orderlineitems orderlineitemssubquery using (orderid)
    group by customerid);
#Single row from clause subquery inline view which is a from clause including a subquery
select customers.firstname || ' ' || customers.lastname as customer, count(*)
from customers, orders, orderlineitems, (
    select productname, productid
    from products) fromsubqueryname
where customers.firstname = orders.customerid
and orders.orderid = orderlineitems.orderid
and orderlineitems.productid = fromsubqueryname.productid
group by customers.firstname, customers.lastname, fromsubqueryname.productname
order by customers.firstname, customers.lastname, fromsubqueryname.productname;
#Single row from clause subquery don't use inline view.  Use joins.
select customers.firstname || ' ' || customers.lastname as customer, products.productname, count(*)
from customers inner join orders using (customerid)
inner join orderlineitems using (orderid)
inner join products using (productid)
group by customers.firstname, customers.lastname, fromsubqueryname.productname
order by customers.firstname, customers.lastname, fromsubqueryname.productname;
#Multi row where clause uncorrelated subquery.  Inner query executed once and passed to the outer query.
select firstname || ' ' || lastname as "Multiple Address Customer having count greater than one"
from customers
where customerid in (
    select customerid
    from customeraddresses
    group by customerid
    having count(*) > 1);
#Multi row where clause correlated subquery.  Don't do this.  Can slow performance.
select employees.firstname || ' ' || employees.lastname as subordinate
from employees employeesquery
where exists (
    select 1
    from employees employeessubquery
    where employeessubquery.employeeid = employeesquery.managerid);