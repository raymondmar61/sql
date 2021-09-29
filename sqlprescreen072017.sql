#RM:  save time run the create table and the insert into values SQL together.
#cPanel-->Databases-->MySQL Databases.  Under Create New Database, type database name at New Database: _*database name*.  Press Create Database.
#phpMyAdmin sqlprescreen072017 database
#Create views table
create table views
    (viewdate date, ad_id varchar(20), user_id varchar(15));
insert into views
values('2016-12-26','awesome_movie','carly090');
insert into views
values('2016-12-30','free_book','tom456');
insert into views
values('2017-03-24','bad_newspaper','jenny234');
insert into views
values('2016-12-13','decent_magazine','carly090');
insert into views
values('2016-12-25','decent_magazine','meghan111');
insert into views
values('2017-02-22','good_movie','jenny234');
insert into views
values('2016-12-09','free_book','bob123');
insert into views
values('2017-02-21','great_pamphlet','tom456');
insert into views
values('2016-12-08','bad_newspaper','tom456');
insert into views
values('2017-01-15','good_movie','carly090');
insert into views
values('2017-02-17','decent_magazine','meghan111');
insert into views
values('2017-01-18','good_movie','tom456');
insert into views
values('2016-12-02','bad_newspaper','simon789');
insert into views
values('2016-12-05','great_pamphlet','green023');
insert into views
values('2017-02-28','decent_magazine','green023');
insert into views
values('2016-12-21','decent_magazine','tom456');
insert into views
values('2016-12-01','awesome_movie','meghan111');
insert into views
values('2017-02-28','bad_newspaper','buster028');
insert into views
values('2017-02-02','great_pamphlet','simon789');
insert into views
values('2017-02-13','awesome_movie','paula765');
insert into views
values('2016-12-21','free_book','meghan111');
insert into views
values('2016-12-11','bad_newspaper','jenny234');
insert into views
values('2017-02-19','bad_newspaper','bob123');
insert into views
values('2017-02-12','decent_magazine','green023');
insert into views
values('2016-12-17','awesome_movie','paula765');
insert into views
values('2017-02-01','awesome_movie','bob123');
insert into views
values('2017-02-01','awesome_movie','jenny234');
insert into views
values('2017-02-02','free_book','simon789');
insert into views
values('2017-02-03','awesome_movie','mary123');
insert into views
values('2017-01-15','great_pamphlet','bob123');

#Create clicks table
create table clicks
    (clickdate date, ad_id varchar(20), user_id varchar(15));
insert into clicks
values('2017-03-24','bad_newspaper','jenny234');
insert into clicks
values('2017-02-21','great_pamphlet','tom456');
insert into clicks
values('2016-12-08','bad_newspaper','tom456');
insert into clicks
values('2017-02-17','decent_magazine','meghan111');
insert into clicks
values('2017-01-18','good_movie','tom456');
insert into clicks
values('2017-02-28','decent_magazine','green023');
insert into clicks
values('2016-12-21','decent_magazine','tom456');
insert into clicks
values('2016-12-01','awesome_movie','meghan111');
insert into clicks
values('2017-02-28','bad_newspaper','buster028');
insert into clicks
values('2017-02-02','great_pamphlet','simon789');
insert into clicks
values('2017-02-12','decent_magazine','green023');
insert into clicks
values('2017-02-01','awesome_movie','bob123');
insert into clicks
values('2017-02-03','awesome_movie','mary123');

#1. How many unique users viewed 1 or more ads on Feb 7, 2017?  RM:  there were none on Feb 7, 2017?  Change question to Dec 2016.
select count(distinct user_id)
from views
where viewdate = '2017-02-07';
select count(distinct user_id)
from views
where viewdate >='2016-12-01' and viewdate <='2016-12-31';

