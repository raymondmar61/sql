#RM:  open w3basicssecondpracticedatabases.sql for database tables
#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php
#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#https://www.w3resource.com/sql-exercises/sorting-and-filtering-hr/index.php

/*
Sample table: salesman
 salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14
        5007 | Paul Adam  | Rome     |       0.13
        5003 | Lauson Hen | San Jose |       0.12
Sample table: orders
ord_no      purch_amt   ord_date    customer_id  salesman_id
----------  ----------  ----------  -----------  -----------
70001       150.5       2012-10-05  3005         5002
70009       270.65      2012-09-10  3001         5005
70002       65.26       2012-10-05  3002         5001
70004       110.5       2012-08-17  3009         5003
70007       948.5       2012-09-10  3005         5002
70005       2400.6      2012-07-27  3007         5001
70008       5760        2012-09-10  3002         5001
70010       1983.43     2012-10-10  3004         5006
70003       2480.4      2012-10-10  3009         5003
70012       250.45      2012-06-27  3008         5002
70011       75.29       2012-08-17  3003         5007
70013       3045.6      2012-04-25  3002         5001
Sample table: customer
 customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
        3004 | Fabian Johnson | Paris      |   300 |        5006
        3009 | Geoff Cameron  | Berlin     |   100 |        5003
        3003 | Jozy Altidor   | Moscow     |   200 |        5007
        3001 | Brad Guzan     | London     |       |        5005
Sample table: nobel_win
YEAR SUBJECT                   WINNER                                        COUNTRY                CATEGORY
---- ------------------------- --------------------------------------------- ------------------------- ------------
1970 Physics                   Hannes Alfven                                 Sweden                 Scientist
1970 Physics                   Louis Neel                                    France                 Scientist
1970 Chemistry                 Luis Federico Leloir                          France                 Scientist
1970 Physiology                Ulf von Euler                                 Sweden                 Scientist
1970 Physiology                Bernard Katz                                  Germany                Scientist
1970 Literature                Aleksandr Solzhenitsyn                        Russia                 Linguist
1970 Economics                 Paul Samuelson                                USA                    Economist
1970 Physiology                Julius Axelrod                                USA                    Scientist
1971 Physics                   Dennis Gabor                                  Hungary                Scientist
1971 Chemistry                 Gerhard Herzberg                              Germany                Scientist
1971 Peace                     Willy Brandt                                  Germany                Chancellor
1971 Literature                Pablo Neruda                                  Chile                  Linguist
1971 Economics                 Simon Kuznets                                 Russia                 Economist
1978 Peace                     Anwar al-Sadat                                Egypt                  President
1978 Peace                     Menachem Begin                                Israel                 Prime Minister
1987 Chemistry                 Donald J. Cram                                USA                    Scientist
1987 Chemistry                 Jean-Marie Lehn                               France                 Scientist
1987 Physiology                Susumu Tonegawa                               Japan                  Scientist
1994 Economics                 Reinhard Selten                               Germany                Economist
1994 Peace                     Yitzhak Rabin                                 Israel                 Prime Minister
1987 Physics                   Johannes Georg Bednorz                        Germany                Scientist
1987 Literature                Joseph Brodsky                                Russia                 Linguist
1987 Economics                 Robert Solow                                  USA                    Economist
1994 Literature                Kenzaburo Oe                                  Japan                  Linguist
Sample table: item_mast
 PRO_ID PRO_NAME                   PRO_PRICE    PRO_COM
------- ------------------------- ---------- ----------
    101 Mother Board                    3200         15
    102 Key Board                        450         16
    103 ZIP drive                        250         14
    104 Speaker                          550         16
    105 Monitor                         5000         11
    106 DVD drive                        900         12
    107 CD drive                         800         12
    108 Printer                         2600         13
    109 Refill cartridge                 350         13
    110 Mouse                            250         12
Sample table: emp_details
 EMP_IDNO EMP_FNAME       EMP_LNAME         EMP_DEPT
--------- --------------- --------------- ----------
   127323 Michale         Robbin                  57
   526689 Carlos          Snares                  63
   843795 Enric           Dosio                   57
   328717 Jhon            Snares                  63
   444527 Joseph          Dosni                   47
   659831 Zanifer         Emily                   47
   847674 Kuleswar        Sitaraman               57
   748681 Henrey          Gabriel                 47
   555935 Alex            Manuel                  57
   539569 George          Mardy                   27
   733843 Mario           Saule                   63
   631548 Alan            Snappy                  27
   839139 Maria           Foster                  57
Sample table: emp_department
DPT_CODE DPT_NAME        DPT_ALLOTMENT
-------- --------------- -------------
      57 IT                      65000
      63 Finance                 15000
      47 HR                     240000
      27 RD                      55000
      89 QC                      75000
Sample table: testtable
col1
--------------------------
A001/DJ-402\44_/100/2015
A001_\DJ-402\44_/100/2015
A001_DJ-402-2014-2015
A002_DJ-401-2014-2015
A001/DJ_401
A001/DJ_402\44
A001/DJ_402\44\2015
A001/DJ-402%45\2015/200
A001/DJ_402\45\2015%100
A001/DJ_402%45\2015/300
A001/DJ-402\44
Sample table: employees
+-------------+-------------+-------------+----------+--------------------+------------+------------+----------+----------------+------------+---------------+
| EMPLOYEE_ID | FIRST_NAME  | LAST_NAME   | EMAIL    | PHONE_NUMBER       | HIRE_DATE  | JOB_ID     | SALARY   | COMMISSION_PCT | MANAGER_ID | DEPARTMENT_ID |
+-------------+-------------+-------------+----------+--------------------+------------+------------+----------+----------------+------------+---------------+
|         100 | Steven      | King        | SKING    | 515.123.4567       | 2003-06-17 | AD_PRES    | 24000.00 |           0.00 |          0 |            90 |
|         101 | Neena       | Kochhar     | NKOCHHAR | 515.123.4568       | 2005-09-21 | AD_VP      | 17000.00 |           0.00 |        100 |            90 |
|         102 | Lex         | De Haan     | LDEHAAN  | 515.123.4569       | 2001-01-13 | AD_VP      | 17000.00 |           0.00 |        100 |            90 |
|         103 | Alexander   | Hunold      | AHUNOLD  | 590.423.4567       | 2006-01-03 | IT_PROG    |  9000.00 |           0.00 |        102 |            60 |
|         104 | Bruce       | Ernst       | BERNST   | 590.423.4568       | 2007-05-21 | IT_PROG    |  6000.00 |           0.00 |        103 |            60 |
|         105 | David       | Austin      | DAUSTIN  | 590.423.4569       | 2005-06-25 | IT_PROG    |  4800.00 |           0.00 |        103 |            60 |
|         106 | Valli       | Pataballa   | VPATABAL | 590.423.4560       | 2006-02-05 | IT_PROG    |  4800.00 |           0.00 |        103 |            60 |
|         107 | Diana       | Lorentz     | DLORENTZ | 590.423.5567       | 2007-02-07 | IT_PROG    |  4200.00 |           0.00 |        103 |            60 |
|         108 | Nancy       | Greenberg   | NGREENBE | 515.124.4569       | 2002-08-17 | FI_MGR     | 12008.00 |           0.00 |        101 |           100 |
|         109 | Daniel      | Faviet      | DFAVIET  | 515.124.4169       | 2002-08-16 | FI_ACCOUNT |  9000.00 |           0.00 |        108 |           100 |
|         110 | John        | Chen        | JCHEN    | 515.124.4269       | 2005-09-28 | FI_ACCOUNT |  8200.00 |           0.00 |        108 |           100 |
|         111 | Ismael      | Sciarra     | ISCIARRA | 515.124.4369       | 2005-09-30 | FI_ACCOUNT |  7700.00 |           0.00 |        108 |           100 |
|         112 | Jose Manuel | Urman       | JMURMAN  | 515.124.4469       | 2006-03-07 | FI_ACCOUNT |  7800.00 |           0.00 |        108 |           100 |
|         113 | Luis        | Popp        | LPOPP    | 515.124.4567       | 2007-12-07 | FI_ACCOUNT |  6900.00 |           0.00 |        108 |           100 |
|         114 | Den         | Raphaely    | DRAPHEAL | 515.127.4561       | 2002-12-07 | PU_MAN     | 11000.00 |           0.00 |        100 |            30 |
|         115 | Alexander   | Khoo        | AKHOO    | 515.127.4562       | 2003-05-18 | PU_CLERK   |  3100.00 |           0.00 |        114 |            30 |
|         116 | Shelli      | Baida       | SBAIDA   | 515.127.4563       | 2005-12-24 | PU_CLERK   |  2900.00 |           0.00 |        114 |            30 |
|         117 | Sigal       | Tobias      | STOBIAS  | 515.127.4564       | 2005-07-24 | PU_CLERK   |  2800.00 |           0.00 |        114 |            30 |
|         118 | Guy         | Himuro      | GHIMURO  | 515.127.4565       | 2006-11-15 | PU_CLERK   |  2600.00 |           0.00 |        114 |            30 |
|         119 | Karen       | Colmenares  | KCOLMENA | 515.127.4566       | 2007-08-10 | PU_CLERK   |  2500.00 |           0.00 |        114 |            30 |
|         120 | Matthew     | Weiss       | MWEISS   | 650.123.1234       | 2004-07-18 | ST_MAN     |  8000.00 |           0.00 |        100 |            50 |
|         121 | Adam        | Fripp       | AFRIPP   | 650.123.2234       | 2005-04-10 | ST_MAN     |  8200.00 |           0.00 |        100 |            50 |
|         122 | Payam       | Kaufling    | PKAUFLIN | 650.123.3234       | 2003-05-01 | ST_MAN     |  7900.00 |           0.00 |        100 |            50 |
|         123 | Shanta      | Vollman     | SVOLLMAN | 650.123.4234       | 2005-10-10 | ST_MAN     |  6500.00 |           0.00 |        100 |            50 |
|         124 | Kevin       | Mourgos     | KMOURGOS | 650.123.5234       | 2007-11-16 | ST_MAN     |  5800.00 |           0.00 |        100 |            50 |
|         125 | Julia       | Nayer       | JNAYER   | 650.124.1214       | 2005-07-16 | ST_CLERK   |  3200.00 |           0.00 |        120 |            50 |
|         126 | Irene       | Mikkilineni | IMIKKILI | 650.124.1224       | 2006-09-28 | ST_CLERK   |  2700.00 |           0.00 |        120 |            50 |
|         127 | James       | Landry      | JLANDRY  | 650.124.1334       | 2007-01-14 | ST_CLERK   |  2400.00 |           0.00 |        120 |            50 |
|         128 | Steven      | Markle      | SMARKLE  | 650.124.1434       | 2008-03-08 | ST_CLERK   |  2200.00 |           0.00 |        120 |            50 |
|         129 | Laura       | Bissot      | LBISSOT  | 650.124.5234       | 2005-08-20 | ST_CLERK   |  3300.00 |           0.00 |        121 |            50 |
|         130 | Mozhe       | Atkinson    | MATKINSO | 650.124.6234       | 2005-10-30 | ST_CLERK   |  2800.00 |           0.00 |        121 |            50 |
|         131 | James       | Marlow      | JAMRLOW  | 650.124.7234       | 2005-02-16 | ST_CLERK   |  2500.00 |           0.00 |        121 |            50 |
|         132 | TJ          | Olson       | TJOLSON  | 650.124.8234       | 2007-04-10 | ST_CLERK   |  2100.00 |           0.00 |        121 |            50 |
|         133 | Jason       | Mallin      | JMALLIN  | 650.127.1934       | 2004-06-14 | ST_CLERK   |  3300.00 |           0.00 |        122 |            50 |
|         134 | Michael     | Rogers      | MROGERS  | 650.127.1834       | 2006-08-26 | ST_CLERK   |  2900.00 |           0.00 |        122 |            50 |
|         135 | Ki          | Gee         | KGEE     | 650.127.1734       | 2007-12-12 | ST_CLERK   |  2400.00 |           0.00 |        122 |            50 |
|         136 | Hazel       | Philtanker  | HPHILTAN | 650.127.1634       | 2008-02-06 | ST_CLERK   |  2200.00 |           0.00 |        122 |            50 |
|         137 | Renske      | Ladwig      | RLADWIG  | 650.121.1234       | 2003-07-14 | ST_CLERK   |  3600.00 |           0.00 |        123 |            50 |
|         138 | Stephen     | Stiles      | SSTILES  | 650.121.2034       | 2005-10-26 | ST_CLERK   |  3200.00 |           0.00 |        123 |            50 |
|         139 | John        | Seo         | JSEO     | 650.121.2019       | 2006-02-12 | ST_CLERK   |  2700.00 |           0.00 |        123 |            50 |
|         140 | Joshua      | Patel       | JPATEL   | 650.121.1834       | 2006-04-06 | ST_CLERK   |  2500.00 |           0.00 |        123 |            50 |
|         141 | Trenna      | Rajs        | TRAJS    | 650.121.8009       | 2003-10-17 | ST_CLERK   |  3500.00 |           0.00 |        124 |            50 |
|         142 | Curtis      | Davies      | CDAVIES  | 650.121.2994       | 2005-01-29 | ST_CLERK   |  3100.00 |           0.00 |        124 |            50 |
|         143 | Randall     | Matos       | RMATOS   | 650.121.2874       | 2006-03-15 | ST_CLERK   |  2600.00 |           0.00 |        124 |            50 |
|         144 | Peter       | Vargas      | PVARGAS  | 650.121.2004       | 2006-07-09 | ST_CLERK   |  2500.00 |           0.00 |        124 |            50 |
|         145 | John        | Russell     | JRUSSEL  | 011.44.1344.429268 | 2004-10-01 | SA_MAN     | 14000.00 |           0.40 |        100 |            80 |
|         146 | Karen       | Partners    | KPARTNER | 011.44.1344.467268 | 2005-01-05 | SA_MAN     | 13500.00 |           0.30 |        100 |            80 |
|         147 | Alberto     | Errazuriz   | AERRAZUR | 011.44.1344.429278 | 2005-03-10 | SA_MAN     | 12000.00 |           0.30 |        100 |            80 |
|         148 | Gerald      | Cambrault   | GCAMBRAU | 011.44.1344.619268 | 2007-10-15 | SA_MAN     | 11000.00 |           0.30 |        100 |            80 |
|         149 | Eleni       | Zlotkey     | EZLOTKEY | 011.44.1344.429018 | 2008-01-29 | SA_MAN     | 10500.00 |           0.20 |        100 |            80 |
|         150 | Peter       | Tucker      | PTUCKER  | 011.44.1344.129268 | 2005-01-30 | SA_REP     | 10000.00 |           0.30 |        145 |            80 |
|         151 | David       | Bernstein   | DBERNSTE | 011.44.1344.345268 | 2005-03-24 | SA_REP     |  9500.00 |           0.25 |        145 |            80 |
|         152 | Peter       | Hall        | PHALL    | 011.44.1344.478968 | 2005-08-20 | SA_REP     |  9000.00 |           0.25 |        145 |            80 |
|         153 | Christopher | Olsen       | COLSEN   | 011.44.1344.498718 | 2006-03-30 | SA_REP     |  8000.00 |           0.20 |        145 |            80 |
|         154 | Nanette     | Cambrault   | NCAMBRAU | 011.44.1344.987668 | 2006-12-09 | SA_REP     |  7500.00 |           0.20 |        145 |            80 |
|         155 | Oliver      | Tuvault     | OTUVAULT | 011.44.1344.486508 | 2007-11-23 | SA_REP     |  7000.00 |           0.15 |        145 |            80 |
|         156 | Janette     | King        | JKING    | 011.44.1345.429268 | 2004-01-30 | SA_REP     | 10000.00 |           0.35 |        146 |            80 |
|         157 | Patrick     | Sully       | PSULLY   | 011.44.1345.929268 | 2004-03-04 | SA_REP     |  9500.00 |           0.35 |        146 |            80 |
|         158 | Allan       | McEwen      | AMCEWEN  | 011.44.1345.829268 | 2004-08-01 | SA_REP     |  9000.00 |           0.35 |        146 |            80 |
|         159 | Lindsey     | Smith       | LSMITH   | 011.44.1345.729268 | 2005-03-10 | SA_REP     |  8000.00 |           0.30 |        146 |            80 |
|         160 | Louise      | Doran       | LDORAN   | 011.44.1345.629268 | 2005-12-15 | SA_REP     |  7500.00 |           0.30 |        146 |            80 |
|         161 | Sarath      | Sewall      | SSEWALL  | 011.44.1345.529268 | 2006-11-03 | SA_REP     |  7000.00 |           0.25 |        146 |            80 |
|         162 | Clara       | Vishney     | CVISHNEY | 011.44.1346.129268 | 2005-11-11 | SA_REP     | 10500.00 |           0.25 |        147 |            80 |
|         163 | Danielle    | Greene      | DGREENE  | 011.44.1346.229268 | 2007-03-19 | SA_REP     |  9500.00 |           0.15 |        147 |            80 |
|         164 | Mattea      | Marvins     | MMARVINS | 011.44.1346.329268 | 2008-01-24 | SA_REP     |  7200.00 |           0.10 |        147 |            80 |
|         165 | David       | Lee         | DLEE     | 011.44.1346.529268 | 2008-02-23 | SA_REP     |  6800.00 |           0.10 |        147 |            80 |
|         166 | Sundar      | Ande        | SANDE    | 011.44.1346.629268 | 2008-03-24 | SA_REP     |  6400.00 |           0.10 |        147 |            80 |
|         167 | Amit        | Banda       | ABANDA   | 011.44.1346.729268 | 2008-04-21 | SA_REP     |  6200.00 |           0.10 |        147 |            80 |
|         168 | Lisa        | Ozer        | LOZER    | 011.44.1343.929268 | 2005-03-11 | SA_REP     | 11500.00 |           0.25 |        148 |            80 |
|         169 | Harrison    | Bloom       | HBLOOM   | 011.44.1343.829268 | 2006-03-23 | SA_REP     | 10000.00 |           0.20 |        148 |            80 |
|         170 | Tayler      | Fox         | TFOX     | 011.44.1343.729268 | 2006-01-24 | SA_REP     |  9600.00 |           0.20 |        148 |            80 |
|         171 | William     | Smith       | WSMITH   | 011.44.1343.629268 | 2007-02-23 | SA_REP     |  7400.00 |           0.15 |        148 |            80 |
|         172 | Elizabeth   | Bates       | EBATES   | 011.44.1343.529268 | 2007-03-24 | SA_REP     |  7300.00 |           0.15 |        148 |            80 |
|         173 | Sundita     | Kumar       | SKUMAR   | 011.44.1343.329268 | 2008-04-21 | SA_REP     |  6100.00 |           0.10 |        148 |            80 |
|         174 | Ellen       | Abel        | EABEL    | 011.44.1644.429267 | 2004-05-11 | SA_REP     | 11000.00 |           0.30 |        149 |            80 |
|         175 | Alyssa      | Hutton      | AHUTTON  | 011.44.1644.429266 | 2005-03-19 | SA_REP     |  8800.00 |           0.25 |        149 |            80 |
|         176 | Jonathon    | Taylor      | JTAYLOR  | 011.44.1644.429265 | 2006-03-24 | SA_REP     |  8600.00 |           0.20 |        149 |            80 |
|         177 | Jack        | Livingston  | JLIVINGS | 011.44.1644.429264 | 2006-04-23 | SA_REP     |  8400.00 |           0.20 |        149 |            80 |
|         178 | Kimberely   | Grant       | KGRANT   | 011.44.1644.429263 | 2007-05-24 | SA_REP     |  7000.00 |           0.15 |        149 |             0 |
|         179 | Charles     | Johnson     | CJOHNSON | 011.44.1644.429262 | 2008-01-04 | SA_REP     |  6200.00 |           0.10 |        149 |            80 |
|         180 | Winston     | Taylor      | WTAYLOR  | 650.507.9876       | 2006-01-24 | SH_CLERK   |  3200.00 |           0.00 |        120 |            50 |
|         181 | Jean        | Fleaur      | JFLEAUR  | 650.507.9877       | 2006-02-23 | SH_CLERK   |  3100.00 |           0.00 |        120 |            50 |
|         182 | Martha      | Sullivan    | MSULLIVA | 650.507.9878       | 2007-06-21 | SH_CLERK   |  2500.00 |           0.00 |        120 |            50 |
|         183 | Girard      | Geoni       | GGEONI   | 650.507.9879       | 2008-02-03 | SH_CLERK   |  2800.00 |           0.00 |        120 |            50 |
|         184 | Nandita     | Sarchand    | NSARCHAN | 650.509.1876       | 2004-01-27 | SH_CLERK   |  4200.00 |           0.00 |        121 |            50 |
|         185 | Alexis      | Bull        | ABULL    | 650.509.2876       | 2005-02-20 | SH_CLERK   |  4100.00 |           0.00 |        121 |            50 |
|         186 | Julia       | Dellinger   | JDELLING | 650.509.3876       | 2006-06-24 | SH_CLERK   |  3400.00 |           0.00 |        121 |            50 |
|         187 | Anthony     | Cabrio      | ACABRIO  | 650.509.4876       | 2007-02-07 | SH_CLERK   |  3000.00 |           0.00 |        121 |            50 |
|         188 | Kelly       | Chung       | KCHUNG   | 650.505.1876       | 2005-06-14 | SH_CLERK   |  3800.00 |           0.00 |        122 |            50 |
|         189 | Jennifer    | Dilly       | JDILLY   | 650.505.2876       | 2005-08-13 | SH_CLERK   |  3600.00 |           0.00 |        122 |            50 |
|         190 | Timothy     | Gates       | TGATES   | 650.505.3876       | 2006-07-11 | SH_CLERK   |  2900.00 |           0.00 |        122 |            50 |
|         191 | Randall     | Perkins     | RPERKINS | 650.505.4876       | 2007-12-19 | SH_CLERK   |  2500.00 |           0.00 |        122 |            50 |
|         192 | Sarah       | Bell        | SBELL    | 650.501.1876       | 2004-02-04 | SH_CLERK   |  4000.00 |           0.00 |        123 |            50 |
|         193 | Britney     | Everett     | BEVERETT | 650.501.2876       | 2005-03-03 | SH_CLERK   |  3900.00 |           0.00 |        123 |            50 |
|         194 | Samuel      | McCain      | SMCCAIN  | 650.501.3876       | 2006-07-01 | SH_CLERK   |  3200.00 |           0.00 |        123 |            50 |
|         195 | Vance       | Jones       | VJONES   | 650.501.4876       | 2007-03-17 | SH_CLERK   |  2800.00 |           0.00 |        123 |            50 |
|         196 | Alana       | Walsh       | AWALSH   | 650.507.9811       | 2006-04-24 | SH_CLERK   |  3100.00 |           0.00 |        124 |            50 |
|         197 | Kevin       | Feeney      | KFEENEY  | 650.507.9822       | 2006-05-23 | SH_CLERK   |  3000.00 |           0.00 |        124 |            50 |
|         198 | Donald      | OConnell    | DOCONNEL | 650.507.9833       | 2007-06-21 | SH_CLERK   |  2600.00 |           0.00 |        124 |            50 |
|         199 | Douglas     | Grant       | DGRANT   | 650.507.9844       | 2008-01-13 | SH_CLERK   |  2600.00 |           0.00 |        124 |            50 |
|         200 | Jennifer    | Whalen      | JWHALEN  | 515.123.4444       | 2003-09-17 | AD_ASST    |  4400.00 |           0.00 |        101 |            10 |
|         201 | Michael     | Hartstein   | MHARTSTE | 515.123.5555       | 2004-02-17 | MK_MAN     | 13000.00 |           0.00 |        100 |            20 |
|         202 | Pat         | Fay         | PFAY     | 603.123.6666       | 2005-08-17 | MK_REP     |  6000.00 |           0.00 |        201 |            20 |
|         203 | Susan       | Mavris      | SMAVRIS  | 515.123.7777       | 2002-06-07 | HR_REP     |  6500.00 |           0.00 |        101 |            40 |
|         204 | Hermann     | Baer        | HBAER    | 515.123.8888       | 2002-06-07 | PR_REP     | 10000.00 |           0.00 |        101 |            70 |
|         205 | Shelley     | Higgins     | SHIGGINS | 515.123.8080       | 2002-06-07 | AC_MGR     | 12008.00 |           0.00 |        101 |           110 |
|         206 | William     | Gietz       | WGIETZ   | 515.123.8181       | 2002-06-07 | AC_ACCOUNT |  8300.00 |           0.00 |        205 |           110 |
+-------------+-------------+-------------+----------+--------------------+------------+------------+----------+----------------+------------+---------------+
Sample table: departments
+---------------+----------------------+------------+-------------+
| DEPARTMENT_ID | DEPARTMENT_NAME      | MANAGER_ID | LOCATION_ID |
+---------------+----------------------+------------+-------------+
|            10 | Administration       |        200 |        1700 |
|            20 | Marketing            |        201 |        1800 |
|            30 | Purchasing           |        114 |        1700 |
|            40 | Human Resources      |        203 |        2400 |
|            50 | Shipping             |        121 |        1500 |
|            60 | IT                   |        103 |        1400 |
|            70 | Public Relations     |        204 |        2700 |
|            80 | Sales                |        145 |        2500 |
|            90 | Executive            |        100 |        1700 |
|           100 | Finance              |        108 |        1700 |
|           110 | Accounting           |        205 |        1700 |
|           120 | Treasury             |          0 |        1700 |
|           130 | Corporate Tax        |          0 |        1700 |
|           140 | Control And Credit   |          0 |        1700 |
|           150 | Shareholder Services |          0 |        1700 |
|           160 | Benefits             |          0 |        1700 |
|           170 | Manufacturing        |          0 |        1700 |
|           180 | Construction         |          0 |        1700 |
|           190 | Contracting          |          0 |        1700 |
|           200 | Operations           |          0 |        1700 |
|           210 | IT Support           |          0 |        1700 |
|           220 | NOC                  |          0 |        1700 |
|           230 | IT Helpdesk          |          0 |        1700 |
|           240 | Government Sales     |          0 |        1700 |
|           250 | Retail Sales         |          0 |        1700 |
|           260 | Recruiting           |          0 |        1700 |
|           270 | Payroll              |          0 |        1700 |
+---------------+----------------------+------------+-------------+
Sample table: job_history
+-------------+------------+------------+------------+---------------+
| EMPLOYEE_ID | START_DATE | END_DATE   | JOB_ID     | DEPARTMENT_ID |
+-------------+------------+------------+------------+---------------+
|         102 | 2001-01-13 | 2006-07-24 | IT_PROG    |            60 |
|         101 | 1997-09-21 | 2001-10-27 | AC_ACCOUNT |           110 |
|         101 | 2001-10-28 | 2005-03-15 | AC_MGR     |           110 |
|         201 | 2004-02-17 | 2007-12-19 | MK_REP     |            20 |
|         114 | 2006-03-24 | 2007-12-31 | ST_CLERK   |            50 |
|         122 | 2007-01-01 | 2007-12-31 | ST_CLERK   |            50 |
|         200 | 1995-09-17 | 2001-06-17 | AD_ASST    |            90 |
|         176 | 2006-03-24 | 2006-12-31 | SA_REP     |            80 |
|         176 | 2007-01-01 | 2007-12-31 | SA_MAN     |            80 |
|         200 | 2002-07-01 | 2006-12-31 | AC_ACCOUNT |            90 |
+-------------+------------+------------+------------+---------------+
Sample table:  locations
+-------------+------------------------------------------+-------------+---------------------+-------------------+------------+
| LOCATION_ID | STREET_ADDRESS                           | POSTAL_CODE | CITY                | STATE_PROVINCE    | COUNTRY_ID |
+-------------+------------------------------------------+-------------+---------------------+-------------------+------------+
|        1000 | 1297 Via Cola di Rie                     | 989         | Roma                |                   | IT         |
|        1100 | 93091 Calle della Testa                  | 10934       | Venice              |                   | IT         |
|        1200 | 2017 Shinjuku-ku                         | 1689        | Tokyo               | Tokyo Prefecture  | JP         |
|        1300 | 9450 Kamiya-cho                          | 6823        | Hiroshima           |                   | JP         |
|        1400 | 2014 Jabberwocky Rd                      | 26192       | Southlake           | Texas             | US         |
|        1500 | 2011 Interiors Blvd                      | 99236       | South San Francisco | California        | US         |
|        1600 | 2007 Zagora St                           | 50090       | South Brunswick     | New Jersey        | US         |
|        1700 | 2004 Charade Rd                          | 98199       | Seattle             | Washington        | US         |
|        1800 | 147 Spadina Ave                          | M5V 2L7     | Toronto             | Ontario           | CA         |
|        1900 | 6092 Boxwood St                          | YSW 9T2     | Whitehorse          | Yukon             | CA         |
|        2000 | 40-5-12 Laogianggen                      | 190518      | Beijing             |                   | CN         |
|        2100 | 1298 Vileparle (E)                       | 490231      | Bombay              | Maharashtra       | IN         |
|        2200 | 12-98 Victoria Street                    | 2901        | Sydney              | New South Wales   | AU         |
|        2300 | 198 Clementi North                       | 540198      | Singapore           |                   | SG         |
|        2400 | 8204 Arthur St                           |             | London              |                   | UK         |
|        2500 | Magdalen Centre, The Oxford Science Park | OX9 9ZB     | Oxford              | Oxford            | UK         |
|        2600 | 9702 Chester Road                        | 9629850293  | Stretford           | Manchester        | UK         |
|        2700 | Schwanthalerstr. 7031                    | 80925       | Munich              | Bavaria           | DE         |
|        2800 | Rua Frei Caneca 1360                     | 01307-002   | Sao Paulo           | Sao Paulo         | BR         |
|        2900 | 20 Rue des Corps-Saints                  | 1730        | Geneva              | Geneve            | CH         |
|        3000 | Murtenstrasse 921                        | 3095        | Bern                | BE                | CH         |
|        3100 | Pieter Breughelstraat 837                | 3029SK      | Utrecht             | Utrecht           | NL         |
|        3200 | Mariano Escobedo 9991                    | 11932       | Mexico City         | Distrito Federal, | MX         |
+-------------+------------------------------------------+-------------+---------------------+-------------------+------------+
Sample table:  jobs
+------------+---------------------------------+------------+------------+
| JOB_ID     | JOB_TITLE                       | MIN_SALARY | MAX_SALARY |
+------------+---------------------------------+------------+------------+
| AD_PRES    | President                       |      20080 |      40000 |
| AD_VP      | Administration Vice President   |      15000 |      30000 |
| AD_ASST    | Administration Assistant        |       3000 |       6000 |
| FI_MGR     | Finance Manager                 |       8200 |      16000 |
| FI_ACCOUNT | Accountant                      |       4200 |       9000 |
| AC_MGR     | Accounting Manager              |       8200 |      16000 |
| AC_ACCOUNT | Public Accountant               |       4200 |       9000 |
| SA_MAN     | Sales Manager                   |      10000 |      20080 |
| SA_REP     | Sales Representative            |       6000 |      12008 |
| PU_MAN     | Purchasing Manager              |       8000 |      15000 |
| PU_CLERK   | Purchasing Clerk                |       2500 |       5500 |
| ST_MAN     | Stock Manager                   |       5500 |       8500 |
| ST_CLERK   | Stock Clerk                     |       2008 |       5000 |
| SH_CLERK   | Shipping Clerk                  |       2500 |       5500 |
| IT_PROG    | Programmer                      |       4000 |      10000 |
| MK_MAN     | Marketing Manager               |       9000 |      15000 |
| MK_REP     | Marketing Representative        |       4000 |       9000 |
| HR_REP     | Human Resources Representative  |       4000 |       9000 |
| PR_REP     | Public Relations Representative |       4500 |      10500 |
+------------+---------------------------------+------------+------------+
*/

