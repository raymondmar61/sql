--create products table
create table products (productid integer constraint primarykey_pk primary key, productname varchar(50) not null, cost float, price float);

--create customer table
create table customer (salesid integer, customerid integer not null, productid integer not null, salesdate date default sysdate, country varchar(3) default 'USA' not null, quantity integer, price float, revenue float, constraint salesid_pk primary key (salesid));

--create foreign key customer table
alter table customer
modify productid constraint productid_fk references products(productid); --SQL Error: ORA-02270 no matching unique or primary key for this.  RM:  idiot Products table productid is not a primary key?  yes; otherwise, sql code is valid

--create products2 table and customer2 table 2 with foreign key constraint
create table products2 (productid integer constraint productid2_pk primary key, productname varchar(50) not null, cost float, price float);
create table customer2 (salesid integer, customerid integer not null, productid integer not null, salesdate date default sysdate, country varchar(3) default 'USA' not null, quantity integer, price float, revenue float, constraint salesid2_pk primary key (salesid), constraint productid3_fk foreign key (productid) references products2(productid)); --SQL Error: ORA-02270 no matching unique or primary key for this column-list  RM:  idiot Products table productid is not a primary key?  yes; otherwise, sql code is valid

--delete constraint or drop constraint
alter table customer2 drop constraint productid_fk;
alter table customer drop constraint SYS_C009895;  --Oracle 12c assigned constraint name to productid being not null

--rename constraint
alter table products rename constraint primarykey_pk to productid_pk;

--rename table name
alter table customer rename to customers;

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

