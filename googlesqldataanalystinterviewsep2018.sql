#cPanel-->Databases-->MySQL Databases.  Under Create New Database, type database name at New Database: _*database name*.  Press Create Database.

#create tables and insert values
create table employees
(employeeid integer primary key, startdate date);
insert into employees
values(6978,"2008/04/01");
insert into employees
values(3765,"2012/03/21");
insert into employees
values(9463,"2011/06/04");
insert into employees
values(5163,"2011/09/15");
insert into employees
values(1783,"2017/10/18");
insert into employees
values(723,"2010/10/06");
insert into employees
values(2022,"2016/11/23");
insert into employees
values(9459,"2011/08/04");
insert into employees
values(954,"2011/11/19");
insert into employees
values(154,"2012/08/07");
insert into employees
values(8230,"2014/10/19");
insert into employees
values(904,"2008/01/22");
insert into employees
values(6733,"2010/12/01");
insert into employees
values(9068,"2015/11/10");
insert into employees
values(8703,"2010/08/28");
insert into employees
values(2137,"2018/07/06");
insert into employees
values(3498,"2011/10/25");
insert into employees
values(4674,"2009/10/28");
insert into employees
values(6866,"2011/03/10");
insert into employees
values(9028,"2010/08/31");
insert into employees
values(8009,"2015/02/24");
insert into employees
values(6929,"2012/02/01");
insert into employees
values(4646,"2011/05/11");
insert into employees
values(7808,"2014/04/10");
insert into employees
values(4141,"2016/03/13");
insert into employees
values(7208,"2017/04/12");
insert into employees
values(2604,"2018/03/26");
insert into employees
values(4889,"2008/03/08");
insert into employees
values(990,"2013/01/07");
insert into employees
values(9743,"2013/12/05");
insert into employees
values(5984,"2008/03/21");
insert into employees
values(7753,"2015/11/08");
insert into employees
values(8679,"2014/10/21");
insert into employees
values(7698,"2016/05/30");
insert into employees
values(1799,"2016/01/24");
insert into employees
values(3108,"2012/02/14");
insert into employees
values(7549,"2008/01/30");
insert into employees
values(8299,"2012/02/18");
insert into employees
values(9008,"2014/11/16");
insert into employees
values(2575,"2012/01/05");
insert into employees
values(7450,"2017/01/21");
insert into employees
values(8018,"2018/06/21");
insert into employees
values(5765,"2016/10/01");
insert into employees
values(6038,"2016/02/06");
insert into employees
values(9630,"2011/06/11");
insert into employees
values(1273,"2015/06/28");
insert into employees
values(536,"2012/06/14");
insert into employees
values(3257,"2017/10/31");
insert into employees
values(9497,"2016/12/10");
insert into employees
values(1708,"2015/02/15");
insert into employees
values(5630,"2018/05/23");
insert into employees
values(5716,"2012/07/04");
insert into employees
values(6786,"2014/08/16");
insert into employees
values(1264,"2012/12/27");
insert into employees
values(7678,"2010/03/15");
insert into employees
values(7352,"2018/06/17");
insert into employees
values(4262,"2010/11/04");
insert into employees
values(4402,"2011/04/12");
insert into employees
values(6013,"2010/04/30");
insert into employees
values(808,"2015/11/23");
create table promotions
(employeeid integer primary key, promotiondate date, promotion varchar(1));
insert into promotions
values(6978,"2018/12/27","Y");
insert into promotions
values(3765,"2014/01/16","Y");
insert into promotions
values(9463,"2017/11/15","Y");
insert into promotions
values(5163,"","N");
insert into promotions
values(1783,"","N");
insert into promotions
values(723,"","N");
insert into promotions
values(2022,"2018/07/23","Y");
insert into promotions
values(9459,"","N");
insert into promotions
values(954,"","N");
insert into promotions
values(154,"2021/04/24","Y");
insert into promotions
values(8230,"2019/01/23","Y");
insert into promotions
values(904,"","N");
insert into promotions
values(6733,"2017/06/28","Y");
insert into promotions
values(9068,"","N");
insert into promotions
values(8703,"","N");
insert into promotions
values(2137,"2018/09/23","Y");
insert into promotions
values(3498,"2012/04/10","Y");
insert into promotions
values(4674,"","N");
insert into promotions
values(6866,"2012/08/10","Y");
insert into promotions
values(9028,"","N");
insert into promotions
values(8009,"2019/03/14","Y");
insert into promotions
values(6929,"","N");
insert into promotions
values(4646,"2021/11/23","Y");
insert into promotions
values(7808,"2022/12/03","Y");
insert into promotions
values(4141,"2023/03/31","Y");
insert into promotions
values(7208,"","N");
insert into promotions
values(2604,"","N");
insert into promotions
values(4889,"","N");
insert into promotions
values(990,"2013/09/05","Y");
insert into promotions
values(9743,"2015/10/19","Y");
insert into promotions
values(5984,"","N");
insert into promotions
values(7753,"2026/03/17","Y");
insert into promotions
values(8679,"2017/02/10","Y");
insert into promotions
values(7698,"","N");
insert into promotions
values(1799,"","N");
insert into promotions
values(3108,"2020/09/14","Y");
insert into promotions
values(7549,"","N");
insert into promotions
values(8299,"","N");
insert into promotions
values(9008,"","N");
insert into promotions
values(2575,"2012/08/17","Y");
insert into promotions
values(7450,"2017/10/19","Y");
insert into promotions
values(8018,"","N");
insert into promotions
values(5765,"","N");
insert into promotions
values(6038,"2019/06/14","Y");
insert into promotions
values(9630,"","N");
insert into promotions
values(1273,"2021/12/05","Y");
insert into promotions
values(536,"2020/09/02","Y");
insert into promotions
values(3257,"2024/05/27","Y");
insert into promotions
values(9497,"2018/03/24","Y");
insert into promotions
values(1708,"","N");
insert into promotions
values(5630,"","N");
insert into promotions
values(5716,"2019/01/29","Y");
insert into promotions
values(6786,"","N");
insert into promotions
values(1264,"","N");
insert into promotions
values(7678,"2016/12/09","Y");
insert into promotions
values(7352,"","N");
insert into promotions
values(4262,"","N");
insert into promotions
values(4402,"2011/12/22","Y");
insert into promotions
values(6013,"2015/01/29","Y");
insert into promotions
values(808,"2023/03/20","Y");
update promotions
set promotiondate = null
where promotiondate = "0000-00-00";
create table itemssold
(item varchar(20), weight integer, confidence decimal(2,1), quantitysold integer);
insert into itemssold
values("baseball",1,6.1,1);
insert into itemssold
values("black pen",1,2.3,1);
insert into itemssold
values("black pen",2,2.9,2);
insert into itemssold
values("blender",2,4.6,1);
insert into itemssold
values("blue pen",1,2.9,1);
insert into itemssold
values("blue pen",2,10,2);
insert into itemssold
values("board game",13,6.1,1);
insert into itemssold
values("book",5,2.7,1);
insert into itemssold
values("CD",1,8.6,1);
insert into itemssold
values("cough drops",1,3.8,1);
insert into itemssold
values("cough drops",2,8,2);
insert into itemssold
values("cup",1,7.8,1);
insert into itemssold
values("cup",5,8.4,5);
insert into itemssold
values("fork",1,10,1);
insert into itemssold
values("laptop",3,7.6,1);
insert into itemssold
values("laptop",6,2.5,2);
insert into itemssold
values("light bulb",1,2.9,1);
insert into itemssold
values("light bulb",3,3.2,3);
insert into itemssold
values("light bulb",5,6.6,5);
insert into itemssold
values("manniquin",20,6.5,1);
insert into itemssold
values("mirror",20,8.1,1);
insert into itemssold
values("monitor",55,6.6,1);
insert into itemssold
values("orange",5,8.5,1);
insert into itemssold
values("orange",10,8.8,2);
insert into itemssold
values("outlet",1,5,1);
insert into itemssold
values("outlet",5,9.7,5);
insert into itemssold
values("outlet",10,2.8,10);
insert into itemssold
values("outlet",3,8.1,3);
insert into itemssold
values("paper",20,8.7,1);
insert into itemssold
values("paper",50,7.6,3);
insert into itemssold
values("plant",5,7.2,1);
insert into itemssold
values("plant",7,4,1);
insert into itemssold
values("rake",3,6.4,1);
insert into itemssold
values("rake",7,4.3,2);
insert into itemssold
values("rake",9,7.2,3);
insert into itemssold
values("sauce",1,6.4,1);
insert into itemssold
values("sauce",2,1.9,2);
insert into itemssold
values("sauce",50,5.3,50);
insert into itemssold
values("screw",1,3.8,1);
insert into itemssold
values("shoes",3,10,1);
insert into itemssold
values("shoes",6,3.7,2);
insert into itemssold
values("sign",7,1.3,1);
insert into itemssold
values("sign",14,2.2,2);
insert into itemssold
values("sofa",50,5.6,1);
insert into itemssold
values("sofa",100,10,2);
insert into itemssold
values("sofa",20,2.4,0);
insert into itemssold
values("speakers",76,7,1);
insert into itemssold
values("towel",1,7,1);
insert into itemssold
values("windshield wipers",1,2.5,1);
insert into itemssold
values("windshield wipers",99,3.3,99);
create table iteminventory
(numberid integer primary key, item varchar(20), weight integer, confidence decimal(2,1));
insert into iteminventory
values(1,"blue pen",1,4.3);
insert into iteminventory
values(2,"black pen",1,7.7);
insert into iteminventory
values(3,"board game",13,3.6);
insert into iteminventory
values(4,"monitor",55,1.8);
insert into iteminventory
values(5,"celery",1,3.6);
insert into iteminventory
values(6,"car",5,2.3);
insert into iteminventory
values(7,"paper",20,2.4);
insert into iteminventory
values(8,"laptop",3,3);
insert into iteminventory
values(9,"sign",7,5.8);
insert into iteminventory
values(10,"CD",1,1.7);
insert into iteminventory
values(11,"speakers",76,4.1);
insert into iteminventory
values(12,"cake",1,4.2);
insert into iteminventory
values(13,"sauce",1,5.9);
insert into iteminventory
values(14,"plant",5,3.3);
insert into iteminventory
values(15,"light bulb",1,2.3);
insert into iteminventory
values(16,"fabric",10,3.5);
insert into iteminventory
values(17,"book",5,5.5);
insert into iteminventory
values(18,"blender",2,6.1);
insert into iteminventory
values(19,"fork",1,6.7);
insert into iteminventory
values(20,"pizza",1,1.4);
insert into iteminventory
values(21,"shirt",2,8.1);
insert into iteminventory
values(22,"sofa",50,1.9);
insert into iteminventory
values(23,"outlet",1,2);
insert into iteminventory
values(24,"manniquin",20,7.2);
insert into iteminventory
values(25,"towel",1,3.8);
insert into iteminventory
values(26,"baseball",1,6);
insert into iteminventory
values(27,"shoes",3,9.9);
insert into iteminventory
values(28,"picture",10,7.4);
insert into iteminventory
values(29,"rake",3,6.2);
insert into iteminventory
values(30,"mirror",20,7.1);
insert into iteminventory
values(31,"bear",1,5.8);
insert into iteminventory
values(32,"calendar",1,1.8);
insert into iteminventory
values(33,"orange",5,8.5);
insert into iteminventory
values(34,"screw",1,9.1);
insert into iteminventory
values(35,"cough drops",1,3.5);
insert into iteminventory
values(36,"shampoo",2,2.3);
insert into iteminventory
values(37,"chair",30,9.1);
insert into iteminventory
values(38,"windshield wipers",1,6.9);
insert into iteminventory
values(39,"dice",1,8.3);
insert into iteminventory
values(40,"cup",1,7.6);

#How many employees were not promoted?   Answer is 29.
select count(*)
from promotions
where promotion = "N"; #return 29  #RM:  I added promotion column to promotions table.
select count(*)
from promotions
where promotiondate is null; #return 29  #RM:  I update promotions table replacing "0000-00-00" with null

#Retrieve employees who were promoted from employees table and promotions table 
select e.employeeid, e.startdate as "employee start date", p.promotiondate as "employee promotion date"
from employees e join promotions p
on e.employeeid = p.employeeid
where p.promotiondate is not null; #return 24 rows
#Retrieve all columns from employees table and promotions table
select *
from employees e join promotions p
on e.employeeid = p.employeeid;

#How many items sold have the maximum confidence number?  Answer is 4.
select count(*)
from itemssold
where confidence in (
    select max(confidence)
    from itemssold); #return 4
