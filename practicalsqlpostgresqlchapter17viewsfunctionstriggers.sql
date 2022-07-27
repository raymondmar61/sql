--Standard view named nevadacountiespop2019
--If replacing an existing view, the replacing query must generate the same column names with the same data types and in the same order as the view being replaced.  Okay to add columns at the end of the column list.
--To see views, click the database name, Schemas-->public-->Views.
create or replace view nevadacountiespop2019 as
    select countyname, statefips, countyfips, popest2019
    from uscountiespopest2019
    where statename='Nevada';
--Run a select query from nevadacountiespop2019 view
select *
from nevadacountiespop2019  
order by countyfips
limit 5;
/*
"countyname"	"statefips"	"countyfips"	"popest2019"
"Churchill County"	"32"	"001"	24909
"Clark County"	"32"	"003"	2266715
"Douglas County"	"32"	"005"	48905
"Elko County"	"32"	"007"	52778
"Esmeralda County"	"32"	"009"	873
*/
--Create view countypopchange20192010 showing population change for US counties
create or replace view countypopchange20192010 as
    select c2019.countyname, c2019.statename, c2019.statefips, c2019.countyfips, c2019.popest2019 as pop2019, c2010.estimatesbase2010 as pop2010, round((c2019.popest2019::numeric-c2010.estimatesbase2010)/c2010.estimatesbase2010*100,1) as pctchange20192010
    from uscountiespopest2019 as c2019 join uscountiespopest2010 as c2010
    on c2019.statefips = c2010.statefips
    and c2019.countyfips = c2010.countyfips;
--Run a select query from countypopchange20192010 view for Nevada
select countyname, statename, pop2019, pctchange20192010
from countypopchange20192010
where statename='Nevada'
order by countyfips
limit 5;
/*
"countyname"	"statename"	"pop2019"	"pctchange20192010"
"Churchill County"	"Nevada"	24909	0.1
"Clark County"	"Nevada"	2266715	16.2
"Douglas County"	"Nevada"	48905	4.1
"Elko County"	"Nevada"	52778	7.8
"Esmeralda County"	"Nevada"	873	11.4
*/
--Delete view use the drop command.  drop view *viewname*;
drop view countypopchange20192010;
--Create materialized view which is the materialized view's stored query is executed and the results are saved in the database creating a new table.  The materialized view retains its stored query.  You can update the saved data with a command to refresh the view.
--To see materialized views, click the database name, Schemas-->public-->Materialized Views.
--or replace keywords are unavailable in a materialized view.
create materialized view nevadacountiespop2019materalizedview as
    select countyname, statefips, countyfips, popest2019
    from uscountiespopest2019
    where statename = 'Nevada';
--Run a select query from nevadacountiespop2019materalizedview view
select *
from nevadacountiespop2019materalizedview
limit 5;
/*
"countyname"	"statefips"	"countyfips"	"popest2019"
"Churchill County"	"32"	"001"	24909
"Clark County"	"32"	"003"	2266715
"Douglas County"	"32"	"005"	48905
"Elko County"	"32"	"007"	52778
"Esmeralda County"	"32"	"009"	873
*/
--Run a refresh if uscountiespopest2019 are updated for nevadacountiespop2019materalizedview view.
refresh materialized view nevadacountiespop2019materalizedview;  --print REFRESH MATERIALIZED VIEW
--Delete materialized view use the drop materialized command.  drop materialized view *viewname*;
drop materialized view nevadacountiespop2019materalizedview;