#2. Which ad got the most clicks in the month of January?  RM:  there was one on Jan 18, 2017?  Change question to month of February.
select ad_id, count(*)
from clicks
where clickdate between '2017-02-01' and '2017-02-28'
group by ad_id
order by count(*) desc;
/*
ad_id   count(*)    
decent_magazine 3   
awesome_movie   2   
great_pamphlet  2   
bad_newspaper   1   
*/
select ad_id, count(*)
from clicks
where clickdate between '2017-02-01' and '2017-02-28'
group by ad_id
order by count(*) desc limit 2;
/*
ad_id   count(*)    
decent_magazine 3   
great_pamphlet  2   
*/

#3. Which ad has the highest click through rate of all time?
select ad_id, count(ad_id)
from clicks
group by ad_id;
/*
ad_id   count(ad_id)    
awesome_movie   3   
bad_newspaper   3   
decent_magazine 4   
good_movie  1   
great_pamphlet  2   
*/
select ad_id, count(ad_id)
from views
group by ad_id;
/*
ad_id   count(ad_id)    
awesome_movie   7   
bad_newspaper   6   
decent_magazine 6   
free_book   4   
good_movie  3   
great_pamphlet  4   
*/
#double tables in from statement or multiple tables in from statement
select *
from (
    select ad_id, count(ad_id)
    from clicks
    group by ad_id) as clickstablefromtable,
    (select ad_id, count(ad_id)
    from views
    group by ad_id) as viewstablefromtable
where clickstablefromtable.ad_id=viewstablefromtable.ad_id;
/*
ad_id   count(ad_id)    ad_id   count(ad_id)    
awesome_movie   3   awesome_movie   7   
bad_newspaper   3   bad_newspaper   6   
decent_magazine 4   decent_magazine 6   
good_movie  1   good_movie  3   
great_pamphlet  2   great_pamphlet  4   
*/
select clickstablefromtable.ad_id, clickstablefromtable.clickscount
from (
    select ad_id, count(ad_id) as "clickscount"
    from clicks
    group by ad_id) as clickstablefromtable,
    (select ad_id, count(ad_id) as "viewscount"
    from views
    group by ad_id) as viewstablefromtable
where clickstablefromtable.ad_id=viewstablefromtable.ad_id;
/*
ad_id   clickscount 
awesome_movie   3   
bad_newspaper   3   
decent_magazine 4   
good_movie  1   
great_pamphlet  2   
*/
select clickstablefromtable.ad_id, clickstablefromtable.clickscount, viewstablefromtable.viewscount, round(clickstablefromtable.clickscount/viewstablefromtable.viewscount,3) as percentageclicked
from (
    select ad_id, count(ad_id) as "clickscount"
    from clicks
    group by ad_id) as clickstablefromtable,
    (select ad_id, count(ad_id) as "viewscount"
    from views
    group by ad_id) as viewstablefromtable
where clickstablefromtable.ad_id=viewstablefromtable.ad_id
order by percentageclicked desc;
/*
ad_id   clickscount viewscount  percentageclicked       
decent_magazine 4   6   0.667   
great_pamphlet  2   4   0.500   
bad_newspaper   3   6   0.500   
awesome_movie   3   7   0.429   
good_movie  1   3   0.333   
*/

