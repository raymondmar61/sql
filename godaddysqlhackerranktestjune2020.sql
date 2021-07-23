#phpMyAdmin innova18_godaddyjune2020 database

#Create tables
create table orderdetail
    (orderdate date, shopperid integer, orderid integer primary key, product varchar(30) primary key, revenue integer);  #RM:  I removed the primary key for product column when I uploaded the table
insert into orderdetail
values("2015/01/01",111,1000,"Website Builder",5);  #RM:  Uploading the data there are duplicate orderid for which orderid is a primary key.  I removed the primary key for orderid.
insert into orderdetail
values("2015/01/01",111,1000,"Domain Name",10);
insert into orderdetail
values("2015/02/02",135,1001,"Hosting",0);
insert into orderdetail
values("2015/02/03",148,1002,"Website Builder",1);
insert into orderdetail
values("2015/03/14",111,1003,"Domain Name",17);
insert into orderdetail
values("2015/03/31",148,1004,"Hosting",45);
insert into orderdetail
values("2015/04/28",153,1005,"SSL",60);
insert into orderdetail
values("2015/04/28",153,1005,"Domain Name",0);
drop table orderdetail;
create table shoppers
    (shopperid integer primary key, shoppername varchar(30), shopperfirstyearspend integer);
insert into shoppers
values(111,"Batman",22139);
insert into shoppers
values(135,"Superman",1);
insert into shoppers
values(148,"The Hulk",230);
insert into shoppers
values(153,"Riddler",99);
insert into shoppers
values(166,"Penguin",572);
insert into shoppers
values(197,"Joker",32);
create table websitevisits
    (visitdate date, shopperid integer, minutesonsite integer);
insert into websitevisits
values("2015-01-01",111,4);
insert into websitevisits
values("2015-01-06",123,1);
insert into websitevisits
values("2015-01-14",104,5);
insert into websitevisits
values("2015-01-16",148,12);
insert into websitevisits
values("2015-02-01",197,2);
insert into websitevisits
values("2015-02-02",135,12);
insert into websitevisits
values("2015-02-03",148,6);
insert into websitevisits
values("2015-02-03",112,3);
insert into websitevisits
values("2015-02-04",111,7);
insert into websitevisits
values("2015-02-09",152,7);
insert into websitevisits
values("2015-03-13",167,22);
insert into websitevisits
values("2015-03-31",148,16);
insert into websitevisits
values("2015-04-02",153,14);
insert into websitevisits
values("2015-04-14",111,2);
insert into websitevisits
values("2015-04-28",153,30);

#1 Return each unique shoppername and product purchased combination
#initial answer
select s.shoppername, o.product
from shoppers s, orderdetail o
where s.shopperid = o.shopperid;
/*
shoppername product 
Batman  Website Builder 
Batman  Domain Name 
Superman    Hosting 
The Hulk    Website Builder 
Batman  Domain Name 
The Hulk    Hosting 
Riddler SSL 
Riddler Domain Name 
*/
#second try answer  #RM:  there are two Batman Domain Name
select distinct s.shoppername, o.product
from shoppers s, orderdetail o
where s.shopperid = o.shopperid;
/*
shoppername product 
Batman  Website Builder 
Batman  Domain Name 
Superman    Hosting 
The Hulk    Website Builder 
The Hulk    Hosting 
Riddler SSL 
Riddler Domain Name 
*/
#2 Return each product and the revenue from orderdetail associated with that product
select product, sum(revenue)
from orderdetail
group by product;
#3 Return all shoppername who spent a total of $0 in orderdetail, include those that do not exist in orderdetail.
#initial answer
select s.shoppername  #returned zero rows
from shoppers s, orderdetail o
where s.shopperid = o.shopperid
and s.shopperid not in (
    select shopperid
    from orderdetail)
and o.revenue = 0;
#second try answer
select s.shoppername as 'Shoppers sum zero revenue and not shopped'
from shoppers s join orderdetail o
on s.shopperid = o.shopperid
group by s.shoppername
having sum(o.revenue) = 0
union
select s.shoppername
from shoppers s
where s.shopperid not in (
    select o.shopperid
    from orderdetail o);
/*
Shoppers sum zero revenue and not shopped   
Superman    
Penguin 
Joker   
*/
#4 Return each shoppername and the total revenue from their first order in orderdetail.  Exclude shoppers with no orders in orderdetail.
#no initial answer submitted
#incomplete answer
select s.shoppername, s.orderdate, sum(o.revenue)
from shoppers s, orderdetail o
where s.shopperid = o.shopperid
group by s.shoppername, s.orderdate;
#second try answer
select s.shoppername, sum(o.revenue)
from shoppers s join orderdetail o
on s.shopperid = o.shopperid
where o.orderid in (
    select o2.orderid as 'o.orderid', min(o2.orderdate)
    from orderdetail o2
    group by o2.shopperid)
group by s.shoppername;
/*
#1241 - Operand should contain 1 column(s)
*/
select s.shoppername, sum(o.revenue)
from shoppers s join orderdetail o
on s.shopperid = o.shopperid
where o.orderid in (
    select orderid
    from orderdetail
    group by shopperid
    having orderdate = min(orderdate))
group by s.shoppername;
/*
shoppername sum(o.revenue)  
Batman  15  
Riddler 60  
Superman    0   
The Hulk    1   
*/
#5 Return each shoppername and the average time rounded to the nearest minute as an integer for only the shoppers who made a purchase.  Exclude shoppers with no orders in orderdetail.  RM:  I assume a zero purchase in orderdetail is a purchase at zero revenue.
#no initial answer submitted
select s.shoppername, round(avg(w.minutesonsite),0)
from shoppers s, websitevisits w
where s.shopperid = w.shopperid
and w.shopperid in (
    select shopperid
    from orderdetail)
group by w.shopperid;
/*
shoppername round(avg(w.minutesonsite),0)   
Batman  4   
Superman    12  
The Hulk    11  
Riddler 22  
*/