#https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php
#1. Write a SQL statement to display all the information of all salesmen.
select *
from salesman;

#2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".
/*
columnname
This is SQL Exercise, Practice and Solution
*/
select 'This is SQL Exercise, Practice and Solution' as "columnname"
from salesman;

#3. Write a query to display three numbers in three columns.
/*
column 40	column 11	column 100
40	11	100
*/
select 40 as "column 40", 11 as "column 11", 100 as "column 100"
from salesman;

#4. Write a query to display the sum of two numbers 10 and 15 from RDMS sever.
select 10+15 as "addition"
from salesman;

#5. Write a query to display the result of an arithmetic expression.
select 10 + 15 - 5 * 2
from salesman;  #RM: returns 15

#6. Write a SQL statement to display specific columns like name and commission for all the salesmen.
select name, commission
from salesman;

#7. Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders.
select ord_date, salesman_id, ord_no, purch_amt
from orders;

#8. Write a query which will retrieve the value of salesman id of all salesmen, getting orders from the customers in orders table without any repeats.    #RM:  list all salesman_id without repeats
select distinct salesman_id
from orders;

#9. Write a SQL statement to display names and city of salesman, who belongs to the city of Paris.
select name, city
from salesman
where city = 'Paris';

#10. Write a SQL statement to display all the information for those customers with a grade of 200.
select *
from customer
where grade = 200;