#4. Generate a list of all user_ids. Label each user as either "viewer only" (for users who have viewed ads but never clicked an ad) or "clicker" (for users who have ever clicked on an ad). Result will be a 2 column table.
select ad_id, user_id || ' is a clicker'
from clicks
union
select ad_id, user_id || ' is a viewer only'
from views;
/*

ad_id   user_id || ' is a clicker'  
bad_newspaper   0   
great_pamphlet  0   
decent_magazine 0   
good_movie  0   
awesome_movie   0   
free_book   0   
*/
select user_id,' is a clicker'
from clicks
union
select user_id,' is a viewer only'
from views;
/*
user_id is a clicker    
jenny234     is a clicker   
tom456   is a clicker   
meghan111    is a clicker   
green023     is a clicker   
buster028    is a clicker   
simon789     is a clicker   
bob123   is a clicker   
mary123  is a clicker   
carly090     is a viewer only   
tom456   is a viewer only   
jenny234     is a viewer only   
meghan111    is a viewer only   
bob123   is a viewer only   
simon789     is a viewer only   
green023     is a viewer only   
buster028    is a viewer only   
paula765     is a viewer only   
mary123  is a viewer only   
*/
select distinct concat(user_id,' clicker')
from clicks;
/*
concat(user_id,' clicker')  
jenny234 clicker    
tom456 clicker  
meghan111 clicker   
green023 clicker    
buster028 clicker   
simon789 clicker    
bob123 clicker  
mary123 clicker 
*/
select distinct user_id,' is a clicker'
from clicks;
/*
user_id is a clicker    
jenny234     is a clicker   
tom456   is a clicker   
meghan111    is a clicker   
green023     is a clicker   
buster028    is a clicker   
simon789     is a clicker   
bob123   is a clicker   
mary123  is a clicker   
*/
select distinct user_id,'clicker label' as labelcolumn
from clicks;
/*
user_id labelcolumn   
jenny234    clicker label   
tom456  clicker label   
meghan111   clicker label   
green023    clicker label   
buster028   clicker label   
simon789    clicker label   
bob123  clicker label   
mary123 clicker label   
*/
select distinct user_id,'views only label' as labelcolumn
from views;
/*
user_id labelcolumn    
carly090    views only label    
tom456  views only label    
jenny234    views only label    
meghan111   views only label    
bob123  views only label    
simon789    views only label    
green023    views only label    
buster028   views only label    
paula765    views only label    
mary123 views only label    
*/
select *
from (
    select distinct user_id,'clicker label' as labelcolumn
    from clicks) as fromstatementtablenameclicks right join
    (select distinct user_id,'views only label' as labelcolumn
    from views) as fromstatementtablenameviews
on fromstatementtablenameclicks.user_id = fromstatementtablenameviews.user_id;
/*
user_id labelcolumn user_id labelcolumn 
NULL NULL carly090    views only label    
tom456  clicker label   tom456  views only label    
jenny234    clicker label   jenny234    views only label    
meghan111   clicker label   meghan111   views only label    
bob123  clicker label   bob123  views only label    
simon789    clicker label   simon789    views only label    
green023    clicker label   green023    views only label    
buster028   clicker label   buster028   views only label    
NULL NULL paula765    views only label    
mary123 clicker label   mary123 views only label    
*/
#RM:  MySql does not recognise MINUS and INTERSECT, these are Oracle based operations. In MySql a user can use NOT IN as MINUS (other solutions are also there, but I liked it lot).  MySQL Does not supports MINUS or EXCEPT,You can use NOT EXISTS , NULL or NOT IN.  https://stackoverflow.com/questions/31397313/trying-to-perform-minus-operation-in-mysql
select distinct views.user_id,'views only label'
from views
where views.user_id not in (
    select distinct clicks.user_id
    from clicks);
/*
user_id views only label    
carly090    views only label    
paula765    views only label    
*/
select distinct clicks.user_id,'clicker label'
from clicks
/*
user_id clicker label   
jenny234    clicker label   
tom456  clicker label   
meghan111   clicker label   
green023    clicker label   
buster028   clicker label   
simon789    clicker label   
bob123  clicker label   
mary123 clicker label   
*/
select distinct views.user_id,'views only label'
from views
where views.user_id not in (
    select distinct clicks.user_id
    from clicks)
union
select distinct clicks.user_id,'clicker label'
from clicks
/*
user_id views only label    
carly090    views only label    
paula765    views only label    
jenny234    clicker label   
tom456  clicker label   
meghan111   clicker label   
green023    clicker label   
buster028   clicker label   
simon789    clicker label   
bob123  clicker label   
mary123 clicker label   
*/