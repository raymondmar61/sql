#Chapter 11 Working With Dates And Times (p 171)
/*  Four data types related to dates and times.  
date records the date only.  Default is YYYY-MM-DD.
time records the time only.  HH:MM:SS.
timestamp records the data and time YYYY-MM-DD HH:MM:SS.  You can use timestamp with time zone or timestamptz to make the column time zone aware YYYY-MM-DD HH:MM:SS TZ.
interval holds a value that represents a unit of time expressed in the format quantity unit.  It doesn't record the start or end of a period.  It records its duration.  e.g. 12 days or 8 hours.
*/

#date_part(text, value) extract the components of a timestamp.  The text format represents the part of the date or time to extract such as hour, minute, or week.  The value is the date, time, or timestamp.
#format the select statement below string as a timestamp with time zone or timestamptz.
SELECT
    date_part('year', '2019-12-01 18:37:12 EST'::timestamptz) AS "year 2019",
    date_part('month', '2019-12-01 18:37:12 EST'::timestamptz) AS "month 12",
    date_part('day', '2019-12-01 18:37:12 EST'::timestamptz) AS "day 1",
    date_part('hour', '2019-12-01 18:37:12 EST'::timestamptz) AS "hour 18",
    date_part('minute', '2019-12-01 18:37:12 EST'::timestamptz) AS "minute 37",
    date_part('seconds', '2019-12-01 18:37:12 EST'::timestamptz) AS "seconds 12",
    date_part('timezone_hour', '2019-12-01 18:37:12 EST'::timestamptz) AS "tz -5",
    date_part('week', '2019-12-01 18:37:12 EST'::timestamptz) AS "week 48",
    date_part('quarter', '2019-12-01 18:37:12 EST'::timestamptz) AS "quarter 4",
    date_part('epoch', '2019-12-01 18:37:12 EST'::timestamptz) AS "epoch 1575243432";  --UTC is -5 which means EST five hours behind Coordinated Universal Time.  epoch is the number of seconds after 01/01/1970 12:00am.
SELECT extract('year' from '2019-12-01 18:37:12 EST'::timestamptz) AS "year 2019";  --Bonus: Using the SQL-standard extract() for similar datetime parsing.

#create datetime values make_date(), make_time(), make_timestamptz()
select make_date(2018, 2, 22) as "year, month, day as date datatype 2018-02-22";
select make_time(18, 40, 30.3) as "hour, minute, second as time without time zone datatype 18:40:30.3";
select make_timestamptz(2018, 2, 22, 18, 4, 30.3, 'Europe/Lisbon') as "year, month, day, hour, minute, second, time zone as timestamp with time zone datatype 2018-02-22 10:04:30.3-08";

#retrieve current date and time current_date, current_time, current_timestamp or now(), localtime, localtimestamp
create table current_time_example (time_id bigserial, current_timestamp_col timestamp with time zone, clock_timestamp_col timestamp with time zone);
insert into current_time_example (current_timestamp_col, clock_timestamp_col)
	select (current_timestamp, clock_timestamp()
	from generate_series(1,1000));  --generate_series(start, stop) returns a set of integers starting with 1 and ending with 1,000.
select current_timestamp_col as "current_timestamp recorded time at start", clock_timestamp_col as "clock_timestamp() recorded time at insertion of each row"
from current_time_example;
--bonus
select date_part('year',current_timestamp_col) || '-' || date_part('month',current_timestamp_col) || '-' || date_part('day',current_timestamp_col) as "YYYY-M-D", date_part('month',current_timestamp_col) || '/' || date_part('day',current_timestamp_col) || '/' || date_part('year',current_timestamp_col) as "M/D/YYYY"
from current_time_example;
drop table current_time_example;

SELECT
    current_date as "date 2018-06-18",
    current_time as "time with timezone 19:04:13.925412-07:00",
    current_timestamp as "date and time with timezone 2018-06-18 19:04:13.925412-07",
    localtime "time without timezone 19:04:13.925412",
    localtimestamp "date and time without timezone 2018-06-18 19:04:13.925412",
    now() as "short for current_timestamp date and time with timezone 2018-06-18 19:04:13.925412-07";

#RM:  skipped Time Zones p 177-180

#calculations with date and times
select '9/30/2019'::date - '9/27/2019'::date as "return 3";
CREATE TABLE nyc_yellow_taxi_trips_2016_06_01 (trip_id bigserial PRIMARY KEY, vendor_id varchar(1) NOT NULL, tpep_pickup_datetime timestamp with time zone NOT NULL, tpep_dropoff_datetime timestamp with time zone NOT NULL, passenger_count integer NOT NULL, trip_distance numeric(8,2) NOT NULL, pickup_longitude numeric(18,15) NOT NULL, pickup_latitude numeric(18,15) NOT NULL, rate_code_id varchar(2) NOT NULL, store_and_fwd_flag varchar(1) NOT NULL, dropoff_longitude numeric(18,15) NOT NULL, dropoff_latitude numeric(18,15) NOT NULL, payment_type varchar(1) NOT NULL, fare_amount numeric(9,2) NOT NULL, extra numeric(9,2) NOT NULL, mta_tax numeric(5,2) NOT NULL, tip_amount numeric(9,2) NOT NULL, tolls_amount numeric(9,2) NOT NULL, improvement_surcharge numeric(9,2) NOT NULL, total_amount numeric(9,2) NOT NULL);
COPY nyc_yellow_taxi_trips_2016_06_01 (vendor_id, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count, trip_distance, pickup_longitude, pickup_latitude, rate_code_id, store_and_fwd_flag, dropoff_longitude, dropoff_latitude, payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, total_amount)
FROM 'i:\program files\postgresql\yellow_tripdata_2016_06_01.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');
CREATE INDEX tpep_pickup_idx
ON nyc_yellow_taxi_trips_2016_06_01 (tpep_pickup_datetime);
SELECT count(*) 
FROM nyc_yellow_taxi_trips_2016_06_01;
select date_part('hour',tpep_pickup_datetime) as "trip by hour", count(*)
from nyc_yellow_taxi_trips_2016_06_01
group by "trip by hour"
order by "trip by hour" asc;  --count taxi trips grouped by hour
copy (
	select date_part('hour',tpep_pickup_datetime) as "trip by hour", count(*)
	from nyc_yellow_taxi_trips_2016_06_01
	group by "trip by hour"
	order by "trip by hour" asc)
to 'i:\program files\postgresql\hourly_pickups_2016_06_01.csv'
with (format csv, header, delimiter ',');  --export count taxi trips grouped by hour as a table CSV file to chart in Excel
select date_part('hour',tpep_pickup_datetime) as "trip by hour", percentile_cont(.5)
	within group (order by
	tpep_dropoff_datetime - tpep_pickup_datetime) as "median trip length"
from nyc_yellow_taxi_trips_2016_06_01
group by "trip by hour"
order by "trip by hour" asc;  --median trip time grouped by hour

#RM:  skipped Finding Patterns in Amtrak Data p 186-189