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
