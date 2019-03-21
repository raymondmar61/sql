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
select r.referee_name
from referee_mast r natural join match_mast m
where m.match_no = 1;