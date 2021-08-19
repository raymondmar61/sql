#cPanel-->Databases-->MySQL Databases.  Under Create New Database, type database name at New Database: _*database name*.  Press Create Database.
#phpMyAdmin _googlefeb2018 database
#single quotes and double quotes valid inserting values answer is yes

#create tables and insert values
create table country
(countryid integer primary key, country varchar(3), countryname varchar(30));
insert into country
values(1,'USA','United States Of America');
insert into country
values(2,'GBR','United Kingdom');
insert into country
values(3,'CHN','China');
insert into country
values(4,'JPN','Japan');
insert into country
values(5,'ITA','Italy');
insert into country
values(6,'CAN','Canada');
insert into country
values(7,'NLD','Netherlands');
insert into country
values(8,'CZE','Czech Republic');
insert into country
values(9,'HUN','Hungary');
insert into country
values(10,'FRA','France');
create table customers
(customerid integer primary key, country varchar(3));
insert into customers
values(1,"FRA");
insert into customers
values(2,"CZE");
insert into customers
values(3,"NLD");
insert into customers
values(4,"ITA");
insert into customers
values(5,"USA");
insert into customers
values(6,"CAN");
insert into customers
values(7,"CAN");
insert into customers
values(8,"CZE");
insert into customers
values(9,"HUN");
insert into customers
values(10,"NLD");
insert into customers
values(11,"ITA");
insert into customers
values(12,"FRA");
insert into customers
values(13,"GBR");
insert into customers
values(14,"CZE");
insert into customers
values(15,"HUN");
insert into customers
values(16,"JPN");
insert into customers
values(17,"CAN");
insert into customers
values(18,"JPN");
insert into customers
values(19,"NLD");
insert into customers
values(20,"FRA");
insert into customers
values(21,"HUN");
insert into customers
values(22,"FRA");
insert into customers
values(23,"GBR");
insert into customers
values(24,"NLD");
insert into customers
values(25,"CHN");
insert into customers
values(26,"NLD");
insert into customers
values(27,"ITA");
insert into customers
values(28,"FRA");
insert into customers
values(29,"FRA");
insert into customers
values(30,"FRA");
insert into customers
values(31,"GBR");
insert into customers
values(32,"NLD");
insert into customers
values(33,"NLD");
insert into customers
values(34,"CAN");
insert into customers
values(35,"JPN");
insert into customers
values(36,"FRA");
insert into customers
values(37,"GBR");
insert into customers
values(38,"USA");
insert into customers
values(39,"GBR");
insert into customers
values(40,"JPN");
insert into customers
values(41,"FRA");
insert into customers
values(42,"HUN");
insert into customers
values(43,"FRA");
insert into customers
values(44,"CHN");
insert into customers
values(45,"NLD");
insert into customers
values(46,"JPN");
insert into customers
values(47,"CHN");
insert into customers
values(48,"GBR");
insert into customers
values(49,"JPN");
insert into customers
values(50,"NLD");
create table products
(productid integer primary key, productname varchar(20), cost decimal(5,2), price decimal(5,2));
insert into products
values (100,'rose',24.23,30.29);
insert into products
values (101,'board game',86.89,108.61);
insert into products
values (102,'pot',11.95,14.94);
insert into products
values (103,'cookies',87.17,108.96);
insert into products
values (104,'DVD',97.74,122.18);
insert into products
values (105,'phone',119.94,149.93);
insert into products
values (106,'underwear',106.3,132.88);
insert into products
values (107,'bedsheet',34.48,43.1);
insert into products
values (108,'zebra',110.38,137.98);
insert into products
values (109,'apple',115.18,143.98);
insert into products
values (110,'flashlight',8.61,10.76);
insert into products
values (111,'book',119.94,149.93);
insert into products
values (112,'plant',85.04,106.3);
insert into products
values (113,'chair',7.91,9.89);
insert into products
values (114,'mop',59.5,74.38);
insert into products
values (115,'piano',18.04,22.55);
insert into products
values (116,'luggage',109.76,137.2);
insert into products
values (117,'fork',37.9,47.38);
insert into products
values (118,'candle',45.18,56.48);
insert into products
values (119,'jacket',59.64,74.55);
insert into products
values (120,'glasses',13.7,17.13);
insert into products
values (121,'soap',39.27,49.09);
insert into products
values (122,'fan',26.11,32.64);
insert into products
values (123,'toilet paper',31.74,39.67);
insert into products
values (124,'trail mix',86.83,108.54);
insert into products
values (125,'car',72.35,90.44);
create table sales
(salesid integer primary key, customerid integer, productid integer, salesdate date, quantity integer);
insert into sales
values (1,5,113,'2016/05/17',4);
insert into sales
values (2,37,101,'2017/02/24',2);
insert into sales
values (3,33,101,'2015/04/27',1);
insert into sales
values (4,26,117,'2017/03/17',2);
insert into sales
values (5,45,115,'2017/10/16',2);
insert into sales
values (6,27,107,'2017/03/25',3);
insert into sales
values (7,24,107,'2016/05/10',5);
insert into sales
values (8,32,116,'2015/03/06',3);
insert into sales
values (9,38,105,'2017/07/04',3);
insert into sales
values (10,17,114,'2017/05/18',5);
insert into sales
values (11,37,110,'2015/07/21',2);
insert into sales
values (12,32,104,'2015/11/22',5);
insert into sales
values (13,41,123,'2017/09/14',5);
insert into sales
values (14,46,109,'2017/09/25',2);
insert into sales
values (15,6,100,'2017/05/23',2);
insert into sales
values (16,18,101,'2016/05/22',4);
insert into sales
values (17,47,112,'2016/07/09',2);
insert into sales
values (18,19,100,'2017/03/10',5);
insert into sales
values (19,9,122,'2015/07/16',4);
insert into sales
values (20,36,122,'2017/09/20',2);
insert into sales
values (21,21,116,'2015/08/17',1);
insert into sales
values (22,28,115,'2017/12/29',4);
insert into sales
values (23,10,113,'2016/11/20',3);
insert into sales
values (24,18,124,'2016/01/27',5);
insert into sales
values (25,50,119,'2016/08/30',2);
insert into sales
values (26,1,109,'2016/01/24',5);
insert into sales
values (27,41,112,'2016/11/26',3);
insert into sales
values (28,25,100,'2015/05/10',1);
insert into sales
values (29,26,108,'2015/11/17',1);
insert into sales
values (30,24,120,'2016/08/04',2);
insert into sales
values (31,26,106,'2017/05/05',4);
insert into sales
values (32,6,107,'2017/05/05',4);
insert into sales
values (33,19,102,'2017/01/26',1);
insert into sales
values (34,39,102,'2015/03/23',3);
insert into sales
values (35,37,123,'2015/08/10',2);
insert into sales
values (36,40,102,'2017/08/25',2);
insert into sales
values (37,10,111,'2015/10/23',1);
insert into sales
values (38,30,117,'2015/07/27',3);
insert into sales
values (39,11,114,'2017/10/18',3);
insert into sales
values (40,41,102,'2015/07/21',1);
insert into sales
values (41,36,100,'2016/02/07',1);
insert into sales
values (42,2,123,'2015/04/18',1);
insert into sales
values (43,42,113,'2015/09/04',5);
insert into sales
values (44,27,103,'2016/11/19',2);
insert into sales
values (45,45,124,'2015/04/23',1);
insert into sales
values (46,1,106,'2016/06/12',2);
insert into sales
values (47,6,109,'2015/07/08',4);
insert into sales
values (48,12,116,'2017/11/09',1);
insert into sales
values (49,3,107,'2017/11/17',1);
insert into sales
values (50,6,118,'2015/04/07',1);
insert into sales
values (51,39,108,'2017/09/29',2);
insert into sales
values (52,10,123,'2016/10/18',5);
insert into sales
values (53,37,117,'2016/07/30',1);
insert into sales
values (54,10,125,'2015/12/22',4);
insert into sales
values (55,9,105,'2015/09/17',3);
insert into sales
values (56,32,121,'2016/10/12',5);
insert into sales
values (57,6,101,'2016/02/17',4);
insert into sales
values (58,12,105,'2015/04/15',3);
insert into sales
values (59,39,123,'2016/04/24',2);
insert into sales
values (60,31,112,'2017/04/14',3);
insert into sales
values (61,23,116,'2016/02/27',5);
insert into sales
values (62,31,125,'2015/09/02',3);
insert into sales
values (63,45,115,'2016/07/21',2);
insert into sales
values (64,27,125,'2015/11/15',5);
insert into sales
values (65,33,110,'2017/10/03',2);
insert into sales
values (66,11,118,'2017/07/10',1);
insert into sales
values (67,14,104,'2016/05/31',5);
insert into sales
values (68,48,107,'2015/05/11',3);
insert into sales
values (69,21,112,'2016/12/08',4);
insert into sales
values (70,30,105,'2015/04/06',4);
insert into sales
values (71,38,108,'2017/01/27',1);
insert into sales
values (72,9,109,'2017/10/22',1);
insert into sales
values (73,35,113,'2015/08/05',1);
insert into sales
values (74,16,114,'2015/02/01',5);
insert into sales
values (75,42,106,'2017/05/26',2);
insert into sales
values (76,42,119,'2017/08/25',1);
insert into sales
values (77,44,123,'2017/03/05',5);
insert into sales
values (78,28,120,'2016/01/01',5);
insert into sales
values (79,7,117,'2016/09/10',5);
insert into sales
values (80,26,121,'2016/08/08',1);
insert into sales
values (81,20,108,'2016/06/27',3);
insert into sales
values (82,9,109,'2015/09/03',3);
insert into sales
values (83,9,120,'2015/02/28',1);
insert into sales
values (84,39,124,'2017/09/18',4);
insert into sales
values (85,5,102,'2015/10/27',3);
insert into sales
values (86,24,114,'2017/04/02',1);
insert into sales
values (87,10,101,'2015/01/22',4);
insert into sales
values (88,44,103,'2015/08/16',5);
insert into sales
values (89,10,108,'2017/06/11',4);
insert into sales
values (90,20,113,'2017/12/07',1);
insert into sales
values (91,5,118,'2017/08/01',3);
insert into sales
values (92,49,118,'2015/01/19',5);
insert into sales
values (93,43,106,'2017/05/03',1);
insert into sales
values (94,25,119,'2015/07/02',1);
insert into sales
values (95,42,116,'2017/06/27',4);
insert into sales
values (96,45,115,'2016/02/05',2);
insert into sales
values (97,15,124,'2015/11/16',4);
insert into sales
values (98,20,105,'2015/12/17',3);
insert into sales
values (99,13,118,'2015/09/05',2);
insert into sales
values (100,47,111,'2015/08/11',1);
insert into sales
values (101,4,122,'2017/11/16',1);
insert into sales
values (102,7,112,'2015/08/27',4);
insert into sales
values (103,17,105,'2016/07/21',2);
insert into sales
values (104,31,108,'2017/03/14',5);
insert into sales
values (105,49,102,'2017/04/06',2);
insert into sales
values (106,28,105,'2015/04/30',3);
insert into sales
values (107,17,118,'2015/04/01',2);
insert into sales
values (108,15,108,'2015/10/10',5);
insert into sales
values (109,37,110,'2016/07/09',1);
insert into sales
values (110,14,125,'2016/12/17',2);
insert into sales
values (111,7,104,'2017/12/16',2);
insert into sales
values (112,11,114,'2016/03/18',4);
insert into sales
values (113,6,105,'2017/10/12',4);
insert into sales
values (114,10,108,'2016/12/07',5);
insert into sales
values (115,14,122,'2017/08/22',3);
insert into sales
values (116,22,103,'2015/10/28',4);
insert into sales
values (117,35,106,'2015/11/29',3);
insert into sales
values (118,6,119,'2015/06/09',5);
insert into sales
values (119,43,108,'2017/08/14',4);
insert into sales
values (120,11,120,'2017/10/26',4);
insert into sales
values (121,12,117,'2017/02/23',2);
insert into sales
values (122,18,105,'2016/06/10',4);
insert into sales
values (123,26,104,'2015/04/18',2);
insert into sales
values (124,12,125,'2015/10/10',3);
insert into sales
values (125,50,125,'2017/03/30',2);
insert into sales
values (126,13,109,'2017/07/03',2);
insert into sales
values (127,19,106,'2017/06/03',2);
insert into sales
values (128,30,108,'2015/07/21',4);
insert into sales
values (129,41,114,'2016/06/19',2);
insert into sales
values (130,42,101,'2017/02/15',3);
insert into sales
values (131,3,124,'2015/08/05',3);
insert into sales
values (132,26,118,'2015/08/23',4);
insert into sales
values (133,32,116,'2016/08/04',1);
insert into sales
values (134,31,121,'2017/04/10',1);
insert into sales
values (135,39,109,'2017/09/03',2);
insert into sales
values (136,19,115,'2015/05/26',4);
insert into sales
values (137,1,113,'2016/06/24',5);
insert into sales
values (138,48,122,'2017/07/18',3);
insert into sales
values (139,49,110,'2017/10/31',5);
insert into sales
values (140,20,102,'2016/03/23',4);
insert into sales
values (141,36,103,'2016/04/18',4);
insert into sales
values (142,9,101,'2017/05/27',2);
insert into sales
values (143,47,121,'2015/01/04',1);
insert into sales
values (144,6,115,'2017/05/09',3);
insert into sales
values (145,21,104,'2017/10/25',1);
insert into sales
values (146,14,123,'2015/11/18',2);
insert into sales
values (147,28,107,'2016/08/10',4);
insert into sales
values (148,2,102,'2017/11/05',1);
insert into sales
values (149,29,119,'2017/09/08',1);
insert into sales
values (150,21,112,'2016/07/16',5);
insert into sales
values (151,10,102,'2017/05/25',3);
insert into sales
values (152,30,111,'2016/12/10',5);
insert into sales
values (153,39,112,'2015/09/07',5);
insert into sales
values (154,11,119,'2017/04/08',4);
insert into sales
values (155,10,101,'2017/09/01',2);
insert into sales
values (156,39,104,'2016/09/28',2);
insert into sales
values (157,22,124,'2016/10/09',3);
insert into sales
values (158,4,114,'2017/06/20',3);
insert into sales
values (159,45,100,'2015/01/13',1);
insert into sales
values (160,25,123,'2016/02/28',4);
insert into sales
values (161,36,124,'2015/11/26',2);
insert into sales
values (162,36,115,'2017/06/06',3);
insert into sales
values (163,4,118,'2017/06/08',4);
insert into sales
values (164,23,104,'2016/06/15',1);
insert into sales
values (165,48,121,'2015/08/19',1);
insert into sales
values (166,36,119,'2017/09/08',1);
insert into sales
values (167,15,123,'2017/05/30',2);
insert into sales
values (168,10,110,'2017/03/23',3);
insert into sales
values (169,50,104,'2015/08/22',3);
insert into sales
values (170,12,106,'2016/12/17',3);
insert into sales
values (171,6,123,'2015/02/08',5);
insert into sales
values (172,45,114,'2016/02/28',2);
insert into sales
values (173,21,114,'2015/01/21',4);
insert into sales
values (174,36,118,'2017/07/30',4);
insert into sales
values (175,38,107,'2015/05/01',3);
insert into sales
values (176,19,101,'2017/12/21',4);
insert into sales
values (177,2,122,'2016/12/21',2);
insert into sales
values (178,21,119,'2016/01/09',4);
insert into sales
values (179,1,125,'2015/12/16',1);
insert into sales
values (180,46,108,'2017/02/07',3);
insert into sales
values (181,17,109,'2015/10/09',4);
insert into sales
values (182,29,110,'2015/04/02',1);
insert into sales
values (183,16,118,'2017/03/17',5);
insert into sales
values (184,3,115,'2016/07/19',4);
insert into sales
values (185,8,110,'2016/09/21',5);
insert into sales
values (186,42,106,'2015/06/16',4);
insert into sales
values (187,4,111,'2016/12/20',5);
insert into sales
values (188,35,118,'2016/04/28',1);
insert into sales
values (189,24,112,'2017/05/02',5);
insert into sales
values (190,25,105,'2015/05/05',5);
insert into sales
values (191,7,122,'2017/07/12',4);
insert into sales
values (192,1,110,'2015/08/29',1);
insert into sales
values (193,10,101,'2017/10/01',4);
insert into sales
values (194,39,111,'2017/09/20',4);
insert into sales
values (195,25,111,'2017/11/29',2);
insert into sales
values (196,13,100,'2017/04/13',4);
insert into sales
values (197,11,122,'2015/04/05',3);
insert into sales
values (198,46,121,'2015/03/21',5);
insert into sales
values (199,1,120,'2016/06/10',4);
insert into sales
values (200,17,107,'2016/03/15',5);
insert into sales
values (201,41,106,'2015/02/06',4);
insert into sales
values (202,23,113,'2015/06/15',1);
insert into sales
values (203,27,107,'2015/11/12',1);
insert into sales
values (204,46,108,'2015/10/05',2);
insert into sales
values (205,34,117,'2015/06/13',5);
insert into sales
values (206,6,115,'2016/02/02',5);
insert into sales
values (207,20,115,'2017/11/19',5);
insert into sales
values (208,32,106,'2017/06/17',1);
insert into sales
values (209,6,123,'2015/01/10',5);
insert into sales
values (210,6,122,'2015/02/08',2);
insert into sales
values (211,12,102,'2016/07/25',2);
insert into sales
values (212,44,118,'2015/04/06',2);
insert into sales
values (213,37,115,'2017/12/07',5);
insert into sales
values (214,30,114,'2015/09/20',2);
insert into sales
values (215,43,101,'2016/10/21',1);
insert into sales
values (216,22,113,'2017/04/28',1);
insert into sales
values (217,4,108,'2016/07/15',4);
insert into sales
values (218,30,105,'2016/09/08',2);
insert into sales
values (219,17,103,'2017/12/20',3);
insert into sales
values (220,15,125,'2017/06/21',2);
insert into sales
values (221,3,100,'2015/12/15',1);
insert into sales
values (222,17,111,'2015/02/03',1);
insert into sales
values (223,1,125,'2017/11/19',3);
insert into sales
values (224,27,119,'2017/11/09',1);
insert into sales
values (225,26,124,'2017/05/20',2);
insert into sales
values (226,9,117,'2015/07/18',2);
insert into sales
values (227,34,119,'2016/04/21',5);
insert into sales
values (228,19,109,'2015/02/14',1);
insert into sales
values (229,22,117,'2016/09/30',4);
insert into sales
values (230,43,122,'2016/01/05',3);
insert into sales
values (231,49,107,'2015/08/30',4);
insert into sales
values (232,49,123,'2015/08/19',3);
insert into sales
values (233,35,119,'2015/01/28',2);
insert into sales
values (234,47,111,'2017/12/31',5);
insert into sales
values (235,50,118,'2017/05/12',3);
insert into sales
values (236,26,115,'2017/06/07',5);
insert into sales
values (237,21,120,'2017/06/19',5);
insert into sales
values (238,32,124,'2016/03/03',1);
insert into sales
values (239,6,100,'2015/11/03',3);
insert into sales
values (240,3,105,'2017/07/27',2);
insert into sales
values (241,50,116,'2016/11/28',4);
insert into sales
values (242,8,117,'2015/04/26',3);
insert into sales
values (243,32,118,'2017/08/16',4);
insert into sales
values (244,32,121,'2016/05/05',2);
insert into sales
values (245,30,122,'2016/04/05',4);
insert into sales
values (246,8,119,'2016/02/28',2);
insert into sales
values (247,15,101,'2017/06/14',5);
insert into sales
values (248,36,124,'2017/10/04',4);
insert into sales
values (249,20,112,'2015/07/24',1);
insert into sales
values (250,22,123,'2016/12/05',5);
insert into sales
values (251,20,113,'2016/10/31',4);
insert into sales
values (252,11,121,'2017/12/22',3);
insert into sales
values (253,4,120,'2017/11/22',2);
insert into sales
values (254,41,110,'2017/05/24',3);
insert into sales
values (255,11,125,'2017/12/07',2);
insert into sales
values (256,3,106,'2015/05/19',3);
insert into sales
values (257,45,113,'2016/08/15',3);
insert into sales
values (258,32,121,'2015/01/17',1);
insert into sales
values (259,1,109,'2015/12/25',4);
insert into sales
values (260,43,113,'2016/02/29',4);
insert into sales
values (261,36,118,'2017/10/06',3);
insert into sales
values (262,6,110,'2016/11/07',5);
insert into sales
values (263,33,114,'2017/06/13',2);
insert into sales
values (264,14,115,'2015/03/05',2);
insert into sales
values (265,8,125,'2017/11/06',1);
insert into sales
values (266,31,125,'2016/08/16',3);
insert into sales
values (267,17,102,'2016/02/18',2);
insert into sales
values (268,38,103,'2015/11/14',2);
insert into sales
values (269,47,118,'2017/03/12',4);
insert into sales
values (270,45,103,'2016/05/19',5);
insert into sales
values (271,4,101,'2017/12/24',3);
insert into sales
values (272,22,122,'2017/05/29',2);
insert into sales
values (273,39,103,'2017/12/23',5);
insert into sales
values (274,1,117,'2017/09/07',2);
insert into sales
values (275,13,115,'2017/05/16',3);
insert into sales
values (276,18,103,'2015/04/21',5);
insert into sales
values (277,39,121,'2017/03/02',1);
insert into sales
values (278,15,105,'2017/11/25',4);
insert into sales
values (279,9,121,'2016/02/23',1);
insert into sales
values (280,42,121,'2015/08/04',4);
insert into sales
values (281,27,105,'2015/09/14',1);
insert into sales
values (282,38,105,'2015/07/17',2);
insert into sales
values (283,25,125,'2016/05/05',3);
insert into sales
values (284,46,106,'2017/03/15',5);
insert into sales
values (285,9,117,'2015/11/27',1);
insert into sales
values (286,28,106,'2017/08/08',5);
insert into sales
values (287,25,109,'2016/06/19',5);
insert into sales
values (288,34,101,'2015/11/19',2);
insert into sales
values (289,39,119,'2017/09/25',4);
insert into sales
values (290,36,122,'2016/06/12',1);
insert into sales
values (291,6,119,'2015/07/27',3);
insert into sales
values (292,50,108,'2017/03/12',2);
insert into sales
values (293,24,121,'2016/05/25',5);
insert into sales
values (294,35,119,'2015/01/27',1);
insert into sales
values (295,16,125,'2015/12/24',4);
insert into sales
values (296,19,124,'2017/08/01',5);
insert into sales
values (297,38,119,'2017/07/17',5);
insert into sales
values (298,45,100,'2017/08/23',1);
insert into sales
values (299,39,122,'2015/02/09',5);
insert into sales
values (300,17,120,'2016/08/07',2);
insert into sales
values (301,11,122,'2017/09/17',3);
insert into sales
values (302,4,110,'2016/05/08',1);
insert into sales
values (303,2,113,'2015/02/24',3);
insert into sales
values (304,10,106,'2015/11/06',2);
insert into sales
values (305,31,113,'2015/05/26',4);
insert into sales
values (306,23,119,'2017/07/03',2);
insert into sales
values (307,8,121,'2015/07/10',5);
insert into sales
values (308,40,104,'2017/11/25',5);
insert into sales
values (309,9,108,'2015/05/06',2);
insert into sales
values (310,34,112,'2017/07/25',2);
insert into sales
values (311,28,111,'2015/08/06',5);
insert into sales
values (312,4,108,'2016/04/07',2);
insert into sales
values (313,1,114,'2017/02/13',4);
insert into sales
values (314,14,106,'2016/10/27',4);
insert into sales
values (315,16,102,'2016/12/08',4);
insert into sales
values (316,20,123,'2017/01/16',5);
insert into sales
values (317,37,105,'2015/06/21',2);
insert into sales
values (318,8,101,'2016/09/28',3);
insert into sales
values (319,4,117,'2015/01/25',1);
insert into sales
values (320,49,112,'2016/06/29',2);
insert into sales
values (321,12,125,'2015/10/14',1);
insert into sales
values (322,4,101,'2016/01/29',4);
insert into sales
values (323,8,103,'2016/03/09',1);
insert into sales
values (324,1,116,'2015/09/01',2);
insert into sales
values (325,47,114,'2017/08/04',4);
insert into sales
values (326,19,119,'2015/01/07',2);
insert into sales
values (327,9,113,'2017/02/18',5);
insert into sales
values (328,48,102,'2016/04/01',2);
insert into sales
values (329,23,121,'2015/10/24',5);
insert into sales
values (330,42,101,'2016/10/13',1);
insert into sales
values (331,26,111,'2017/08/06',1);
insert into sales
values (332,46,106,'2016/05/18',5);
insert into sales
values (333,4,105,'2015/06/05',1);
insert into sales
values (334,23,118,'2016/02/04',3);
insert into sales
values (335,46,116,'2016/12/27',4);
insert into sales
values (336,17,121,'2016/10/05',5);
insert into sales
values (337,29,111,'2017/08/09',5);
insert into sales
values (338,37,116,'2016/09/14',4);
insert into sales
values (339,39,110,'2017/05/22',4);
insert into sales
values (340,20,116,'2016/05/18',2);
insert into sales
values (341,8,117,'2016/07/21',3);
insert into sales
values (342,27,121,'2015/02/01',3);
insert into sales
values (343,28,110,'2017/11/12',5);
insert into sales
values (344,37,102,'2015/12/13',3);
insert into sales
values (345,29,101,'2015/08/02',1);
insert into sales
values (346,34,125,'2015/07/18',2);
insert into sales
values (347,23,110,'2015/08/10',3);
insert into sales
values (348,47,105,'2015/09/23',1);
insert into sales
values (349,25,109,'2015/01/25',2);
insert into sales
values (350,3,115,'2015/02/26',4);
insert into sales
values (351,2,100,'2017/08/04',3);
insert into sales
values (352,17,101,'2017/07/04',4);
insert into sales
values (353,35,115,'2016/08/29',1);
insert into sales
values (354,35,118,'2015/03/15',5);
insert into sales
values (355,24,108,'2017/11/03',1);
insert into sales
values (356,19,103,'2017/10/02',5);
insert into sales
values (357,41,125,'2015/05/19',5);
insert into sales
values (358,48,110,'2016/02/07',4);
insert into sales
values (359,22,113,'2016/02/09',1);
insert into sales
values (360,41,124,'2016/09/15',1);
insert into sales
values (361,37,117,'2015/07/31',3);
insert into sales
values (362,22,116,'2015/01/22',5);
insert into sales
values (363,45,110,'2016/01/08',4);
insert into sales
values (364,33,102,'2017/01/31',4);
insert into sales
values (365,9,121,'2017/10/26',4);
insert into sales
values (366,37,120,'2015/05/21',2);
insert into sales
values (367,11,107,'2015/10/12',3);
insert into sales
values (368,25,114,'2015/05/18',5);
insert into sales
values (369,49,102,'2017/09/16',5);
insert into sales
values (370,7,111,'2016/04/11',3);
insert into sales
values (371,22,103,'2016/08/16',5);
insert into sales
values (372,29,107,'2016/02/15',3);
insert into sales
values (373,39,120,'2017/03/12',5);
insert into sales
values (374,35,104,'2015/07/27',1);
insert into sales
values (375,48,120,'2016/09/19',4);
insert into sales
values (376,11,124,'2017/01/06',4);
insert into sales
values (377,30,114,'2015/01/06',3);
insert into sales
values (378,22,113,'2015/06/05',4);
insert into sales
values (379,14,103,'2017/04/14',1);
insert into sales
values (380,32,117,'2015/09/14',2);
insert into sales
values (381,39,100,'2017/10/07',1);
insert into sales
values (382,30,110,'2015/06/05',5);
insert into sales
values (383,21,114,'2015/04/07',4);
insert into sales
values (384,19,103,'2016/07/07',2);
insert into sales
values (385,27,122,'2015/12/11',5);
insert into sales
values (386,10,110,'2016/05/20',4);
insert into sales
values (387,25,101,'2016/02/26',2);
insert into sales
values (388,24,120,'2015/04/24',4);
insert into sales
values (389,29,121,'2016/07/31',2);
insert into sales
values (390,42,104,'2016/08/25',2);
insert into sales
values (391,45,103,'2016/12/03',3);
insert into sales
values (392,5,123,'2017/08/26',4);
insert into sales
values (393,14,110,'2015/10/06',3);
insert into sales
values (394,42,115,'2016/07/01',4);
insert into sales
values (395,10,107,'2016/03/05',5);
insert into sales
values (396,8,122,'2016/11/01',2);
insert into sales
values (397,47,119,'2015/02/01',1);
insert into sales
values (398,21,102,'2016/05/19',4);
insert into sales
values (399,44,123,'2017/10/18',2);
insert into sales
values (400,23,118,'2016/06/22',5);
insert into sales
values (401,33,120,'2016/04/07',3);
insert into sales
values (402,41,117,'2015/10/29',5);
insert into sales
values (403,45,116,'2017/04/17',2);
insert into sales
values (404,46,108,'2015/12/17',2);
insert into sales
values (405,34,114,'2016/03/16',5);
insert into sales
values (406,2,124,'2017/11/30',2);
insert into sales
values (407,49,111,'2016/12/11',3);
insert into sales
values (408,45,123,'2015/04/05',1);
insert into sales
values (409,46,111,'2016/01/12',4);
insert into sales
values (410,27,117,'2016/03/17',5);
insert into sales
values (411,32,123,'2015/01/07',3);
insert into sales
values (412,26,101,'2016/03/28',4);
insert into sales
values (413,16,122,'2015/12/21',3);
insert into sales
values (414,10,110,'2015/07/20',4);
insert into sales
values (415,7,117,'2016/02/09',5);
insert into sales
values (416,17,121,'2015/03/23',5);
insert into sales
values (417,49,124,'2017/08/10',2);
insert into sales
values (418,7,120,'2015/02/04',3);
insert into sales
values (419,32,108,'2016/03/12',5);
insert into sales
values (420,50,112,'2017/12/01',2);
insert into sales
values (421,44,102,'2015/02/13',3);
insert into sales
values (422,25,109,'2016/06/10',2);
insert into sales
values (423,1,105,'2015/11/28',4);
insert into sales
values (424,35,109,'2015/08/29',3);
insert into sales
values (425,33,110,'2016/03/10',3);
insert into sales
values (426,40,120,'2015/12/28',2);
insert into sales
values (427,44,115,'2015/11/06',3);
insert into sales
values (428,38,100,'2017/11/22',4);
insert into sales
values (429,42,103,'2015/02/16',2);
insert into sales
values (430,32,116,'2015/01/27',5);
insert into sales
values (431,8,107,'2015/09/01',2);
insert into sales
values (432,46,119,'2017/01/15',1);
insert into sales
values (433,45,111,'2017/03/26',1);
insert into sales
values (434,17,107,'2016/07/12',2);
insert into sales
values (435,19,107,'2017/01/04',1);
insert into sales
values (436,38,114,'2016/07/14',1);
insert into sales
values (437,50,121,'2017/06/06',3);
insert into sales
values (438,18,102,'2017/08/11',2);
insert into sales
values (439,33,106,'2015/12/15',4);
insert into sales
values (440,30,101,'2017/08/30',5);
insert into sales
values (441,11,106,'2015/10/08',3);
insert into sales
values (442,24,103,'2015/08/16',1);
insert into sales
values (443,7,111,'2015/11/29',4);
insert into sales
values (444,14,102,'2017/11/23',1);
insert into sales
values (445,17,124,'2016/12/31',5);
insert into sales
values (446,28,104,'2017/09/14',4);
insert into sales
values (447,46,109,'2017/09/18',3);
insert into sales
values (448,12,124,'2017/02/28',3);
insert into sales
values (449,8,109,'2016/04/22',1);
insert into sales
values (450,5,119,'2017/02/21',1);
insert into sales
values (451,13,117,'2017/10/12',4);
insert into sales
values (452,27,113,'2017/10/04',3);
insert into sales
values (453,14,108,'2015/07/16',3);
insert into sales
values (454,35,100,'2015/05/10',3);
insert into sales
values (455,15,107,'2017/01/03',3);
insert into sales
values (456,13,111,'2017/11/16',4);
insert into sales
values (457,50,110,'2016/03/22',2);
insert into sales
values (458,21,119,'2016/02/29',1);
insert into sales
values (459,9,119,'2017/11/06',4);
insert into sales
values (460,37,122,'2017/12/10',4);
insert into sales
values (461,21,103,'2016/12/29',2);
insert into sales
values (462,25,112,'2016/10/13',5);
insert into sales
values (463,8,125,'2015/12/06',5);
insert into sales
values (464,5,114,'2016/06/16',4);
insert into sales
values (465,16,103,'2015/10/26',3);
insert into sales
values (466,30,123,'2017/12/27',4);
insert into sales
values (467,36,115,'2017/12/23',2);
insert into sales
values (468,26,106,'2017/09/17',2);
insert into sales
values (469,23,115,'2015/12/01',4);
insert into sales
values (470,25,108,'2016/05/06',2);
insert into sales
values (471,26,102,'2015/08/06',5);
insert into sales
values (472,26,115,'2017/01/21',4);
insert into sales
values (473,6,113,'2017/05/08',3);
insert into sales
values (474,1,107,'2015/02/15',2);
insert into sales
values (475,37,119,'2017/04/07',5);
insert into sales
values (476,43,110,'2016/09/19',2);
insert into sales
values (477,41,101,'2016/06/20',3);
insert into sales
values (478,26,124,'2015/11/04',4);
insert into sales
values (479,41,125,'2016/01/14',5);
insert into sales
values (480,24,101,'2015/07/03',4);
insert into sales
values (481,41,104,'2015/07/01',4);
insert into sales
values (482,12,109,'2017/10/12',4);
insert into sales
values (483,35,124,'2017/12/30',2);
insert into sales
values (484,10,117,'2015/09/25',4);
insert into sales
values (485,46,100,'2017/03/10',4);
insert into sales
values (486,40,121,'2017/04/09',5);
insert into sales
values (487,1,116,'2016/10/24',1);
insert into sales
values (488,44,119,'2016/10/31',5);
insert into sales
values (489,40,112,'2015/11/14',3);
insert into sales
values (490,2,117,'2016/06/19',3);
insert into sales
values (491,2,106,'2015/04/01',3);
insert into sales
values (492,32,120,'2015/01/24',5);
insert into sales
values (493,8,111,'2015/04/16',4);
insert into sales
values (494,32,124,'2017/08/27',5);
insert into sales
values (495,41,109,'2015/10/05',2);
insert into sales
values (496,48,117,'2015/05/13',4);
insert into sales
values (497,35,125,'2016/01/23',4);
insert into sales
values (498,8,100,'2017/01/28',2);
insert into sales
values (499,29,117,'2015/10/06',2);
insert into sales
values (500,3,124,'2015/07/07',1);

