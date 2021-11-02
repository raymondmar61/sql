#RM:  save time run the create table and the insert into values SQL together.
#cPanel-->Databases-->MySQL Databases.  Under Create New Database, type database name at New Database: _*database name*.  Press Create Database.
#phpMyAdmin prescreeningquestionssqlanswers0721201605192016 database
#Create views table
create table orders
    (orderid integer(3) not null, itemid integer(3));
insert into orders
values(1,235);
insert into orders
values(1,200);
insert into orders
values(1,203);
insert into orders
values(2,235);
insert into orders
values(3,218);
insert into orders
values(3,205);
insert into orders
values(8,207);
insert into orders
values(7,230);
insert into orders
values(4,215);
insert into orders
values(5,220);
insert into orders
values(2,224);
insert into orders
values(4,226);
insert into orders
values(1,206);
insert into orders
values(3,200);
insert into orders
values(9,208);
insert into orders
values(3,212);
insert into orders
values(7,222);
insert into orders
values(8,237);
insert into orders
values(8,216);
insert into orders
values(6,203);
insert into orders
values(5,239);
insert into orders
values(1,235);
insert into orders
values(9,239);
insert into orders
values(4,214);
drop table orders;
create table itemprice
    (itemid integer(3), price decimal(5,2));
insert into itemprice
values(200,66.66);
insert into itemprice
values(203,109.27);
insert into itemprice
values(205,115.2);
insert into itemprice
values(206,17.2);
insert into itemprice
values(207,132.86);
insert into itemprice
values(208,110.4);
insert into itemprice
values(212,73.34);
insert into itemprice
values(214,83.83);
insert into itemprice
values(215,132.44);
insert into itemprice
values(216,123.73);
insert into itemprice
values(218,96.14);
insert into itemprice
values(220,36.42);
insert into itemprice
values(222,133.23);
insert into itemprice
values(224,107.03);
insert into itemprice
values(226,91.9);
insert into itemprice
values(230,136);
insert into itemprice
values(235,26.3);
insert into itemprice
values(237,49.03);
insert into itemprice
values(239,90.87);

#1.  Assume a table named order_details. It has order_id and item_id. An order can have multiple items - For ex., if a customer ordered cookies, chocolates, and bread, this would count as 3 items in one order. The question is to find the number of orders in each item count. The output of this query would be something like 100 orders had 1 item, 70 orders had 2 items, 30 had 3 items, and so on.  RM:  Override question.  Count the number of orders for each item.
select itemid, count(orderid)
from orders
group by itemid;

#2.  Second question is to find the number of orders whose total value is in the range of $0-$50, $51-$100, over $101. This table has two columns order_id and total_value. (table: order_value  RM:  table name is itemprice).  RM:  number of orders is range 100-129, 130-199, 200-299, 300 and over for variety.
#RM:  Warm-up not correct answer
select o.itemid, count(o.itemid)*i.price
from orders o, itemprice i
where o.itemid=i.itemid
group by o.itemid;
/*
itemid  count(o.itemid)*i.price 
200 133.32  
203 218.54  
205 115.20  
206 17.20   
207 132.86  
208 110.40  
212 73.34   
214 83.83   
215 132.44  
216 123.73  
218 96.14   
220 36.42   
222 133.23  
224 107.03  
226 91.90   
230 136.00  
235 78.90   
237 49.03   
239 181.74  
*/
#RM:  BEGIN CORRECT ANSWERS
select o.orderid, o.itemid, i.price, count(o.itemid)
from orders o, itemprice i
where o.itemid=i.itemid
group by o.orderid, o.itemid, i.price;
/*
orderid itemid  price   count(o.itemid) 
1   200 66.66   1   
1   203 109.27  1   
1   206 17.20   1   
1   235 26.30   2   
2   224 107.03  1   
2   235 26.30   1   
3   200 66.66   1   
3   205 115.20  1   
3   212 73.34   1   
3   218 96.14   1   
4   214 83.83   1   
4   215 132.44  1   
4   226 91.90   1   
5   220 36.42   1   
5   239 90.87   1   
6   203 109.27  1   
7   222 133.23  1   
7   230 136.00  1   
8   207 132.86  1   
8   216 123.73  1   
8   237 49.03   1   
9   208 110.40  1   
9   239 90.87   1   
*/
select o.orderid, o.itemid, i.price, count(o.itemid)*i.price
from orders o, itemprice i
where o.itemid=i.itemid
group by o.orderid, o.itemid, i.price;
/*
orderid itemid  price   count(o.itemid)*i.price 
1   200 66.66   66.66   
1   203 109.27  109.27  
1   206 17.20   17.20   
1   235 26.30   52.60   
2   224 107.03  107.03  
2   235 26.30   26.30   
3   200 66.66   66.66   
3   205 115.20  115.20  
3   212 73.34   73.34   
3   218 96.14   96.14   
4   214 83.83   83.83   
4   215 132.44  132.44  
4   226 91.90   91.90   
5   220 36.42   36.42   
5   239 90.87   90.87   
6   203 109.27  109.27  
7   222 133.23  133.23  
7   230 136.00  136.00  
8   207 132.86  132.86  
8   216 123.73  123.73  
8   237 49.03   49.03   
9   208 110.40  110.40  
9   239 90.87   90.87   
*/
select one, sum(four)
from
    (select o.orderid as "one", o.itemid "two", i.price "three", count(o.itemid)*i.price as "four"
    from orders o, itemprice i
    where o.itemid=i.itemid
    group by o.orderid, o.itemid, i.price) as love
