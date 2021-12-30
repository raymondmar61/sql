#Subquery as a data source
select movies.mov_title, tablealiasratingreviewer.rev_name, tablealiasratingreviewer.rev_stars
from movies inner join (
    select rating.mov_id, rating.rev_id, reviewer.rev_name, rating.rev_stars
    from rating inner join reviewer
    on rating.rev_id = reviewer.rev_id
    where rev_stars is not null) as tablealiasratingreviewer
on movies.mov_id = tablealiasratingreviewer.mov_id
order by movies.mov_title;
/*
mov_title       rev_name    rev_stars   
Aliens  Brandt Sponseller   8.4 
American Beauty Sasha Goldshtein    7.0 
Annie Hall  Mike Salvati    8.1 
Avatar  Victor Woeltjen 7.3 
Beyond the Sea  Richard Adams   6.7 
Blade Runner        8.2 
Boogie Nights   Paul Monks  3.0 
Braveheart  Krug Stillo 7.7 
Donnie Darko    Hannah Steele   8.1 
Good Will Hunting   Josh Cates  4.0 
Lawrence of Arabia  Flagrant Baronessa  8.3 
Princess Mononoke       8.4 
Slumdog Millionaire Vincent Cadena  8.0 
The Innocents   Jack Malvern    7.9 
The Usual Suspects  Simon Wright    8.6 
Titanic Righty Sock 7.7 
Vertigo Righty Sock 8.4 
*/

#Subquery in selection criteria
select *
from movies
where mov_id in (
    select mov_id
    from rating
    where num_o_ratings >= 500000);
/*
mov_id  mov_title   mov_year    mov_time    mov_lang    mov_dt_rel  mov_rel_country 
908 The Usual Suspects  1995    106 English 1995-08-25  UK  
914 American Beauty 1999    122 English 0000-00-00  UK  
915 Titanic 1997    194 English 1998-01-23  UK  
916 Good Will Hunting   1997    126 English 1998-06-03  UK  
918 Trainspotting   1996    94  English 1996-02-23  UK  
920 Donnie Darko    2001    113 English 0000-00-00  UK  
921 Slumdog Millionaire 2008    120 English 2009-01-09  UK  
922 Aliens  1986    137 English 1986-08-29  UK  
*/

#Subquery as a calculated column
select salesman.salesman_id, salesman.name, (
    select count(ord_no)
    from orders
    where salesman.salesman_id = orders.salesman_id) as "column alias number of orders"
from salesman
order by salesman.salesman_id;
/*
salesman_id     name    column alias number of orders   
5001    James Hoog  4   
5002    Nail Knite  3   
5003    Lauson Hen  2   
5005    Pit Alex    1   
5006    Mc Lyon 1   
5007    Paul Adam   1   
*/
#Inner join and group by equivalent
select salesman.salesman_id, salesman.name, count(orders.ord_no)
from salesman inner join orders
on salesman.salesman_id = orders.salesman_id
group by salesman.salesman_id, salesman.name
order by salesman.salesman_id;
/*
salesman_id     name    count(orders.ord_no)    
5001    James Hoog  4   
5002    Nail Knite  3   
5003    Lauson Hen  2   
5005    Pit Alex    1   
5006    Mc Lyon 1   
5007    Paul Adam   1   
*/

#Correlated Subquery example from book.  Create a list of customers total order about less than 20 dollars.  The subquery is correlated because it can't be executed on its own. customers.customerid doesn't exist within the context of the subquery.
select customername as "customer name"
from customers
where (
    select sum(orderamount)
    from orders
    where customers.customerid = orders.customerid) < 20;
#It's like . . .
select customername as "customer name"
from customers
where subqueryresult < 20;
#Joins and groups equivalent
select customername as "customer name"
from customers left join orders
on customers.customerid = orders.customerid
group by customers.customerid, customername
having sum(orderamount) < 20;
#Correlated Subquery exists operator example from book.
select customername as "customer name"
from customers
where exists (
    select *
    from orders
    where customers.customerid = orders.customerid);
#Subquery in selection criteria equivalent
select customername as "customer name"
from customers
where customerid in (
    select customerid
    from orders);