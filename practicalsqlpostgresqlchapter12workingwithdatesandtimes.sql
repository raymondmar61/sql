--Practical SQL By Anthony DeBarros Second Edition Chapter 12 Working With Dates And Times

--date_part(text, value) extract a date or time such as month, year, or minute
--'2022-12-25 18:37:12 EST' is a string case as a timestamp with timezone with the PostgreSQL double colonr syntax and the timestamptz short for timestamp with time zone 
select date_part('year','2022-12-25 18:37:12 EST'::timestamptz) as year; --print 2022
select date_part('month','2022-12-25 18:37:12 EST'::timestamptz) as month; --print 12
select date_part('day','2022-12-25 18:37:12 EST'::timestamptz) as day; --print 25
select date_part('hour','2022-12-25 18:37:12 EST'::timestamptz) as "hour EST"; --print 15 #RM:  must be time zones EST and my PST
select date_part('hour','2022-12-25 18:37:12 PST'::timestamptz) as "hour PST"; --print 18 #RM:  changed time zones from EST to PST
select date_part('minute','2022-12-25 18:37:12 EST'::timestamptz) as minute; --print 37
select date_part('seconds','2022-12-25 18:37:12 EST'::timestamptz) as seconds; --print 12
select date_part('timezone_hour','2022-12-25 18:37:12 EST'::timestamptz) as timezone; --print -8 #RM:  EST is -5.  PST -8 is from my computer.
select date_part('week','2022-12-25 18:37:12 EST'::timestamptz) as week; --print 51
select date_part('quarter','2022-12-25 18:37:12 EST'::timestamptz) as quarter; --print 4
select date_part('epoch','2022-12-25 18:37:12 EST'::timestamptz) as epoch; --print 1672011432
--timezone_hour prints the hours difference or offset from the Coordinated Universal Time.  -8 is Pacific Daylight Time Zone.  -9 is Pacific Standard Time Zone.  Monday is the first day in a week.  The epoch column represents the number of seconds elapsed before or ater 12am January 1, 1970.
--extract() isn't widly supported by other database managers such as SQLL Server
select extract(year from '2022-12-25 18:37:12 EST'::timestamptz) as "year using extract()"; --print 2022
select make_date(2022,12,25) as "return a value of date type (yyyy,mm,dd)";  --print 2022-12-25
select make_time(18,4,30.3) as "return a value of time type 24 hour format (18,4,30.3) (hour,minute,second.milisecond)"; --print 18:04:30.3
select make_timestamptz(2022,12,25,18,4,30.3,'America/New_York');  --print 2022-12-25 15:04:30.3-08 for which -08 is the Pacific time zone UTC even though I set time zone to America/New_York
'''
current_timestamp returns the current timestamp with time zone.  now() is valid.
localtimestamp returns the current timestamp without time zone.
current_date returns the date.
current_time returns the current time with time zone; however, the time alone is useless becaues there is no date.
localtime returns the current time without time zone.
clock_timestamp() function returns the current time as the time elapses.
'''
show timezone; #print America/Los_Angeles
select current_setting('timezone') as "View current time zone setting"; #print America/Los_Angeles
select make_timestamptz(2022,12,25,18,4,30.3,current_setting('timezone'));  --print 2022-12-25 15:04:30.3-08 for which -08 is the Pacific time zone UTC
--Retrieve all time zone abbreviations or names and their UTC offsets.  Authors says faster than looking up Wikipedia
select *
from pg_timezone_abbrevs;
select *
from pg_timezone_names;
create table nycyellowtaxitrips
(tripid bigint generated always as identity primary key, vendorid text not null, tpeppickupdatetime timestamptz not null, tpepdropoffdatetime timestamptz not null, passengercount integer not null, tripdistance numeric(8,2) not null, pickuplongitude numeric(18,15) not null, pickuplatitude numeric(18,15) not null, ratecodeid text not null, storeandfwdflag text not null, dropofflongitude numeric(18,15) not null, dropofflatitude numeric(18,15) not null, paymenttype text not null, fareamount numeric(9,2) not null, extra numeric(9,2) not null, mtatax numeric(5,2) not null, tipamount numeric(9,2) not null, tollsamount numeric(9,2) not null, improvementsurcharge numeric(9,2) not null, totalamount numeric(9,2) not null);
copy nycyellowtaxitrips
(vendorid, tpeppickupdatetime, tpepdropoffdatetime, passengercount, tripdistance, pickuplongitude, pickuplatitude, ratecodeid, storeandfwdflag, dropofflongitude, dropofflatitude, paymenttype, fareamount, extra, mtatax, tipamount, tollsamount, improvementsurcharge, totalamount)
from '/home/mar/postgresql/nyc_yellow_taxi_trips.csv'
with (format csv, header);
create index tpep_pickup_idx
on nycyellowtaxitrips (tpeppickupdatetime);
select count(*)
from nycyellowtaxitrips; #print 368744
set time zone 'US/Eastern'; --Change time zone to Eastern Time Zone
select date_part('hour',tpeppickupdatetime) as "Hour Count Rides By Hour", count(*)
from nycyellowtaxitrips
group by 1
order by 1;
'''
"Hour Count Rides By Hour"	"count"
0	8182
1	5003
2	3070
3	2275
4	2229
5	3925
6	10825
...
'''
select date_part('hour',tpeppickupdatetime) as "Hour Median trip Length By Hour", percentile_cont(.5) within group (order by tpepdropoffdatetime-tpeppickupdatetime) as "Median Trip"
from nycyellowtaxitrips
group by 1
order by 1;
'''
"Hour Median trip Length By Hour"	"Median Trip"
0	"00:10:04"
1	"00:09:27"
2	"00:08:59"
3	"00:09:57"
4	"00:10:06"
5	"00:07:37"
6	"00:07:54"
...
'''
create table trainrides
(tripid bigint generated always as identity primary key, segment text not null, departure timestamptz not null, arrival timestamptz not null);
insert into trainrides (segment, departure, arrival)
values ('Chicago to New York', '2020-11-13 21:30 CST', '2020-11-14 18:23 EST'), ('New York to New Orleans', '2020-11-15 14:15 EST', '2020-11-16 19:32 CST'), ('New Orleans to Los Angeles', '2020-11-17 13:45 CST', '2020-11-18 9:00 PST'), ('Los Angeles to San Francisco', '2020-11-19 10:10 PST', '2020-11-19 21:24 PST'), ('San Francisco to Denver', '2020-11-20 9:10 PST', '2020-11-21 18:38 MST'), ('Denver to Chicago', '2020-11-22 19:10 MST', '2020-11-23 14:50 CST');
set time zone 'US/Central';
select *
from trainrides;
'''
"tripid"	"segment"	"departure"	"arrival"
1	"Chicago to New York"	"2020-11-13 21:30:00-06"	"2020-11-14 17:23:00-06"
2	"New York to New Orleans"	"2020-11-15 13:15:00-06"	"2020-11-16 19:32:00-06"
3	"New Orleans to Los Angeles"	"2020-11-17 13:45:00-06"	"2020-11-18 11:00:00-06"
4	"Los Angeles to San Francisco"	"2020-11-19 12:10:00-06"	"2020-11-19 23:24:00-06"
5	"San Francisco to Denver"	"2020-11-20 11:10:00-06"	"2020-11-21 19:38:00-06"
6	"Denver to Chicago"	"2020-11-22 20:10:00-06"	"2020-11-23 14:50:00-06"
'''
select segment, to_char(departure, 'yyyy-mm-dd HH12:MI a.m. TZ') as "Convert to string 12 hour clock", arrival - departure as "Calculate train duration"
from trainrides;  --RM: Look at the second column for the 12 hour clock.  Don't look at the calculation.
'''
"segment"	"Convert to string 12 hour clock"	"Calculate train duration"
"Chicago to New York"	"2020-11-13 09:30 p.m. CST"	"19:53:00"
"New York to New Orleans"	"2020-11-15 01:15 p.m. CST"	"1 day 06:17:00"
"New Orleans to Los Angeles"	"2020-11-17 01:45 p.m. CST"	"21:15:00"
"Los Angeles to San Francisco"	"2020-11-19 12:10 p.m. CST"	"11:14:00"
"San Francisco to Denver"	"2020-11-20 11:10 a.m. CST"	"1 day 08:28:00"
"Denver to Chicago"	"2020-11-22 08:10 p.m. CST"	"18:40:00"
'''
select segment, departure, arrival, arrival - departure as "Calculate train duration"
from trainrides;
'''
"segment"	"departure"	"arrival"	"Calculate train duration"
"Chicago to New York"	"2020-11-13 21:30:00-06"	"2020-11-14 17:23:00-06"	"19:53:00"
"New York to New Orleans"	"2020-11-15 13:15:00-06"	"2020-11-16 19:32:00-06"	"1 day 06:17:00"
"New Orleans to Los Angeles"	"2020-11-17 13:45:00-06"	"2020-11-18 11:00:00-06"	"21:15:00"
"Los Angeles to San Francisco"	"2020-11-19 12:10:00-06"	"2020-11-19 23:24:00-06"	"11:14:00"
"San Francisco to Denver"	"2020-11-20 11:10:00-06"	"2020-11-21 19:38:00-06"	"1 day 08:28:00"
"Denver to Chicago"	"2020-11-22 20:10:00-06"	"2020-11-23 14:50:00-06"	"18:40:00"
'''
select segment, arrival - departure as "Calculate train duration", sum(arrival-departure) over (order by tripid) as "Cumulative sum train duration"
from trainrides;
'''
"segment"	"Calculate train duration"	"Cumulative sum train duration"
"Chicago to New York"	"19:53:00"	"19:53:00"
"New York to New Orleans"	"1 day 06:17:00"	"1 day 26:10:00"
"New Orleans to Los Angeles"	"21:15:00"	"1 day 47:25:00"
"Los Angeles to San Francisco"	"11:14:00"	"1 day 58:39:00"
"San Francisco to Denver"	"1 day 08:28:00"	"2 days 67:07:00"
"Denver to Chicago"	"18:40:00"	"2 days 85:47:00"
'''
select segment, arrival - departure as "Calculate train duration", justify_interval(sum(arrival-departure) over (order by tripid)) as "Cumulative sum train duration standardize 24 hours to days and 30 days to months"
from trainrides;
'''
"segment"	"Calculate train duration"	"Cumulative sum train duration standardize 24 hours to days and "
"Chicago to New York"	"19:53:00"	"19:53:00"
"New York to New Orleans"	"1 day 06:17:00"	"2 days 02:10:00"
"New Orleans to Los Angeles"	"21:15:00"	"2 days 23:25:00"
"Los Angeles to San Francisco"	"11:14:00"	"3 days 10:39:00"
"San Francisco to Denver"	"1 day 08:28:00"	"4 days 19:07:00"
"Denver to Chicago"	"18:40:00"	"5 days 13:47:00"
'''
from trainrides;