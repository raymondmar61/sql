#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/soccer-database-exercise/joins-exercises-on-soccer-database.php

#1. Write a query in SQL to find the name of the venue with city where the EURO cup 2016 final match was played.
select venue.venue_name, city.city
from soccer_venue venue inner join soccer_city city
on venue.city_id = city.city_id
inner join match_mast match
on venue.venue_id = match.venue_id
where play_stage = 'F';

#2. Write a query in SQL to find the number of goal scored by each team in every match within normal play schedule.
select country.country_name, sum(match.goal_score)
from match_details match, soccer_country country
where match.team_id = country.country_id
and match.play_stage = 'G'
group by country.country_name;

#3. Write a query in SQL to find the total number of goals scored by each player within normal play schedule and arrange the result set according to the heighest to lowest scorer.
select player.player_name, count(goal.player_id)
from player_mast player natural join goal_details goal
group by player.player_name
order by 2 desc;
#official solution included all matches and player's country
select player.player_name, country.country_name, count(goal.player_id)
from player_mast player inner join goal_details goal
on player.player_id = goal.player_id
inner join soccer_country country
on goal.team_id = country.country_id
group by player.player_name, country.country_name
order by count(goal.player_id) desc;
#official solution
select player_name, count(*), country_name
from goal_details a join player_mast b
on a.player_id=b.player_id
join soccer_country c
on a.team_id=c.country_id
group by player_name, country_name
order by count(*) desc;

#4. Write a query in SQL to find the highest individual scorer in EURO cup 2016.
select player.player_name, country.country_name, count(goal.player_id)
from player_mast player inner join goal_details goal
on player.player_id = goal.player_id
inner join soccer_country country
on goal.team_id = country.country_id
group by player.player_name, country.country_name
order by count(goal.player_id) desc limit 1;
#what if more than one player scored the most goals?
select player.player_name, country.country_name, count(goal.player_id)
from player_mast player inner join goal_details goal
on player.player_id = goal.player_id
inner join soccer_country country
on goal.team_id = country.country_id
group by player.player_name, country.country_name
having count(goal.player_id) = (
	select count(goal.player_id)
	from player_mast player inner join goal_details goal
	on player.player_id = goal.player_id
	group by player.player_name
	order by count(goal.player_id) desc limit 1);
#official solution
select player_name, country_name, count(player_name)
from goal_details gd join player_mast pm
on gd.player_id = pm.player_id
join soccer_country sc
on pm.team_id = sc.country_id
group by country_name, player_name
having count(player_name) >= all (
	select count(player_name)
	from goal_details gd join player_mast pm
	on gd.player_id = pm.player_id
	join soccer_country sc
	on pm.team_id = sc.country_id
	group by country_name,player_name);

#5. Write a query in SQL to find the scorer of only goal along with his country and jersey number in the final of EURO cup 2016.
select player.player_name, player.jersey_no, country.country_name
from player_mast player, goal_details goal, soccer_country country
where player.player_id = goal.player_id
and player.team_id = country.country_id
and goal.play_stage = 'F';

#6. Write a query in SQL to find the country where Football EURO cup 2016 held.
select distinct country.country_name
from soccer_country country natural join soccer_city city;

#7. Write a query in SQL to find the player who socred first goal of EURO cup 2016.
select p.player_name
from player_mast p natural join goal_details g
where g.goal_id = 1;

#8. Write a query in SQL to find the name and country of the referee who managed the opening match.
select r.referee_name, s.country_name
from referee_mast r natural join match_mast m
natural join soccer_country s
where m.match_no = 1;

#9. Write a query in SQL to find the name and country of the referee who managed the final match.
select r.referee_name, s.country_name
from referee_mast r natural join match_mast m
natural join soccer_country s
where play_stage = 'F';

