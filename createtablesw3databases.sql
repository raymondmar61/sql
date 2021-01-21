#RM:  save time run the create table and the insert into values SQL together.
#RM:  varchar(must have a number)
create table salesman
	(salesman_id integer(4) not null primary key, name varchar(15), city varchar(10), commission decimal(3,2));
insert into salesman
values(5001,"James Hoog","New York",0.15);
insert into salesman
values(5002,"Nail Knite","Paris",0.13);
insert into salesman
values(5005,"Pit Alex","London",0.11);
insert into salesman
values(5006,"Mc Lyon","Paris",0.14);
insert into salesman
values(5007,"Paul Adam","Rome",0.13);
insert into salesman
values(5003,"Lauson Hen","San Jose",0.12);

create table orders
	(ord_no integer not null primary key, purch_amt decimal(5,2), ord_date date, customer_id integer, salesman_id integer);
insert into orders
values(70001,150.5,"10/5/2012",3005,5002);
insert into orders
values(70009,270.65,"9/10/2012",3001,5005);
insert into orders
values(70002,65.26,"10/5/2012",3002,5001);
insert into orders
values(70004,110.5,"8/17/2012",3009,5003);
insert into orders
values(70007,948.5,"9/10/2012",3005,5002);
insert into orders
values(70005,2400.6,"7/27/2012",3007,5001);
insert into orders
values(70008,5760,"9/10/2012",3002,5001);
insert into orders
values(70010,1983.43,"10/10/2012",3004,5006);
insert into orders
values(70003,2480.4,"10/10/2012",3009,5003);
insert into orders
values(70012,250.45,"6/27/2012",3008,5002);
insert into orders
values(70011,75.29,"8/17/2012",3003,5007);
insert into orders
values(70013,3045.6,"4/25/2012",3002,5001);
#RM:  innovateinfinitely.com cPanel wants yyyy-mm-dd MySQL database.  Source https://www.mysqltutorial.org/mysql-date/.
delete
from orders;
alter table orders
modify column purch_amt decimal(6,2); #RM:  MySQL
alter table orders
modify purch_amt decimal(6,2); #RM:  Oracle
insert into orders
values(70001,150.5,"2012/10/05",3005,5002);
insert into orders
values(70009,270.65,"2012/09/10",3001,5005);
insert into orders
values(70002,65.26,"2012/10/05",3002,5001);
insert into orders
values(70004,110.5,"2012/08/17",3009,5003);
insert into orders
values(70007,948.5,"2012/09/10",3005,5002);
insert into orders
values(70005,2400.6,"2012/07/27",3007,5001);
insert into orders
values(70008,5760,"2012/09/10",3002,5001);
insert into orders
values(70010,1983.43,"2012/10/10",3004,5006);
insert into orders
values(70003,2480.4,"2012/10/10",3009,5003);
insert into orders
values(70012,250.45,"2012/06/27",3008,5002);
insert into orders
values(70011,75.29,"2012/08/17",3003,5007);
insert into orders
values(70013,3045.6,"2012/04/25",3002,5001);

create table customer
(customer_id integer not null, cust_name varchar(15), city varchar(15), grade integer, salesman_id integer, primary key (customer_id));
insert into customer
values(3002,"Nick Rimando","New York",100,5001);
insert into customer
values(3007,"Brad Davis","New York",200,5001);
insert into customer
values(3005,"Graham Zusi","California",200,5002);
insert into customer
values(3008,"Julian Green","London",300,5002);
insert into customer
values(3004,"Fabian Johnson","Paris",300,5006);
insert into customer
values(3009,"Geoff Cameron","Berlin",100,5003);
insert into customer
values(3003,"Jozy Altidor","Moscow",200,5007);
insert into customer
values(3001,"Brad Guzan","London",,5005);

