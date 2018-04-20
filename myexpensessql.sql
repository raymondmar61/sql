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

select expensedate, to_char(expensedate,'yyyy') as "2014", to_char(expensedate,'yy') as "14", to_char(expensedate,'Mon-yy') as "Jan-14", to_char(expensedate,'mm-dd-yy') as "01-02-14", to_char(expensedate,'Month ddth, yyyy') as "January      2nd, 2014", to_char(expensedate,'Mon dth, yyyy') as "Jan 2nd, 2014", to_char(expensedate,'year') as 'twenty fourteen', to_char(expensedate,'day') as "thursday", to_char(expensedate,'d') as "5 (1 is Sun)", to_char(expensedate,'dy') as "thu"
from expenses;
select amount, to_char(amount,'$99.999.99') as "$7.880"
from expenses;

select amount, nvl(tax,0) as "tax", (amount-nvl(tax,0)) as "subtotal", round(nvl(tax,0)/(amount-nvl(tax,0)),4)*100 as "tax rate"
from expenses
where expensedate >='01/01/2017'
and amount > 0
and tip is null;
--nvl2 function null if not null nvl(expression1, expression2, expression3) if expression1 is not null, then return expression 2; if expression1 is null, then return expression 3.  expression2 and expression3 must be the same data type.
select nvl2(tax,'yes tax','no tax') as "yes no tax"
from expenses;
-- nullif function nullif(expression1, expression2) compares expression1 and expression2.  If equal, return null.  If not equal, return expression1.  RM:  I can't think of using nullif() in select statement.  Also, tax field must be a zero to work.  Tax field can't be null.  In lament terms, if amount and amount-nvl(tax,0) are equal, then return null.  Find id with nullif(amount,amount-nvl(tax,0)) is null.
select id
from expenses
where nullif(amount,amount-nvl(tax,0)) is null
order by id;

--coalesce function coalesce(expression1, expression2, expression3, . . . expressionx) advanced nvl function.  If expression1 is null, look at expression2.  If expression2 is null, look at expression3.  Continues until any un-null value or the last expression expressionx; i.e. returns the first non null value or expressionx if previous expressions are null.  Also, expressions data type must be the same.  RM: in lament terms, coalesce(state, city, 'not has') if state is null, then check city.  If city is null, then return 'not has'.
select id, state, city, coalesce(state, city, 'not has')
from personplace;
select id, state, city, coalesce(state, city, 'not has')
from personplace
where coalesce(state, city, 'not has') = 'not has';  --return rows state and city are null
--similarily
select amount, tax
from expenses
where coalesce(amount,tax,-10) = -10;
select *
from expenses
where coalesce(gallons, pricepergallon, -100) = -100
and category like 'Gas%';  --return rows gallons and pricepergallon are null for gas expenses.  RM:  found one which was gym miscategorized as Gas

--case expression.  case expr when comparisonexpr1 then returnexpr1 [when comparisonexpr2 then returnexpr2 when comparisonexprn then returnexprn] else elseexpr end.  Used for if then else or if else logic SQL. Can be used in select clause and where clause. returnexpr must be same data types.  RM:  returnexpr can be different data type.  Also, no paranthesis
select id, payment_method, case when payment_method like 'Gift Card%' then 'Gift Card' when payment_method like 'Visa%' then 'Visa' when payment_method like 'Master Card%' then 'Master Card' else payment_method end as "Easy read payment_method"
from expenses;
select id, tax, case when tax>0 and tax <=5 then 'low tax' when tax>5 and tax <=10 then 'medium tax' when tax >10 and tax <=20 then 'high tax' when tax >20 then 'too much' else 'error' end as "tax opinion"
from expenses
where tax is not null;
select id, case when amount >=0 and amount <=50 then '0-50' when amount >=51 and amount <=100 then '51-100' else '101-' end as "category"
from expenses;
select temptable.rangesname, count(*) as "Range Count"
from (
	select case when amount >=0 and amount <=50 then '0-50' when amount >=51 and amount <=100 then '51-100' else '101-' end as rangesname
	from expenses) temptable
group by temptable.rangesname
order by temptable.rangesname;  --group by ranges group by range https://stackoverflow.com/questions/232387/in-sql-how-can-you-group-by-in-ranges

--bonus group by count of counts
/* template for group by count of counts https://stackoverflow.com/questions/8338607/sql-group-by-count-of-counts
SELECT countitemidforeachorderid, COUNT(1) as groupedcount
FROM
(
    SELECT orderid, count(itemid) as countitemidforeachorderid
    FROM items
    Group By orderid 

) MyTable
GROUP BY countitemidforeachorderid
*/
select payment_method, count(payment_method) as "count payment_method"
from expenses
group by payment_method
order by count(payment_method);  --count how many times for each payment method I paid goods and services
select "order size", count(*) as "Number"
from (
	select payment_method, count(payment_method) as "order size"
	from expenses
	group by payment_method
) MyTable
group by "order size"
order by "order size";  --raw template count the count how many times for each payment method I paid goods and services
select "order size", count(*) as "Number"
from (
	select payment_method, case when count(payment_method) >=1 and count(payment_method) <=9 then '1-9' when count(payment_method) >=10 and count(payment_method) <=50 then '10-50' when count(payment_method) >=51 and  count(payment_method) <=99 then '51-99' when count(payment_method) >=100 and count(payment_method) <=299 then '100-299' else 'popular' end as "order size"
	from expenses
	group by payment_method
) MyTable
group by "order size"
order by "order size";  --group count the count how many times for each payment method I paid goods and services; e.g. how many payment methods between 1 and 9, between 10 and 50, between 51 and 100, etc.
--start oraclesql12cintroduction.sql line 292 04/16/18