#11. Write a SQL query to display the order number followed by order date and the purchase amount for each order which will be delivered by the salesman who is holding the ID 5001.
select ord_no, ord_date, purch_amt
from orders
where salesman_id = 5001;

#12. Write a SQL query to display the Nobel prizes for 1970.
select *
from nobel_win
where year = 1970;

#13. Write a SQL query to know the winner of the 1971 prize for Literature.
select *
from nobel_win
where year = 1971
and subject = 'Literature';

#14. Write a SQL query to display the year and subject that won 'Dennis Gabor' his prize.
select year, subject
from nobel_win
where winner = 'Dennis Gabor';

#15. Write a SQL query to give the name of the 'Physics' winners since the year 1950.
select winner
from nobel_win
where subject = 'Physics'
and year >= 1950;

#16. Write a SQL query to Show all the details (year, subject, winner, country ) of the Chemistry prize winners between the year 1965 to 1975 inclusive.  #RM:  between statement is inclusive between statement.
select *
from nobel_win
where subject = 'Chemistry'
and year between 1965 and 1975;

#17. Write a SQL query to show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin.
select *
from nobel_win
where year > 1972
and winner in ('Menachem Begin','Yitzhak Rabin');

#18. Write a SQL query to show all the details of the winners with first name Louis.
select *
from nobel_win
where winner like 'Louis%';

