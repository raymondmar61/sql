#RM:  save time run the create table and the insert into values SQL together.
#cPanel-->Databases-->MySQL Databases.  Under Create New Database, type database name at New Database: _*database name*.  Press Create Database.
#phpMyAdmin analystsql092017 database
#Database name analystsql092017
#Create items table
create table items
    (orderid integer(2), itemid integer(2), vlookupitem varchar(15), vlookupprice integer(3));
insert into items
values(1,2,'chocolate',75);
insert into items
values(2,9,'soda',5);
insert into items
values(3,2,'chocolate',75);
insert into items
values(3,10,'salt',4);
insert into items
values(4,13,'zucchini',3);
insert into items
values(5,5,'orange',7);
insert into items
values(5,12,'broccoli',3);
insert into items
values(5,14,'ice cream',4);
insert into items
values(5,19,'sauce',200);
insert into items
values(6,4,'apple',33);
insert into items
values(6,5,'orange',7);
insert into items
values(6,10,'salt',4);
insert into items
values(7,3,'bread',6);
insert into items
values(7,4,'apple',33);
insert into items
values(7,6,'chicken',10);
insert into items
values(7,15,'peanuts',3);
insert into items
values(8,16,'jam',5);
insert into items
values(8,20,'olive oil',120);
insert into items
values(9,4,'apple',33);
insert into items
values(10,6,'chicken',10);
insert into items
values(10,8,'water',1);
insert into items
values(12,12,'broccoli',3);
insert into items
values(13,6,'chicken',10);
insert into items
values(13,8,'water',1);
insert into items
values(14,17,'butter',4);
insert into items
values(15,2,'chocolate',75);
insert into items
values(16,7,'sausage',15);
insert into items
values(18,2,'chocolate',75);
insert into items
values(18,14,'ice cream',4);
insert into items
values(18,19,'sauce',200);
insert into items
values(19,3,'bread',6);
insert into items
values(19,7,'sausage',15);
insert into items
values(20,4,'apple',33);
insert into items
values(20,19,'sauce',200);
insert into items
values(21,5,'orange',7);
insert into items
values(23,3,'bread',6);
insert into items
values(23,11,'pepper',5);
insert into items
values(26,8,'water',1);
insert into items
values(27,11,'pepper',5);
insert into items
values(28,7,'sausage',15);
insert into items
values(29,18,'milk',40);
insert into items
values(30,15,'peanuts',3);
insert into items
values(30,17,'butter',4);
insert into items
values(31,1,'cookies',55);
insert into items
values(32,4,'apple',33);
insert into items
values(33,5,'orange',7);
insert into items
values(34,8,'water',1);
insert into items
values(34,12,'broccoli',3);
insert into items
values(35,14,'ice cream',4);
insert into items
values(35,17,'butter',4);
insert into items
values(36,1,'cookies',55);
insert into items
values(36,11,'pepper',5);
insert into items
values(36,18,'milk',40);
insert into items
values(37,10,'salt',4);
insert into items
values(38,10,'salt',4);
insert into items
values(39,8,'water',1);
insert into items
values(39,9,'soda',5);
insert into items
values(39,12,'broccoli',3);
insert into items
values(39,14,'ice cream',4);
insert into items
values(39,16,'jam',5);
insert into items
values(39,17,'butter',4);
insert into items
values(40,6,'chicken',10);
insert into items
values(41,18,'milk',40);
insert into items
values(42,6,'chicken',10);
insert into items
values(42,9,'soda',5);
insert into items
values(42,18,'milk',40);
insert into items
values(43,9,'soda',5);
insert into items
values(45,10,'salt',4);
insert into items
values(46,1,'cookies',55);
insert into items
values(46,19,'sauce',200);
insert into items
values(47,5,'orange',7);
insert into items
values(49,6,'chicken',10);
insert into items
values(49,12,'broccoli',3);
insert into items
values(50,9,'soda',5);
insert into items
values(50,15,'peanuts',3);
insert into items
values(50,18,'milk',40);
insert into items
values(53,16,'jam',5);
insert into items
values(55,3,'bread',6);
insert into items
values(55,13,'zucchini',3);
insert into items
values(56,8,'water',1);
insert into items
values(58,2,'chocolate',75);
insert into items
values(59,6,'chicken',10);
insert into items
values(59,14,'ice cream',4);
insert into items
values(60,2,'chocolate',75);
insert into items
values(61,6,'chicken',10);
insert into items
values(61,14,'ice cream',4);
insert into items
values(62,19,'sauce',200);
insert into items
values(63,2,'chocolate',75);
insert into items
values(63,12,'broccoli',3);
insert into items
values(64,18,'milk',40);
insert into items
values(65,12,'broccoli',3);
insert into items
values(66,3,'bread',6);
insert into items
values(66,4,'apple',33);
insert into items
values(66,7,'sausage',15);
insert into items
values(66,14,'ice cream',4);
insert into items
values(67,1,'cookies',55);
insert into items
values(67,5,'orange',7);
insert into items
values(69,4,'apple',33);
insert into items
values(69,14,'ice cream',4);
insert into items
values(70,10,'salt',4);

