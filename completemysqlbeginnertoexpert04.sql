/* Complete MySQL Beginner to Expert [en6YPAgc6WM] */
/* Fourth file */
drop database instagram;
create database igclone;
use igclone;
create table users (id integer auto_increment primary key, username varchar(255) unique not null, createdat timestamp default now());
describe users;
/*
# Field	Type	Null	Key	Default	Extra
id	int	NO	PRI		auto_increment
username	varchar(255)	NO	UNI		
createdat	timestamp	YES		CURRENT_TIMESTAMP	DEFAULT_GENERATED
*/
insert into users (username)
values('BlueTheCat'),('CharlieBrown'),('ColtSteele');
select *
from users;
/*
# id	username	createdat
1	BlueTheCat	2023-04-20 12:38:29
2	CharlieBrown	2023-04-20 12:38:29
3	ColtSteele	2023-04-20 12:38:29
*/
create table photos (id integer auto_increment primary key, imageurl varchar(255) not null, userid integer not null, createdat timestamp default now(), foreign key(userid) references users(id));
describe photos;
/*
# Field	Type	Null	Key	Default	Extra
id	int	NO	PRI		auto_increment
imageurl	varchar(255)	NO			
userid	int	NO	MUL		
createdat	timestamp	YES		CURRENT_TIMESTAMP	DEFAULT_GENERATED
*/
insert into photos (imageurl, userid)
values('/alskjd76',1),('/lkajsd98',2),('/90jddlkj',2);
select *
from photos;
/*
# id	imageurl	userid	createdat
1	/alskjd76	1	2023-04-20 12:48:38
2	/lkajsd98	2	2023-04-20 12:48:38
3	/90jddlkj	2	2023-04-20 12:48:38
*/
select photos.imageurl, users.username
from photos join users
on photos.userid = users.id;
/*
# imageurl	username
/alskjd76	BlueTheCat
/lkajsd98	CharlieBrown
/90jddlkj	CharlieBrown
*/
create table comments (id integer auto_increment primary key, commenttext varchar(255) not null, userid integer not null, photoid integer not null, createdat timestamp default now(), foreign key(userid) references users(id), foreign key(photoid) references photos(id));
describe comments;
/*
# Field	Type	Null	Key	Default	Extra
id	int	NO	PRI		auto_increment
commenttext	varchar(255)	NO			
userid	int	NO	MUL		
photoid	int	NO	MUL		
createdat	timestamp	YES		CURRENT_TIMESTAMP	DEFAULT_GENERATED
*/
insert into comments (commenttext, userid, photoid)
values('Meow!',1,2),('Amazing Shot!',3,2),('I <3 This',2,1);
drop table comments;
select *
from comments;
/*
# id	commenttext	userid	photoid	createdat
1	Meow!	1	2	2023-04-20 13:03:01
2	Amazing Shot!	3	2	2023-04-20 13:03:01
3	I <3 This	2	1	2023-04-20 13:03:01
*/
create table likes (userid integer not null, photoid integer not null, createdat timestamp default now(), foreign key(userid) references users(id), foreign key(photoid) references photos(id), primary key(userid, photoid)); #Want unique likes for each userid liking each photo once.  Declare double primary keys primary key(userid, photoid).
describe likes;
/*
# Field	Type	Null	Key	Default	Extra
userid	int	NO	PRI		
photoid	int	NO	PRI		
createdat	timestamp	YES		CURRENT_TIMESTAMP	DEFAULT_GENERATED
*/
insert into likes (userid, photoid)
values (1,1),(2,1),(1,2),(1,3),(3,3);
select *
from likes;
/*
# userid	photoid	createdat
1	1	2023-04-20 13:14:20
1	2	2023-04-20 13:14:20
1	3	2023-04-20 13:14:20
2	1	2023-04-20 13:14:20
3	3	2023-04-20 13:14:20
*/
insert into likes (userid, photoid)
values (1,1);
/*
Error Code: 1062. Duplicate entry '1-1' for key 'likes.PRIMARY'
*/
create table follows (followerid integer not null, followeeid integer not null, createdat timestamp default now(), foreign key(followerid) references users(id), foreign key(followeeid) references users(id), primary key(followerid, followeeid)); #Want unique users following and being followed combination.  No duplicate followers following another user.  Declare double primary keys primary key(followerid, followeeid).
describe follows;
/*
# Field	Type	Null	Key	Default	Extra
followerid	int	NO	PRI		
followeeid	int	NO	PRI		
createdat	timestamp	YES		CURRENT_TIMESTAMP	DEFAULT_GENERATED
*/
insert into follows(followerid, followeeid)
values(1,2),(1,3),(3,1),(2,3);
select *
from follows;
/*
# followerid	followeeid	createdat
1	2	2023-04-20 13:26:26
1	3	2023-04-20 13:26:26
2	3	2023-04-20 13:26:26
3	1	2023-04-20 13:26:26
*/
insert into follows(followerid, followeeid)
values(1,3),(2,1);
/*
Error Code: 1062. Duplicate entry '1-3' for key 'follows.PRIMARY'
*/
insert into follows(followerid, followeeid)
values(2,1);
create table tags (id integer auto_increment primary key, tagname varchar(255) unique, createdat timestamp default now());
create table phototags (photoid integer not null, tagid integer not null, foreign key(photoid) references photos(id), foreign key(tagid) references tags(id), primary key(photoid, tagid)); #No duplicate.  Declare double primary keys primary key(photoid, tagid).
show tables;
/*
# Tables_in_igclone
comments
follows
likes
photos
phototags
tags
users
*/
insert into tags(tagname)
values('adorable'),('cute'),('sunrise');
select *
from tags;
/*
# id	tagname	createdat
1	adorable	2023-04-20 13:48:32
2	cute	2023-04-20 13:48:32
3	sunrise	2023-04-20 13:48:32
*/
insert into phototags(photoid, tagid)
values(1,1),(1,2),(2,3),(3,2);
select *
from phototags;
/*
# photoid	tagid
1	1
1	2
3	2
2	3
*/
#Delete igclone because remove all data inserted during the create schema tutorial.  Create igclone for the second time for the next tutorial.  Create the same seven tables for the second time.  The next tutorial includes new data.  New data file instagramdata.sql.
drop database igclone;
create database igclone;
use igclone;
#1 Find the five oldest users
select *
from users
order by createdat asc limit 5;
/*
# id	username	createdat
80	Darby_Herzog	2016-05-06 00:14:21
67	Emilio_Bernier52	2016-05-06 13:04:30
63	Elenor88	2016-05-08 01:30:41
95	Nicole71	2016-05-09 17:30:22
38	Jordyn.Jacobson2	2016-05-14 07:56:26
*/
#2 What day of the week most users register?
select dayname(createdat), count(*) as aliasname
from users
group by dayname(createdat)
order by aliasname desc;
/*
# dayname(createdat)	count(*)
Thursday	16
Sunday	16
Friday	15
Tuesday	14
Monday	14
Wednesday	13
Saturday	12
*/
#3 Find users who never posted a photo
select username
from users
where id not in (
    select distinct userid
    from photos);
