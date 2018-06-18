#Chapter 10 Statistical Functions In SQL (p 155)
create table acs_2011_2015_stats (geoid varchar(14) constraint geoid_key primary key, county varchar(50) not null, st varchar(20) not null, pct_travel_60_min numeric(5,3) not null, pct_bachelors_higher numeric(5,3) not null, pct_masters_higher numeric(5,3) not null, median_hh_income integer, check (pct_masters_higher <= pct_bachelors_higher));  --check constraint figures for master's degree are less than or equal to bachelor's degree
copy acs_2011_2015_stats
from 'i:\program files\postgresql\acs_2011_2015_stats.csv'
with (format csv, header, delimiter ',');
select *
from acs_2011_2015_stats;

#Pearson correlation coefficient "r" quantifying the strength of a linear relationship between two variables corr(x,y).  Coefficient closer to 1 indicates a strong relationship.  Positive is direct relationship.  Negative is inverse relationship.
#RM:  the book teaches corr(dependent variable or y, independent variable or x).  
#RM:  correlation doesn't imply causality.
select corr(median_hh_income, pct_bachelors_higher) as bachelors_income_r
from acs_2011_2015_stats;  --returned 0.682185675451399.  Higher education increases household income.

#Predict values using regression analysis regr_slope(x,y) for slope and regr_intercept(x,y) for y-intercept.  Find the best linear equation or straight line y=mx+b describes the relationship between an independent variable and a dependent variable.  The straight line running through the middle of all the data points is called the least squares regression line with approximates the best fit for a straight line describing the relationship between the variables.
select round(regr_slope(median_hh_income, pct_bachelors_higher)::numeric,2) as slope, regr_intercept(median_hh_income, pct_bachelors_higher) as y_intercept
from acs_2011_2015_stats;  --returned 926.25, 27901.1486837528.  At 30% of people with a bachelor's degree or higher, 926.25*(30)+27901.15=55709.65

#Coefficient of determination or r-squared regr_r2(x,y).  It's the variation in the independent variable explains the variation in the dependent variable.  An r-squared between zero and one indicates the percentage of the variation that is explained by the independent variable.  e.g. if r-squared = .1 says the independent variable explains a 10% of the variation in the dependent variable.
select round(regr_r2(median_hh_income, pct_bachelors_higher)::numeric,3) as r_squared
from acs_2011_2015_stats;  --returned .465.  46.5% of the variation in the median income can be explained by the percentage of people with a bachelor's degree or higher.  What about the other 53.5% variation in household income?  Any number of factors explains the rest of the variation.
--same as
select round(regr_r2(pct_bachelors_higher, median_hh_income)::numeric,3) as r_squared
from acs_2011_2015_stats;  --returned .465