#10. Write a query in SQL to find the name and country of the referee who assisted the referee in the opening match.
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar natural join soccer_country c;  #return assistant referees and their country
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar natural join soccer_country c
natural join match_details m;  #return nothing
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar natural join soccer_country c
and asst_referee_mast ar inner join match_details m
where ar.ass_ref_id = m.ass_ref;  #return nothing
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar natural join soccer_country c
and asst_referee_mast ar inner join match_details m
on ar.ass_ref_id = m.ass_ref;  #return nothing
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar natural join soccer_country c
inner join match_details m
on ar.ass_ref_id = m.ass_ref;  #return nothing
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar inner join soccer_country c
on ar.country_id = c.country_id
inner join match_details m
on ar.ass_ref_id = m.ass_ref;  #return assistant referees and their country
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar inner join soccer_country c
on ar.country_id = c.country_id
inner join match_details m
on ar.ass_ref_id = m.ass_ref
where match_no = 1;  #return assistant referees and their country opening match

#11. Write a query in SQL to find the name and country of the referee who assisted the referee in the final match.
select ar.ass_ref_name, c.country_name
from asst_referee_mast ar inner join soccer_country c
on ar.country_id = c.country_id
inner join match_details m
on ar.ass_ref_id = m.ass_ref
where play_stage = 'F';

#12. Write a query in SQL to find the city where the opening match of EURO cup 2016 played.
select c.city
from soccer_city c natural join soccer_venue v
natural join match_mast m
where m.match_no = 1;

#13. Write a query in SQL to find the stadium hosted the final match of EURO cup 2016 along with the capacity, and audance for that match.
select v.venue_name, v.aud_capacity, m.audence
from soccer_venue v natural join soccer_city c
natural join match_mast m
where m.play_stage = 'F';  #soccer_venue v and soccer_city c natural join city_id.  soccer_venue v and match_mast m natural join venue_id.  No natural join soccer_city c and match_mast m.  SQL query still works.

#14. Write a query in SQL to compute a report that contain the number of matches played in each venue along with their city.
select c.city, v.venue_name, count(*)
from soccer_venue v natural join soccer_city c
natural join match_mast m
group by 1, 2;

#15. Write a query in SQL to find the player who was the first player to be sent off at the tournament EURO cup 2016.
select match_no
from player_booked
where sent_off = 'Y' limit 1;  #return 1.  1 is correct first player to be sent off.
select p.player_name
from player_mast p inner join player_booked b
on p.player_id = b.player_id
where p.player_id in (
	select b.player_id
	from player_booked b
	where b.match_no in (
		select b.match_no
		from player_booked b
		where b.sent_off = 'Y' limit 1));  #return all four players on player_booked b match 1
select p.player_name
from player_mast p inner join player_booked b
on p.player_id = b.player_id
where p.player_id in (
	select b.player_id
	from player_booked b
	where b.match_no in (
		select min(b.match_no)
		from player_booked b
		where b.sent_off = 'Y'));  #return all four players on player_booked b match 1
select p.player_name
from player_mast p inner join player_booked b
on p.player_id = b.player_id
where p.player_id in (
	select b.player_id
	from player_booked b
	where sent_off = 'Y'
	and match_no = (
		select min(match_no)
		from player_booked b
		where sent_off = 'Y'));  #correct
#user solution
select player_name
from player_mast
where player_id = (
	select player_id
	from player_booked
	where sent_off = 'Y'
	order by match_no, booking_time	limit 1);

#16. Write a query in SQL to find the teams that scored only one goal to the torunament.
select c.country_name
from soccer_country c, soccer_team t
where c.country_id = t.team_id
and t.goal_for = 1;

#17. Write a query in SQL to find the yellow cards received by each country.  #RM:  solution wants a count by country
select c.country_name, count(*)
from soccer_country c, player_booked b
where c.country_id = b.team_id
group by c.country_name
order by count(*) desc;

#18. Write a query in SQL to find the venue with number of goals that has seen.
select v.venue_name, count(g.goal_id)
from soccer_venue v inner join match_mast m
on v.venue_id = m.venue_id
inner join goal_details g
on m.match_no = g.match_no
inner join soccer_country c
on g.team_id = c.country_id
group by v.venue_name
order by count(g.goal_id) desc;