#or
select u.username, p.id
from users u left join photos p
on u.id = p.userid
where p.id is null;
/*
# username	id
Aniya_Hackett	
Bartholome.Bernhard	
Bethany20	
Darby_Herzog	
David.Osinski47	
Duane60	
Esmeralda.Mraz57	
Esther.Zulauf61	
Franco_Keebler64	
Hulda.Macejkovic	
Jaclyn81	
...
*/
#4 Whose photo received the most likes
select p.id, p.imageurl, count(*) as totalcount
from photos p inner join likes l
on l.photoid = p.id
group by p.id
order by totalcount desc limit 5;
/*
# id	imageurl	totalcount
145	https://jarret.name	48
182	https://dorcas.biz	43
127	https://celestine.name	43
123	http://shannon.org	42
61	https://dejon.name	41
*/
select u.username, p.id, p.imageurl, count(*) as totalcount
from photos p inner join likes l
on l.photoid = p.id
join users u
on u.id = p.userid
group by p.id
order by totalcount desc limit 5;
/*
# username	id	imageurl	totalcount
Zack_Kemmer93	145	https://jarret.name	48
Malinda_Streich	127	https://celestine.name	43
Adelle96	182	https://dorcas.biz	43
Seth46	123	http://shannon.org	42
Annalise.McKenzie16	52	https://hershel.com	41
*/