--insert data customer table
insert into customer values (1,5,113,'5/17/2016','USA',4,9.89,39.56);
insert into customer values (2,37,101,'2/24/2017','GBR',2,108.61,217.22);
insert into customer values (3,33,101,'4/27/2015','NLD',1,108.61,108.61);
insert into customer values (4,26,117,'3/17/2017','NLD',2,47.38,94.76);
insert into customer values (5,45,115,'10/16/2017','NLD',2,22.55,45.1);
insert into customer values (6,27,107,'3/25/2017','ITA',3,43.1,129.3);
insert into customer values (7,24,107,'5/10/2016','NLD',5,43.1,215.5);
insert into customer values (8,32,116,'3/6/2015','NLD',3,137.2,411.6);
insert into customer values (9,38,105,'7/4/2017','USA',3,149.93,449.79);
insert into customer values (10,17,114,'5/18/2017','CAN',5,74.38,371.9);
insert into customer values (11,37,110,'7/21/2015','GBR',2,10.76,21.52);
insert into customer values (12,32,104,'11/22/2015','NLD',5,122.18,610.9);
insert into customer values (13,41,123,'9/14/2017','FRA',5,39.67,198.35);
insert into customer values (14,46,109,'9/25/2017','JPN',2,143.98,287.96);
insert into customer values (15,6,100,'5/23/2017','CAN',2,30.29,60.58);
insert into customer values (16,18,101,'5/22/2016','JPN',4,108.61,434.44);
insert into customer values (17,47,112,'7/9/2016','CHN',2,106.3,212.6);
insert into customer values (18,19,100,'3/10/2017','NLD',5,30.29,151.45);
insert into customer values (19,9,122,'7/16/2015','HUN',4,32.64,130.56);
insert into customer values (20,36,122,'9/20/2017','FRA',2,32.64,65.28);
insert into customer values (21,21,116,'8/17/2015','HUN',1,137.2,137.2);
insert into customer values (22,28,115,'12/29/2017','FRA',4,22.55,90.2);
insert into customer values (23,10,113,'11/20/2016','NLD',3,9.89,29.67);
insert into customer values (24,18,124,'1/27/2016','JPN',5,108.54,542.7);
insert into customer values (25,50,119,'8/30/2016','NLD',2,74.55,149.1);
insert into customer values (26,1,109,'1/24/2016','FRA',5,143.98,719.9);
insert into customer values (27,41,112,'11/26/2016','FRA',3,106.3,318.9);
insert into customer values (28,25,100,'5/10/2015','CHN',1,30.29,30.29);
insert into customer values (29,26,108,'11/17/2015','NLD',1,137.98,137.98);
insert into customer values (30,24,120,'8/4/2016','NLD',2,17.13,34.26);
insert into customer values (31,26,106,'5/5/2017','NLD',4,132.88,531.52);
insert into customer values (32,6,107,'5/5/2017','CAN',4,43.1,172.4);
insert into customer values (33,19,102,'1/26/2017','NLD',1,14.94,14.94);
insert into customer values (34,39,102,'3/23/2015','GBR',3,14.94,44.82);
insert into customer values (35,37,123,'8/10/2015','GBR',2,39.67,79.34);
insert into customer values (36,40,102,'8/25/2017','JPN',2,14.94,29.88);
insert into customer values (37,10,111,'10/23/2015','NLD',1,149.93,149.93);
insert into customer values (38,30,117,'7/27/2015','FRA',3,47.38,142.14);
insert into customer values (39,11,114,'10/18/2017','ITA',3,74.38,223.14);
insert into customer values (40,41,102,'7/21/2015','FRA',1,14.94,14.94);
insert into customer values (41,36,100,'2/7/2016','FRA',1,30.29,30.29);
insert into customer values (42,2,123,'4/18/2015','CZE',1,39.67,39.67);
insert into customer values (43,42,113,'9/4/2015','HUN',5,9.89,49.45);
insert into customer values (44,27,103,'11/19/2016','ITA',2,108.96,217.92);
insert into customer values (45,45,124,'4/23/2015','NLD',1,108.54,108.54);
insert into customer values (46,1,106,'6/12/2016','FRA',2,132.88,265.76);
insert into customer values (47,6,109,'7/8/2015','CAN',4,143.98,575.92);
insert into customer values (48,12,116,'11/9/2017','FRA',1,137.2,137.2);
insert into customer values (49,3,107,'11/17/2017','NLD',1,43.1,43.1);
insert into customer values (50,6,118,'4/7/2015','CAN',1,56.48,56.48);
insert into customer values (51,39,108,'9/29/2017','GBR',2,137.98,275.96);
insert into customer values (52,10,123,'10/18/2016','NLD',5,39.67,198.35);
insert into customer values (53,37,117,'7/30/2016','GBR',1,47.38,47.38);
insert into customer values (54,10,125,'12/22/2015','NLD',4,90.44,361.76);
insert into customer values (55,9,105,'9/17/2015','HUN',3,149.93,449.79);
insert into customer values (56,32,121,'10/12/2016','NLD',5,49.09,245.45);
insert into customer values (57,6,101,'2/17/2016','CAN',4,108.61,434.44);
insert into customer values (58,12,105,'4/15/2015','FRA',3,149.93,449.79);
insert into customer values (59,39,123,'4/24/2016','GBR',2,39.67,79.34);
insert into customer values (60,31,112,'4/14/2017','GBR',3,106.3,318.9);
insert into customer values (61,23,116,'2/27/2016','GBR',5,137.2,686);
insert into customer values (62,31,125,'9/2/2015','GBR',3,90.44,271.32);
insert into customer values (63,45,115,'7/21/2016','NLD',2,22.55,45.1);
insert into customer values (64,27,125,'11/15/2015','ITA',5,90.44,452.2);
insert into customer values (65,33,110,'10/3/2017','NLD',2,10.76,21.52);
insert into customer values (66,11,118,'7/10/2017','ITA',1,56.48,56.48);
insert into customer values (67,14,104,'5/31/2016','CZE',5,122.18,610.9);
insert into customer values (68,48,107,'5/11/2015','GBR',3,43.1,129.3);
insert into customer values (69,21,112,'12/8/2016','HUN',4,106.3,425.2);
insert into customer values (70,30,105,'4/6/2015','FRA',4,149.93,599.72);
insert into customer values (71,38,108,'1/27/2017','USA',1,137.98,137.98);
insert into customer values (72,9,109,'10/22/2017','HUN',1,143.98,143.98);
insert into customer values (73,35,113,'8/5/2015','JPN',1,9.89,9.89);
insert into customer values (74,16,114,'2/1/2015','JPN',5,74.38,371.9);
insert into customer values (75,42,106,'5/26/2017','HUN',2,132.88,265.76);
insert into customer values (76,42,119,'8/25/2017','HUN',1,74.55,74.55);
insert into customer values (77,44,123,'3/5/2017','CHN',5,39.67,198.35);
insert into customer values (78,28,120,'1/1/2016','FRA',5,17.13,85.65);
insert into customer values (79,7,117,'9/10/2016','CAN',5,47.38,236.9);
insert into customer values (80,26,121,'8/8/2016','NLD',1,49.09,49.09);
insert into customer values (81,20,108,'6/27/2016','FRA',3,137.98,413.94);
insert into customer values (82,9,109,'9/3/2015','HUN',3,143.98,431.94);
insert into customer values (83,9,120,'2/28/2015','HUN',1,17.13,17.13);
insert into customer values (84,39,124,'9/18/2017','GBR',4,108.54,434.16);
insert into customer values (85,5,102,'10/27/2015','USA',3,14.94,44.82);
insert into customer values (86,24,114,'4/2/2017','NLD',1,74.38,74.38);
insert into customer values (87,10,101,'1/22/2015','NLD',4,108.61,434.44);
insert into customer values (88,44,103,'8/16/2015','CHN',5,108.96,544.8);
insert into customer values (89,10,108,'6/11/2017','NLD',4,137.98,551.92);
insert into customer values (90,20,113,'12/7/2017','FRA',1,9.89,9.89);
insert into customer values (91,5,118,'8/1/2017','USA',3,56.48,169.44);
insert into customer values (92,49,118,'1/19/2015','JPN',5,56.48,282.4);
insert into customer values (93,43,106,'5/3/2017','FRA',1,132.88,132.88);
insert into customer values (94,25,119,'7/2/2015','CHN',1,74.55,74.55);
insert into customer values (95,42,116,'6/27/2017','HUN',4,137.2,548.8);
insert into customer values (96,45,115,'2/5/2016','NLD',2,22.55,45.1);
insert into customer values (97,15,124,'11/16/2015','HUN',4,108.54,434.16);
insert into customer values (98,20,105,'12/17/2015','FRA',3,149.93,449.79);
insert into customer values (99,13,118,'9/5/2015','GBR',2,56.48,112.96);
insert into customer values (100,47,111,'8/11/2015','CHN',1,149.93,149.93);
insert into customer values (101,4,122,'11/16/2017','ITA',1,32.64,32.64);
insert into customer values (102,7,112,'8/27/2015','CAN',4,106.3,425.2);
insert into customer values (103,17,105,'7/21/2016','CAN',2,149.93,299.86);
insert into customer values (104,31,108,'3/14/2017','GBR',5,137.98,689.9);
insert into customer values (105,49,102,'4/6/2017','JPN',2,14.94,29.88);
insert into customer values (106,28,105,'4/30/2015','FRA',3,149.93,449.79);
insert into customer values (107,17,118,'4/1/2015','CAN',2,56.48,112.96);
insert into customer values (108,15,108,'10/10/2015','HUN',5,137.98,689.9);
insert into customer values (109,37,110,'7/9/2016','GBR',1,10.76,10.76);
insert into customer values (110,14,125,'12/17/2016','CZE',2,90.44,180.88);
insert into customer values (111,7,104,'12/16/2017','CAN',2,122.18,244.36);
insert into customer values (112,11,114,'3/18/2016','ITA',4,74.38,297.52);
insert into customer values (113,6,105,'10/12/2017','CAN',4,149.93,599.72);
insert into customer values (114,10,108,'12/7/2016','NLD',5,137.98,689.9);
insert into customer values (115,14,122,'8/22/2017','CZE',3,32.64,97.92);
insert into customer values (116,22,103,'10/28/2015','FRA',4,108.96,435.84);
insert into customer values (117,35,106,'11/29/2015','JPN',3,132.88,398.64);
insert into customer values (118,6,119,'6/9/2015','CAN',5,74.55,372.75);
insert into customer values (119,43,108,'8/14/2017','FRA',4,137.98,551.92);
insert into customer values (120,11,120,'10/26/2017','ITA',4,17.13,68.52);
insert into customer values (121,12,117,'2/23/2017','FRA',2,47.38,94.76);
insert into customer values (122,18,105,'6/10/2016','JPN',4,149.93,599.72);
insert into customer values (123,26,104,'4/18/2015','NLD',2,122.18,244.36);
insert into customer values (124,12,125,'10/10/2015','FRA',3,90.44,271.32);
insert into customer values (125,50,125,'3/30/2017','NLD',2,90.44,180.88);
insert into customer values (126,13,109,'7/3/2017','GBR',2,143.98,287.96);
insert into customer values (127,19,106,'6/3/2017','NLD',2,132.88,265.76);
insert into customer values (128,30,108,'7/21/2015','FRA',4,137.98,551.92);
insert into customer values (129,41,114,'6/19/2016','FRA',2,74.38,148.76);
insert into customer values (130,42,101,'2/15/2017','HUN',3,108.61,325.83);
insert into customer values (131,3,124,'8/5/2015','NLD',3,108.54,325.62);
insert into customer values (132,26,118,'8/23/2015','NLD',4,56.48,225.92);
insert into customer values (133,32,116,'8/4/2016','NLD',1,137.2,137.2);
insert into customer values (134,31,121,'4/10/2017','GBR',1,49.09,49.09);
insert into customer values (135,39,109,'9/3/2017','GBR',2,143.98,287.96);
insert into customer values (136,19,115,'5/26/2015','NLD',4,22.55,90.2);
insert into customer values (137,1,113,'6/24/2016','FRA',5,9.89,49.45);
insert into customer values (138,48,122,'7/18/2017','GBR',3,32.64,97.92);
insert into customer values (139,49,110,'10/31/2017','JPN',5,10.76,53.8);
insert into customer values (140,20,102,'3/23/2016','FRA',4,14.94,59.76);
insert into customer values (141,36,103,'4/18/2016','FRA',4,108.96,435.84);
insert into customer values (142,9,101,'5/27/2017','HUN',2,108.61,217.22);
insert into customer values (143,47,121,'1/4/2015','CHN',1,49.09,49.09);
insert into customer values (144,6,115,'5/9/2017','CAN',3,22.55,67.65);
insert into customer values (145,21,104,'10/25/2017','HUN',1,122.18,122.18);
insert into customer values (146,14,123,'11/18/2015','CZE',2,39.67,79.34);
insert into customer values (147,28,107,'8/10/2016','FRA',4,43.1,172.4);
insert into customer values (148,2,102,'11/5/2017','CZE',1,14.94,14.94);
insert into customer values (149,29,119,'9/8/2017','FRA',1,74.55,74.55);
insert into customer values (150,21,112,'7/16/2016','HUN',5,106.3,531.5);
insert into customer values (151,10,102,'5/25/2017','NLD',3,14.94,44.82);
insert into customer values (152,30,111,'12/10/2016','FRA',5,149.93,749.65);
insert into customer values (153,39,112,'9/7/2015','GBR',5,106.3,531.5);
insert into customer values (154,11,119,'4/8/2017','ITA',4,74.55,298.2);
insert into customer values (155,10,101,'9/1/2017','NLD',2,108.61,217.22);
insert into customer values (156,39,104,'9/28/2016','GBR',2,122.18,244.36);
insert into customer values (157,22,124,'10/9/2016','FRA',3,108.54,325.62);
insert into customer values (158,4,114,'6/20/2017','ITA',3,74.38,223.14);
insert into customer values (159,45,100,'1/13/2015','NLD',1,30.29,30.29);
insert into customer values (160,25,123,'2/28/2016','CHN',4,39.67,158.68);
insert into customer values (161,36,124,'11/26/2015','FRA',2,108.54,217.08);
insert into customer values (162,36,115,'6/6/2017','FRA',3,22.55,67.65);
insert into customer values (163,4,118,'6/8/2017','ITA',4,56.48,225.92);
insert into customer values (164,23,104,'6/15/2016','GBR',1,122.18,122.18);
insert into customer values (165,48,121,'8/19/2015','GBR',1,49.09,49.09);
insert into customer values (166,36,119,'9/8/2017','FRA',1,74.55,74.55);
insert into customer values (167,15,123,'5/30/2017','HUN',2,39.67,79.34);
insert into customer values (168,10,110,'3/23/2017','NLD',3,10.76,32.28);
insert into customer values (169,50,104,'8/22/2015','NLD',3,122.18,366.54);
insert into customer values (170,12,106,'12/17/2016','FRA',3,132.88,398.64);
insert into customer values (171,6,123,'2/8/2015','CAN',5,39.67,198.35);
insert into customer values (172,45,114,'2/28/2016','NLD',2,74.38,148.76);
insert into customer values (173,21,114,'1/21/2015','HUN',4,74.38,297.52);
insert into customer values (174,36,118,'7/30/2017','FRA',4,56.48,225.92);
insert into customer values (175,38,107,'5/1/2015','USA',3,43.1,129.3);
insert into customer values (176,19,101,'12/21/2017','NLD',4,108.61,434.44);
insert into customer values (177,2,122,'12/21/2016','CZE',2,32.64,65.28);
insert into customer values (178,21,119,'1/9/2016','HUN',4,74.55,298.2);
insert into customer values (179,1,125,'12/16/2015','FRA',1,90.44,90.44);
insert into customer values (180,46,108,'2/7/2017','JPN',3,137.98,413.94);
insert into customer values (181,17,109,'10/9/2015','CAN',4,143.98,575.92);
insert into customer values (182,29,110,'4/2/2015','FRA',1,10.76,10.76);
insert into customer values (183,16,118,'3/17/2017','JPN',5,56.48,282.4);
insert into customer values (184,3,115,'7/19/2016','NLD',4,22.55,90.2);
insert into customer values (185,8,110,'9/21/2016','CZE',5,10.76,53.8);
insert into customer values (186,42,106,'6/16/2015','HUN',4,132.88,531.52);
insert into customer values (187,4,111,'12/20/2016','ITA',5,149.93,749.65);
insert into customer values (188,35,118,'4/28/2016','JPN',1,56.48,56.48);
insert into customer values (189,24,112,'5/2/2017','NLD',5,106.3,531.5);
insert into customer values (190,25,105,'5/5/2015','CHN',5,149.93,749.65);
insert into customer values (191,7,122,'7/12/2017','CAN',4,32.64,130.56);
insert into customer values (192,1,110,'8/29/2015','FRA',1,10.76,10.76);
insert into customer values (193,10,101,'10/1/2017','NLD',4,108.61,434.44);
insert into customer values (194,39,111,'9/20/2017','GBR',4,149.93,599.72);
insert into customer values (195,25,111,'11/29/2017','CHN',2,149.93,299.86);
insert into customer values (196,13,100,'4/13/2017','GBR',4,30.29,121.16);
insert into customer values (197,11,122,'4/5/2015','ITA',3,32.64,97.92);
insert into customer values (198,46,121,'3/21/2015','JPN',5,49.09,245.45);
insert into customer values (199,1,120,'6/10/2016','FRA',4,17.13,68.52);
insert into customer values (200,17,107,'3/15/2016','CAN',5,43.1,215.5);
insert into customer values (201,41,106,'2/6/2015','FRA',4,132.88,531.52);
insert into customer values (202,23,113,'6/15/2015','GBR',1,9.89,9.89);
insert into customer values (203,27,107,'11/12/2015','ITA',1,43.1,43.1);
insert into customer values (204,46,108,'10/5/2015','JPN',2,137.98,275.96);
insert into customer values (205,34,117,'6/13/2015','CAN',5,47.38,236.9);
insert into customer values (206,6,115,'2/2/2016','CAN',5,22.55,112.75);
insert into customer values (207,20,115,'11/19/2017','FRA',5,22.55,112.75);
insert into customer values (208,32,106,'6/17/2017','NLD',1,132.88,132.88);
insert into customer values (209,6,123,'1/10/2015','CAN',5,39.67,198.35);
insert into customer values (210,6,122,'2/8/2015','CAN',2,32.64,65.28);
insert into customer values (211,12,102,'7/25/2016','FRA',2,14.94,29.88);
insert into customer values (212,44,118,'4/6/2015','CHN',2,56.48,112.96);
insert into customer values (213,37,115,'12/7/2017','GBR',5,22.55,112.75);
insert into customer values (214,30,114,'9/20/2015','FRA',2,74.38,148.76);
insert into customer values (215,43,101,'10/21/2016','FRA',1,108.61,108.61);
insert into customer values (216,22,113,'4/28/2017','FRA',1,9.89,9.89);
insert into customer values (217,4,108,'7/15/2016','ITA',4,137.98,551.92);
insert into customer values (218,30,105,'9/8/2016','FRA',2,149.93,299.86);
insert into customer values (219,17,103,'12/20/2017','CAN',3,108.96,326.88);
insert into customer values (220,15,125,'6/21/2017','HUN',2,90.44,180.88);
insert into customer values (221,3,100,'12/15/2015','NLD',1,30.29,30.29);
insert into customer values (222,17,111,'2/3/2015','CAN',1,149.93,149.93);
insert into customer values (223,1,125,'11/19/2017','FRA',3,90.44,271.32);
insert into customer values (224,27,119,'11/9/2017','ITA',1,74.55,74.55);
insert into customer values (225,26,124,'5/20/2017','NLD',2,108.54,217.08);
insert into customer values (226,9,117,'7/18/2015','HUN',2,47.38,94.76);
insert into customer values (227,34,119,'4/21/2016','CAN',5,74.55,372.75);
insert into customer values (228,19,109,'2/14/2015','NLD',1,143.98,143.98);
insert into customer values (229,22,117,'9/30/2016','FRA',4,47.38,189.52);
insert into customer values (230,43,122,'1/5/2016','FRA',3,32.64,97.92);
insert into customer values (231,49,107,'8/30/2015','JPN',4,43.1,172.4);
insert into customer values (232,49,123,'8/19/2015','JPN',3,39.67,119.01);
insert into customer values (233,35,119,'1/28/2015','JPN',2,74.55,149.1);
insert into customer values (234,47,111,'12/31/2017','CHN',5,149.93,749.65);
insert into customer values (235,50,118,'5/12/2017','NLD',3,56.48,169.44);
insert into customer values (236,26,115,'6/7/2017','NLD',5,22.55,112.75);
insert into customer values (237,21,120,'6/19/2017','HUN',5,17.13,85.65);
insert into customer values (238,32,124,'3/3/2016','NLD',1,108.54,108.54);
insert into customer values (239,6,100,'11/3/2015','CAN',3,30.29,90.87);
insert into customer values (240,3,105,'7/27/2017','NLD',2,149.93,299.86);
insert into customer values (241,50,116,'11/28/2016','NLD',4,137.2,548.8);
insert into customer values (242,8,117,'4/26/2015','CZE',3,47.38,142.14);
insert into customer values (243,32,118,'8/16/2017','NLD',4,56.48,225.92);
insert into customer values (244,32,121,'5/5/2016','NLD',2,49.09,98.18);
insert into customer values (245,30,122,'4/5/2016','FRA',4,32.64,130.56);
insert into customer values (246,8,119,'2/28/2016','CZE',2,74.55,149.1);
insert into customer values (247,15,101,'6/14/2017','HUN',5,108.61,543.05);
insert into customer values (248,36,124,'10/4/2017','FRA',4,108.54,434.16);
insert into customer values (249,20,112,'7/24/2015','FRA',1,106.3,106.3);
insert into customer values (250,22,123,'12/5/2016','FRA',5,39.67,198.35);
insert into customer values (251,20,113,'10/31/2016','FRA',4,9.89,39.56);
insert into customer values (252,11,121,'12/22/2017','ITA',3,49.09,147.27);
insert into customer values (253,4,120,'11/22/2017','ITA',2,17.13,34.26);
insert into customer values (254,41,110,'5/24/2017','FRA',3,10.76,32.28);
insert into customer values (255,11,125,'12/7/2017','ITA',2,90.44,180.88);
insert into customer values (256,3,106,'5/19/2015','NLD',3,132.88,398.64);
insert into customer values (257,45,113,'8/15/2016','NLD',3,9.89,29.67);
insert into customer values (258,32,121,'1/17/2015','NLD',1,49.09,49.09);
insert into customer values (259,1,109,'12/25/2015','FRA',4,143.98,575.92);
insert into customer values (260,43,113,'2/29/2016','FRA',4,9.89,39.56);
insert into customer values (261,36,118,'10/6/2017','FRA',3,56.48,169.44);
insert into customer values (262,6,110,'11/7/2016','CAN',5,10.76,53.8);
insert into customer values (263,33,114,'6/13/2017','NLD',2,74.38,148.76);
insert into customer values (264,14,115,'3/5/2015','CZE',2,22.55,45.1);
insert into customer values (265,8,125,'11/6/2017','CZE',1,90.44,90.44);
insert into customer values (266,31,125,'8/16/2016','GBR',3,90.44,271.32);
insert into customer values (267,17,102,'2/18/2016','CAN',2,14.94,29.88);
insert into customer values (268,38,103,'11/14/2015','USA',2,108.96,217.92);
insert into customer values (269,47,118,'3/12/2017','CHN',4,56.48,225.92);
insert into customer values (270,45,103,'5/19/2016','NLD',5,108.96,544.8);
insert into customer values (271,4,101,'12/24/2017','ITA',3,108.61,325.83);
insert into customer values (272,22,122,'5/29/2017','FRA',2,32.64,65.28);
insert into customer values (273,39,103,'12/23/2017','GBR',5,108.96,544.8);
insert into customer values (274,1,117,'9/7/2017','FRA',2,47.38,94.76);
insert into customer values (275,13,115,'5/16/2017','GBR',3,22.55,67.65);
insert into customer values (276,18,103,'4/21/2015','JPN',5,108.96,544.8);
insert into customer values (277,39,121,'3/2/2017','GBR',1,49.09,49.09);
insert into customer values (278,15,105,'11/25/2017','HUN',4,149.93,599.72);
insert into customer values (279,9,121,'2/23/2016','HUN',1,49.09,49.09);
insert into customer values (280,42,121,'8/4/2015','HUN',4,49.09,196.36);
insert into customer values (281,27,105,'9/14/2015','ITA',1,149.93,149.93);
insert into customer values (282,38,105,'7/17/2015','USA',2,149.93,299.86);
insert into customer values (283,25,125,'5/5/2016','CHN',3,90.44,271.32);
insert into customer values (284,46,106,'3/15/2017','JPN',5,132.88,664.4);
insert into customer values (285,9,117,'11/27/2015','HUN',1,47.38,47.38);
insert into customer values (286,28,106,'8/8/2017','FRA',5,132.88,664.4);
insert into customer values (287,25,109,'6/19/2016','CHN',5,143.98,719.9);
insert into customer values (288,34,101,'11/19/2015','CAN',2,108.61,217.22);
insert into customer values (289,39,119,'9/25/2017','GBR',4,74.55,298.2);
insert into customer values (290,36,122,'6/12/2016','FRA',1,32.64,32.64);
insert into customer values (291,6,119,'7/27/2015','CAN',3,74.55,223.65);
insert into customer values (292,50,108,'3/12/2017','NLD',2,137.98,275.96);
insert into customer values (293,24,121,'5/25/2016','NLD',5,49.09,245.45);
insert into customer values (294,35,119,'1/27/2015','JPN',1,74.55,74.55);
insert into customer values (295,16,125,'12/24/2015','JPN',4,90.44,361.76);
insert into customer values (296,19,124,'8/1/2017','NLD',5,108.54,542.7);
insert into customer values (297,38,119,'7/17/2017','USA',5,74.55,372.75);
insert into customer values (298,45,100,'8/23/2017','NLD',1,30.29,30.29);
insert into customer values (299,39,122,'2/9/2015','GBR',5,32.64,163.2);
insert into customer values (300,17,120,'8/7/2016','CAN',2,17.13,34.26);
insert into customer values (301,11,122,'9/17/2017','ITA',3,32.64,97.92);
insert into customer values (302,4,110,'5/8/2016','ITA',1,10.76,10.76);
insert into customer values (303,2,113,'2/24/2015','CZE',3,9.89,29.67);
insert into customer values (304,10,106,'11/6/2015','NLD',2,132.88,265.76);
insert into customer values (305,31,113,'5/26/2015','GBR',4,9.89,39.56);
insert into customer values (306,23,119,'7/3/2017','GBR',2,74.55,149.1);
insert into customer values (307,8,121,'7/10/2015','CZE',5,49.09,245.45);
insert into customer values (308,40,104,'11/25/2017','JPN',5,122.18,610.9);
insert into customer values (309,9,108,'5/6/2015','HUN',2,137.98,275.96);
insert into customer values (310,34,112,'7/25/2017','CAN',2,106.3,212.6);
insert into customer values (311,28,111,'8/6/2015','FRA',5,149.93,749.65);
insert into customer values (312,4,108,'4/7/2016','ITA',2,137.98,275.96);
insert into customer values (313,1,114,'2/13/2017','FRA',4,74.38,297.52);
insert into customer values (314,14,106,'10/27/2016','CZE',4,132.88,531.52);
insert into customer values (315,16,102,'12/8/2016','JPN',4,14.94,59.76);
insert into customer values (316,20,123,'1/16/2017','FRA',5,39.67,198.35);
insert into customer values (317,37,105,'6/21/2015','GBR',2,149.93,299.86);
insert into customer values (318,8,101,'9/28/2016','CZE',3,108.61,325.83);
insert into customer values (319,4,117,'1/25/2015','ITA',1,47.38,47.38);
insert into customer values (320,49,112,'6/29/2016','JPN',2,106.3,212.6);
insert into customer values (321,12,125,'10/14/2015','FRA',1,90.44,90.44);
insert into customer values (322,4,101,'1/29/2016','ITA',4,108.61,434.44);
insert into customer values (323,8,103,'3/9/2016','CZE',1,108.96,108.96);
insert into customer values (324,1,116,'9/1/2015','FRA',2,137.2,274.4);
insert into customer values (325,47,114,'8/4/2017','CHN',4,74.38,297.52);
insert into customer values (326,19,119,'1/7/2015','NLD',2,74.55,149.1);
insert into customer values (327,9,113,'2/18/2017','HUN',5,9.89,49.45);
insert into customer values (328,48,102,'4/1/2016','GBR',2,14.94,29.88);
insert into customer values (329,23,121,'10/24/2015','GBR',5,49.09,245.45);
insert into customer values (330,42,101,'10/13/2016','HUN',1,108.61,108.61);
insert into customer values (331,26,111,'8/6/2017','NLD',1,149.93,149.93);
insert into customer values (332,46,106,'5/18/2016','JPN',5,132.88,664.4);
insert into customer values (333,4,105,'6/5/2015','ITA',1,149.93,149.93);
insert into customer values (334,23,118,'2/4/2016','GBR',3,56.48,169.44);
insert into customer values (335,46,116,'12/27/2016','JPN',4,137.2,548.8);
insert into customer values (336,17,121,'10/5/2016','CAN',5,49.09,245.45);
insert into customer values (337,29,111,'8/9/2017','FRA',5,149.93,749.65);
insert into customer values (338,37,116,'9/14/2016','GBR',4,137.2,548.8);
insert into customer values (339,39,110,'5/22/2017','GBR',4,10.76,43.04);
insert into customer values (340,20,116,'5/18/2016','FRA',2,137.2,274.4);
insert into customer values (341,8,117,'7/21/2016','CZE',3,47.38,142.14);
insert into customer values (342,27,121,'2/1/2015','ITA',3,49.09,147.27);
insert into customer values (343,28,110,'11/12/2017','FRA',5,10.76,53.8);
insert into customer values (344,37,102,'12/13/2015','GBR',3,14.94,44.82);
insert into customer values (345,29,101,'8/2/2015','FRA',1,108.61,108.61);
insert into customer values (346,34,125,'7/18/2015','CAN',2,90.44,180.88);
insert into customer values (347,23,110,'8/10/2015','GBR',3,10.76,32.28);
insert into customer values (348,47,105,'9/23/2015','CHN',1,149.93,149.93);
insert into customer values (349,25,109,'1/25/2015','CHN',2,143.98,287.96);
insert into customer values (350,3,115,'2/26/2015','NLD',4,22.55,90.2);
insert into customer values (351,2,100,'8/4/2017','CZE',3,30.29,90.87);
insert into customer values (352,17,101,'7/4/2017','CAN',4,108.61,434.44);
insert into customer values (353,35,115,'8/29/2016','JPN',1,22.55,22.55);
insert into customer values (354,35,118,'3/15/2015','JPN',5,56.48,282.4);
insert into customer values (355,24,108,'11/3/2017','NLD',1,137.98,137.98);
insert into customer values (356,19,103,'10/2/2017','NLD',5,108.96,544.8);
insert into customer values (357,41,125,'5/19/2015','FRA',5,90.44,452.2);
insert into customer values (358,48,110,'2/7/2016','GBR',4,10.76,43.04);
insert into customer values (359,22,113,'2/9/2016','FRA',1,9.89,9.89);
insert into customer values (360,41,124,'9/15/2016','FRA',1,108.54,108.54);
insert into customer values (361,37,117,'7/31/2015','GBR',3,47.38,142.14);
insert into customer values (362,22,116,'1/22/2015','FRA',5,137.2,686);
insert into customer values (363,45,110,'1/8/2016','NLD',4,10.76,43.04);
insert into customer values (364,33,102,'1/31/2017','NLD',4,14.94,59.76);
insert into customer values (365,9,121,'10/26/2017','HUN',4,49.09,196.36);
insert into customer values (366,37,120,'5/21/2015','GBR',2,17.13,34.26);
insert into customer values (367,11,107,'10/12/2015','ITA',3,43.1,129.3);
insert into customer values (368,25,114,'5/18/2015','CHN',5,74.38,371.9);
insert into customer values (369,49,102,'9/16/2017','JPN',5,14.94,74.7);
insert into customer values (370,7,111,'4/11/2016','CAN',3,149.93,449.79);
insert into customer values (371,22,103,'8/16/2016','FRA',5,108.96,544.8);
insert into customer values (372,29,107,'2/15/2016','FRA',3,43.1,129.3);
insert into customer values (373,39,120,'3/12/2017','GBR',5,17.13,85.65);
insert into customer values (374,35,104,'7/27/2015','JPN',1,122.18,122.18);
insert into customer values (375,48,120,'9/19/2016','GBR',4,17.13,68.52);
insert into customer values (376,11,124,'1/6/2017','ITA',4,108.54,434.16);
insert into customer values (377,30,114,'1/6/2015','FRA',3,74.38,223.14);
insert into customer values (378,22,113,'6/5/2015','FRA',4,9.89,39.56);
insert into customer values (379,14,103,'4/14/2017','CZE',1,108.96,108.96);
insert into customer values (380,32,117,'9/14/2015','NLD',2,47.38,94.76);
insert into customer values (381,39,100,'10/7/2017','GBR',1,30.29,30.29);
insert into customer values (382,30,110,'6/5/2015','FRA',5,10.76,53.8);
insert into customer values (383,21,114,'4/7/2015','HUN',4,74.38,297.52);
insert into customer values (384,19,103,'7/7/2016','NLD',2,108.96,217.92);
insert into customer values (385,27,122,'12/11/2015','ITA',5,32.64,163.2);
insert into customer values (386,10,110,'5/20/2016','NLD',4,10.76,43.04);
insert into customer values (387,25,101,'2/26/2016','CHN',2,108.61,217.22);
insert into customer values (388,24,120,'4/24/2015','NLD',4,17.13,68.52);
insert into customer values (389,29,121,'7/31/2016','FRA',2,49.09,98.18);
insert into customer values (390,42,104,'8/25/2016','HUN',2,122.18,244.36);
insert into customer values (391,45,103,'12/3/2016','NLD',3,108.96,326.88);
insert into customer values (392,5,123,'8/26/2017','USA',4,39.67,158.68);
insert into customer values (393,14,110,'10/6/2015','CZE',3,10.76,32.28);
insert into customer values (394,42,115,'7/1/2016','HUN',4,22.55,90.2);
insert into customer values (395,10,107,'3/5/2016','NLD',5,43.1,215.5);
insert into customer values (396,8,122,'11/1/2016','CZE',2,32.64,65.28);
insert into customer values (397,47,119,'2/1/2015','CHN',1,74.55,74.55);
insert into customer values (398,21,102,'5/19/2016','HUN',4,14.94,59.76);
insert into customer values (399,44,123,'10/18/2017','CHN',2,39.67,79.34);
insert into customer values (400,23,118,'6/22/2016','GBR',5,56.48,282.4);
insert into customer values (401,33,120,'4/7/2016','NLD',3,17.13,51.39);
insert into customer values (402,41,117,'10/29/2015','FRA',5,47.38,236.9);
insert into customer values (403,45,116,'4/17/2017','NLD',2,137.2,274.4);
insert into customer values (404,46,108,'12/17/2015','JPN',2,137.98,275.96);
insert into customer values (405,34,114,'3/16/2016','CAN',5,74.38,371.9);
insert into customer values (406,2,124,'11/30/2017','CZE',2,108.54,217.08);
insert into customer values (407,49,111,'12/11/2016','JPN',3,149.93,449.79);
insert into customer values (408,45,123,'4/5/2015','NLD',1,39.67,39.67);
insert into customer values (409,46,111,'1/12/2016','JPN',4,149.93,599.72);
insert into customer values (410,27,117,'3/17/2016','ITA',5,47.38,236.9);
insert into customer values (411,32,123,'1/7/2015','NLD',3,39.67,119.01);
insert into customer values (412,26,101,'3/28/2016','NLD',4,108.61,434.44);
insert into customer values (413,16,122,'12/21/2015','JPN',3,32.64,97.92);
insert into customer values (414,10,110,'7/20/2015','NLD',4,10.76,43.04);
insert into customer values (415,7,117,'2/9/2016','CAN',5,47.38,236.9);
insert into customer values (416,17,121,'3/23/2015','CAN',5,49.09,245.45);
insert into customer values (417,49,124,'8/10/2017','JPN',2,108.54,217.08);
insert into customer values (418,7,120,'2/4/2015','CAN',3,17.13,51.39);
insert into customer values (419,32,108,'3/12/2016','NLD',5,137.98,689.9);
insert into customer values (420,50,112,'12/1/2017','NLD',2,106.3,212.6);
insert into customer values (421,44,102,'2/13/2015','CHN',3,14.94,44.82);
insert into customer values (422,25,109,'6/10/2016','CHN',2,143.98,287.96);
insert into customer values (423,1,105,'11/28/2015','FRA',4,149.93,599.72);
insert into customer values (424,35,109,'8/29/2015','JPN',3,143.98,431.94);
insert into customer values (425,33,110,'3/10/2016','NLD',3,10.76,32.28);
insert into customer values (426,40,120,'12/28/2015','JPN',2,17.13,34.26);
insert into customer values (427,44,115,'11/6/2015','CHN',3,22.55,67.65);
insert into customer values (428,38,100,'11/22/2017','USA',4,30.29,121.16);
insert into customer values (429,42,103,'2/16/2015','HUN',2,108.96,217.92);
insert into customer values (430,32,116,'1/27/2015','NLD',5,137.2,686);
insert into customer values (431,8,107,'9/1/2015','CZE',2,43.1,86.2);
insert into customer values (432,46,119,'1/15/2017','JPN',1,74.55,74.55);
insert into customer values (433,45,111,'3/26/2017','NLD',1,149.93,149.93);
insert into customer values (434,17,107,'7/12/2016','CAN',2,43.1,86.2);
insert into customer values (435,19,107,'1/4/2017','NLD',1,43.1,43.1);
insert into customer values (436,38,114,'7/14/2016','USA',1,74.38,74.38);
insert into customer values (437,50,121,'6/6/2017','NLD',3,49.09,147.27);
insert into customer values (438,18,102,'8/11/2017','JPN',2,14.94,29.88);
insert into customer values (439,33,106,'12/15/2015','NLD',4,132.88,531.52);
insert into customer values (440,30,101,'8/30/2017','FRA',5,108.61,543.05);
insert into customer values (441,11,106,'10/8/2015','ITA',3,132.88,398.64);
insert into customer values (442,24,103,'8/16/2015','NLD',1,108.96,108.96);
insert into customer values (443,7,111,'11/29/2015','CAN',4,149.93,599.72);
insert into customer values (444,14,102,'11/23/2017','CZE',1,14.94,14.94);
insert into customer values (445,17,124,'12/31/2016','CAN',5,108.54,542.7);
insert into customer values (446,28,104,'9/14/2017','FRA',4,122.18,488.72);
insert into customer values (447,46,109,'9/18/2017','JPN',3,143.98,431.94);
insert into customer values (448,12,124,'2/28/2017','FRA',3,108.54,325.62);
insert into customer values (449,8,109,'4/22/2016','CZE',1,143.98,143.98);
insert into customer values (450,5,119,'2/21/2017','USA',1,74.55,74.55);
insert into customer values (451,13,117,'10/12/2017','GBR',4,47.38,189.52);
insert into customer values (452,27,113,'10/4/2017','ITA',3,9.89,29.67);
insert into customer values (453,14,108,'7/16/2015','CZE',3,137.98,413.94);
insert into customer values (454,35,100,'5/10/2015','JPN',3,30.29,90.87);
insert into customer values (455,15,107,'1/3/2017','HUN',3,43.1,129.3);
insert into customer values (456,13,111,'11/16/2017','GBR',4,149.93,599.72);
insert into customer values (457,50,110,'3/22/2016','NLD',2,10.76,21.52);
insert into customer values (458,21,119,'2/29/2016','HUN',1,74.55,74.55);
insert into customer values (459,9,119,'11/6/2017','HUN',4,74.55,298.2);
insert into customer values (460,37,122,'12/10/2017','GBR',4,32.64,130.56);
insert into customer values (461,21,103,'12/29/2016','HUN',2,108.96,217.92);
insert into customer values (462,25,112,'10/13/2016','CHN',5,106.3,531.5);
insert into customer values (463,8,125,'12/6/2015','CZE',5,90.44,452.2);
insert into customer values (464,5,114,'6/16/2016','USA',4,74.38,297.52);
insert into customer values (465,16,103,'10/26/2015','JPN',3,108.96,326.88);
insert into customer values (466,30,123,'12/27/2017','FRA',4,39.67,158.68);
insert into customer values (467,36,115,'12/23/2017','FRA',2,22.55,45.1);
insert into customer values (468,26,106,'9/17/2017','NLD',2,132.88,265.76);
insert into customer values (469,23,115,'12/1/2015','GBR',4,22.55,90.2);
insert into customer values (470,25,108,'5/6/2016','CHN',2,137.98,275.96);
insert into customer values (471,26,102,'8/6/2015','NLD',5,14.94,74.7);
insert into customer values (472,26,115,'1/21/2017','NLD',4,22.55,90.2);
insert into customer values (473,6,113,'5/8/2017','CAN',3,9.89,29.67);
insert into customer values (474,1,107,'2/15/2015','FRA',2,43.1,86.2);
insert into customer values (475,37,119,'4/7/2017','GBR',5,74.55,372.75);
insert into customer values (476,43,110,'9/19/2016','FRA',2,10.76,21.52);
insert into customer values (477,41,101,'6/20/2016','FRA',3,108.61,325.83);
insert into customer values (478,26,124,'11/4/2015','NLD',4,108.54,434.16);
insert into customer values (479,41,125,'1/14/2016','FRA',5,90.44,452.2);
insert into customer values (480,24,101,'7/3/2015','NLD',4,108.61,434.44);
insert into customer values (481,41,104,'7/1/2015','FRA',4,122.18,488.72);
insert into customer values (482,12,109,'10/12/2017','FRA',4,143.98,575.92);
insert into customer values (483,35,124,'12/30/2017','JPN',2,108.54,217.08);
insert into customer values (484,10,117,'9/25/2015','NLD',4,47.38,189.52);
insert into customer values (485,46,100,'3/10/2017','JPN',4,30.29,121.16);
insert into customer values (486,40,121,'4/9/2017','JPN',5,49.09,245.45);
insert into customer values (487,1,116,'10/24/2016','FRA',1,137.2,137.2);
insert into customer values (488,44,119,'10/31/2016','CHN',5,74.55,372.75);
insert into customer values (489,40,112,'11/14/2015','JPN',3,106.3,318.9);
insert into customer values (490,2,117,'6/19/2016','CZE',3,47.38,142.14);
insert into customer values (491,2,106,'4/1/2015','CZE',3,132.88,398.64);
insert into customer values (492,32,120,'1/24/2015','NLD',5,17.13,85.65);
insert into customer values (493,8,111,'4/16/2015','CZE',4,149.93,599.72);
insert into customer values (494,32,124,'8/27/2017','NLD',5,108.54,542.7);
insert into customer values (495,41,109,'10/5/2015','FRA',2,143.98,287.96);
insert into customer values (496,48,117,'5/13/2015','GBR',4,47.38,189.52);
insert into customer values (497,35,125,'1/23/2016','JPN',4,90.44,361.76);
insert into customer values (498,8,100,'1/28/2017','CZE',2,30.29,60.58);
insert into customer values (499,29,117,'10/6/2015','FRA',2,47.38,94.76);
insert into customer values (500,3,124,'7/7/2015','NLD',1,108.54,108.54);
insert into customer (salesid,customerid,country) values (501,51,'HUN');