#19. Write a SQL query to show all the winners in Physics for 1970 together with the winner of Economics for 1971.
select *
from nobel_win
where (subject = 'Physics' and year = 1970)
or (subject = 'Economics' and year = 1971);

#20. Write a SQL query to show all the winners of nobel prize in the year 1970 except the subject Physiology and Economics.
select *
from nobel_win
where year = 1970
and subject not in ('Physiology','Economics');

#21. Write a SQL query to show the winners of a 'Physiology' prize in an early year before 1971 together with winners of a 'Peace' prize in a later year on and after the 1974.
select *
from nobel_win
where (subject in ('Physiology') and year < 1971)
or (subject = 'Peace' and year >= 1974);

#22. Write a SQL query to find all details of the prize won by Johannes Georg Bednorz.
select *
from nobel_win
where winner = 'Johannes Georg Bednorz';

#23. Write a SQL query to find all the details of the nobel winners for the subject not started with the letter 'P' and arranged the list as the most recent comes first, then by name in order.
select *
from nobel_win
where subject not like 'P%'
order by year desc, winner;

#24. Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
#official solution
select *
from nobel_win
where year = 1970
order by case
	when subject in ('Economics','Chemistry') then 1 else 0 end asc,
subject, winner;

#25. Write a SQL query to find all the products with a price between Rs.200 and Rs.600.
select *
from item_mast
where pro_price between 200 and 600;

