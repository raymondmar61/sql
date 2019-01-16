#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/joins-hr/index.php

/*
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
*/

#1. Write a query in SQL to display the first name, last name, department number, and department name for each employee.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id=d.department_id;
#also
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

/*
Sample table: locations
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
*/
#2. Write a query in SQL to display the first and last name, department, city, and state province for each employee.
select e.first_name, e.last_name, d.department_name, l.city, l.state_provice
from employees e join departments d
on e.department_id=d.department_id
join locations l
on d.location_id=l.location_id;

/*
Sample table:  job_grades
GRADE_LEVEL  LOWEST_SAL HIGHEST_SAL
------------ ---------- -----------
A              1000        2999
B              3000        5999
C              6000        9999
D             10000       14999
E             15000       24999
F             25000       40000
*/
#3. Write a query in SQL to display the first name, last name, salary, and job grade for all employees.  RM:  copied solution
/* join unequal tables.  Can use between ... and, and comparison operators < > >= <= RM:  also <> */
select e.first_name, e.last_name, e.salary, j.grade_level
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal;

#4. Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.
select e.first_name, e.last_name, d.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id
where e.department_id in (80,40);
#official solution
select e.first_name, e.last_name, e.department_id , d.department_name 
from employees e join departments d 
on e.department_id = d.department_id and e.department_id in (80,40)
order by e.last_name;

#5. Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
select e.first_name, e.last_name, e.department_id, l.city, l.state_provice
from employees e left outer join departments d
on e.department_id = e.department_id
left outer join locations l
on d.location_id = e.location_id
where e.first_name like '%z%';

#6. Write a query in SQL to display all departments including those where does not have any employee.  RM:  SQL technical question no practical sense.
select distinct d.department_name
from departments d; #RM:  display all department_name departments; although, there are no duplicate department names.  No distinct required.
#RM:  return a table of employees and their departments.  Also include departments which don't have employees.
select e.first_name, e.last_name, d.department_id, d.department_name
from departments d left outer join employees e
on d.department_id = e.department_id;
#official solution
select e.first_name, e.last_name, d.department_id, d.department_name
from employee e right outer join departments d
on e.department_id = d.department_id;

#7. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
select first_name, last_name, salary
from employees
where salary < (
	select salary
	from employees
	where employee_id = 182);
#official solution
/* join unequal tables.  Can use between ... and, and comparison operators < > >= <= RM:  also <> */
select e.first_name, e.last_name, e.salary 
from employees e join employees s
on e.salary < s.salary and s.employee_id = 182;

#8. Write a query in SQL to display the first name of all employees including the first name of their manager.
select e.first_name as "Employee First Name", manager.first_name as "Manager First Name"
from employees e join employees manager
on e.employee_id = manager.manager_id;
#RM:  Each employee must have one manager.

#9. Write a query in SQL to display the department name, city, and state province for each department.
select d.department_name, l.city, l.state_provice
from departments d join locations l
on d.location_id = l.location_id;

#10. Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department.
select e.first_name, e.last_name, d.department_id, d.department_name
from departments d left outer join employees e
on d.department_id = e.department_id;

#11. Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager.
select e.first_name as "Employee First Name", manager.first_name as "Manager First Name"
from employees e left outer join employees manager
on e.employee_id = manager.manager_id;  #RM:  running the query resulted in incorrect output.  SQL is correct.

#12. Write a query in SQL to display the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
select first_name, last_name, department_id
from employees
where department_id in (
	select department_id
	from employees
	where last_name = 'Taylor');
#official solution
select e.first_name, e.last_name, e.department_id 
from employees e join employees same
on e.department_id = same.department_id
and same.last_name = 'Taylor';