create table movies
(mov_id integer not null, mov_title varchar(25), mov_year integer, mov_time integer, mov_lang varchar(10), mov_dt_rel date, mov_rel_country varchar(3), constraint constraintname primary key (mov_id));
insert into movies
values(901,"Vertigo",1958,128,"English","1958-08-24","UK");
insert into movies
values(902,"The Innocents",1961,100,"English","1962-02-19","SW");
insert into movies
values(903,"Lawrence of Arabia",1962,216,"English","1962-12-11","UK");
insert into movies
values(904,"The Deer Hunter",1978,183,"English","1979-03-08","UK");
insert into movies
values(905,"Amadeus",1984,160,"English","1985-01-07","UK");
insert into movies
values(906,"Blade Runner",1982,117,"English","1982-09-09","UK");
insert into movies
values(907,"Eyes Wide Shut",1999,159,"English","","UK");
insert into movies
values(908,"The Usual Suspects",1995,106,"English","1995-08-25","UK");
insert into movies
values(909,"Chinatown",1974,130,"English","1974-08-09","UK");
insert into movies
values(910,"Boogie Nights",1997,155,"English","1998-02-16","UK");
insert into movies
values(911,"Annie Hall",1977,93,"English","1977-04-20","USA");
insert into movies
values(912,"Princess Mononoke",1997,134,"Japanese","2001-10-19","UK");
insert into movies
values(913,"The Shawshank Redemption",1994,142,"English","1995-02-17","UK");
insert into movies
values(914,"American Beauty",1999,122,"English","","UK");
insert into movies
values(915,"Titanic",1997,194,"English","1998-01-23","UK");
insert into movies
values(916,"Good Will Hunting",1997,126,"English","1998-06-03","UK");
insert into movies
values(917,"Deliverance",1972,109,"English","1982-10-05","UK");
insert into movies
values(918,"Trainspotting",1996,94,"English","1996-02-23","UK");
insert into movies
values(919,"The Prestige",2006,130,"English","2006-11-10","UK");
insert into movies
values(920,"Donnie Darko",2001,113,"English","","UK");
insert into movies
values(921,"Slumdog Millionaire",2008,120,"English","2009-01-09","UK");
insert into movies
values(922,"Aliens",1986,137,"English","1986-08-29","UK");
insert into movies
values(923,"Beyond the Sea",2004,118,"English","2004-11-26","UK");
insert into movies
values(924,"Avatar",2009,162,"English","2009-12-17","UK");
insert into movies
values(926,"Seven Samurai",1954,207,"Japanese","1954-04-26","JP");
insert into movies
values(927,"Spirited Away",2001,125,"Japanese","2003-09-12","UK");
insert into movies
values(928,"Back to the Future",1985,116,"English","1985-12-04","UK");
insert into movies
values(925,"Braveheart",1995,178,"English","1995-09-08","UK");
create table reviewer
(rev_id integer, rev_name varchar(20));
alter table reviewer
modify column rev_id integer not null primary key;
insert into reviewer
values(9001,"Righty Sock");
insert into reviewer
values(9002,"Jack Malvern");
insert into reviewer
values(9003,"Flagrant Baronessa");
insert into reviewer
values(9004,"Alec Shaw");
insert into reviewer
values(9005,"");
insert into reviewer
values(9006,"Victor Woeltjen");
insert into reviewer
values(9007,"Simon Wright");
insert into reviewer
values(9008,"Neal Wruck");
insert into reviewer
values(9009,"Paul Monks");
insert into reviewer
values(9010,"Mike Salvati");
insert into reviewer
values(9011,"");
insert into reviewer
values(9012,"Wesley S. Walker");
insert into reviewer
values(9013,"Sasha Goldshtein");
insert into reviewer
values(9014,"Josh Cates");
insert into reviewer
values(9015,"Krug Stillo");
insert into reviewer
values(9016,"Scott LeBrun");
insert into reviewer
values(9017,"Hannah Steele");
insert into reviewer
values(9018,"Vincent Cadena");
insert into reviewer
values(9019,"Brandt Sponseller");
insert into reviewer
values(9020,"Richard Adams");
create table rating
(mov_id integer not null, rev_id integer not null, rev_stars decimal(2,1), num_o_ratings integer);
insert into rating
values(901,9001,8.4,263575);
insert into rating
values(902,9002,7.9,20207);
insert into rating
values(903,9003,8.3,202778);
insert into rating
values(906,9005,8.2,484746);
insert into rating
values(924,9006,7.3,);
insert into rating
values(908,9007,8.6,779489);
insert into rating
values(909,9008,,227235);
insert into rating
values(910,9009,3,195961);
insert into rating
values(911,9010,8.1,203875);
insert into rating
values(912,9011,8.4,);
insert into rating
values(914,9013,7,862618);
insert into rating
values(915,9001,7.7,830095);
insert into rating
values(916,9014,4,642132);
insert into rating
values(925,9015,7.7,81328);
insert into rating
values(918,9016,,580301);
insert into rating
values(920,9017,8.1,609451);
insert into rating
values(921,9018,8,667758);
insert into rating
values(922,9019,8.4,511613);
insert into rating
values(923,9020,6.7,13091);
create table actor
(act_id integer not null, act_fname varchar(10), act_lname varchar(10), act_gender varchar(1), constraint primarykey_act_id primary key (act_id));
(act_id integer, act_fname varchar(10), act_lname varchar(10), act_gender varchar(1), constraint primarykey_act_id primary key (act_id), constraint notnull_act_id not null (act_id)); #constraint not null invalid
insert into actor
values(101,"James","Stewart","M");
insert into actor
values(102,"Deborah","Kerr","F");
insert into actor
values(103,"Peter","OToole","M");
insert into actor
values(104,"Robert","De Niro","M");
insert into actor
values(105,"F. Murray","Abraham","M");
insert into actor
values(106,"Harrison","Ford","M");
insert into actor
values(107,"Nicole","Kidman","F");
insert into actor
values(108,"Stephen","Baldwin","M");
insert into actor
values(109,"Jack","Nicholson","M");
insert into actor
values(110,"Mark","Wahlberg","M");
insert into actor
values(111,"Woody","Allen","M");
insert into actor
values(112,"Claire","Danes","F");
insert into actor
values(113,"Tim","Robbins","M");
insert into actor
values(114,"Kevin","Spacey","M");
insert into actor
values(115,"Kate","Winslet","F");
insert into actor
values(116,"Robin","Williams","M");
insert into actor
values(117,"Jon","Voight","M");
insert into actor
values(118,"Ewan","McGregor","M");
insert into actor
values(119,"Christian","Bale","M");
insert into actor
values(120,"Maggie","Gyllenhaal","F");
insert into actor
values(121,"Dev","Patel","M");
insert into actor
values(122,"Sigourney","Weaver","F");
insert into actor
values(123,"David","Aston","M");
insert into actor
values(124,"Ali","Astin","F");
create table moviecast
(act_id integer not null, mov_id integer not null, role varchar(25));
insert into moviecast
values(101,901,"John Scottie Ferguson");
insert into moviecast
values(102,902,"Miss Giddens");
insert into moviecast
values(103,903,"T.E. Lawrence");
insert into moviecast
values(104,904,"Michael");
insert into moviecast
values(105,905,"Antonio Salieri");
insert into moviecast
values(106,906,"Rick Deckard");
insert into moviecast
values(107,907,"Alice Harford");
insert into moviecast
values(108,908,"McManus");
insert into moviecast
values(110,910,"Eddie Adams");
insert into moviecast
values(111,911,"Alvy Singer");
insert into moviecast
values(112,912,"San");
insert into moviecast
values(113,913,"Andy Dufresne");
insert into moviecast
values(114,914,"Lester Burnham");
insert into moviecast
values(115,915,"Rose DeWitt Bukater");
insert into moviecast
values(116,916,"Sean Maguire");
insert into moviecast
values(117,917,"Ed");
insert into moviecast
values(118,918,"Renton");
insert into moviecast
values(120,920,"Elizabeth Darko");
insert into moviecast
values(121,921,"Older Jamal");
insert into moviecast
values(122,922,"Ripley");
insert into moviecast
values(114,923,"Bobby Darin");
insert into moviecast
values(109,909,"J.J. Gittes");
insert into moviecast
values(119,919,"Alfred Borden");
create table director
(dir_id integer not null primary key, dir_fname varchar(15), dir_lname varchar(15));
insert into director
values(201,"Alfred","Hitchcock");
insert into director
values(202,"Jack","Clayton");
insert into director
values(203,"David","Lean");
insert into director
values(204,"Michael","Cimino");
insert into director
values(205,"Milos","Forman");
insert into director
values(206,"Ridley","Scott");
insert into director
values(207,"Stanley","Kubrick");
insert into director
values(208,"Bryan","Singer");
insert into director
values(209,"Roman","Polanski");
insert into director
values(210,"Paul","Thomas Anderson");
insert into director
values(211,"Woody","Allen");
insert into director
values(212,"Hayao","Miyazaki");
insert into director
values(213,"Frank","Darabont");
insert into director
values(214,"Sam","Mendes");
insert into director
values(215,"James","Cameron");
insert into director
values(216,"Gus","Van Sant");
insert into director
values(217,"John","Boorman");
insert into director
values(218,"Danny","Boyle");
insert into director
values(219,"Christopher","Nolan");
insert into director
values(220,"Richard","Kelly");
insert into director
values(221,"Kevin","Spacey");
insert into director
values(222,"Andrei","Tarkovsky");
insert into director
values(223,"Peter","Jackson");
create table moviedirection
(dir_id integer not null, mov_id integer not null);
insert into moviedirection
values(201,901);
insert into moviedirection
values(202,902);
insert into moviedirection
values(203,903);
insert into moviedirection
values(204,904);
insert into moviedirection
values(205,905);
insert into moviedirection
values(206,906);
insert into moviedirection
values(207,907);
insert into moviedirection
values(208,908);
insert into moviedirection
values(209,909);
insert into moviedirection
values(210,910);
insert into moviedirection
values(211,911);
insert into moviedirection
values(212,912);
insert into moviedirection
values(213,913);
insert into moviedirection
values(214,914);
insert into moviedirection
values(215,915);
insert into moviedirection
values(216,916);
insert into moviedirection
values(217,917);
insert into moviedirection
values(218,918);
insert into moviedirection
values(219,919);
insert into moviedirection
values(220,920);
insert into moviedirection
values(218,921);
insert into moviedirection
values(215,922);
insert into moviedirection
values(221,923);
create table genres
(gen_id integer not null primary key, gen_title varchar(10) not null);
insert into genres
values(1001,"Action");
insert into genres
values(1002,"Adventure");
insert into genres
values(1003,"Animation");
insert into genres
values(1004,"Biography");
insert into genres
values(1005,"Comedy");
insert into genres
values(1006,"Crime");
insert into genres
values(1007,"Drama");
insert into genres
values(1008,"Horror");
insert into genres
values(1009,"Music");
insert into genres
values(1010,"Mystery");
insert into genres
values(1011,"Romance");
insert into genres
values(1012,"Thriller");
insert into genres
values(1013,"War");
create table moviegenres
(mov_id integer not null primary key, gen_id integer not null);
insert into moviegenres
values(922,1001);
insert into moviegenres
values(917,1002);
insert into moviegenres
values(903,1002);
insert into moviegenres
values(912,1003);
insert into moviegenres
values(911,1005);
insert into moviegenres
values(908,1006);
insert into moviegenres
values(913,1006);
insert into moviegenres
values(926,1007);
insert into moviegenres
values(928,1007);
insert into moviegenres
values(918,1007);
insert into moviegenres
values(921,1007);
insert into moviegenres
values(902,1008);
insert into moviegenres
values(923,1009);
insert into moviegenres
values(907,1010);
insert into moviegenres
values(927,1010);
insert into moviegenres
values(901,1010);
insert into moviegenres
values(914,1011);
insert into moviegenres
values(906,1012);
insert into moviegenres
values(904,1013);