#26. Write a SQL query to calculate the average price of all products of the manufacturer which code is 16.
select avg(pro_price)
from item_mast
where pro_com = 16;

#27. Write a SQL query to find the item name and price in Rs.
select pro_name, pro_price
from item_mast;

#28. Write a SQL query to display the name and price of all the items with a price is equal or more than Rs.250, and the list contain the larger price first and then by name in ascending order.
select pro_name, pro_price
from item_mast
where pro_price >= 250
order by pro_price desc, name asc;

#29. Write a SQL query to display the average price of the items for each company, showing only the company code.  #RM:  average price for each company code.
select pro_com, avg(pro_price)
from item_mast
group by pro_com;

#30. Write a SQL query to find the name and price of the cheapest item(s).
select pro_name, pro_price
from item_mast
where pro_price = (
	select min(pro_price)
	from item_mast);
#also
select *
from item_mast
order by pro_price asc limit 1;  #RM:  partially correct.  There are two items priced cheapest.

#31. Write a query in SQL to find the last name of all employees, without duplicates.
select distinct emp_lname
from emp_details;

#32. Write a query in SQL to find the data of employees whose last name is 'Snares'.
select *
from emp_details
where emp_lname = 'Snares';

#33. Write a query in SQL to display all the data of employees that work in the department 57.
select *
from emp_details
where emp_dept = 57;

#https://www.w3resource.com/sql-exercises/sql-boolean-operators.php
#1. Write a query to display all customers with a grade above 100.
select *
from customer
where grade > 100;

#2. Write a query statement to display all customers in New York who have a grade value above 100.
select *
from customer
where city = 'New York'
and grade > 100;

#3. Write a SQL statement to display all customers, who are either belongs to the city New York or had a grade above 100.
select *
from customer
where city = 'New York'
or grade > 100;

#4. Write a SQL statement to display all the customers, who are either belongs to the city New York or not had a grade above 100.
select *
from customer
where city = 'New York'
or grade <= 100;

#5.Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
select *
from customer
where city <> 'New York'
or grade <= 100;  #RM:  incorrect.  It's a neither nor.  It appears first SQL is incorrect.
select *
from customer
where not (city = 'New York' or grade > 100);  #RM:  correct.  It's neither nor.

#6. Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is 505 and below or those orders which purchase amount is 1000.00 and below.
select *
from orders
where (ord_date <> '2012-09-10' and salesman_id <= 505)
or purch_amt < 1000;
#official solution
select * 
from  orders 
where not ((ord_date ='2012-09-10' and salesman_id > 505)
or purch_amt > 1000.00);

#7. Write a SQL statement to display salesman_id, name, city and commission who gets the commission within the range more than 0.10% and less than 0.12%.
select *
from salesman
where commission > 0.10 and commission < 0.12;

#8. Write a SQL query to display all orders where purchase amount less than 200 or exclude those orders which order date is on or greater than 10th Feb,2012 and customer id is below 3009.
select *
from orders
where (purch_amt < 200 or ord_date < '2012-02-10')
and customer_id < 3009;

#9. Write a SQL statement to exclude the rows which satisfy 1) order dates are 2012-08-17 and purchase amount is below 1000 2) customer id is greater than 3005 and purchase amount is below 1000.
select *
from orders
where (ord_date <> '2012-08-17' and purch_amt >= 1000)
and (customer_id <= 3005 and purch_amt >= 1000);


#10. Write a SQL query to display order number, purchase amount, achieved, the unachieved percentage for those order which exceeds the 50% of the target value of 6000.#RM:  looked at solution.  #RM:  dumb question
select ord_no, purch_amt, (purch_amt/6000) as "achieved %", ((6000-purch_amt)/6000) as "unachieved % which is 1.0-achieved"
from orders
where (purch_amt/6000) > .50;

#11. Write a query in SQL to find the data of employees whose last name is Dosni or Mardy.
select *
from emp_details
where emp_lname in ('Dosni','Mardy');

#12. Write a query in SQL to display all the data of employees that work in department 47 or department 63.
select *
from emp_details
where emp_dept in (47, 63);

#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#1. Write a SQL statement to find the total purchase amount of all orders.
select sum(purch_amt)
from orders;

#2. Write a SQL statement to find the average purchase amount of all orders.
select avg(purch_amt)
from orders;

#3. Write a SQL statement to find the number of salesmen currently listing for all of their customers.
select count(distinct salesman_id)
from orders;

#4. Write a SQL statement know how many customer have listed their names.
select count(cust_name)
from customer;

#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance.
select count(cust_name)
from customer
where grade is not null;
#official solution
select count(all grade)
from customer;  #RM:  works for Oracle?

#6. Write a SQL statement to get the maximum purchase amount of all the orders.
select max(purch_amt)
from orders;

#7. Write a SQL statement to get the minimum purchase amount of all the orders.
select min(purch_amt)
from orders;

#8. Write a SQL statement which selects the highest grade for each of the cities of the customers.
select city, max(grade)
from customer
group by city;

