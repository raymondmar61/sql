#Chapter 08 Extracting Information By Grouping And Summarizing (p 113)
--pls=Public Library Survey
--pupld=Public Library Data
--a full list of PostgreSQL aggregates www.postgresql.org/docs/current/static/functions-aggregate.html

create table pls_fy2014_pupld14a (stabr varchar(2) not null, fscskey varchar(6) constraint fscskey2014_key primary key, libid varchar(20) not null, libname varchar(100) not null, obereg varchar(2) not null, rstatus integer not null, statstru varchar(2) not null, statname varchar(2) not null, stataddr varchar(2) not null, . . . );
CREATE TABLE pls_fy2014_pupld14a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2014_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl float NOT NULL,
    video_ph integer NOT NULL,
    video_dl float NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    elmatcir integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    yr_sub integer NOT NULL
);
create index libname2014_idx on pls_fy2014_pupld14a (libname);
create index stabr2014_idx on pls_fy2014_pupld14a (stabr);
create index city2014_idx on pls_fy2014_pupld14a (city);
create index visits2014_idx on pls_fy2014_pupld14a (visits);
copy pls_fy2014_pupld14a
from 'i:\program files\postgresql\pls_fy2014_pupld14a.csv'
with (format csv, header);

CREATE TABLE pls_fy2009_pupld09a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2009_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio integer NOT NULL,
    video integer NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    yr_sub integer NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL
);
CREATE INDEX libname2009_idx ON pls_fy2009_pupld09a (libname);
CREATE INDEX stabr2009_idx ON pls_fy2009_pupld09a (stabr);
CREATE INDEX city2009_idx ON pls_fy2009_pupld09a (city);
CREATE INDEX visits2009_idx ON pls_fy2009_pupld09a (visits);
COPY pls_fy2009_pupld09a
from 'i:\program files\postgresql\pls_fy2009_pupld09a.csv'
WITH (FORMAT CSV, HEADER);

select count(*)
from pls_fy2014_pupld14a; --print 9305
select count(*)
from pls_fy2009_pupld09a; --print 9299
select count(salaries)
from pls_fy2014_pupld14a; --print 5983

select count(libname)
from pls_fy2014_pupld14a; --print 9305
select count(distinct libname)
from pls_fy2014_pupld14a; --print 8515.  Distinct returns a list of unique values in one column or unique combinations of values in multiple columns
select count(*)
from pls_fy2014_pupld14a
where libname = 'OXFORD PUBLIC LIBRARY';  --print 9
select max(visits), min(visits)
from pls_fy2014_pupld14a;  --min(visits) printed -3 because -3 indicates "not applicable" when a library is closed.  RM:  an example data is not perfect because visits column with negative numbers.
select stabr
from pls_fy2014_pupld14a
group by stabr
order by stabr;  --stabr is state abbreviations
--same as because group by on its own eliminates duplicate values
select distinct stabr
from pls_fy2014_pupld14a
order by stabr;
select city, stabr
from pls_fy2014_pupld14a
group by city, stabr
order by city, stabr;
select stabr, count(*)
from pls_fy2014_pupld14a
group by stabr
order by count(*) desc;  --count number of agencies for each state or number of states sort biggest to smallest.  count(*) with asterisk includes null values.
select count()
from pls_fy2014_pupld14a;  --error message
select stabr, stataddr, count(*)
from pls_fy2014_pupld14a
group by stabr, stataddr
order by stabr asc, count(*) desc;

select sum(visits) as visits_2014
from pls_fy2014_pupld14a
where visits >= 0;
select sum(visits) as visits_2009
from pls_fy2009_pupld09a
where visits >= 0;
--add the visits sum(visits) where libraries existed in pls_fy2009_pupld09a and pls_fy2014_pupld14a or fscskey in both tables
select sum(pls14.visits) as visits_2014, sum(pls09.visits) as visits_2009
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey=pls09.fscskey
where pls14.visits >=0 and pls09.visits >=0;  --join and inner join are the same
select pls14.stabr, sum(pls09.visits) as visits_2009, sum(pls14.visits) as visits_2014, sum(pls14.visits)-sum(pls09.visits) as difference
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey=pls09.fscskey
where pls14.visits >=0 and pls09.visits >=0
group by pls14.stabr;
select pls14.stabr, sum(pls09.visits) as visits_2009, sum(pls14.visits) as visits_2014, round((cast(sum(pls14.visits) as decimal(10,1))-sum(pls09.visits)) / sum(pls09.visits) * 100, 2) as percent_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey=pls09.fscskey
where pls14.visits >=0 and pls09.visits >=0
group by pls14.stabr
order by percent_change desc;  --RM:  OK is at the bottom with -35.39.  A data analyst investigates what's driving the change.  Make phone calls.
--Filter aggregate functions use the having clause.  The having clause places conditions on groups created by aggregating.
select pls14.stabr, sum(pls09.visits) as visits_2009, sum(pls14.visits) as visits_2014, round((cast(sum(pls14.visits) as decimal(10,1))-sum(pls09.visits)) / sum(pls09.visits) * 100, 2) as percent_change
from pls_fy2014_pupld14a pls14 join pls_fy2009_pupld09a pls09
on pls14.fscskey=pls09.fscskey
where pls14.visits >=0 and pls09.visits >=0
group by pls14.stabr
having sum(pls14.visits) > 50000000  
order by percent_change desc;  --include rows with a sum of visits in 2014 greater than 50 million
#A sentence or bullet point one may say, "In the nation's largest states, visits decreased between 8 percent and 17 percent between 2009 and 2014."  RM:  I have been doing this.  However, one step better is investigating.