create table employees
(emp_id integer not null, emp_name varchar(20), job_name varchar(10) not null, manager_id integer, hire_date date not null, salary integer, commission integer, dep_id integer not null, constraint primarykey_emp_id primary key (emp_id));
insert into employees
values(68319,"KAYLING","PRESIDENT",null,"1991-11-18",6000,null,1001);
insert into employees
values(66928,"BLAZE","MANAGER",68319,"1991-05-01",2750,null,3001);
insert into employees
values(67832,"CLARE","MANAGER",68319,"1991-06-09",2550,null,1001);
insert into employees
values(65646,"JONAS","MANAGER",68319,"1991-04-02",2957,null,2001);
insert into employees
values(67858,"SCARLET","ANALYST",65646,"1997-04-19",3100,null,2001);
insert into employees
values(69062,"FRANK","ANALYST",65646,"1991-12-03",3100,null,2001);
insert into employees
values(63679,"SANDRINE","CLERK",69062,"1990-12-18",900,null,2001);
insert into employees
values(64989,"ADELYN","SALESMAN",66928,"1991-02-20",1700,400,3001);
insert into employees
values(65271,"WADE","SALESMAN",66928,"1991-02-22",1350,600,3001);
insert into employees
values(66564,"MADDEN","SALESMAN",66928,"1991-09-28",1350,1500,3001);
insert into employees
values(68454,"TUCKER","SALESMAN",66928,"1991-09-08",1600,null,3001);
insert into employees
values(68736,"ADNRES","CLERK",67858,"1997-05-23",1200,null,2001);
insert into employees
values(69000,"JULIUS","CLERK",66928,"1991-12-03",1050,null,3001);
insert into employees
values(69324,"MARKER","CLERK",67832,"1992-01-23",1400,null,1001);
create table department
(dep_id integer not null primary key, dep_name varchar(20), dep_location varchar(15));
insert into department
values(1001,"FINANCE","SYDNEY");
insert into department
values(2001,"AUDIT","MELBOURNE");
insert into department
values(3001,"MARKETING","PERTH");
insert into department
values(4001,"PRODUCTION","BRISBANE");
create table salary
(grade integer not null primary key, min_sal integer not null, max_sal integer not null);
insert into salary
values(1,800,1300);
insert into salary
values(2,1301,1500);
insert into salary
values(3,1501,2100);
insert into salary
values(4,2101,3100);
insert into salary
values(5,3101,9999);

