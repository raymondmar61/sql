/*
Q1: Table ‘Items’ has columns order_id and item_id. Each item_id is associated with an item. An order_id can have multiple associated items. For example, if a customer ordered cookies, chocolate, and bread, there would be 3 rows in the ‘Items’ table for this order, one for each of the 3 items. Find the number of orders of each order size, where order size is the number of items in an order. In the above example, order size would be 3 (cookies, chocolate, and bread). The output of your query would be something like 100 orders had 1 item, 70 orders had 2 items, 30 orders had 3 items, and so on

Q2: Table ‘Orders’ has columns order_id and total_value. Find the number of orders whose total value is in each of the following ranges: $0-$50, $51-$100, over $101. Column total_value has been rounded to integers.

Oracle SQL Developer table is hr2passwordishr
*/
create table items (orderid number(3), itemid number(3), item varchar(50));

insert into items values (100, 1, 'cookies');
insert into items values (100, 2, 'chocolate');
insert into items values (100, 3, 'bread');
insert into items values (100, 4, 'milk');
insert into items values (101, 2, 'chocolate');
insert into items values (102, 3, 'bread');
insert into items values (103, 4, 'milk');
insert into items values (104, 1, 'cookies');
insert into items values (104, 2, 'chocolate');
insert into items values (104, 3, 'bread');
insert into items values (105, 3, 'bread');
insert into items values (105, 4, 'milk');
insert into items values (105, 5, 'fish');

delete from items where orderid = 100 and itemid = 1;
delete from items where orderid = 100;

select *
from items;

select *
from items
group by orderid; --error message because can't group by all columns.  Must include orderid in select clause

select orderid, count(orderid)
from items
group by orderid;  --return orderid and the count of orders for each orderid

select orderid, count(itemid)
from items
group by orderid
order by orderid;  --return orderid and the count of orders for each itemid

/* template for group by count of counts https://stackoverflow.com/questions/8338607/sql-group-by-count-of-counts
SELECT countitemidforeachorderid, COUNT(1) as groupedcount
FROM
(
    SELECT orderid, count(itemid) as countitemidforeachorderid
    FROM items
    Group By orderid 

) MyTable
GROUP BY countitemidforeachorderid
*/

/*
select "Order Size", count(1) as "Number of Orders Order Size"
from
(
    select orderid, count(itemid) as "Order Size"
    from items
    group By orderid 

) MyTable
group by "Order Size"
order by "Order Size";  --double quotes for alias.  Alias is case sensitive.
*/

select "Order Size", count(1) as "Number of Orders Order Size"
from
(
    select order_id, count(item_id) as "Order Size"
    from Items
    group By order_id
) MyTable
group by "Order Size"
order by "Order Size";  --double quotes for alias.  Alias is case sensitive.

/*
Q2: Table ‘Orders’ has columns order_id and total_value. Find the number of orders whose total value is in each of the following ranges: $0-$50, $51-$100, over $101. Column total_value has been rounded to integers.
*/
create table orders (orderid number(3), totalvalue number);

insert into orders values (100, 107);
insert into orders values (101, 25);
insert into orders values (102, 53);
insert into orders values (103, 5);
insert into orders values (104, 220);
insert into orders values (105, 1500);

select *
from orders;

select count(orderid)
from orders
where totalvalue >=0 and totalvalue <=50; --2
select count(orderid)
from orders
where totalvalue >=51 and totalvalue <=100; --1
select count(orderid)
from orders
where totalvalue >=101; --3

/*template for group by ranges https://stackoverflow.com/questions/232387/in-sql-how-can-you-group-by-in-ranges
select mytable2.range as scorerange, count(*) as numberofoccurences
from (
select case
when totalvalue between 0 and 50 then '0-50'
when totalvalue between 51 and 100 then '51-100'
else '101+' end as range
from orders) mytable2
group by mytable2.range;
*/

/* 
select mytable2.ranges as "Total Value Range", count(*) as "Number of Orders Range"
from (
	select case
		when totalvalue >=0 and totalvalue <=50 then '0-50'
		when totalvalue >=51 and totalvalue <=100 then '51-100'
		else 'greater 101+' end as ranges
	from orders) mytable2
group by mytable2.ranges
order by mytable2.ranges;
*/

select MyTable2.ranges as "Total Value Range", count(*) as "Number of Orders Range"
from (
	select case
		when total_value >=0 and total_value <=50 then '0-50'
		when total_value >=51 and total_value <=100 then '51-100'
		else 'greater 101+' end as ranges
	from Orders) MyTable2
group by MyTable2.ranges
order by MyTable2.ranges;