#9. Write a SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.
select customer_id, max(purch_amt)
from orders
group by customer_id;

#10. Write a SQL statement to find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date;

#11. Write a SQL statement to find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.
select salesman_id, max(purch_amt)
from orders
where ord_date = '2012-08-17'
group by salesman_id;

#12. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) > 2000;

#13. Write a SQL statement to find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) between 2000 and 6000;

#14. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount in a day is within the list 2000, 3000, 5760 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) in (2000, 3000, 5760, 6000);

#15. Write a SQL statement to find the highest purchase amount with their ID, for only those customers whose ID is within the range 3002 and 3007.
select customer_id, max(purch_amt)
from orders
where customer_id between 3002 and 3007
group by customer_id;

#16. Write a SQL statement to display customer details (ID and purchase amount) whose IDs are within the range 3002 and 3007 and highest purchase amount is more than 1000.
select customer_id, max(purch_amt)
from orders
where customer_id between 3002 and 3007
group by customer_id
having max(purch_amt) > 1000;

#17. Write a SQL statement to find the highest purchase amount with their ID, for only those salesmen whose ID is within the range 5003 and 5008.
select salesman_id, max(purch_amt)
from orders
where salesman_id between 5003 and 5008
group by salesman_id;

#18. Write a SQL statement that counts all orders for a date August 17th, 2012.
select count(*)
from orders
where ord_date = '2012-08-07';

#19. Write a SQL statement that count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified.
select city, count(*)
from salesman
where city is not null
group by city;
#official solution
select city, count(*)
from salesman
group by city;

#20. Write a query that counts the number of salesmen with their order date and ID registering orders for each day.  RM:  It didn't ask how to sort.
select salesman_id, ord_date, count(*)
from orders
group by salesman_id, ord_date
order by salesman_id asc, ord_date desc;

#21. Write a SQL query to calculate the average price of all the products.
select avg(pro_price)
from item_mast;

#22. Write a SQL query to find the number of products with a price more than or equal to Rs.350.
select count(*)
from item_mast
where pro_price >= 350;

#23. Write a SQL query to display the average price of each company's products, along with their code.
select pro_com, avg(pro_price)
from item_mast
group by pro_com;
#also
select avg(pro_price), pro_com
from item_mast
group by pro_com;

#24. Write a query in SQL to find the sum of the allotment amount of all departments.
select sum(dpt_allotment)
from emp_department;

#25. Write a query in SQL to find the number of employees in each department along with the department code.
select emp_dept, count(*)
from emp_details
group by emp_dept;

#https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php
#1. Write a SQL statement to find those salesmen with all information who come from the city either Paris or Rome.
select *
from salesman
where city = 'Paris'
or city = 'Rome';

#2. Write a query to filter those salesmen with all information who comes from any of the cities Paris and Rome.
select *
from salesman
where city in ('Paris','Rome');

#3. Write a query to produce a list of salesman_id, name, city and commission of each salesman who live in cities other than Paris and Rome.
select *
from salesman
where city not in ('Paris','Rome');

#4. Write a query to sort out those customers with all information whose ID value is within any of 3007, 3008 and 3009.
select *
from customer
where customer_id in (3007,3008,3009);

#5. Write a SQL statement to find those salesmen with all information who gets the commission within a range of 0.12 and 0.14.
select *
from salesman
where commission between 0.12 and 0.14;

#6. Write a query to filter all those orders with all information which purchase amount value is within the range 500 and 4000 except those orders of purchase amount value 948.50 and 1983.43.
select *
from orders
where purch_amt between 500 and 4000
and purch_amt not in (948.50, 1983.43);

#7. Write a SQL statement to find those salesmen with all other information and name started with any letter within 'A' and 'K'.  #RM:  find name starting with the letters between A and K.
select *
from salesman
where name between like 'A%' and like 'K%';  #does it work?  No.  It appears like is invalid.
select *
from salesman
where name between 'A%' and 'K%';  #does it work?  Yes.  Like is invalid.  Exclude in between statement.
#official solution
select *
from salesman
where name between 'A' and 'K';
#oracle solution? from user
select *
from salesman
where name like '[a-k]%';

#8. Write a SQL statement to find those salesmen with all other information and name started with other than any latter within 'A' and 'L'. 
select *
from salesman
where name not between 'A%' and 'L%';  #RM:  Like is invalid.  Exclude in between statement.

#9. Write a SQL statement to find that customer with all information whose name begin with the letter 'B'.
select *
from customer
where cust_name like 'B%';

#10. Write a SQL statement to find all those customers with all information whose names are ending with the letter 'n'.
select *
from customer
where cust_name like '%n';

#11. Write a SQL statement to find those salesmen with all information whose name containing the 1st character is 'N' and the 4th character is 'l' and rests may be any character.
select *
from salesman
where name like 'N__l%';

#12. Write a SQL statement to find those rows from the table testtable which contain the escape character underscore ( _ ) in its column 'col1'.  #RM:  underscore _ is a wildcard character.
select *
from testtable
where col1 like '%/_%' escape '/';
#RM:  Oracle SQl escape character http://www.dba-oracle.com/t_special_characters_like_sql_query.htm
/*
set escape '\'
select stuff
from mytable
where mycool like '%\_to\_%';
#also
select stuff
from mytable
where mycool like '%\_to\_%' escape '\';
*/

#13. Write a SQL statement to find those rows from the table testtable which does not contain the character underscore ( _ ) in its column 'col1'.
select *
from testtable
where col1 not like '%/_%' escape '/';

#14. Write a SQL statement to find those rows from the table testtable which contain the escape character ( / ) in its column 'col1'.
select *
from testtable
where col1 like '%//%' escape '/';

#15. Write a SQL statement to find those rows from the table testtable which does not contain the escape character ( / ) in its column 'col1'.
select *
from testtable
where col1 not like '%//%' escape '/';

#16. Write a SQL statement to find those rows from the table testtable which contain the string ( _/ ) in its column 'col1'.
select *
from testtable
where col1 like '%/_//%' escape '/'; #RM:  need two escape /.  One for the _.  Second for the /.

#17. Write a SQL statement to find those rows from the table testtable which does not contain the string ( _/ ) in its column 'col1'.
select *
from testtable
where col1 not like '%/_//%' escape '/'; #RM:  need two escape /.  One for the _.  Second for the /.

#18. Write a SQL statement to find those rows from the table testtable which contain the character ( % ) in its column 'col1'.
select *
from testtable
where col1 like '%/%%' escape '/';

#19. Write a SQL statement to find those rows from the table testtable which does not contain the character ( % ) in its column 'col1'.
select *
from testtable
where col1 not like '%/%%' escape '/';

#20. Write a SQL statement to find that customer with all information who does not get any grade except NULL.
select *
from customer
where grade is null;

#21. Write a SQL statement to find that customer with all information who gets a grade except NULL value.
select *
from customer
where grade is not null;

#22. Write a query in SQL to display all the data of employees whose last name begins with an 'D'.
select *
from emp_details
where emp_lname like 'D%';

#https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php
#1. Write a SQL statement to find the total purchase amount of all orders.
select sum(purch_amt)
from orders;

#2. Write a SQL statement to find the average purchase amount of all orders.
select avg(purch_amt)
from orders;

#3. Write a SQL statement to find the number of salesmen currently listing for all of their customers.
select count(name)
from salesman;

#4. Write a SQL statement know how many customer have listed their names.
select count(cust_name)
from customer;

#5. Write a SQL statement find the number of customers who gets at least a gradation for his/her performance.
select count(grade)
from customer
where grade is not null;

#6. Write a SQL statement to get the maximum purchase amount of all the orders.
select max(purch_amt)
from orders;

#7. Write a SQL statement to get the minimum purchase amount of all the orders.
select min(purch_amt)
from orders;

#8. Write a SQL statement which selects the highest grade for each of the cities of the customers.
select city, max(grade)
from customer
group by city;

#9. Write a SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.
select customer_id, max(purch_amt)
from orders
group by customer_id;

#10. Write a SQL statement to find the highest purchase amount ordered by the each customer on a particular date with their ID, order date and highest purchase amount.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date;

#11. Write a SQL statement to find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.
select salesman_id, max(purch_amt)
from orders
where ord_date = '2012-08-17'
group by salesman_id;

