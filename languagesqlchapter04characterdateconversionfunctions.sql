#The Language Of SQL by Larry Rockoff Chapter 04 Using Functions
select last_name, left(last_name, 5), right(last_name, 5), substring(last_name, 3,2) as "start third character, two letters"
from employees
/*
last_name	left(last_name, 5)	right(last_name, 5)	start third character, two letters	
King	King	King	ng	
Kochhar	Kochh	chhar	ch	
De Haan	De Ha	 Haan	 H	
Hunold	Hunol	unold	no	
Ernst	Ernst	Ernst	ns	
Austin	Austi	ustin	st	
Pataballa	Patab	balla	ta	
Lorentz	Loren	rentz	re	
Greenberg	Green	nberg	ee	
Faviet	Favie	aviet	vi	
Chen	Chen	Chen	en	
Sciarra	Sciar	iarra	ia	
Urman	Urman	Urman	ma	
Popp	Popp	Popp	pp	
Raphaely	Rapha	haely	ph	
Khoo	Khoo	Khoo	oo	
Baida	Baida	Baida	id	
Tobias	Tobia	obias	bi	
Himuro	Himur	imuro	mu	
Colmenares	Colme	nares	lm	
Weiss	Weiss	Weiss	is	
Fripp	Fripp	Fripp	ip	
Kaufling	Kaufl	fling	uf	
Vollman	Vollm	llman	ll	
Mourgos	Mourg	urgos	ur	
*/
#left and right doesn't work in Oracle.  Use substr(columnname, starting position, number of characters to extract)
#ltrim and right trip removes spaces to the left and to the right of the string.  For example ltrim(columnname) removes spaces to the left of the rows in columnname.
select first_name, last_name, concat(first_name, ' ', last_name) as "full employee name concatenate", upper(first_name), lower(last_name)
from employees;
/*
first_name	last_name	full employee name concatenate	upper(first_name)	lower(last_name)	
Steven	King	Steven King	STEVEN	king	
Neena	Kochhar	Neena Kochhar	NEENA	kochhar	
Lex	De Haan	Lex De Haan	LEX	de haan	
Alexander	Hunold	Alexander Hunold	ALEXANDER	hunold	
Bruce	Ernst	Bruce Ernst	BRUCE	ernst	
*/
#Get today's date or current date
select now();
#or
select current_date();
#datediff is the number of days between two dates.  datediff(later date, earlier date).  datediff doesn't work in Oracle.
select hire_date, datediff(current_date(),hire_date)
from employees;
/*
hire_date	datediff(current_date(),hire_date)	
2003-06-17	6638	
2005-09-21	5811	
2001-01-13	7523	
2006-01-03	5707	
2007-05-21	5204	
2005-06-25	5899	
2006-02-05	5674	
2007-02-07	5307	
...
*/
select commission_pct, round(commission_pct,1) as "round one decimal place"
from employees
where commission_pct is not null;
/*
commission_pct	round one decimal place	
0.40	0.4	
0.30	0.3	
0.30	0.3	
0.30	0.3	
0.20	0.2	
0.30	0.3	
0.25	0.3	
0.25	0.3	
0.20	0.2	
0.20	0.2	
0.15	0.2	
0.35	0.4	
0.35	0.4	
...
*/
select commission_pct, ifnull(commission_pct, 0) as "null commission is zero"
from employees;
/*
commission_pct	null commission is zero	
0.25	0.25	
0.20	0.20	
0.20	0.20	
0.15	0.15	
0.10	0.10	
NULL	0.00	
NULL	0.00	
...
*/
#Use isnull if ifnull doesn't work.  Oracle use nvl.  Convert null conversion.