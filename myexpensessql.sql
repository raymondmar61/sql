describe categories;
--same as
desc categories;

--add column q'[columndata]'  as "columntitle" populated with columndata in cell titled columntitle
select q'[columndata]' as "columntitle" , personplace, city
from personplace;
--or
select personplace, city, q'[USA]' as "country"
from personplace;  --third column title is country populated with USA

select distinct event, category
from expenses
where expensedate between '01/01/2015' and '12/31/2015'
and event is not null
order by event, category;
--start oraclesql12cintroduction.sql line 39 04/07/18

select nz(gallons,0.0)
from expenses; --null nz() function doesn't work.  Use nvl()
select nvl(gallons,0.0)
from expenses;

select gallons || ', ' || pricepergallon as "gallons, ppg", round((gallons*pricepergallon),2) as "math", amount, expensedate
from expenses
where category = 'Gas-Toyota Camry 2005';
--RM:  jumping ahead group number of times I purchased gas by year
select count(trunc(expensedate, 'YEAR'))
from expenses
group by (trunc(expensedate, 'YEAR'));
select (trunc(expensedate, 'YEAR')), count(trunc(expensedate, 'YEAR'))
from expenses
where category = 'Gas-Toyota Camry 2005'
group by (trunc(expensedate, 'YEAR'));  --print 01/01/2014 to represent 2014, 01/01/2015 to represent 2015, etc.
select to_char(expensedate, 'yyyy'), count(to_char(expensedate, 'yyyy'))
from expenses
where category = 'Gas-Toyota Camry 2005'
group by to_char(expensedate, 'yyyy')
order by to_char(expensedate, 'yyyy');  --print 2014 to represent 2014, 2015 to represent 2015, etc.
--RM:  jumping ahead sum gallons gas purchased by year
select to_char(expensedate, 'yyyy'), sum(gallons)
from expenses
group by to_char(expensedate, 'yyyy')
order by to_char(expensedate, 'yyyy') desc;
select to_char(expensedate, 'yyyy') as year, sum(gallons), count(gallons)
from expenses
group by to_char(expensedate, 'yyyy')
order by year desc;  --it appears keywords good for order by not group by

select name, amount, expensedate, trunc(sysdate-expensedate) as "number of days"
from expenses
where amount > 500;  --sysdate for today's date today date
select name, amount, expensedate
from expenses
where goingout is not null
and expensedate in ('1/17/2014','4/30/2017',sysdate);
select name, amount, expensedate
from expenses
where comments like '%sale%';  --% and _ for single character like wild card
--start oraclesql12cintroduction.sql line 113 04/10/18

--number of times I purchased milk by year
select to_char(expensedate, 'yyyy'), count(expensedate)
from expenses
where category in ('%milk%')
group by to_char(expensedate, 'yyyy');
--RM:  jumping ahead joins eat restaurants Danville, San Ramon, Pleasanton rough estimate PML
select to_char(expensedate, 'yyyy'), p.city, count(expensedate)
from expenses e left outer join personplace p
on e.name = p.personplace
where p.city in ('Danville','Pleasanton','San Ramon')
and e.goingout in ('Must Eat','Self Pleasure','Friends')
group by to_char(expensedate, 'yyyy'), p.city
order by to_char (expensedate, 'yyyy') desc;

select *
from expenses
where expensedate between '01/01/2015' and '12/31/2015'
order by comments nulls last;  --nulls displayed last
select expensedate, name, amount
from expenses
order by 1 desc, 2 asc;  --sorting can be done with columns numeric position
select name, length(name), lower(name), upper(name), initcap(name), substr(name,1,5), substr(name,3,6)
from expenses;  --substring substr() extract string
select personplace, streetnumber || ' ' || streetname || ' ' || city || ', ' || state || ' ' || zip
from personplace
where state in ('CA')
and streetnumber not in (0);  --concat() concatenates two parameters only
select personplace, instr(personplace,'e') as "find first e only or 0 if no e"
from personplace;  --instring instr finds first instance or 0 if none.  find string find word
select event, replace(event,nulls,'No Event')
from expenses;  --incorrect use of replacing null.  Use nvl() below.  Otherwise, replace() works.
select event, nvl(event,'No Event')
from expenses;
select carmodel, lpad(carmodel,20,'*') as "must have 20 fill with * from left"
from car; --e.g. **************Camery
select carmodel, rpad(carmodel,20,'*') as "must have 20 fill with * from right"
from car; --e.g. Camery**************
select round(12.136,2) as "12.14", round(12.136,3) as "12.136", round(12.136,1) as "12.1", round(12.136) as "12", round(12.536) as "13", round(12.536,2) as "12.54", trunc(12.536,2) as "12.53", trunc(12.536) as "12", ceil(12.536) as "13", ceil (12.001) as "13", ceil (12.999) as "13", floor(12.001) as "12", mod(10,5) as "10/5 remainder 0", mod(1800,23) as "1800/23 remainder 6"
from dual;
select substr('Raymond Mar',instr('Raymond Mar', ' ')+1) as "Mar"
from dual;  --extract first
select substr('Raymond Mar',1,instr('Raymond Mar',' ')-1) as "Raymond"
from dual;  --extract last
--start oraclesql12cintroduction.sql line 196 04/12/18

select event, expensedate, trunc(sysdate-expensedate)
from expenses
where event is not null;
--ADD_MONTHS add specific month to specified date.  Use negative number to subtract specific month.
select add_months('06/20/2017',2)
from dual;  --returns 08/20/2017
--MONTHS_BETWEEN number of months between two dates
select months_between('09/03/2015', '02/18/2015'), round(months_between('09/03/2015', '02/18/2015'))
from dual; --returns 6.51612903225, 7
--ROUND, TRUNC, NEXT_DAY returns next specified day, LAST_DAY returns last day of the month
select round(sysdate, 'MONTH'), to_char(round(sysdate, 'MONTH'),'mm/yyyy')
from dual; --returns 04/01/2018, 04/2018 ran on 04/12/2018. Also round('04/20/2018') invalid.
select trunc(sysdate, 'YEAR'), to_char(trunc(sysdate, 'YEAR'), 'yyyy')
from dual; --return 01/01/2018, 2018 ran on 04/12/2018.  Also trunc('04/20/2018') invalid.
select next_day('06/20/2017','Wednesday')
from dual; --return 06/21/2017 which is a Wednesday ran on Tuesday 06/20/17.  Also next_day(sysdate) invalid.
select last_day('06/13/2017'), last_day('06/20/2018'), last_day(sysdate), last_day(sysdate)+1, to_char(last_day(sysdate)+1,'mm/yyyy')
from dual;  --return 06/30/2018, 06/30/2018, 04/30/2018, 05/01/2018, 05/2018 ran on 04/12/18
--start oraclesql12cintroduction.sql line 223 04/12/18