#Write a SQL query to get the Top 10 Customers per country in terms of Revenue?  RM:  Each customer is from the same country.  Modify question.  Top two customers by country because some countries have less than five.  It appeasrs rank() function doesn't work in phpMyAdmin.
select sales.customerid, sales.productid, sales.quantity, products.price, products.price*sales.quantity as "total purchased"
from sales, products
where sales.productid = products.productid;
select customers.country, sales.customerid, sum(products.price*sales.quantity) as "total purchased by country and customerid"
from sales, products, customers
where sales.productid = products.productid
and sales.customerid = customers.customerid
group by customers.country, sales.customerid
order by 1 asc, 3 desc;
/*
country customerid  total purchased by country and customerid    
CAN 17  3671.33 
CAN 6   3312.66 
CAN 7   2374.82 
CAN 34  1592.25 
CHN 25  4276.75 
CHN 47  1909.19 
CHN 44  1420.67 
CZE 8   2665.82 
CZE 14  2115.78 
CZE 2   998.29  
FRA 30  3601.28 
FRA 41  3597.10 
FRA 1   3541.87 
FRA 28  2754.61 
FRA 22  2504.75 
FRA 12  2373.57 
FRA 36  1797.95 
FRA 20  1664.74 
FRA 29  1265.81 
FRA 43  952.41  
GBR 39  3712.09 
GBR 37  2062.16 
GBR 23  1786.94 
GBR 31  1640.09 
GBR 13  1378.97 
...
*/
create view testview as
select customers.country, sales.customerid, sum(products.price*sales.quantity) as "totalpurchasedbycountryandcustomerid"
from sales, products, customers
where sales.productid = products.productid
and sales.customerid = customers.customerid
group by customers.country, sales.customerid
order by 1 asc, 3 desc;
#RM:  Ran query in phpMyAdmin my webpage.  Created a view testview in innova18_googlefeb2018 database under Views.
select *
from testview;
#Write a SQL query to get the Total Revenue by Product_Name and Country
select products.productname, customers.country, sum(products.price*sales.quantity)
from sales, products, customers
where sales.productid = products.productid
and sales.customerid = customers.customerid
group by products.productname, customers.country;
/*
productname country sum(products.price*sales.quantity)  
apple   CAN 1151.84 
apple   CHN 1295.82 
apple   CZE 143.98  
apple   FRA 2159.70 
apple   GBR 575.92  
apple   HUN 575.92  
apple   JPN 1151.84 
apple   NLD 143.98  
bedsheet    CAN 474.10  
bedsheet    CZE 86.20   
bedsheet    FRA 387.90  
bedsheet    GBR 129.30  
bedsheet    HUN 129.30  
bedsheet    ITA 301.70  
bedsheet    JPN 172.40  
bedsheet    NLD 517.20  
bedsheet    USA 129.30  
board game  CAN 1086.10 
board game  CHN 217.22  
board game  CZE 325.83  
board game  FRA 1086.10 
board game  GBR 217.22  
board game  HUN 1194.71 
board game  ITA 760.27  
board game  JPN 434.44  
...
*/
#Write a SQL query to get the Total Revenue by Country for the year 2017
select customers.country, sum(products.price*sales.quantity)
from sales, products, customers
where sales.productid = products.productid
and sales.customerid = customers.customerid
and sales.salesdate >= '2017/01/01' and sales.salesdate <= '2017/12/31' #or and sales.salesdate between '2017/01/01' and'2017/12/31'
group by customers.country;
#Is there anything wrong with this query? If yes, what would you suggest?
select customer_id, year(date) as year_date, sum(revenue) as revenue_sum
from customer
where year(date) in (2015);
#Yes.  Here's my sql query below.
select customer_id, extract(year from date) as year_date, sum(revenue) as revenue_sum
from customer
where extract(year from date) as year_date = 2015
group by 1, 2;