/*
Sample table:  job_history
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
#13. Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997.  #RM:  first SQL with four tables.  Also, question wants start_date column 1/1/1993 to 8/31/1997.  Not start date 1/1/1993 and end date 8/31/1997.
select j.job_title, d.department_name, e.first_name || ' ' || e.last_name as "Full Name", jobhistory.start_date
from employees e join departments d
on e.department_id = d.department_id
join job_history jobhistory
on d.department_id = jobhistory.department_id
join
jobs j
on jobhistory.job_id = j.job_id
where jobhistory.start_date >= '1993-01-01' and jobhistory.end_date <= '1997-08-31';  #RM:  incorrect.  Applied incorrect join . . . on.  Answer says join employee e and departments d with employee_id.
#correct solution from user
select j.job_title, d.department_name, e.first_name || ' ' || e.last_name as "Full Name", jobhistory.start_date
from jobs j join employees e
on j.job_id = e.job_id
join departments d
on e.department_id = d.department_id
join job_history jobhistory
on e.employee_id = jobhistory.employee_id  #RM:  I can link a join from a table not next to each other.  employee e is second table and job_history jobhistory is last table.
where jobhistory.start_date >= '1993-01-01' and jobhistory.start_date <= '1997-08-31';
#official solution
select job_title, department_name, first_name || ' ' || last_name as employee_name, start_date 
from job_history 
join jobs using (job_id) 
join departments using (department_id) 
join employees using (employee_id) 
where start_date >='1993-01-01' and start_date <='1997-08-31';

#14. Write a query in SQL to display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee.
select e.first_name || ' ' || e.last_name as "Full Name", (j.max_salary-e.salary)
from employee e join jobs j
on e.job_id = j.job_id;
#official solution
select job_title, first_name || ' ' || last_name as employee_name, max_salary-salary as salary_difference 
from employees natural join jobs;

#15. Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.
select d.department_name, avg(e.salary), count(e.commission_pct)
from employees e join departments d
on e.department_id = d.department_id
group by d.department_name;
#official solution
select department_name, avg(salary), count(commission_pct) 
from departments join employees using (department_id)
group by department_name;

#16. Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary differences to their own job for those employees who is working in the department ID 80.
select e.first_name || ' ' || e.last_name as "Full Name", j.job_title, j.max_salary-e.salary as "salary difference"
from employees e join jobs j
on e.job_id = j.job_id
where e.department_id = 80;
#official solution
select job_title, first_name || ' ' || last_name as employee_name, max_salary-salary as salary_difference
from employees natural join jobs 
where department_id  = 80;

/*
Sample table:  countries
+------------+--------------------------+-----------+
| COUNTRY_ID | COUNTRY_NAME             | REGION_ID |
+------------+--------------------------+-----------+
| AR         | Argentina                |         2 |
| AU         | Australia                |         3 |
| BE         | Belgium                  |         1 |
| BR         | Brazil                   |         2 |
| CA         | Canada                   |         2 |
| CH         | Switzerland              |         1 |
| CN         | China                    |         3 |
| DE         | Germany                  |         1 |
| DK         | Denmark                  |         1 |
| EG         | Egypt                    |         4 |
| FR         | France                   |         1 |
| IL         | Israel                   |         4 |
| IN         | India                    |         3 |
| IT         | Italy                    |         1 |
| JP         | Japan                    |         3 |
| KW         | Kuwait                   |         4 |
| ML         | Malaysia                 |         3 |
| MX         | Mexico                   |         2 |
| NG         | Nigeria                  |         4 |
| NL         | Netherlands              |         1 |
| SG         | Singapore                |         3 |
| UK         | United Kingdom           |         1 |
| US         | United States of America |         2 |
| ZM         | Zambia                   |         4 |
| ZW         | Zimbabwe                 |         4 |
+------------+--------------------------+-----------+
*/
#17. Write a query in SQL to display the name of the country, city, and the departments which are running there.
select c.country_name, l.city, d.department_name
from countries c join locations l #RM:  right outer join returned a department without a country
on c.country_id = l.country_id
join departments d
on l.location_id = d.location_id;
#official solution
select country_name,city, department_name 
from countries 
join locations using (country_id) 
join departments using (location_id);

#18. Write a query in SQL to display department name and the full name (first and last name) of the manager.
select d.department_name, e.first_name || ' ' || e.last_name as "Full Name"
from departments d join employees e
on d.manager_id = e.manager_id;

#19. Write a query in SQL to display job title and average salary of employees.
select j.job_title, avg(e.salary)
from jobs j right outer join employees e
on j.job_id = e.job_id
group by j.job_title;
#official solution
select job_title, avg(salary)
from employees natural join jobs
group by job_title;

#20. Write a query in SQL to display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000.
select j.*
from job_history j join employees e 
on j.employee_id = e.employee_id
where e.salary >= 12000;
#RM:  I can get all columns from one table in the join by doing the following:  select tablealias.*
#RM:  no need for left outer join because an employee may have two or more job history; e.g. employee_id 101 has two entries.  For each row in job_history there is one employees.

#21. Write a query in SQL to display the country name, city, and number of those departments where at leaste 2 employees are working.  RM:  four tables.  Four table joins.
select c.country_name, l.city, d.department_name, count(e.employee_id)
from countries c join locations l
on c.country_id = l.country_id
join departments d
on l.location_id = d.location_id
right outer join employees e
on d.department_id = e.department_id
group by c.country_name, l.city, d.department_name
having count(e.employee_id) >=2;
#RM:  my SQL code returns country, city, department, employee count where number of employees 2 or greater, and employees without a country, city, and department
#RM:  question is number of departments where number of employees 2 or greater
#official solution modified
select c.country_name, l.city, count(d.department_id)
from countries c join locations l
on c.country_id = l.country_id
join departments d
on l.location_id = d.location_id
where d.department_id in (
		select e.department_id
		from employees e
		group by e.department_id
		having count(e.department_id)>=2) #RM:  use department_id to count employees instead of employee_id because need department_id in where clause