create table employeeshr
(employee_id integer not null primary key, first_name varchar(15), last_name varchar(20), email	varchar(20), phone_number varchar(20), hire_date date, job_id varchar(10), salary integer, commission_pct decimal(3,2),	manager_id integer, department_id integer);
insert into employeeshr
values(100,"Steven","King","SKING","515.123.4567","2003-06-17","AD_PRES",24000,0,0,90);
insert into employeeshr
values(101,"Neena","Kochhar","NKOCHHAR","515.123.4568","2005-09-21","AD_VP",17000,0,100,90);
insert into employeeshr
values(102,"Lex","De Haan","LDEHAAN","515.123.4569","2001-01-13","AD_VP",17000,0,100,90);
insert into employeeshr
values(103,"Alexander","Hunold","AHUNOLD","590.423.4567","2006-01-03","IT_PROG",9000,0,102,60);
insert into employeeshr
values(104,"Bruce","Ernst","BERNST","590.423.4568","2007-05-21","IT_PROG",6000,0,103,60);
insert into employeeshr
values(105,"David","Austin","DAUSTIN","590.423.4569","2005-06-25","IT_PROG",4800,0,103,60);
insert into employeeshr
values(106,"Valli","Pataballa","VPATABAL","590.423.4560","2006-02-05","IT_PROG",4800,0,103,60);
insert into employeeshr
values(107,"Diana","Lorentz","DLORENTZ","590.423.5567","2007-02-07","IT_PROG",4200,0,103,60);
insert into employeeshr
values(108,"Nancy","Greenberg","NGREENBE","515.124.4569","2002-08-17","FI_MGR",12008,0,101,100);
insert into employeeshr
values(109,"Daniel","Faviet","DFAVIET","515.124.4169","2002-08-16","FI_ACCOUNT",9000,0,108,100);
insert into employeeshr
values(110,"John","Chen","JCHEN","515.124.4269","2005-09-28","FI_ACCOUNT",8200,0,108,100);
insert into employeeshr
values(111,"Ismael","Sciarra","ISCIARRA","515.124.4369","2005-09-30","FI_ACCOUNT",7700,0,108,100);
insert into employeeshr
values(112,"Jose Manuel","Urman","JMURMAN","515.124.4469","2006-03-07","FI_ACCOUNT",7800,0,108,100);
insert into employeeshr
values(113,"Luis","Popp","LPOPP","515.124.4567","2007-12-07","FI_ACCOUNT",6900,0,108,100);
insert into employeeshr
values(114,"Den","Raphaely","DRAPHEAL","515.127.4561","2002-12-07","PU_MAN",11000,0,100,30);
insert into employeeshr
values(115,"Alexander","Khoo","AKHOO","515.127.4562","2003-05-18","PU_CLERK",3100,0,114,30);
insert into employeeshr
values(116,"Shelli","Baida","SBAIDA","515.127.4563","2005-12-24","PU_CLERK",2900,0,114,30);
insert into employeeshr
values(117,"Sigal","Tobias","STOBIAS","515.127.4564","2005-07-24","PU_CLERK",2800,0,114,30);
insert into employeeshr
values(118,"Guy","Himuro","GHIMURO","515.127.4565","2006-11-15","PU_CLERK",2600,0,114,30);
insert into employeeshr
values(119,"Karen","Colmenares","KCOLMENA","515.127.4566","2007-08-10","PU_CLERK",2500,0,114,30);
insert into employeeshr
values(120,"Matthew","Weiss","MWEISS","650.123.1234","2004-07-18","ST_MAN",8000,0,100,50);
insert into employeeshr
values(121,"Adam","Fripp","AFRIPP","650.123.2234","2005-04-10","ST_MAN",8200,0,100,50);
insert into employeeshr
values(122,"Payam","Kaufling","PKAUFLIN","650.123.3234","2003-05-01","ST_MAN",7900,0,100,50);
insert into employeeshr
values(123,"Shanta","Vollman","SVOLLMAN","650.123.4234","2005-10-10","ST_MAN",6500,0,100,50);
insert into employeeshr
values(124,"Kevin","Mourgos","KMOURGOS","650.123.5234","2007-11-16","ST_MAN",5800,0,100,50);
insert into employeeshr
values(125,"Julia","Nayer","JNAYER","650.124.1214","2005-07-16","ST_CLERK",3200,0,120,50);
insert into employeeshr
values(126,"Irene","Mikkilineni","IMIKKILI","650.124.1224","2006-09-28","ST_CLERK",2700,0,120,50);
insert into employeeshr
values(127,"James","Landry","JLANDRY","650.124.1334","2007-01-14","ST_CLERK",2400,0,120,50);
insert into employeeshr
values(128,"Steven","Markle","SMARKLE","650.124.1434","2008-03-08","ST_CLERK",2200,0,120,50);
insert into employeeshr
values(129,"Laura","Bissot","LBISSOT","650.124.5234","2005-08-20","ST_CLERK",3300,0,121,50);
insert into employeeshr
values(130,"Mozhe","Atkinson","MATKINSO","650.124.6234","2005-10-30","ST_CLERK",2800,0,121,50);
insert into employeeshr
values(131,"James","Marlow","JAMRLOW","650.124.7234","2005-02-16","ST_CLERK",2500,0,121,50);
insert into employeeshr
values(132,"TJ","Olson","TJOLSON","650.124.8234","2007-04-10","ST_CLERK",2100,0,121,50);
insert into employeeshr
values(133,"Jason","Mallin","JMALLIN","650.127.1934","2004-06-14","ST_CLERK",3300,0,122,50);
insert into employeeshr
values(134,"Michael","Rogers","MROGERS","650.127.1834","2006-08-26","ST_CLERK",2900,0,122,50);
insert into employeeshr
values(135,"Ki","Gee","KGEE","650.127.1734","2007-12-12","ST_CLERK",2400,0,122,50);
insert into employeeshr
values(136,"Hazel","Philtanker","HPHILTAN","650.127.1634","2008-02-06","ST_CLERK",2200,0,122,50);
insert into employeeshr
values(137,"Renske","Ladwig","RLADWIG","650.121.1234","2003-07-14","ST_CLERK",3600,0,123,50);
insert into employeeshr
values(138,"Stephen","Stiles","SSTILES","650.121.2034","2005-10-26","ST_CLERK",3200,0,123,50);
insert into employeeshr
values(139,"John","Seo","JSEO","650.121.2019","2006-02-12","ST_CLERK",2700,0,123,50);
insert into employeeshr
values(140,"Joshua","Patel","JPATEL","650.121.1834","2006-04-06","ST_CLERK",2500,0,123,50);
insert into employeeshr
values(141,"Trenna","Rajs","TRAJS","650.121.8009","2003-10-17","ST_CLERK",3500,0,124,50);
insert into employeeshr
values(142,"Curtis","Davies","CDAVIES","650.121.2994","2005-01-29","ST_CLERK",3100,0,124,50);
insert into employeeshr
values(143,"Randall","Matos","RMATOS","650.121.2874","2006-03-15","ST_CLERK",2600,0,124,50);
insert into employeeshr
values(144,"Peter","Vargas","PVARGAS","650.121.2004","2006-07-09","ST_CLERK",2500,0,124,50);
insert into employeeshr
values(145,"John","Russell","JRUSSEL","011.44.1344.429268","2004-10-01","SA_MAN",14000,0.4,100,80);
insert into employeeshr
values(146,"Karen","Partners","KPARTNER","011.44.1344.467268","2005-01-05","SA_MAN",13500,0.3,100,80);
insert into employeeshr
values(147,"Alberto","Errazuriz","AERRAZUR","011.44.1344.429278","2005-03-10","SA_MAN",12000,0.3,100,80);
insert into employeeshr
values(148,"Gerald","Cambrault","GCAMBRAU","011.44.1344.619268","2007-10-15","SA_MAN",11000,0.3,100,80);
insert into employeeshr
values(149,"Eleni","Zlotkey","EZLOTKEY","011.44.1344.429018","2008-01-29","SA_MAN",10500,0.2,100,80);
insert into employeeshr
values(150,"Peter","Tucker","PTUCKER","011.44.1344.129268","2005-01-30","SA_REP",10000,0.3,145,80);
insert into employeeshr
values(151,"David","Bernstein","DBERNSTE","011.44.1344.345268","2005-03-24","SA_REP",9500,0.25,145,80);
insert into employeeshr
values(152,"Peter","Hall","PHALL","011.44.1344.478968","2005-08-20","SA_REP",9000,0.25,145,80);
insert into employeeshr
values(153,"Christopher","Olsen","COLSEN","011.44.1344.498718","2006-03-30","SA_REP",8000,0.2,145,80);
insert into employeeshr
values(154,"Nanette","Cambrault","NCAMBRAU","011.44.1344.987668","2006-12-09","SA_REP",7500,0.2,145,80);
insert into employeeshr
values(155,"Oliver","Tuvault","OTUVAULT","011.44.1344.486508","2007-11-23","SA_REP",7000,0.15,145,80);
insert into employeeshr
values(156,"Janette","King","JKING","011.44.1345.429268","2004-01-30","SA_REP",10000,0.35,146,80);
insert into employeeshr
values(157,"Patrick","Sully","PSULLY","011.44.1345.929268","2004-03-04","SA_REP",9500,0.35,146,80);
insert into employeeshr
values(158,"Allan","McEwen","AMCEWEN","011.44.1345.829268","2004-08-01","SA_REP",9000,0.35,146,80);
insert into employeeshr
values(159,"Lindsey","Smith","LSMITH","011.44.1345.729268","2005-03-10","SA_REP",8000,0.3,146,80);
insert into employeeshr
values(160,"Louise","Doran","LDORAN","011.44.1345.629268","2005-12-15","SA_REP",7500,0.3,146,80);
insert into employeeshr
values(161,"Sarath","Sewall","SSEWALL","011.44.1345.529268","2006-11-03","SA_REP",7000,0.25,146,80);
insert into employeeshr
values(162,"Clara","Vishney","CVISHNEY","011.44.1346.129268","2005-11-11","SA_REP",10500,0.25,147,80);
insert into employeeshr
values(163,"Danielle","Greene","DGREENE","011.44.1346.229268","2007-03-19","SA_REP",9500,0.15,147,80);
insert into employeeshr
values(164,"Mattea","Marvins","MMARVINS","011.44.1346.329268","2008-01-24","SA_REP",7200,0.1,147,80);
insert into employeeshr
values(165,"David","Lee","DLEE","011.44.1346.529268","2008-02-23","SA_REP",6800,0.1,147,80);
insert into employeeshr
values(166,"Sundar","Ande","SANDE","011.44.1346.629268","2008-03-24","SA_REP",6400,0.1,147,80);
insert into employeeshr
values(167,"Amit","Banda","ABANDA","011.44.1346.729268","2008-04-21","SA_REP",6200,0.1,147,80);
insert into employeeshr
values(168,"Lisa","Ozer","LOZER","011.44.1343.929268","2005-03-11","SA_REP",11500,0.25,148,80);
insert into employeeshr
values(169,"Harrison","Bloom","HBLOOM","011.44.1343.829268","2006-03-23","SA_REP",10000,0.2,148,80);
insert into employeeshr
values(170,"Tayler","Fox","TFOX","011.44.1343.729268","2006-01-24","SA_REP",9600,0.2,148,80);
insert into employeeshr
values(171,"William","Smith","WSMITH","011.44.1343.629268","2007-02-23","SA_REP",7400,0.15,148,80);
insert into employeeshr
values(172,"Elizabeth","Bates","EBATES","011.44.1343.529268","2007-03-24","SA_REP",7300,0.15,148,80);
insert into employeeshr
values(173,"Sundita","Kumar","SKUMAR","011.44.1343.329268","2008-04-21","SA_REP",6100,0.1,148,80);
insert into employeeshr
values(174,"Ellen","Abel","EABEL","011.44.1644.429267","2004-05-11","SA_REP",11000,0.3,149,80);
insert into employeeshr
values(175,"Alyssa","Hutton","AHUTTON","011.44.1644.429266","2005-03-19","SA_REP",8800,0.25,149,80);
insert into employeeshr
values(176,"Jonathon","Taylor","JTAYLOR","011.44.1644.429265","2006-03-24","SA_REP",8600,0.2,149,80);
insert into employeeshr
values(177,"Jack","Livingston","JLIVINGS","011.44.1644.429264","2006-04-23","SA_REP",8400,0.2,149,80);
insert into employeeshr
values(178,"Kimberely","Grant","KGRANT","011.44.1644.429263","2007-05-24","SA_REP",7000,0.15,149,0);
insert into employeeshr
values(179,"Charles","Johnson","CJOHNSON","011.44.1644.429262","2008-01-04","SA_REP",6200,0.1,149,80);
insert into employeeshr
values(180,"Winston","Taylor","WTAYLOR","650.507.9876","2006-01-24","SH_CLERK",3200,0,120,50);
insert into employeeshr
values(181,"Jean","Fleaur","JFLEAUR","650.507.9877","2006-02-23","SH_CLERK",3100,0,120,50);
insert into employeeshr
values(182,"Martha","Sullivan","MSULLIVA","650.507.9878","2007-06-21","SH_CLERK",2500,0,120,50);
insert into employeeshr
values(183,"Girard","Geoni","GGEONI","650.507.9879","2008-02-03","SH_CLERK",2800,0,120,50);
insert into employeeshr
values(184,"Nandita","Sarchand","NSARCHAN","650.509.1876","2004-01-27","SH_CLERK",4200,0,121,50);
insert into employeeshr
values(185,"Alexis","Bull","ABULL","650.509.2876","2005-02-20","SH_CLERK",4100,0,121,50);
insert into employeeshr
values(186,"Julia","Dellinger","JDELLING","650.509.3876","2006-06-24","SH_CLERK",3400,0,121,50);
insert into employeeshr
values(187,"Anthony","Cabrio","ACABRIO","650.509.4876","2007-02-07","SH_CLERK",3000,0,121,50);
insert into employeeshr
values(188,"Kelly","Chung","KCHUNG","650.505.1876","2005-06-14","SH_CLERK",3800,0,122,50);
insert into employeeshr
values(189,"Jennifer","Dilly","JDILLY","650.505.2876","2005-08-13","SH_CLERK",3600,0,122,50);
insert into employeeshr
values(190,"Timothy","Gates","TGATES","650.505.3876","2006-07-11","SH_CLERK",2900,0,122,50);
insert into employeeshr
values(191,"Randall","Perkins","RPERKINS","650.505.4876","2007-12-19","SH_CLERK",2500,0,122,50);
insert into employeeshr
values(192,"Sarah","Bell","SBELL","650.501.1876","2004-02-04","SH_CLERK",4000,0,123,50);
insert into employeeshr
values(193,"Britney","Everett","BEVERETT","650.501.2876","2005-03-03","SH_CLERK",3900,0,123,50);
insert into employeeshr
values(194,"Samuel","McCain","SMCCAIN","650.501.3876","2006-07-01","SH_CLERK",3200,0,123,50);
insert into employeeshr
values(195,"Vance","Jones","VJONES","650.501.4876","2007-03-17","SH_CLERK",2800,0,123,50);
insert into employeeshr
values(196,"Alana","Walsh","AWALSH","650.507.9811","2006-04-24","SH_CLERK",3100,0,124,50);
insert into employeeshr
values(197,"Kevin","Feeney","KFEENEY","650.507.9822","2006-05-23","SH_CLERK",3000,0,124,50);
insert into employeeshr
values(198,"Donald","OConnell","DOCONNEL","650.507.9833","2007-06-21","SH_CLERK",2600,0,124,50);
insert into employeeshr
values(199,"Douglas","Grant","DGRANT","650.507.9844","2008-01-13","SH_CLERK",2600,0,124,50);
insert into employeeshr
values(200,"Jennifer","Whalen","JWHALEN","515.123.4444","2003-09-17","AD_ASST",4400,0,101,10);
insert into employeeshr
values(201,"Michael","Hartstein","MHARTSTE","515.123.5555","2004-02-17","MK_MAN",13000,0,100,20);
insert into employeeshr
values(202,"Pat","Fay","PFAY","603.123.6666","2005-08-17","MK_REP",6000,0,201,20);
insert into employeeshr
values(203,"Susan","Mavris","SMAVRIS","515.123.7777","2002-06-07","HR_REP",6500,0,101,40);
insert into employeeshr
values(204,"Hermann","Baer","HBAER","515.123.8888","2002-06-07","PR_REP",10000,0,101,70);
insert into employeeshr
values(205,"Shelley","Higgins","SHIGGINS","515.123.8080","2002-06-07","AC_MGR",12008,0,101,110);
insert into employeeshr
values(206,"William","Gietz","WGIETZ","515.123.8181","2002-06-07","AC_ACCOUNT",8300,0,205,110);
create table departments
(department_id integer not null primary key, department_name varchar(25), manager_id integer, location_id integer);
insert into departments values(10,"Administration",200,1700);
insert into departments values(20,"Marketing",201,1800);
insert into departments values(30,"Purchasing",114,1700);
insert into departments values(40,"Human Resources",203,2400);
insert into departments values(50,"Shipping",121,1500);
insert into departments values(60,"IT",103,1400);
insert into departments values(70,"Public Relations",204,2700);
insert into departments values(80,"Sales",145,2500);
insert into departments values(90,"Executive",100,1700);
insert into departments values(100,"Finance",108,1700);
insert into departments values(110,"Accounting",205,1700);
insert into departments values(120,"Treasury",0,1700);
insert into departments values(130,"Corporate Tax",0,1700);
insert into departments values(140,"Control And Credit",0,1700);
insert into departments values(150,"Shareholder Services",0,1700);
insert into departments values(160,"Benefits",0,1700);
insert into departments values(170,"Manufacturing",0,1700);
insert into departments values(180,"Construction",0,1700);
insert into departments values(190,"Contracting",0,1700);
insert into departments values(200,"Operations",0,1700);
insert into departments values(210,"IT Support",0,1700);
insert into departments values(220,"NOC",0,1700);
insert into departments values(230,"IT Helpdesk",0,1700);
insert into departments values(240,"Government Sales",0,1700);
insert into departments values(250,"Retail Sales",0,1700);
insert into departments values(260,"Recruiting",0,1700);
insert into departments values(270,"Payroll",0,1700);
create table jobhistory
(employee_id integer not null, start_date date, end_date date, job_id varchar(10), department_id integer);
insert into jobhistory values(102,"2001-01-13","2006-07-24","IT_PROG",60);
insert into jobhistory values(101,"1997-09-21","2001-10-27","AC_ACCOUNT",110);
insert into jobhistory values(101,"2001-10-28","2005-03-15","AC_MGR",110);
insert into jobhistory values(201,"2004-02-17","2007-12-19","MK_REP",20);
insert into jobhistory values(114,"2006-03-24","2007-12-31","ST_CLERK",50);
insert into jobhistory values(122,"2007-01-01","2007-12-31","ST_CLERK",50);
insert into jobhistory values(200,"1995-09-17","2001-06-17","AD_ASST",90);
insert into jobhistory values(176,"2006-03-24","2006-12-31","SA_REP",80);
insert into jobhistory values(176,"2007-01-01","2007-12-31","SA_MAN",80);
insert into jobhistory values(200,"2002-07-01","2006-12-31","AC_ACCOUNT",90);
create table locations
(location_id integer not null primary key, street_address varchar(50), postal_code varchar(15), city varchar(20), state_province varchar(20), country_id varchar(2));
insert into locations values(1000,"1297 Via Cola di Rie","989","Roma","","IT");
insert into locations values(1100,"93091 Calle della Testa","10934","Venice","","IT");
insert into locations values(1200,"2017 Shinjuku-ku","1689","Tokyo","Tokyo Prefecture","JP");
insert into locations values(1300,"9450 Kamiya-cho","6823","Hiroshima","","JP");
insert into locations values(1400,"2014 Jabberwocky Rd","26192","Southlake","Texas","US");
insert into locations values(1500,"2011 Interiors Blvd","99236","South San Francisco","California","US");
insert into locations values(1600,"2007 Zagora St","50090","South Brunswick","New Jersey","US");
insert into locations values(1700,"2004 Charade Rd","98199","Seattle","Washington","US");
insert into locations values(1800,"147 Spadina Ave","M5V 2L7","Toronto","Ontario","CA");
insert into locations values(1900,"6092 Boxwood St","YSW 9T2","Whitehorse","Yukon","CA");
insert into locations values(2000,"40-5-12 Laogianggen","190518","Beijing","","CN");
insert into locations values(2100,"1298 Vileparle (E)","490231","Bombay","Maharashtra","IN");
insert into locations values(2200,"12-98 Victoria Street","2901","Sydney","New South Wales","AU");
insert into locations values(2300,"198 Clementi North","540198","Singapore","","SG");
insert into locations values(2400,"8204 Arthur St","","London","","UK");
insert into locations values(2500,"Magdalen Centre, The Oxford Science Park","OX9 9ZB","Oxford","Oxford","UK");
insert into locations values(2600,"9702 Chester Road","9629850293","Stretford","Manchester","UK");
insert into locations values(2700,"Schwanthalerstr. 7031","80925","Munich","Bavaria","DE");
insert into locations values(2800,"Rua Frei Caneca 1360","01307-002","Sao Paulo","Sao Paulo","BR");
insert into locations values(2900,"20 Rue des Corps-Saints","1730","Geneva","Geneve","CH");
insert into locations values(3000,"Murtenstrasse 921","3095","Bern","BE","CH");
insert into locations values(3100,"Pieter Breughelstraat 837","3029SK","Utrecht","Utrecht","NL");
insert into locations values(3200,"Mariano Escobedo 9991","11932","Mexico City","Distrito Federal,","MX");
create table jobs
(job_id varchar(10) not null primary key, job_title varchar(40), min_salary integer, max_salary integer);
insert into jobs values("AD_PRES","President",20080,40000);
insert into jobs values("AD_VP","Administration Vice President",15000,30000);
insert into jobs values("AD_ASST","Administration Assistant",3000,6000);
insert into jobs values("FI_MGR","Finance Manager",8200,16000);
insert into jobs values("FI_ACCOUNT","Accountant",4200,9000);
insert into jobs values("AC_MGR","Accounting Manager",8200,16000);
insert into jobs values("AC_ACCOUNT","Public Accountant",4200,9000);
insert into jobs values("SA_MAN","Sales Manager",10000,20080);
insert into jobs values("SA_REP","Sales Representative",6000,12008);
insert into jobs values("PU_MAN","Purchasing Manager",8000,15000);
insert into jobs values("PU_CLERK","Purchasing Clerk",2500,5500);
insert into jobs values("ST_MAN","Stock Manager",5500,8500);
insert into jobs values("ST_CLERK","Stock Clerk",2008,5000);
insert into jobs values("SH_CLERK","Shipping Clerk",2500,5500);
insert into jobs values("IT_PROG","Programmer",4000,10000);
insert into jobs values("MK_MAN","Marketing Manager",9000,15000);
insert into jobs values("MK_REP","Marketing Representative",4000,9000);
insert into jobs values("HR_REP","Human Resources Representative",4000,9000);
insert into jobs values("PR_REP","Public Relations Representative",4500,10500);
create table jobgrades
(grade_level varchar(1) not null primary key, lowest_sal integer not null, highest_sal integer not null);
insert into jobgrades values("A",1000,2999);
insert into jobgrades values("B",3000,5999);
insert into jobgrades values("C",6000,9999);
insert into jobgrades values("D",10000,14999);
insert into jobgrades values("E",15000,24999);
insert into jobgrades values("F",25000,40000);
create table countries
(country_id varchar(3) not null primary key, country_name varchar(20), region_id integer);
insert into jobgrades values("AR","Argentina",2);
insert into jobgrades values("AU","Australia",3);
insert into jobgrades values("BE","Belgium",1);
insert into jobgrades values("BR","Brazil",2);
insert into jobgrades values("CA","Canada",2);
insert into jobgrades values("CH","Switzerland",1);
insert into jobgrades values("CN","China",3);
insert into jobgrades values("DE","Germany",1);
insert into jobgrades values("DK","Denmark",1);
insert into jobgrades values("EG","Egypt",4);
insert into jobgrades values("FR","France",1);
insert into jobgrades values("IL","Israel",4);
insert into jobgrades values("IN","India",3);
insert into jobgrades values("IT","Italy",1);
insert into jobgrades values("JP","Japan",3);
insert into jobgrades values("KW","Kuwait",4);
insert into jobgrades values("ML","Malaysia",3);
insert into jobgrades values("MX","Mexico",2);
insert into jobgrades values("NG","Nigeria",4);
insert into jobgrades values("NL","Netherlands",1);
insert into jobgrades values("SG","Singapore",3);
insert into jobgrades values("UK","United Kingdom",1);
insert into jobgrades values("US","United States of America",2);
insert into jobgrades values("ZM","Zambia",4);
insert into jobgrades values("ZW","Zimbabwe",4);
create table regions
(region_id integer not null primary key, region_name varchar(25));
insert into regions values (1, "Europe");
insert into regions values (2, "Americas");
insert into regions values (3, "Asia");
insert into regions values (4, "Middle East and Africa");