#12. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have highest purchase amount in a day is more than 2000.
select ord_date, ord_no, max(purch_amt)
from orders
group by ord_date, ord_no
having max(purch_amt) > 2000;
#official solution
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) > 2000;

#13. Write a SQL statement to find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) between 2000 and 6000;

#14. Write a SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount in a day is within the list 2000, 3000, 5760 and 6000.
select customer_id, ord_date, max(purch_amt)
from orders
group by customer_id, ord_date
having max(purch_amt) in (2000, 3000, 5760, 6000);

#15. Write a SQL statement to find the highest purchase amount with their ID, for only those customers whose ID is within the range 3002 and 3007.
select customer_id, max(purch_amt)
from orders
where customer_id between 3002 and 3007
group by customer_id;

#16. Write a SQL statement to display customer details (ID and purchase amount) whose IDs are within the range 3002 and 3007 and highest purchase amount is more than 1000.
select customer_id, max(purch_amt)
from orders
where customer_id between 3002 and 3007
group by customer_id
having max(purch_amt) > 1000;

#17. Write a SQL statement to find the highest purchase amount with their ID, for only those salesmen whose ID is within the range 5003 and 5008.
select customer_id, max(purch_amt)
from orders
where salesman_id between 5003 and 5008
group by customer_id;

#18. Write a SQL statement that counts all orders for a date August 17th, 2012.
select count(*)
from orders
where ord_date = '2012-08-17';

#19. Write a SQL statement that count the number of salesmen for whom a city is specified. Note that there may be spaces or no spaces in the city column if no city is specified.
select city, count(city)
from salesman
group by city;

#20. Write a query that counts the number of salesmen with their order date and ID registering orders for each day.
select salesman_id, ord_date, count(*)
from orders
group by salesman_id, ord_date
order by salesman_id asc, ord_date desc;

#21. Write a SQL query to calculate the average price of all the products.
select avg(pro_price)
from item_mast;

#22. Write a SQL query to find the number of products with a price more than or equal to Rs.350.
select count(*)
from item_mast
where pro_price >= 350;

#23. Write a SQL query to display the average price of each company's products, along with their code.  #RM:  code is pro_com
select pro_com, avg(pro_price)
from item_mast
group by pro_com;

#24. Write a query in SQL to find the sum of the allotment amount of all departments.
select sum(dpt_allotment)
from emp_department;

#25. Write a query in SQL to find the number of employees in each department along with the department code.
select emp_dept, count(*)
from emp_details
group by emp_dept;

#https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php
#1. Write a SQL statement to display the commission with the percent sign ( % ) with salesman ID, name and city columns for all the salesmen.
select commission*100 || '%' as "Commission Percentage double quote", salesman_id, name, city
from salesman;

#2. Write a SQL statement to find out the number of orders booked for each day and display it in such a format like "For 2001-10-10 there are 15 orders".
select 'For ' || ord_date || ' there are ' || count(*) || ' orders.' as "Orders"
from orders
group by ord_date
order by ord_date;
#SQL code below doesn't work.  Returns second column only such as 2 orders and 1 orders.
select 'For ' || ord_date || ' there are ', count(*) || ' orders.'
from orders
group by ord_date;

#3. Write a query to display the orders according to the order number arranged by ascending order.
select *
from orders
order by ord_no;

#4. Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates.
select *
from orders
order by ord_date desc;

#5. Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first.
select *
from orders
order by ord_date asc, purch_amt desc;

#6. Write a SQL statement to display the customer name, city, and grade, etc. and the display will be arranged according to the smallest customer ID.
select cust_name, city, grade
from customer
order by customer_id;

#7. Write a SQL statement to make a report with salesman ID, order date and highest purchase amount in such an arrangement that, the smallest salesman ID will come first along with their smallest order date.
select salesman_id, ord_date, max(purch_amt)
from orders
order by salesman_id, ord_date;

#8. Write a SQL statement to display customer name, city and grade in such a manner that, the customer holding highest grade will come first.
select cust_name, city, grade
from customer
order by grade desc;

#9. Write a SQL statement to make a report with customer ID in such a manner that, the largest number of orders booked by the customer will come first along with their highest purchase amount.  #RM:  multiple aggregate multiple aggregate functions
select customer_id, count(*), max(purch_amt)
from orders
group by customer_id
order by count(*) desc;

#10. Write a SQL statement to make a report with order date in such a manner that, the latest order date will come last along with the total purchase amount and total commission (15% for all salesmen) for that date.
select ord_date, sum(purch_amt), sum(purch_amt*.15) as "total commission 15%"
from orders
group by ord_date
order by ord_date;

#https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php
#1. Write a query to find those customers with their name and those salesmen with their name and city who lives in the same city.
select c.cust_name, s.name
from customers c join salesman s
on c.salesman_id = s.salesman_id
and c.city = s.city; #incorrect, want to match customer city and salesmen city only.
#correct solution
select c.cust_name, s.name, c.city
from customer c, salesman s
where c.city = s.city;
#user solution
select c.cust_name, s.name, c.city
from customer c inner join salesman s
on c.city = s.city;

#2. Write a SQL statement to find the names of all customers along with the salesmen who works for them.
select c.cust_name, s.name
from customers c join salesman s
on c.salesman_id = s.salesman_id;
#also
select c.cust_name, s.name
from customer c, salesman s
where c.salesman_id = s.salesman_id;

#3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
select o.*
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on s.salesman_id = c.salesman_id
and s.city <> c.city;  #incorrect.  Return nothing.
#official solution
select o.*
from salesman s, customer c, orders o
where c.city <> s.city
and o.customer_id = c.customer_id
and o.salesman_id = s.salesman_id;  #correct
#user solution
select o.*
from orders o inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on o.salesman_id = s.salesman_id
where c.city <> s.city;

#4. Write a SQL statement that finds out each order number followed by the name of the customers who made the order.
select o.ord_no, c.cust_name
from orders o join customer c
on o.customer_id = c.customer_id;
#also
select o.ord_no, c.cust_name
from orders o, customer c
where o.customer_id = c.customer_id;

#5. Write a SQL statement that sorts out the customer and their grade who made an order. Each of the customers must have a grade and served by at least a salesman, who belongs to a city.
select c.cust_name, c.grade, s.name
from customer c join orders o
on c.customer_id = o.customer_id
join salesman_id s
on s.salesman_id = o.salesman_id
and s.city is not null
and c.grade is not null;
#also
select c.cust_name, c.grade, o.ord_no
from customer c, orders o, salesman s
where c.customer_id = o.customer_id
and c.salesman_id = s.salesman_id
and s.city is not null
and c.grade is not null;

#6. Write a query that produces all customers with their name, city, salesman and commission, who served by a salesman and the salesman works at a rate of the commission within 12% to 14%.
select c.cust_name, c.city, s.name, s.commission
from customer c join salesman s
on c.salesman_id = s.salesman_id
where commission between 0.12 and 0.14;
#also
select c.cust_name, c.city, s.name, s.commission
from customer c, salesman s
where c.salesman_id = s.salesman_id
and s.commission between 0.12 and 0.14;

#7. Write a SQL statement that produces all orders with the order number, customer name, commission rate and earned commission amount for those customers who carry their grade is 200 or more and served by an existing salesman.
select o.ord_no, c.cust_name, s.commission, (s.commission*o.purch_amt) as "Earned Commission"
from orders o join customer c
on o.customer_id = c.customer_id
join salesman s
on s.salesman_id = c.salesman_id
where c.grade >= 200;
#also
select c.cust_name, c.grade, s.name, s.commission, (s.commission*o.purch_amt) as "earned commission", o.ord_no
from customer c, salesman s, orders o
where c.salesman_id = s.salesman_id
and c.customer_id = o.customer_id
and c.grade >= 200;

#https://www.w3resource.com/sql-exercises/sorting-and-filtering-hr/index.php
#1. Write a query in SQL to display the full name (first and last name), and salary for those employees who earn below 6000.
select first_name, last_name, salary
from employees
where salary < 6000;
#official solution
select first_name || ' ' || last_name as fullname, salary
from employees
where salary < 6000;

#2. Write a query in SQL to display the first and last_name, department number and salary for those employees who earn more than 8000.
select first_name, last_name, salary
from employees
where salary < 8000;