--basic SQL statements
select *
from customers
where salesdate between '01/01/2015' and '6/30/2015'
order by salesdate;

select distinct country
from customers;

select productname, cost, price
from products
where (productid = 101 or productid = 110) and cost > 50;

select customerid, productid, revenue
from customers
where country in ('USA','GBR')
and revenue > 100
order by revenue desc, customerid asc;

select *
from customers
where country = 'CHN' or country = 'JPN'
and revenue > 100 and revenue < 150;

select customerid, country, revenue
from customers
where country like 'C%'  --wild card %, not *
and revenue between 200 and 300 --inclusive
order by country asc, revenue desc; 

select productname, cost
from products
where productname <> 'DVD' and cost < 100;

select customerid
from customers
where productid = (select productid from products where productname in ('DVD');  --Nested select statements. Not a join.  valid
select customerid
from customers
where productid = (select productid from products where productname in ('DVD','cookies','zebra');  --Nested select statements. Not a join. invalid ORA-01427: single-row subquery returns more than one row.

select customerid, productid, quantity || ' * ' || price || ' = ' || revenue as "show math"
from customers
where customerid between 10 and 20;  --concatenate.  CONCAT() two parameters only.

select customerid
from customers
where productid in (
	select productid
	from products
	where productname in ('DVD','cookies','zebra'));  --Nested select statements using In().  Find customers purchased DVD, cookies, zebra.

select count(revenue) as "count revenue", sum(revenue) "total_revenue", avg(revenue) as "avg revenue", min(revenue), max(revenue)
from customers
where country = 'HUN';

select count(*) as "customers sale outside NA"
from customers
where country not in ('USA','CAN');
select count(*) as "customers sale outside NA"
from customers
where country <> 'USA' and country <>'CAN';

select sum(revenue), customerid
from customers
group by customerid;
select customerid, sum(revenue)
from customers
group by customerid;

select productid, count(*)
from customers
group by productid
order by productid;

select count(distinct customerid)
from customers;  --Use distinct keyword
select count(distinct productid)
from customers;  --Use distinct keyword

select *
from customers
where price = (select max(price) from customers); --Nested select statements using =.  Find highest price records.

select max(count(*))
from customers
group by customerid;  --print 16
select customerid, max(count(*))
from customers
group by customerid;  --error ORA-00937: not a single-group group function
select customerid, count(*)
from customers
group by customerid
order by count(*) desc;  --get highest count customerid which are 6 and 10
select *
from customers
where customerid in (6,10);  --RM: how to combine to one sql statement?
select customerid, count(*)
from customers
where count(*) = (
	select max(count(*))
	from customers)
group by customerid;  --error ORA-00934: group function is not allowed here

--RM:  Start Portnov line 269 insert, delete, update on 02/23/2018
insert into customers values (502,100,101,'02/23/2018','USA',1,null,null);
select *
from customers
where salesid = 502;
insert into customers values((select max(salesid)+1 from customers),101,102,null,'CAN',null,null,null);  --salesdate field null is null. Oracle doesn't add sysdate today's date by default
insert into customers values((select max(salesid)+1 from customers),101,102,(select sysdate from dual),'CAN',null,null,null);  --salesdate field today's date from select sysdate from dual. Oracle doesn't add sysdate today's date by default
rollback;

update products
set cost = 1.00
where productid = 109;
update products
set price = cost/.8
where productid = 109;
rollback;

update customers
set quantity = 500
where customerid = 9 and productid = 122;
update customers
set revenue = quantity * price
where customerid = 9 and productid = 122;
rollback;

--JOIN.  Getting information from related tables is called JOIN operation.
--Step 1 start with fields to see in our result table.  Template-->tablename.tablefieldname
--Step 2 specify where we like to retrieve the information or specify the tables.
--Step 3 match or equate the fields in tables to connect the tables
select customers.customerid, customers.productid, products.productname, customers.quantity, customers.revenue
from customers, products
where customers.productid = products.productid;
--same as
select c.customerid, c.productid, p.productname, c.quantity, c.revenue
from customers c, products p
where c.productid = p.productid;

select c.customerid, c.productid, p.productname, c.quantity, c.revenue
from customers c left outer join products p
on c.productid = p.productid;  --returns 501 records including customerid 51 purchased nothing

select c.customerid, c.productid, p.productname, c.quantity, c.revenue
from customers c right outer join products p
on c.productid = p.productid;  --returns 500 records excluding customerid 51 purchased nothing

--Notice difference joins use on sql command; comma joins use where sql command
select p.productname as "Products", count(c.productid) as "Number Customers Purchased"
from products p right outer join customers c
on p.productid = c.productid
having count(c.productid) > 0
group by p.productname;
select p.productname as "Products", sum(c.quantity) as "Number Products Sold"
from products p, customers c
where p.productid = c.productid
group by p.productname
order by sum(c.quantity) desc;

--buckymysql.sql start line 144 UPPER