#Create orders table
create table orders
    (orderid integer(2) not null primary key, totalvalue integer(3));
insert into orders
values(1,75);
insert into orders
values(2,5);
insert into orders
values(3,79);
insert into orders
values(4,3);
insert into orders
values(5,214);
insert into orders
values(6,44);
insert into orders
values(7,52);
insert into orders
values(8,125);
insert into orders
values(9,33);
insert into orders
values(10,11);
insert into orders
values(12,3);
insert into orders
values(13,11);
insert into orders
values(14,4);
insert into orders
values(15,75);
insert into orders
values(16,15);
insert into orders
values(18,279);
insert into orders
values(19,21);
insert into orders
values(20,233);
insert into orders
values(21,7);
insert into orders
values(23,11);
insert into orders
values(26,1);
insert into orders
values(27,5);
insert into orders
values(28,15);
insert into orders
values(29,40);
insert into orders
values(30,7);
insert into orders
values(31,55);
insert into orders
values(32,33);
insert into orders
values(33,7);
insert into orders
values(34,4);
insert into orders
values(35,8);
insert into orders
values(36,100);
insert into orders
values(37,4);
insert into orders
values(38,4);
insert into orders
values(39,22);
insert into orders
values(40,10);
insert into orders
values(41,40);
insert into orders
values(42,55);
insert into orders
values(43,5);
insert into orders
values(45,4);
insert into orders
values(46,255);
insert into orders
values(47,7);
insert into orders
values(49,13);
insert into orders
values(50,48);
insert into orders
values(53,5);
insert into orders
values(55,9);
insert into orders
values(56,1);
insert into orders
values(58,75);
insert into orders
values(59,14);
insert into orders
values(60,75);
insert into orders
values(61,14);
insert into orders
values(62,200);
insert into orders
values(63,78);
insert into orders
values(64,40);
insert into orders
values(65,3);
insert into orders
values(66,58);
insert into orders
values(67,62);
insert into orders
values(69,37);
insert into orders
values(70,4);

#Q1 Table 'Items' has columns order_id and item_id. Each item_id is associated with an item. An order_id can have multiple associated items. For example, if a customer ordered cookies, chocolate, and bread, there would be 3 rows in the 'Items' table for this order, one for each of the 3 items. Find the number of orders of each order size, where order size is the number of items in an order. In the above example, order size would be 3 (cookies, chocolate, and bread). The output of your query would be something like 100 orders had 1 item, 70 orders had 2 items, 30 orders had 3 items, and so on
select orderid, count(itemid)
from items
group by orderid;

select countorders, count(countorders)
from (
    select count(itemid) as countorders
    from items
    group by orderid) as subtablefromstatement
group by countorders;
/*
countorders count(countorders)  
1   31  
2   18  
3   5   
4   3   
6   1   
RM:  confirmed correct
*/

#Q2: Table 'Orders' has columns order_id and total_value. Find the number of orders whose total value is in each of the following ranges: $0-$50, $51-$100, over $101. Column total_value has been rounded to integers.
select totalvalue, case when totalvalue <=50 then '0-50' when totalvalue <=100 then '51-100' else '101 and greater' end
from orders;

select casecolumnnameranges, count(casecolumnnameranges)
from (
    select totalvalue, case when totalvalue <=50 then '0-50' when totalvalue <=100 then '51-100' else '101 and greater' end as casecolumnnameranges
    from orders) as subtablefromstatement
group by casecolumnnameranges;
/*
casecolumnnameranges    count(casecolumnnameranges) 
0-50    40  
101 and greater 6   
51-100  12  
RM:  confirmed correct
*/