#19. Write a query in SQL to find the match where no stoppage time added in 1st half of play.
select match_no
from match_mast
where stop1_sec = 0;  #answer is match #4

select md.match_no, c.country_name
from match_details md left outer join match_mast mm
on md.match_no = mm.match_no
inner join soccer_country c
on md.team_id = c.country_id
where mm.stop1_sec = 0;

#20. Write a query in SQL to find the team(s) who conceded the most goals in EURO cup 2016.
select c.country_name
from soccer_country c inner join soccer_team t
on c.country_id = t.team_id
where t.team_id in (
	select t.team_id
	from soccer_team t
	where goal_agnst = (
		select max(t.goal_agnst)
		from soccer_team t));

#21. Write a query in SQL to find the match where highest stoppege time added in 2nd half of play.
select match_no
from match_mast
where stop2_sec in (
	select max(stop2_sec)
	from match_mast); #match #17

select m.match_no, c.country_name, m.stop2_sec
from match_mast m inner join match_details d
on m.match_no = d.match_no
inner join soccer_country c
on d.team_id = c.country_id
where m.stop2_sec in (
	select max(m.stop2_sec)
	from match_mast m);

#22. Write a query in SQL to find the matchs ending with a goalless draw in group stage of play.
select distinct(match_no)
from match_details
where win_lose = 'D'
and goal_score = 0;

select m.match_no, c.country_name
from match_details m inner join soccer_country c
on m.team_id = c.country_id
where m.match_no in (
	select distinct(m.match_no)
	from match_details m
	where m.win_lose = 'D'
	and m.goal_score = 0)
order by m.match_no;

#23. Write a query in SQL to find the match no. and the teams played in that match where the 2nd highest stoppage time had been added in the 2nd half of play.
select match_no
from match_mast
where stop2_sec in (
	select stop2_sec from (
		select stop2_sec, rank() over (order by stop2_sec desc) rank
	from match_mast) stop2_sec_rank
	where rank = 2);  #match #15
select m.match_no, c.country_name, m.stop2_sec
from match_mast m inner join match_details d
on m.match_no = d.match_no
inner join soccer_country c
on d.team_id = c.country_id
where m.stop2_sec in (
	select stop2_sec
	from match_mast
	where stop2_sec in (
		select stop2_sec from (
			select stop2_sec, rank() over (order by stop2_sec desc) rank
		from match_mast) stop2_sec_rank
		where rank = 2));  #correct
select m.match_no, c.country_name, m.stop2_sec
from match_mast m inner join match_details d
on m.match_no = d.match_no
inner join soccer_country c
on d.team_id = c.country_id
where m.stop2_sec in (
	select m.stop2_sec
	from match_mast m
	where m.stop2_sec in (
		select m.stop2_sec from (
			select m.stop2_sec, rank() over (order by m.stop2_sec desc) rank
		from match_mast m) stop2_sec_rank
		where rank = 2));  #error.  Returns all matches.

#24. Write a query in SQL to find the player and his team and how many matches he kept goal for his team.  #RM:  find all goal keepers played for each team or country.  #official solution wants country, player, games played
select distinct(p.player_name), c.country_name
from player_mast p inner join match_details m
on p.player_id = m.player_gk
inner join soccer_country c
on p.team_id = c.country_id
order by c.country_name;
select c.country_name, p.player_name, count(m.player_gk)
from player_mast p inner join match_details m
on p.player_id = m.player_gk
inner join soccer_country c
on p.team_id = c.country_id
group by c.country_name, p.player_name
order by c.country_name;

#25. Write a query in SQL to find the venue that has seen the most goals.  #subquery having statement and subquery from statement.
select match_no, count(match_no)
from goal_details
group by match_no
order by match_no;  #count goals for each match_no
select v.venue_name
from soccer_venue v inner join match_mast m
on v.venue_id = m.venue_id
inner join goal_details g
on m.match_no = g.match_no
where m.match_no in (
	select match_no
	from goal_details
	having count(match_no) in (
		select count(match_no)
		from goal_details
		group by match_no
		order by count(match_no) desc limit 1));  #RM:  missing SQL line group by match_no above having count(match_no) in (
