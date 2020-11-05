#Practical SQL Chapter 1 Creating Your First Database And Table
create table teachers (id integer not null primary key, first_name varchar(25), last_name varchar(50), school varchar(50), hire_date date, salary integer);
create table teachers (id integer, first_name varchar(25), last_name varchar(50), school varchar(50), hire_date date, salary integer, constraint primarykey_id primary key (id), constraint notnull_id not null (id));
insert into teachers (id, first_name, last_name, school, hire_date, salary)
values (1, 'Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200);
insert into teachers (id, first_name, last_name, school, hire_date, salary) 
values (2, 'Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000);
insert into teachers (id, first_name, last_name, school, hire_date, salary) 
values (3, 'Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500);
insert into teachers (id, first_name, last_name, school, hire_date, salary) 
values (4, 'Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200);
insert into teachers (id, first_name, last_name, school, hire_date, salary) 
values (5, 'Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500);
insert into teachers (id, first_name, last_name, school, hire_date, salary) 
values (6, 'Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);

#Practical SQL Chapter 2 Beginning Data Exploration With Select
select last_name, first_name, salary
from teachers;
select distinct school
from teachers;
select distinct school, salary
from teachers;
select first_name, last_name, salary
from teachers
order by salary desc;
select last_name, school, hire_date
from teachers
order by school asc, hire_date desc;
select last_name, school, hire_date
from teachers
where school = "Myers Middle School";
select school
from teachers
where school <> "F.D. Roosevelt HS";
select *
from teachers
where hire_date < '2000-01-01';
select *
from teachers
where salary between 40000 and 65000;
select *
from teachers
where first_name like "sam%";
select *
from teachers
where school = "Myers Middle School"
and salary < 40000;
select *
from teachers
where last_name = "Cole"
or last_name = "Bush";

#Practical SQL Chapter 3 Understanding Data Types
char(n)  #infrequently used
varchar(n)
text
integer #4 bytes -2147483648 to 2147483647
smallint #2 bytes -32768 to 32767
bigint #8 bytes -9223372036854775808 to 9223372036854775807
decimal(precision maximum number of digits to the left and to the right of the decimal point, scale number of digits allowed on the right of the decimal point); e.g. 1.47, 1.00, 121.50 are decimal(5,2)
real
timestamp #records date and time
date #date only
time #time only
boolean

#Practical SQL Chapter 4 Importing And Exporting Data
CREATE TABLE us_counties_2010 (
    geo_name varchar(90),                    -- Name of the geography
    state_us_abbreviation varchar(2),        -- State/U.S. abbreviation
    summary_level varchar(3),                -- Summary Level
    region smallint,                         -- Region
    division smallint,                       -- Division
    state_fips varchar(2),                   -- State FIPS code
    county_fips varchar(3),                  -- County code
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                        -- Area (Water) in square meters
    population_count_100_percent integer,    -- Population count (100%)
    housing_unit_count_100_percent integer,  -- Housing Unit count (100%)
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)

    -- This section is referred to as P1. Race:
    p0010001 integer,   -- Total population
    p0010002 integer,   -- Population of one race:
    p0010003 integer,       -- White Alone
    p0010004 integer,       -- Black or African American alone
    p0010005 integer,       -- American Indian and Alaska Native alone
    p0010006 integer,       -- Asian alone
    p0010007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0010008 integer,       -- Some Other Race alone
    p0010009 integer,   -- Population of two or more races
    p0010010 integer,   -- Population of two races:
    p0010011 integer,       -- White; Black or African American
    p0010012 integer,       -- White; American Indian and Alaska Native
    p0010013 integer,       -- White; Asian
    p0010014 integer,       -- White; Native Hawaiian and Other Pacific Islander
    p0010015 integer,       -- White; Some Other Race
    p0010016 integer,       -- Black or African American; American Indian and Alaska Native
    p0010017 integer,       -- Black or African American; Asian
    p0010018 integer,       -- Black or African American; Native Hawaiian and Other Pacific Islander
    p0010019 integer,       -- Black or African American; Some Other Race
    p0010020 integer,       -- American Indian and Alaska Native; Asian
    p0010021 integer,       -- American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
    p0010022 integer,       -- American Indian and Alaska Native; Some Other Race
    p0010023 integer,       -- Asian; Native Hawaiian and Other Pacific Islander
    p0010024 integer,       -- Asian; Some Other Race
    p0010025 integer,       -- Native Hawaiian and Other Pacific Islander; Some Other Race
    p0010026 integer,   -- Population of three races
    p0010047 integer,   -- Population of four races
    p0010063 integer,   -- Population of five races
    p0010070 integer,   -- Population of six races

    -- This section is referred to as P2. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    p0020001 integer,   -- Total
    p0020002 integer,   -- Hispanic or Latino
    p0020003 integer,   -- Not Hispanic or Latino:
    p0020004 integer,   -- Population of one race:
    p0020005 integer,       -- White Alone
    p0020006 integer,       -- Black or African American alone
    p0020007 integer,       -- American Indian and Alaska Native alone
    p0020008 integer,       -- Asian alone
    p0020009 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0020010 integer,       -- Some Other Race alone
    p0020011 integer,   -- Two or More Races
    p0020012 integer,   -- Population of two races
    p0020028 integer,   -- Population of three races
    p0020049 integer,   -- Population of four races
    p0020065 integer,   -- Population of five races
    p0020072 integer,   -- Population of six races

    -- This section is referred to as P3. RACE FOR THE POPULATION 18 YEARS AND OVER
    p0030001 integer,   -- Total
    p0030002 integer,   -- Population of one race:
    p0030003 integer,       -- White alone
    p0030004 integer,       -- Black or African American alone
    p0030005 integer,       -- American Indian and Alaska Native alone
    p0030006 integer,       -- Asian alone
    p0030007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0030008 integer,       -- Some Other Race alone
    p0030009 integer,   -- Two or More Races
    p0030010 integer,   -- Population of two races
    p0030026 integer,   -- Population of three races
    p0030047 integer,   -- Population of four races
    p0030063 integer,   -- Population of five races
    p0030070 integer,   -- Population of six races

    -- This section is referred to as P4. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    -- FOR THE POPULATION 18 YEARS AND OVER
    p0040001 integer,   -- Total
    p0040002 integer,   -- Hispanic or Latino
    p0040003 integer,   -- Not Hispanic or Latino:
    p0040004 integer,   -- Population of one race:
    p0040005 integer,   -- White alone
    p0040006 integer,   -- Black or African American alone
    p0040007 integer,   -- American Indian and Alaska Native alone
    p0040008 integer,   -- Asian alone
    p0040009 integer,   -- Native Hawaiian and Other Pacific Islander alone
    p0040010 integer,   -- Some Other Race alone
    p0040011 integer,   -- Two or More Races
    p0040012 integer,   -- Population of two races
    p0040028 integer,   -- Population of three races
    p0040049 integer,   -- Population of four races
    p0040065 integer,   -- Population of five races
    p0040072 integer,   -- Population of six races

    -- This section is referred to as H1. OCCUPANCY STATUS
    h0010001 integer,   -- Total housing units
    h0010002 integer,   -- Occupied
    h0010003 integer    -- Vacant
);
select geo_name, state_us_abbreviation, area_land
from us_counties_2010
order by area_land desc
limit 3;

#Practical SQL Chapter 5 Basic Math And Stats With SQL
select geo_name, state_us_abbreviation as "St", p0010003 as "White", p0010004 as "Black", p0010003+p0010004 as "White And Black"
from us_counties_2010;
select sum(p0010001) as "Country Sum", round(avg(p0010001),0) as "Country Average zero decimals", round(avg(p0010001),2) as "Country Average two decimals"
from us_counties_2010;
/*
Country Sum 	Country Average zero decimals	Country Average two decimals
308745538	98202	98201.51
*/

#Practical SQL Chapter 6 Joining Tables In A Relational Database
create table departments (dept_id integer, dept varchar(100), city varchar(100), constraint dept_id_key primary key (dept_id), constraint dept_id_city_unique unique (dept, city));
insert into departments (dept_id, dept, city)
values (1, 'tax', 'atlanta'), (2, 'it', 'boston');
create table employees (emp_id integer, first_name varchar(100), last_name varchar(100), salary integer, dept_id integer references departments (dept_id), constraint emp_id_key primary key (emp_id), constraint emp__id_dept_id_unique unique (emp_id, dept_id));
insert into employees (emp_id, first_name, last_name, salary, dept_id)
values (1, 'Nancy', 'Jones', 62500, 1), (2, 'Lee', 'Smith', 59300, 1), (3, 'Soo', 'Nguyen', 83000, 2), (4, 'Janet', 'King', 95000, 2);
select *
from employees join departments
on employees.dept_id = departments.dept_id;
/*
join:  returns rows from both tables where matching values are found in the joined columns of both tables.
inner join:  returns rows from both tables where matching values are found in the joined columns of both tables
left join:  returns every row from the left table plus rows that match values in the joined column from the right table.  When a left table row doesn't have a match in the right table, the result shows no values from the right table.
right join:  returns every row from the right table plus rows that match values in the joined column from the left table.  When a right table row doesn't have a match in the left table, the result shows no values from the left table.
full outer join:  returns every row from both tables and matches rows; then joins the rows where values in the joined columns match.  If there's no match for a value in either the left table or right table, the query result contains an empty row for the other table.  See all rows from both tables regardless of whether any match.
cross join:  returns every possible combination of rows from both tables.
*/
create table schools_left (id integer, constraint id_key primary key (id), left_school varchar(30));
insert into schools_left (id, left_school)
values (1, 'Oak Street School'), (2, 'Roosevelt High School'), (5, 'Washington Middle School'), (6, 'Jefferson High School');
create table schools_right (id integer, constraint id_key primary key (id), right_school varchar(30));
insert into schools_right (id, right_school)
values (1, 'Oak Street School'), (2, 'Roosevelt High School'), (3, 'Morrison Elementary'), (4, 'Chase Magnet Academy'), (6, 'Jefferson High School');
select *
from schools_left join schools_right
on schools_left.id = schools_right.id;
select *
from schools_left left join schools_right
on schools_left.id = schools_right.id;
select *
from schools_left right join schools_right
on schools_left.id = schools_right.id;
select *
from schools_left full outer join schools_right
on schools_left.id = schools_right.id;
select *
from schools_left cross join schools_right;
#find missing data or find missing rows use null.  Filter to show all rows without a match.
select *
from schools_left left join schools_right
on schools_left.id = schools_right.id
where schools_right.id is null;
/*
id 	left_school id 	right_school
5 Washington Middle School NULL NULL
*/
select schools_left.id, schools_left.left_school, schools_right.right_school
from schools_left left join schools_right
on schools_left.id = schools_right.id;
select sl.id, sl.left_school, sr.right_school
from schools_left sl left join schools_right sr
on sl.id = sr.id;
create table schools_enrollment (id integer, enrollment integer);
insert into schools_enrollment (id, enrollment)
values (1, 360), (2, 1001), (5, 450), (6, 927);
create table schools_grades (id integer, grades varchar(10));
insert into schools_grades (id, grades)
values (1, 'k-3'), (2, '9-12'), (5, '6-8'), (6, '9-12');
select sl.id, sl.left_school, se.enrollment, sg.grades
from schools_left sl join schools_enrollment se
on sl.id = se.id
join schools_grades sg
on sl.id = sg.id;

#Practical SQL Chapter 7 Table Design That Works For You
create table albums (album_id bigserial, album_catalog_code varchar(100), album_title text, album_aritst text, album_release_date date, album_genre varchar(40), album_description text);
create table songs (song_id bigserial, song_title text, song_artist text, album_id bigint);

create table albums (album_id bigserial, constraint albumidpk primary key (album_id), album_catalog_code varchar(100) not null, album_title text not null, album_aritst text not null, album_release_date date, album_genre varchar(40), album_description text);
create table songs (song_id bigserial, song_title text not null, song_artist text not null, album_id bigint references albums (album_id) on delete cascade, constraint songidpk primary key (song_id));  #on delete cascade to delete the rows in songs when the albums table deletes its rows.

#Practical SQL Chapter 8 Extracting Information By Grouping And Summarizing
select count(*)
from pls_fy2014_pupld14a;
select count(*)
from pls_fy2009_pupld09a;
select count(libname)
from pls_fy2014_pupld14a;
select count(distinct libname)
from pls_fy2014_pupld14a;
select max(visits), min(visits)
from pls_fy2014_pupld14a;
select city, stabr
from pls_fy2014_pupld14a
group by city, stabr
order by city, stabr;
select stabr, count(*)
from pls_fy2014_pupld14a
group by stabr
order by count(*) desc;
select stabr, stataddr, count(*)
from pls_fy2014_pupld14a
group by stabr, stataddr
order by stabr asc, count(*) desc;
select sum(visits) as visits_2014
from pls_fy2014_pupld14a
where visits >=0; #-1 means nonresponse and -3 means not applicable in visits
select sum(visits) as visits_2009
from pls_fy2009_pupld09a
where visits >=0; #-1 means nonresponse and -3 means not applicable in visits
select sum(pls14.visits) as visits_2014, sum(pls09.visits) as visits_2009
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.visits >=0  and pls09.visits >=0; #-1 means nonresponse and -3 means not applicable in visits.  Book stated Although we joined the tables on fscskey, it’s entirely possible that some library agencies that appear in both tables merged or split between 2009 and 2014. A call to the IMLS asking about caveats for working with this data is a good idea.
select pls14.stabr, sum(pls14.visits) as visits_2014, sum(pls09.visits) as visits_2009, round(((sum(pls14.visits) - sum(pls09.visits))/sum(pls09.visits))*100,2) as pct_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.visits >=0  and pls09.visits >=0 #-1 means nonresponse and -3 means not applicable in visits.  Book stated Although we joined the tables on fscskey, it’s entirely possible that some library agencies that appear in both tables merged or split between 2009 and 2014. A call to the IMLS asking about caveats for working with this data is a good idea.
group by pls14.stabr
order by pct_change desc;
select pls14.stabr, sum(pls14.visits) as visits_2014, sum(pls09.visits) as visits_2009, round(((sum(pls14.visits) - sum(pls09.visits))/sum(pls09.visits))*100,2) as pct_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey = pls09.fscskey
where pls14.visits >=0  and pls09.visits >=0 #-1 means nonresponse and -3 means not applicable in visits.  Book stated Although we joined the tables on fscskey, it’s entirely possible that some library agencies that appear in both tables merged or split between 2009 and 2014. A call to the IMLS asking about caveats for working with this data is a good idea.
group by pls14.stabr
having sum(pls14.visits) > 50000000
order by pct_change desc;