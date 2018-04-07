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