select distinct(v.venue_name)
from soccer_venue v inner join match_mast m
on v.venue_id = m.venue_id
inner join goal_details g
on m.match_no = g.match_no
where m.match_no in (
	select match_no
	from goal_details
	group by match_no
	having count(match_no) = (
		select count(match_no)
		from goal_details
		group by match_no
		order by count(match_no) desc limit 1));  #RM:  correct added missing SQL line
#user solution
select venue_name
from soccer_venue
where venue_id = ( 
	select venue_id
	from match_mast
	where match_no = (
		select match_no
		from goal_details
		group by match_no
		order by count(*) desc limit 1));

#26. Write a query in SQL to find the oldest player to have appeared in a EURO cup 2016 match.
select player_name
from player_mast
having max(age) = (
	select max(age)
	from player_mast);  #nothing
select player_name
from player_mast
where age = (
	select max(age)
	from player_mast);  #correct
select m.player_name, c.country_name
from player_mast m, soccer_country c
where m.team_id = c.country_id
and m.age = (
	select max(age)
	from player_mast);  #correct with player's country

#27. Write a query in SQL to find those two teams which scored three goals in a single game at this tournament.  #RM:  Question asks for the game the two teams scored three goals each.  Not teams scoring three goals in a game.
select c.country_name
from soccer_country c inner join match_details m
on c.country_id = m.team_id
where m.goal_score = 3 and m.win_lose = 'D';

#28. Write a query in SQL to find the teams with other information that finished bottom of their respective groups after conceding four times in three games.  #RM:  find teams group_position is fourth or last place in their group.
select c.country_name
from soccer_team t, soccer_country c
where t.team_id = c.country_id
and t.group_position = 4;
#RM:  solution included goal_agnst = 4.  How does user know most goals against for group_position is four?  Is the answer conceding four times in three games?
select a.country_name as team , b.team_group,b.match_played, b.goal_agnst, b.group_position 
from soccer_country a join soccer_team b
on a.country_id=b.team_id
where goal_agnst=4 and group_position=4
order by team_group;
#find max goals given up for last place teams in thier groups
select max(goal_agnst)
from soccer_team
where group_position = 4; #answer is six for goals given up all teams last place in their groups
select c.country_name
from soccer_team t, soccer_country c
where t.team_id = c.country_id
and t.group_position = 4
and t.goal_agnst = (
	select max(goal_agnst)
	from soccer_team
	where group_position = 4);  #answer is Russia absolute bottom.  Fourth place gave up most goals which was six.

#29. Write a query in SQL to find those three players with other information, who contracted to Lyon participated in the EURO cup 2016 Finals
select p.player_name
from player_mast p natural join match_details m
where p.playing_club = 'Lyon'
and m.play_stage = 'F';

#30. Write a query in SQL to find the final four teams in the tournament.
select country_name
from soccer_country
where country_id in (
	select distinct(team_id)
	from match_details
	where play_stage in ('S','F'));
#also
select distinct(c.country_name)
from soccer_country c inner join match_details m
on c.country_id = m.team_id
where m.play_stage in ('S','F');
#official solution.  No need for F because teams in S two of the four go to finals.
select country_name
from match_details a join soccer_country b
on a.team_id=b.country_id
where play_stage='s';

#31. Write a query in SQL to find the captains for the top four teams with other information which participated in the semifinals (match 48 and 49) in the tournament.
select m.player_name, m.jersey_no, country.country_name, m.posi_to_play
from match_captain c, player_mast m, soccer_country country
where c.player_captain = m.player_id
and c.team_id = country.country_id
and c.match_no in (48, 49);

#32. Write a query in SQL to find the captains with other information for all the matches in the tournament.
select c.match_no, m.player_name, m.jersey_no, country.country_name, m.posi_to_play
from match_captain c, player_mast m, soccer_country country
where c.player_captain = m.player_id
and c.team_id = country.country_id
order by c.match_no, m.player_name;