group by one;
/*
select one, sum(four)
from (select o.orderid as "one", o.itemid "two", i.price "three", count(o.itemid)*i.price as "four"
from orders o, itemprice i
where o.itemid=i.itemid
group by o.orderid, o.itemid, i.price) as love
group by one
one sum(four)   
1   245.73  
2   133.33  
3   351.34  
4   308.17  
5   127.29  
6   109.27  
7   269.23  
8   305.62  
9   201.27  
*/
select casecolumnnameranges, count(casecolumnnameranges)
from (
    select sum(four), case when sum(four) <=199 then '100-199' when sum(four) <=299 then '200-299' else '300 and greater' end as casecolumnnameranges
    from
        (select o.orderid as "one", o.itemid "two", i.price "three", count(o.itemid)*i.price as "four"
        from orders o, itemprice i
        where o.itemid=i.itemid
        group by o.orderid, o.itemid, i.price) as love) as subtablefromstatement
group by casecolumnnameranges;
/*
300 and greater 1   
*/
select casecolumnnameranges, count(casecolumnnameranges)
from (
    select one, sum(four), case when sum(four) <=129 then '100-129' when sum(four) <=199 then '130-199' when sum(four) <=299 then '200-299' else '300 and greater' end as casecolumnnameranges
    from
        (select o.orderid as "one", o.itemid "two", i.price "three", count(o.itemid)*i.price as "four"
        from orders o, itemprice i
        where o.itemid=i.itemid
        group by o.orderid, o.itemid, i.price) as love
    group by one) as subtablefromstatement
group by casecolumnnameranges;
/*
casecolumnnameranges    count(casecolumnnameranges) 
100-129 2   
130-199 1   
200-299 3   
300 and greater 3   
*/

#3.  Similar to the second one, the third question is to get the total number of orders in $50 increments. (table: order_value)
select casecolumnnameranges, count(casecolumnnameranges)
from (
    select one, sum(four), case when sum(four) <=149 then '100-149' when sum(four) <=199 then '150-199' when sum(four) <=249 then '200-249' when sum(four) <=299 then '250-299' when sum(four) <=349 then '300-349' else '350 and greater' end as casecolumnnameranges
    from
        (select o.orderid as "one", o.itemid "two", i.price "three", count(o.itemid)*i.price as "four"
        from orders o, itemprice i
        where o.itemid=i.itemid
        group by o.orderid, o.itemid, i.price) as love
    group by one) as subtablefromstatement
group by casecolumnnameranges;
/*
casecolumnnameranges    count(casecolumnnameranges) 
100-149 3   
200-249 2   
250-299 1   
300-349 2   
350 and greater 1   
*/