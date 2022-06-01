--Practical SQL By Anthony DeBarros Second Edition Chapter 11 Statistical Functions In SQL

create table acs20142018stats
(geoid text constraint geoidkey primary key, country text not null, st text not null, pcttravel60min numeric(5,2), pctbachelorshigher numeric(5,2), pctmasetershigher numeric(5,2), medianhhincome integer, check (pctmasetershigher<=pctbachelorshigher));  --The check constant is bachlor's degree percentage is equal to or higher than the master's degree percentage
copy acs20142018stats
from '/home/mar/postgresql/acs_2014_2018_stats.csv'
with (format csv, header);
select *
from acs20142018stats;
'''
"geoid"	"country"	"st"	"pcttravel60min"	"pctbachelorshigher"	"pctmasetershigher"	"medianhhincome"
"0500000US01001"	"Autauga County"	"Alabama"	5.67	27.69	11.81	58786
"0500000US01003"	"Baldwin County"	"Alabama"	7.86	31.35	10.64	55962
"0500000US01005"	"Barbour County"	"Alabama"	8.02	12.22	4.42	34186
"0500000US01007"	"Bibb County"	"Alabama"	8.85	11.49	3.90	45340
"0500000US01009"	"Blount County"	"Alabama"	17.95	12.64	4.52	48695
"0500000US01011"	"Bullock County"	"Alabama"	12.81	13.30	5.90	32152
...
'''
select corr(medianhhincome, pctbachelorshigher) as "Correlation between median income and percentage bachlors"
from acs20142018stats;  --return 0.6999086502599159
select round(corr(medianhhincome, pctbachelorshigher)::numeric,2) as "Correlation median income and bachlors", round(corr(pcttravel60min, medianhhincome)::numeric,2) as "Correlation commute and median income", round(corr(pcttravel60min, pctbachelorshigher)::numeric,2) as "Correlation commute and bachlors"
from acs20142018stats;
'''
"Correlation median income and bachlors"	"Correlation commute and median income"	"Correlation commute and bachlors"
0.70	0.06	-0.14
'''
select round(regr_slope(medianhhincome, pctbachelorshigher)::numeric,2) as "Slope how much y changes for each x", round(regr_intercept(medianhhincome,pctbachelorshigher)::numeric,2) as "Y intercept constant add or constant subtract"
from acs20142018stats;
'''
"Slope how much y changes for each x"	"Y intercept constant add or constant subtract"
1016.55	29651.42
'''
--Predict or forecast.  For every one unit increase in bachelor's degree percentage, the median household income increase 1016.55.  Zero unit or zero percentage bachelor's degree the median income is 29651.42.  x = 30% with a bachelor's degree or percentage bachelors degree we predict the median household income is 60,148 or 60,148=(1,016.55*30)+29,651.42.
--Coefficient Of Determination or r-squared r^2.  Calculate the variation in the x variable or independent variable explains the variation in the y variable or dependent variable.  R-squared indicates the percentage of the variation explained by the independent variable between zero and one.  If r-squared is 0.1, then the independent variable explains 10 percent of the variation in the dependent variable or not much at all.  Use regr_r2(y,x).  Correlation doesn't prove causality.
select round(regr_r2(medianhhincome,pctbachelorshigher)::numeric,3) as "R Squared bachelors explain median income"
from acs20142018stats;
'''
"R Squared bachelors explain median income"
0.490
'''
--Variance is the average of each number's squared distance from the average.  The more dispersion in a set of values, the greater the variance.
--Standard deviation is the square root of the variance.  It's most useful for assessing data whose values form a normal distribution or bell curve.  In a normal distribution, about two-thirds of values fall within one standard deviation of the average, 95% of values fall within two standard deviations.  The standard deviation tells how close most of the values are to the average.
--Standard deviation is expressed in the same units as the values.  Variance reports a number larger than the units.
--var_pop(numeric) calculates the population variance, var_samp(numeric) calclates the sample variance.
--stddev_pop(numeric) calculates the population standard deviation, stddev_samp(numeric) calculates the sample standard deviation.
--rank() and dense_rank() perform calculations across a set of rows relative to the current row.  rank() for ties share the rank number with gaps.  dense_rank() for ties share the rank number without gaps no skipping rank numbers in sequential.
create table widgetcompanies
(id integer primary key generated always as identity, company text not null, widgetoutput integer not null);
insert into widgetcompanies (company, widgetoutput)
values ('Dom Widgets', 125000), ('Ariadne Widget Masters', 143000), ('Saito Widget Co.', 201000), ('Mal Inc.', 133000), ('Dream Widget Inc.', 196000), ('Miles Amalgamated', 620000), ('Arthur Industries', 244000), ('Fischer Worldwide', 201000);
select company, widgetoutput
from widgetcompanies;
'''
"company"	"widgetoutput"
"Dom Widgets"	125000
"Ariadne Widget Masters"	143000
"Saito Widget Co."	201000
"Mal Inc."	133000
"Dream Widget Inc."	196000
"Miles Amalgamated"	620000
"Arthur Industries"	244000
"Fischer Worldwide"	201000
'''
select company, widgetoutput, rank() over (order by widgetoutput desc) as "Ties share rank with gaps"
from widgetcompanies
order by widgetoutput desc;
'''
"company"	"widgetoutput"	"Ties share rank with gaps"
"Miles Amalgamated"	620000	1
"Arthur Industries"	244000	2
"Fischer Worldwide"	201000	3
"Saito Widget Co."	201000	3
"Dream Widget Inc."	196000	5
"Ariadne Widget Masters"	143000	6
"Mal Inc."	133000	7
"Dom Widgets"	125000	8
'''
select company, widgetoutput, dense_rank() over (order by widgetoutput desc) as "Ties share rank no gaps yes sequential"
from widgetcompanies
order by widgetoutput desc;
'''
"company"	"widgetoutput"	"Ties share rank no gaps yes sequential"
"Miles Amalgamated"	620000	1
"Arthur Industries"	244000	2
"Fischer Worldwide"	201000	3
"Saito Widget Co."	201000	3
"Dream Widget Inc."	196000	4
"Ariadne Widget Masters"	143000	5
"Mal Inc."	133000	6
"Dom Widgets"	125000	7
'''
--Rank within subgroups using partition by
create table storesales
(store text not null, category text not null, unitsales bigint not null, constraint storecategorykey primary key (store, category));
insert into storesales (store, category, unitsales)
values ('Broders', 'Cereal', 1104), ('Wallace', 'Ice Cream', 1863), ('Broders', 'Ice Cream', 2517), ('Cramers', 'Ice Cream', 2112), ('Broders', 'Beer', 641), ('Cramers', 'Cereal', 1003), ('Cramers', 'Beer', 640), ('Wallace', 'Cereal', 980), ('Wallace', 'Beer', 988);
select category, store, unitsales
from storesales;
'''
"category"	"store"	"unitsales"
"Cereal"	"Broders"	1104
"Ice Cream"	"Wallace"	1863
"Ice Cream"	"Broders"	2517
"Ice Cream"	"Cramers"	2112
"Beer"	"Broders"	641
"Cereal"	"Cramers"	1003
"Beer"	"Cramers"	640
"Cereal"	"Wallace"	980
"Beer"	"Wallace"	988
'''
select category, store, unitsales, rank() over (partition by category order by unitsales desc) as "Rank unitsales group by category"
from storesales
order by category, rank() over (partition by category order by unitsales desc);
'''
"category"	"store"	"unitsales"	"Rank unitsales group by category"
"Beer"	"Wallace"	988	1
"Beer"	"Broders"	641	2
"Beer"	"Cramers"	640	3
"Cereal"	"Broders"	1104	1
"Cereal"	"Cramers"	1003	2
"Cereal"	"Wallace"	980	3
"Ice Cream"	"Broders"	2517	1
"Ice Cream"	"Cramers"	2112	2
"Ice Cream"	"Wallace"	1863	3
'''
--Comparing numbers per 1,000 or a number represents per capita.  For example, 115 births in a town population 2,200 women ages 15-44.  (115/2,200)*1,000=52.3.  52.3 births per 1,000 women ages 15-44.  Proportion.
create table cbpnaics72establishments
(statefips text, countyfips text, county text not null, st text not null, naics2017 text not null, naics2017label text not null, year smallint not null, establishments integer not null, constraint cbpfipskey primary key (statefips, countyfips));
copy cbpnaics72establishments
from '/home/mar/postgresql/cbp_naics_72_establishments.csv'
with (format csv, header);
select *
from cbpnaics72establishments
order by statefips, countyfips
limit 10;
'''
"statefips"	"countyfips"	"county"	"st"	"naics2017"	"naics2017label"	"year"	"establishments"
"01"	"001"	"Autauga County"	"Alabama"	"72"	"Accommodation and food services"	2018	102
"01"	"003"	"Baldwin County"	"Alabama"	"72"	"Accommodation and food services"	2018	575
"01"	"005"	"Barbour County"	"Alabama"	"72"	"Accommodation and food services"	2018	48
"01"	"007"	"Bibb County"	"Alabama"	"72"	"Accommodation and food services"	2018	18
"01"	"009"	"Blount County"	"Alabama"	"72"	"Accommodation and food services"	2018	49
"01"	"011"	"Bullock County"	"Alabama"	"72"	"Accommodation and food services"	2018	7
"01"	"013"	"Butler County"	"Alabama"	"72"	"Accommodation and food services"	2018	41
"01"	"015"	"Calhoun County"	"Alabama"	"72"	"Accommodation and food services"	2018	216
"01"	"017"	"Chambers County"	"Alabama"	"72"	"Accommodation and food services"	2018	58
"01"	"019"	"Cherokee County"	"Alabama"	"72"	"Accommodation and food services"	2018	40
'''
select cbp.county, cbp.st, cbp.establishments, pop.popest2018,round((cbp.establishments::numeric / pop.popest2018) * 1000,1) as "highest concentration per 1,000"
from cbpnaics72establishments cbp join uscountiespopest2019 pop
on cbp.statefips = pop.statefips
and cbp.countyfips = pop.countyfips
where pop.popest2018 >= 50000
order by cbp.establishments::numeric / pop.popest2018 desc;
'''
"county"	"st"	"establishments"	"popest2018"	"highest concentration per 1,000"
"Cape May County"	"New Jersey"	925	92446	10.0
"Worcester County"	"Maryland"	453	51960	8.7
"Monroe County"	"Florida"	540	74757	7.2
"Warren County"	"New York"	427	64215	6.6
"New York County"	"New York"	10428	1629055	6.4
"Hancock County"	"Maine"	337	54734	6.2
"Sevier County"	"Tennessee"	570	97895	5.8
"Eagle County"	"Colorado"	309	54943	5.6
"Taney County"	"Missouri"	309	55719	5.5
"Barnstable County"	"Massachusetts"	1107	213471	5.2
"San Francisco County"	"California"	4547	880696	5.2
"Kenai Peninsula Borough"	"Alaska"	294	58561	5.0
"Newport County"	"Rhode Island"	386	82547	4.7
...
'''
--Rolling average is an average calculated for each period in a database.  Smooth numbers calculating the rolling average or moving average.
create table usexports
(year smallint, month smallint, citrusexportvalue bigint, soybeansexportvalue bigint);
copy usexports
from '/home/mar/postgresql/us_exports.csv'
with (format csv, header);
select year, month, citrusexportvalue
from usexports
order by year, month
limit 10;
'''
"year"	"month"	"citrusexportvalue"
2002	1	81939159
2002	2	91145699
2002	3	115051310
2002	4	86779722
2002	5	45814736
2002	6	36015544
2002	7	18333834
2002	8	15058915
2002	9	13271588
2002	10	26590694
...
'''
select year, month, citrusexportvalue, round(avg(citrusexportvalue) over(order by year, month rows between 11 preceding and current row),0) as "twelve month average "
from usexports
order by year, month;  --The avg() function calculates the average of the values in citrusexportvalue.  The over() clause sorts the data for the 12 months and the number of rows to average using rows between 11 preceding and current which tells PostgreSQL to limit to the current row and the 11 rows before the current row totaling 12 rows.
'''
"year"	"month"	"citrusexportvalue"	"twelve month average "
2002	1	81939159	81939159
2002	2	91145699	86542429
2002	3	115051310	96045389
2002	4	86779722	93728973
2002	5	45814736	84146125
2002	6	36015544	76124362
2002	7	18333834	67868572
2002	8	15058915	61267365
2002	9	13271588	55934501
2002	10	26590694	53000120
2002	11	53639481	53058244
2002	12	61170830	53734293
2003	1	79069804	53495180
2003	2	91905948	53558534
2003	3	112045016	53308009
2003	4	82714650	52969253
2003	5	65807931	54635353
2003	6	37152480	54730098
2003	7	22025720	55037755
2003	8	15347844	55061832
2003	9	12997666	55039005
2003	10	37309973	55932279
2003	11	54333917	55990148
2003	12	69999550	56725875
...
'''