#33. Write a query in SQL to find the captain and goal keeper with other information for all the matches for all the team.
select d.match_no, m.player_name, m.jersey_no, country.country_name, m.posi_to_play, 'GK' as "GK or Captain"
from player_mast m, match_details d, soccer_country country
where m.player_id = d.player_gk
and d.team_id = country.country_id
union
(select c.match_no, m.player_name, m.jersey_no, country.country_name, m.posi_to_play, 'Captain' as "GK or Captain"
from match_captain c, player_mast m, soccer_country country
where c.player_captain = m.player_id
and c.team_id = country.country_id)
order by match_no, country_name, player_name;
/*
match_no	player_name	jersey_no	country_name	posi_to_play	GK or Captain
1	Hugo Lloris	1	France	GK	GK
1	Hugo Lloris	1	France	GK	Captain
1	Ciprian Tatarusanu	12	Romania	GK	GK
1	Vlad Chiriches	6	Romania	DF	Captain
2	Etrit Berisha	1	Albania	GK	GK
2	Lorik Cana	5	Albania	MF	Captain
2	Stephan Lichtsteiner	2	Switzerland	DF	Captain
2	Yann Sommer	1	Switzerland	GK	GK
3	Martin Skrtel	3	Slovakia	DF	Captain
3	MatusKozacik	23	Slovakia	GK	GK
3	Ashley Williams	6	Wales	DF	Captain
3	Danny Ward	21	Wales	GK	GK
*/
#same without country and position
select match_captain.match_no, player_mast.player_name, 'Captain' as "GK or Captain"
from match_captain inner join player_mast
on match_captain.player_captain = player_mast.player_id
union
(select match_details.match_no, player_mast.player_name, 'GK' as "GK or Captain"
from match_details inner join player_mast
on match_details.player_gk = player_mast.player_id)
order by match_details.match_no;  #Combined captain and GK on one line.  Not correct.
select match_details.match_no, playercaptain.player_name as "Captain", playergk.player_name as "GK", country.country_name
from match_details inner join match_captain captain
on match_details.match_no = captain.match_no
inner join soccer_country country
on match_details.team_id = country.country_id
inner join player_mast playercaptain
on captain.player_captain = playercaptain.player_id
inner join player_mast playergk
on match_details.player_gk = playergk.player_id
order by match_details.match_no;  #RM:  close.  match_details.match_no = captain.match_no is incorrrect.  match_details.team_id= captain.team_id is correct.  Also, add distinct.
/*
match_no	Captain	GK	country_name
1	Hugo Lloris	Hugo Lloris	France
1	Hugo Lloris	Ciprian Tatarusanu	Romania
1	Vlad Chiriches	Hugo Lloris	France
1	Vlad Chiriches	Ciprian Tatarusanu	Romania
2	Lorik Cana	Etrit Berisha	Albania
2	Lorik Cana	Yann Sommer	Switzerland
2	Stephan Lichtsteiner	Etrit Berisha	Albania
2	Stephan Lichtsteiner	Yann Sommer	Switzerland
*/
#official solution
select a.match_no, c.player_name as "captain", d.player_name as "goal keeper", e.country_name
from match_captain a natural join match_details b
join soccer_country e
on b.team_id=e.country_id
join player_mast c
on a.player_captain=c.player_id
join player_mast d
on b.player_gk=d.player_id;
#piggy back from official solution elaborating joins.  Two tables joining the same table.  Two tables join same table.
select match_captain.match_no, captainplayer.player_name as "captain", gkplayer.player_name as "goal keeper", soccer_country.country_name
from match_captain natural join match_details
join soccer_country
on match_details.team_id=soccer_country.country_id
join player_mast captainplayer
on match_captain.player_captain=captainplayer.player_id
join player_mast gkplayer
on match_details.player_gk=gkplayer.player_id;
/*
match_no	captain	goal keeper	country_name
1	Hugo Lloris	Hugo Lloris	France
1	Vlad Chiriches	Ciprian Tatarusanu	Romania
2	Lorik Cana	Etrit Berisha	Albania
2	Stephan Lichtsteiner	Yann Sommer	Switzerland
3	Ashley Williams	Danny Ward	Wales
3	Martin Skrtel	MatusKozacik	Slovakia
*/
#Not correct.  on match_captain.match_no = match_details.match_no is incorrect. on match_captain.team_id= match_details.team_id is correct.  Also, add distinct. 
select match_captain.match_no, captainplayer.player_name as "captain", gkplayer.player_name as "goal keeper", soccer_country.country_name
from match_captain inner join match_details
on match_captain.match_no = match_details.match_no
inner join soccer_country
on match_details.team_id=soccer_country.country_id
join player_mast captainplayer
on match_captain.player_captain=captainplayer.player_id
inner join player_mast gkplayer
on match_details.player_gk=gkplayer.player_id
order by match_no;
/*
match_no	Captain	GK	country_name
1	Hugo Lloris	Hugo Lloris	France
1	Hugo Lloris	Ciprian Tatarusanu	Romania
1	Vlad Chiriches	Hugo Lloris	France
1	Vlad Chiriches	Ciprian Tatarusanu	Romania
2	Lorik Cana	Etrit Berisha	Albania
2	Lorik Cana	Yann Sommer	Switzerland
2	Stephan Lichtsteiner	Etrit Berisha	Albania
2	Stephan Lichtsteiner	Yann Sommer	Switzerland
*/
#user solutions
select distinct mc.match_no, sc.country_name, pmc.player_name as "Captain", pmgk.player_name as "Goal"
from match_captain mc join match_details md
on mc.team_id=md.team_id
join player_mast pmc
on mc.player_captain=pmc.player_id
join player_mast pmgk
on md.player_gk=pmgk.player_id
join soccer_country sc
on sc.country_id=mc.team_id
order by 1;
/*
match_no	country_name	Captain	Goal
1	France	Hugo Lloris	Hugo Lloris
1	Romania	Vlad Chiriches	Ciprian Tatarusanu
2	Albania	Lorik Cana	Etrit Berisha
2	Switzerland	Stephan Lichtsteiner	Yann Sommer
3	Slovakia	Martin Skrtel	MatusKozacik
3	Wales	Ashley Williams	Danny Ward
*/