group by c.country_name, l.city;
#official solution
select country_name,city, count(department_id)
from countries 
join locations using (country_id) 
join departments using (location_id) 
where department_id in (
	select department_id 
	from employees 
	group by department_id 
	having count(department_id)>=2)
group by country_name,city;

#22. Write a query in SQL to display the department name, full name (first and last name) of manager, and their city.
select d.department_name, e.first_name || ' ' || e.last_name as "Full Name Manager", l.city
from employees e left outer join departments d
on e.manager_id = d.manager_id
join locations l
on d.location_id = l.location_id;
#RM:  correct solution.  Reason is we want the manager's name departments d table connect with manager's employee_id employees e table
select d.department_name, e.first_name || ' ' || e.last_name as "Full Name Manager", l.city
from employees e join departments d
on e.employee_id = d.manager_id
join locations l
on d.location_id = l.location_id;

#23. Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.
select jobhistory.employee_id, j.job_title, (jobhistory.end_date-jobhistory.start_date) as "Number Days Worked"
from job_history jobhistory join jobs j
on jobhistory.job_id = j.job_id
where jobhistory.department_id = 80;
#official solution
select employee_id, job_title, end_date-start_date days
from job_history natural join jobs
where department_id=80;

#24. Write a query in SQL to display the full name (first and last name), and salary of those employees who working in any department located in London.
select e.first_name || ' ' || e.last_name as "Full Name", e.salary
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'London';
#also
select e.first_name || ' ' || e.last_name as "Full Name", e.salary
from employees e join departments d using (department_id)
join locations l using (location_id)
where l.city = 'London';
#two natural joins?!?
select e.first_name || ' ' || e.last_name, e.salary
from employees e natural join departments d
natural join locations l
where l.city = 'London';  #RM  can I use two or more natural joins?  Apparently no.

#25. Write a query in SQL to display full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
select e.first_name || ' ' || e.last_name as "Full Name", j.job_title, jobhistory.start_date, jobhistory.end_date
from employees e join job_history jobhistory
on e.employee_id = jobhistory.employee_id
join jobs j
on jobhistory.job_id = j.job_id
where e.commission_pct = 0;  #RM:  problem is there are two employees with two job_id in job_history table.  We want the latest job or the job with the latest date; e.g. start date 9/21/97 or 10/28/01 we want 10/28/01.
#correct answer
select e.first_name || ' ' || e.last_name as "Full Name", j.job_title, jobhistoryspecial.*
from employees e join (
	select max(start_date), max(end_date), employee_id
	from job_history
	group by employee_id) jobhistoryspecial
on e.employee_id = jobhistoryspecial.employee_id
join jobs j
on j.job_id = e.job_id
where e.commission_pct = 0;
/*
employee_name		job_title			starting_date	ending_date	employee_id
Neena Kochhar		Administration Vice President	2001-10-28	2005-03-15	101
Lex De Haan		Administration Vice President	2001-01-13	2006-07-24	102
Den Raphaely		Purchasing Manager		2006-03-24	2007-12-31	114
Payam Kaufling		Stock Manager			2007-01-01	2007-12-31	122
Jennifer Whalen		Administration Assistant	2002-07-01	2006-12-31	200
Michael Hartstein	Marketing Manager		2004-02-17	2007-12-19	201
*/

#26. Write a query in SQL to display the department name and number of employees in each of the department.
select d.department_name, count(e.department_id)
from departments d join employees e
on d.department_id = e.department_id
group by d.department_name;
#official solution which added department_id column
select d.department_name, e.*
from departments d join (
	select department_id, count(employee_id)
	from employees
	group by department_id) e
using (department_id);

#27. Write a query in SQL to display the full name (firt and last name ) of employee with ID and name of the country presently where (s)he is working.  RM:  four tables.  Also added country_id from countries c table.
select e.first_name || ' ' || e.last_name as "Full Name", e.employee_id, c.country_id, c.country_name
from employees e inner join departments d
on e.department_id = d.department_id
inner join locations l
on d.location_id = l.location_id
inner join countries c
on l.country_id = c.country_id;
#same as inner join and join are the same inner join join
select e.first_name || ' ' || e.last_name as "Full Name", e.employee_id, c.country_id, c.country_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id = c.country_id;
#official solution
select first_name || ' ' || last_name as employee_name, employee_id, country_name 
from employees join departments using(department_id) 
join locations using(location_id) 
join countries using (country_id);
