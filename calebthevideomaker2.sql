--single quotes only.

create table users(
userid number,
username varchar2(50 char),
firstname varchar2(50 char),
lastname varchar2(50)
);

drop table users;

--constraints are rules what data are allowed in a column.  Constraints are the following:  not null, primary key, foreign key, check (restrict more specifically what's allowed and what's not allowed e.g. between 10 and 100), unique, default
--null is the absence of a value.

create table users(
userid number not null unique
);
--not null and unique is a primary key
create table users(
userid number primary key,
accountbalance number default 0
);
--name a constraint.  Keyword constraint then constraintname
create table users(
userid number constraint constraintname primary key,
accountbalance number default 0
);
--instructor says preferred way to add a constraint.  It's complex, too.
create table users(
userid number,
username varchar2(50 char),
constraint constraintname primary key (userid)
);

create table users (
userid number,
username varchar2(50 char) not null unique,
constraint userspk primary key(userid)
);
create table projects (
projectid number, 
projectname varchar2(50 char) unique, 
creator varchar2(50 char) not null constraint projectsusersfk references users (username), --reference foreign key creator to table users column username constraint name projectsusersfk.  It's problem if there's two different foreign keys referencing the same table.
constraint projectpk primary key(projectid)
);
--another way to create a foreign key
create table projects (
projectid number, 
projectname varchar2(50 char) unique, 
creator varchar2(50 char) not null, --reference foreign key creator to table users column username constraint name projectsusersfk.  It's problem if there's two different foreign keys referencing the same table.
constraint projectpk primary key(projectid), 
constraint projectsusersfk foreign key (creator) references users (username)  --reference foreign key creator to table users column username constraint name projectsusersfk.
);

drop table projects;

insert into users
values (1,'calebcurry');
insert into projects
values (23,'Legit Project','calebcurry');

delete from users
where userid = 1; --error message attempted to delete a parent key value that had a foreign dependency.

create table projects (
projectid number, 
projectname varchar2(50 char) unique, 
creator varchar2(50 char) not null, --reference foreign key creator to table users column username constraint name projectsusersfk.  It's problem if there's two different foreign keys referencing the same table.
constraint projectpk primary key(projectid), 
constraint projectsusersfk foreign key (creator) references users (username)  --reference foreign key creator to table users column username constraint name projectsusersfk.
on delete set null  --creator column becomes null, but since it's set to not null, it's not going to work.  If a user is deleted, the project still exists.  The project is not deleted.  Project has no creator if the user is deleted.
);
create table projects (
projectid number, 
projectname varchar2(50 char) unique, 
creator varchar2(50 char) not null, --reference foreign key creator to table users column username constraint name projectsusersfk.  It's problem if there's two different foreign keys referencing the same table.
constraint projectpk primary key(projectid), 
constraint projectsusersfk foreign key (creator) references users (username)  --reference foreign key creator to table users column username constraint name projectsusersfk.
on delete cascade  --if a user is deleted, then the project is deleted, too.
);
create table projectusers (
projectid not null references projects (projectid) on delete cascade,
userid not null references users (userid) on delete cascade,
constraint projectuserspk primary key (userid, projectid) --benefits using table level constraints.  Assign multiple primary keys.
);

drop table projectusers;

insert into users
values (77,'calebcurry');
insert into users
values (86,'calebsfriend');
insert into projects
values (1,'legit project','calebcurry');
insert into projectusers
values (1,86);

delete from projectusers
where projectid = 1;

--primary keys and the unique constraint are by default indexed
--foreign keys constraints should be indexed
--the create index sql below is not part of the create table sql statements
create index indexname
on projects (creator);
create unique index indexname --to create an index if the column is unique?
on projects (creator);
drop index indexname;

--date type also stores time in Oracle database