#33. Continuation next SQL day.  Write a query in SQL to find the captain and goal keeper with other information for all the matches for all the team.
select match_details.match_no, player_mast.player_name
from match_details inner join player_mast
on match_details.player_gk = player_mast.player_id
order by match_details.match_no;  #match_no and goal keeper
select match_captain.match_no, player_mast.player_name
from match_captain inner join player_mast
on match_captain.player_captain = player_mast.player_id
order by match_captain.match_no;  #match_no and captain

select match_details.match_no, playercaptain.player_name, playergk.player_name
from match_details, match_captain, player_mast playercaptain, player_mast playergk
where match_captain.player_captain = playercaptain.player_id
and match_details.player_gk	 = playergk.player_id
and match_details.match_no = match_captain.match_no
order by match_details.match_no; #not correct.  One column GK only.
/*
match_no	player_name
1	Hugo Lloris
1	Hugo Lloris
1	Ciprian Tatarusanu
1	Ciprian Tatarusanu
2	Etrit Berisha
2	Etrit Berisha
2	Yann Sommer
2	Yann Sommer
3	MatusKozacik
3	MatusKozacik
3	Danny Ward
3	Danny Ward
*/
select match_details.match_no, playercaptain.player_name as "Captain", playergk.player_name as "GK"
from match_details, match_captain, player_mast playercaptain, player_mast playergk
where match_captain.player_captain = playercaptain.player_id
and match_details.player_gk	 = playergk.player_id
and match_details.match_no = match_captain.match_no
order by match_details.match_no; #not correct.  Incorrect join match_details.match_no = match_captain.match_no.  Duplicates.
/*
match_no	Captain	GK
1	Hugo Lloris	Hugo Lloris
1	Vlad Chiriches	Hugo Lloris
1	Hugo Lloris	Ciprian Tatarusanu
1	Vlad Chiriches	Ciprian Tatarusanu
2	Lorik Cana	Etrit Berisha
2	Stephan Lichtsteiner	Etrit Berisha
2	Lorik Cana	Yann Sommer
2	Stephan Lichtsteiner	Yann Sommer
3	Martin Skrtel	MatusKozacik
3	Ashley Williams	MatusKozacik
3	Martin Skrtel	Danny Ward
3	Ashley Williams	Danny Ward
*/
select match_details.match_no, playercaptain.player_name as "Captain", playergk.player_name as "GK"
from match_details, match_captain, player_mast playercaptain, player_mast playergk
where match_captain.player_captain = playercaptain.player_id
and match_details.player_gk	 = playergk.player_id
and match_details.team_id = match_captain.team_id
order by match_details.match_no; #not correct.  Duplicates.
/*
match_no	Captain	GK
1	Vlad Chiriches	Ciprian Tatarusanu
1	Hugo Lloris	Hugo Lloris
1	Hugo Lloris	Hugo Lloris
1	Hugo Lloris	Hugo Lloris
1	Hugo Lloris	Hugo Lloris
1	Hugo Lloris	Hugo Lloris
1	Hugo Lloris	Hugo Lloris
1	Hugo Lloris	Hugo Lloris
1	Vlad Chiriches	Ciprian Tatarusanu
1	Vlad Chiriches	Ciprian Tatarusanu
*/
select distinct match_details.match_no, playercaptain.player_name as "Captain", playergk.player_name as "GK"
from match_details, match_captain, player_mast playercaptain, player_mast playergk
where match_captain.player_captain = playercaptain.player_id
and match_details.player_gk	 = playergk.player_id
and match_details.team_id = match_captain.team_id
order by match_details.match_no; #correct.
/*
match_no	Captain	GK
1	Hugo Lloris	Hugo Lloris
1	Vlad Chiriches	Ciprian Tatarusanu
2	Ansi Agolli	Etrit Berisha
2	Lorik Cana	Etrit Berisha
2	Stephan Lichtsteiner	Yann Sommer
3	Ashley Williams	Danny Ward
3	Martin Skrtel	MatusKozacik
*/
select distinct match_details.match_no, playercaptain.player_name as "Captain", playergk.player_name as "GK", soccer_country.country_name
from match_details, match_captain, player_mast playercaptain, player_mast playergk, soccer_country
where match_captain.player_captain = playercaptain.player_id
and match_details.player_gk	 = playergk.player_id
and match_details.team_id = match_captain.team_id
and match_details.team_id = soccer_country.country_id
order by match_details.match_no; #correct with country.
/*
match_no	Captain	GK	country_name
1	Hugo Lloris	Hugo Lloris	France
1	Vlad Chiriches	Ciprian Tatarusanu	Romania
2	Ansi Agolli	Etrit Berisha	Albania
2	Lorik Cana	Etrit Berisha	Albania
2	Stephan Lichtsteiner	Yann Sommer	Switzerland
3	Ashley Williams	Danny Ward	Wales
3	Martin Skrtel	MatusKozacik	Slovakia
*/
select distinct match_details.match_no, playercaptain.player_name as "Captain", playergk.player_name as "GK", soccer_country.country_name
from match_details inner join match_captain
on match_details.team_id = match_captain.team_id
inner join player_mast playergk
on match_details.player_gk = playergk.player_id
inner join player_mast playercaptain
on match_captain.player_captain = playercaptain.player_id
inner join soccer_country
on match_details.team_id = soccer_country.country_id
order by 1; #correct with country using joins
/*
match_no	Captain	GK	country_name
1	Hugo Lloris	Hugo Lloris	France
1	Vlad Chiriches	Ciprian Tatarusanu	Romania
2	Ansi Agolli	Etrit Berisha	Albania
2	Lorik Cana	Etrit Berisha	Albania
2	Stephan Lichtsteiner	Yann Sommer	Switzerland
3	Ashley Williams	Danny Ward	Wales
3	Martin Skrtel	MatusKozacik	Slovakia
*/