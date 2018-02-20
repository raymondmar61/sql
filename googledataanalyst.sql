--create products table
create table products (productid integer constraint primarykey_pk primary key, productname varchar(50) not null, cost float, price float);

--create customer table
create table customer (salesid integer, customerid integer not null, productid integer not null, salesdate date default sysdate, country varchar(3) default 'USA' not null, quantity integer, price float, revenue float, constraint salesid_pk primary key (salesid));

--create foreign key
alter table customer
modify productid constraint productid_fk references products(productid); --SQL Error: ORA-02270 no matching unique or primary key for this.  RM:  idiot Products table productid is not a primary key?  yes; otherwise, sql code is valid

--create products2 table and customer2 table 2 with foreign key constraint
create table products2 (productid integer constraint productid_pk primary key auto_increment, productname varchar(50) not null, cost float, price float);
create table customer2 (salesid integer, customerid integer not null, productid2 integer not null, salesdate date default sysdate, country varchar(3) default 'USA' not null, quantity integer, price float, revenue float, constraint salesid2_pk primary key (salesid), constraint productid_fk foreign key (productid2) references products2(productid)); --SQL Error: ORA-02270 no matching unique or primary key for this column-list  RM:  idiot Products table productid is not a primary key?  yes; otherwise, sql code is valid

--delete constraint or drop constraint
alter table customer2 drop constraint productid_fk;

--insert data products table
insert into products values (100,'rose',24.23,30.29);
insert into products values (101,'board game',86.89,108.61);
insert into products values (102,'pot',11.95,14.94);
insert into products values (103,'cookies',87.17,108.96);
insert into products values (104,'DVD',97.74,122.18);
insert into products values (105,'phone',119.94,149.93);
insert into products values (106,'underwear',106.3,132.88);
insert into products values (107,'bedsheet',34.48,43.1);
insert into products values (108,'zebra',110.38,137.98);
insert into products values (109,'apple',115.18,143.98);
insert into products values (110,'flashlight',8.61,10.76);
insert into products values (111,'book',119.94,149.93);
insert into products values (112,'plant',85.04,106.3);
insert into products values (113,'chair',7.91,9.89);
insert into products values (114,'mop',59.5,74.38);
insert into products values (115,'piano',18.04,22.55);
insert into products values (116,'luggage',109.76,137.2);
insert into products values (117,'fork',37.9,47.38);
insert into products values (118,'candle',45.18,56.48);
insert into products values (119,'jacket',59.64,74.55);
insert into products values (120,'glasses',13.7,17.13);
insert into products values (121,'soap',39.27,49.09);
insert into products values (122,'fan',26.11,32.64);
insert into products values (123,'toilet paper',31.74,39.67);
insert into products values (124,'trail mix',86.83,108.54);
insert into products values (125,'car',72.35,90.44);