#3. Write a query in SQL to display the first and last name, and department number for all employees whose last name is "McEwen".
select first_name, last_name, department_id
from employees
where last_name = 'McEwen';

#4. Write a query in SQL to display all the information for all employees without any department number.
select *
from employees
where department_id is null;  #RM:  database no department number is 0.
select *
from employees
where department_id = 0;  #RM:  database no department number is 0.

#5. Write a query in SQL to display all the information about the department Marketing.
select *
from departments
where department_name = 'Marketing';

#6. Write a query in SQL to display the full name (first and last), hire date, salary, and department number for those employees whose first name does not containing the letter M and make the result set in ascending order by department number.
select first_name, last_name, hire_date, department_id
from employees
where first_name not like '%M%'
order by department_id;

#7. Write a query in SQL to display all the information of employees whose salary is in the range of 8000 and 12000 and commission is not null or department number is except the number 40, 120 and 70 and they have been hired before June 5th, 1987.
select *
from employees
where salary between 8000 and 12000
and commission is not null
or department_id not in (40, 120, 70)
and hire_date < '1987-06-05';  #RM:  bad grammar to understand and's and or's

#8. Write a query in SQL to display the full name (first and last name), and salary for all employees who does not earn any commission.
select first_name, last_name, salary
from employees
where commission is null;

#9. Write a query in SQL to display the full name (first and last), the phone number and email separated by hyphen, and salary, for those employees whose salary is within the range of 9000 and 17000. The column headings assign with Full_Name, Contact_Details and Remuneration respectively.
select first_name, last_name, phone_number || '-' || email as Contact_Details, salary as Remuneration
from employees
where salary between 9000 and 17000;

#10. Write a query in SQL to display the first and last name, and salary for those employees whose first name is ending with the letter m.
select first_name, last_name, salary
from employees
where first_name like '%m';

#11. Write a query in SQL to display the full name (first and last) name, and salary, for all employees whose salary is out of the range 7000 and 15000 and make the result set in ascending order by the full name.
select first_name, last_name, salary
from employees
where salary < 7000 and salary > 15000
order by last_name;
#official solution
select first_name || ' ' || last_name as name, salary
from  employees
where salary not between 7000 and 15000
order by first_name || ' ' || last_name;

#12. Write a query in SQL to display the full name (first and last), job id and date of hire for those employees who was hired during November 5th, 2007 and July 5th, 2009.
select first_name, last_name, job_id, hire_date
from employees
where hire_date between '2007-11-05' and '2009-07-05';

#13. Write a query in SQL to display the the full name (first and last name), and department number for those employees who works either in department 70 or 90.
select first_name, last_name, department_id
from employees
where department_id in (70,90);

#14. Write a query in SQL to display the full name (first and last name), salary, and manager number for those employees who is working under a manager.
select first_name, last_name, salary, manager_id
from employees
where manager_id is not null; #RM:  database no manager_id number is 0.

#15. Write a query in SQL to display all the information from Employees table for those employees who was hired before June 21st, 2002.
select *
from employees
where hire_date < '2002-06-21';

#16. Write a query in SQL to display the first and last name, email, salary and manager ID, for those employees whose managers are hold the ID 120, 103 or 145.
select first_name, last_name, email, salary, manager_id
from employees
where manager_id in (120, 103, 145);

#17. Write a query in SQL to display all the information for all employees who have the letters D, S, or N in their first name and also arrange the result in descending order by salary.
select *
from employees
where first_name like '%D%'
or first_name like '%S%'
or first_name like '%N%'
order by salary desc;

#18. Write a query in SQL to display the full name (first name and last name), hire date, commission percentage, email and telephone separated by '-', and salary for those employees who earn the salary above 11000 or the seventh digit in their phone number equals 3 and make the result set in a descending order by the first name.
select first_name, last_name, hire_date, commission_pct, email || '-' || phone_number, salary
from employees
where salary > 11000
or phone_number like '______3%'
order by first_name desc;

#19. Write a query in SQL to display the first and last name, and department number for those employees who holds a letter s as a 3rd character in their first name.
select first_name, last_name, department_id
from employees
where first_name like '__s%';

#20. Write a query in SQL to display the employee ID, first name, job id, and department number for those employees who is working except the departments 50,30 and 80.
select employee_id, first_name, job_id, department_id
from employees
where department_id not in (50, 30, 80);

#21. Write a query in SQL to display the employee Id, first name, job id, and department number for those employees whose department number equals 30, 40 or 90.
select employee_id, first_name, job_id, department_id
from employees
where department_id in (30, 40, 90);

#22. Write a query in SQL to display the ID for those employees who did two or more jobs in the past.
select employee_id
from job_history
group by employee_id
having count(employee_id) >=2;

#23. Write a query in SQL to display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary for a job.
/*
job_id  count sum ?column?
AC_ACCOUNT  1 8300.00 0.00
ST_MAN  5 36400.00  2400.00
IT_PROG 5 28800.00  4800.00
SA_MAN  5 61000.00  3500.00
*/
select job_id, count(*), sum(salary), max(salary) - min(salary)
from employees
group by job_id;

#24. Write a query in SQL to display job ID for those jobs that were done by two or more for more than 300 days.
select job_id
from job_history
where (end_date - start_date) > 300
group by job_id
having count(job_id) >=2;

#25. Write a query in SQL to display the country ID and number of cities in that country we have.
select country_id, count(city)
from locations
group by country_id;

#26. Write a query in SQL to display the manager ID and number of employees managed by the manager.
select manager_id, count(employee_id)
from employees
group by manager_id;

#27. Write a query in SQL to display the details of jobs in descending sequence on job title.
select *
from jobs
order by job_title desc;

#28. Write a query in SQL to display the first and last name and date of joining of the employees who is either Sales Representative or Sales Man.  #RM:  string is case sensitive
select first_name, last_name, hire_date
from employees
where job_id in ('SA_MAN','SA_REP');
#bonus
select first_name, last_name, hire_date
from employees
where job_id in (
  select job_id
  from jobs
  where job_title in ('Sales Manager','Sales Representative'));
#also
select e.first_name, e.last_name, e.hire_date
from employees e join jobs j
on e.job_id = j.job_id
where j.job_title in ('Sales Manager','Sales Representative');

#29. Write a query in SQL to display the average salary of employees for each department who gets a commission percentage.
select department_id, avg(salary)
from employees
where commission_pct > 0
group by department_id;
#RM:  official solution is incorrect because employees not earning a commission entered as 0.00
select department_id, avg(salary) 
from employees 
where commission_pct is not null 
group by department_id;

#30. Write a query in SQL to display those departments where any manager is managing 4 or more employees.
select department_id, count(manager_id)
from employees
group by department_id
having count(manager_id) >= 4;

#31. Write a query in SQL to display those departments where more than ten employees work who got a commission percentage.
select department_id, count(*)
from employees
where commission_pct > 0
group by department_id
having count(*) > 10;

#32. Write a query in SQL to display the employee ID and the date on which he ended his previous job.  #RM:  some employee_id worked two or more job_ids.  Question asked for the latest end_date.
/*
employee_id max
122 2007-12-31
201 2007-12-19
101 2005-03-15
114 2007-12-31
176 2007-12-31
102 2006-07-24
200 2006-12-31
*/
select employee_id, max(end_date)
from job_history
group by employee_id;

#33. Write a query in SQL to display the details of the employees who have no commission percentage and salary within the range 7000 to 12000 and works in that department which number is 50.
select *
from employees
where commission_pct = 0
and salary between 7000 and 12000
and department_id = 50;

#34. Write a query in SQL to display the job ID for those jobs which average salary is above 8000.
select job_id, avg(salary)
from employees
group by job_id
having avg(salary) > 8000;

#35. Write a query in SQL to display job Title, the difference between minimum and maximum salaries for those jobs which max salary within the range 12000 to 18000.
select job_title, max_salary - min_salary
from jobs
where max_salary between 12000 and 18000;

#36. Write a query in SQL to display all those employees whose first name or last name starts with the letter D.
select *
from employees
where first_name like 'D%'
or last_name like 'D%';

#37. Write a query in SQL to display the details of jobs which minimum salary is greater than 9000.
select *
from jobs
where min_salary > 9000;

#38. Write a query in SQL to display those employees who joined after 7th September, 1987.
select *
from employees
where hire_date > '1987-09-07';