select to_char(expensedate,'yyyy'), count(amount), sum(amount), max(amount), min(amount), case when min(amount) <0 then '0' else min(amount) end, round(avg(amount),2)
from expenses
where amount >=-500 and amount <=500
group by to_char(expensedate,'yyyy')
order by to_char(expensedate,'yyyy') desc;  --case when okay string to number, not okay number to string-->case when min(amount) <0 then 'refund' else min(amount) error message appears.
select to_char(expensedate,'yyyy'), round(avg(amount),2)
from expenses
group by to_char(expensedate,'yyyy')
having avg(amount) > 30
order by to_char(expensedate,'yyyy') desc;  --having statement is like a where statement.  It's for the group function.  Can't use group function with where clause.  where clause restricts rows.  having clause restricts groups.  order by clause is the last statement.

select *
from categories c, expenses e
where c.category=e.category;
select c.id, c.category as "category table category", e.id, e.category as "expense table category", e.name, e.amount
from categories c, expenses e
where c.category=e.category;
--RM:  skipped Natural Join.  Join two tables with columns with the same name.  select rows from two tables which have equal values in the same name columns
select e.expensedate, e.name, p.city, p.state
from expenses e left outer join personplace p
on e.name=p.personplace;
--multiple join
select e.expensedate, e.name, p.city, p.state, c.id, c.category
from expenses e left outer join personplace p
on e.name=p.personplace
join categories c
on c.category=e.category;
--same as rearranging on c.category=e.category; to on e.category=c.category;
select e.expensedate, e.name, p.city, p.state, c.id, c.category
from expenses e left outer join personplace p
on e.name=p.personplace
join categories c
on e.category=c.category;
--same as adding left outer join
select e.expensedate, e.name, p.city, p.state, c.id, c.category
from expenses e left outer join personplace p
on e.name=p.personplace
left outer join categories c
on e.category=c.category;
--different adding right outer join got more results because getting all categories c even if I didn't purchase from the categories 2014-2017
select e.expensedate, e.name, p.city, p.state, c.id, c.category
from expenses e left outer join personplace p
on e.name=p.personplace
right outer join categories c
on e.category=c.category;
--start oraclesql12cintroduction.sql line 426 04/18/18
select e.expensedate, e.name, e.amount, p.city, p.state
from expenses e join personplace p
on e.name = p.personplace;
select e.id, e.name, e.category, c.category, c.id
from expenses e join categories c
using (category);  --error message can't refer join columns in select statement
select e.id, e.name, c.id
from expenses e join categories c
using (category);  --okay.  Linking column must be in paranthesis
--full outer join retrives all the columns or matching rows from both tables and nulls for the unmatched rows of both tables.  The union of left and router outer joins and unmatched rows of both tables are returned.
select e.expensedate, e.name, e.amount, p.personplace, p.city, p.state
from expenses e full outer join personplace p
on e.name = p.personplace;  --p.personplace not purchased 2014-2017 rows are included

select round(avg(amount),2)
from expenses;  --return 38.83
select *
from expenses
where amount > 38.83;
select *
from expenses
where amount > (
	select round(avg(amount),2)
	from expenses);
select id
from categories
where category in ('Gas-Toyota Camry 2005');  --return 103
select event, name, amount, expensedate
from expenses
where category in (
	select category
	from categories
	where id = 103);
--or
select event, name, amount, expensedate
from expenses
where category in ('Gas-Toyota Camry 2005');
--RM:  jumping ahead update record
update expenses
set name = 'Chevron-Winchester Payne'
where id = 5992;
commit;
select *
from expenses
where category in (
	select category
	from categories
	where id = 103)
and
pricepergallon > (
	select round(avg(pricepergallon),2)
	from expenses);  --multi line single-row subquery
select category, min(amount)
from expenses
where amount > 0
group by category
order by category;  --find lowest amount spent per category
select category, name, amount, id
from expenses
where amount in (
  select min(amount)
  from expenses
  where amount > 0
  group by category)
order by name;  --find the name for each category spent minimum.  Amounts tied all rows included.  RM:  it doesn't work; e.g. Chevron-Hamilton there is a 25 and a 28 both included in results which must not be included.  12.98 is correct at Chevron-Winchester Payne.  Next SQL query is correct.
select category, name, amount, id
from expenses
where (category, amount) in (
  select category, min(amount)
  from expenses
  where amount > 0
  group by category)
order by category, name;  --correct SQL query. 12.98 is correct at Chevron-Winchester Payne.  No Chevron-Hamilton 25 and 28.  It's a multiple column subquery.
--start oraclesql12cintroduction.sql line 536 04/20/18