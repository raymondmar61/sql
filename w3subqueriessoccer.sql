#https://www.w3resource.com/sql/tutorials.php
#https://www.w3resource.com/sql-exercises/index.php
#https://www.w3resource.com/sql-exercises/soccer-database-exercise/subqueries-exercises-on-soccer-database.php

#1. Write a query in SQL to find the teams played the first match of EURO cup 2016.  #RM:  find the teams played in the first game.  Not teams playing in EURO cup for the first time.
select country_name
from soccer_country
where country_id in (
	select team_id
	from match_details
	where match_no = 1);

#2. Write a query in SQL to find the winner of EURO cup 2016.
select country_name
from soccer_country
where country_id = (
	select team_id
	from match_details
	where play_stage = 'F'
	and win_lose = 'W');

#3. Write a query in SQL to find the match with match no, play stage, goal scored, and the audence which was the heighest audence match.
select match_no, play_stage, goal_score, audence
from match_mast
where audence = (
	select max(audence)
	from match_mast);

#4. Write a query in SQL to find the match no in which Germany played against Poland. #Germany 1208.  Poland 1213.
select *
from match_details
where team_id in (
	select country_id
	from soccer_country
	where country_name in ('Germany','Poland'));  #RM:  incorrect because want the match_no Germany vs. Poland.
select *
from match_details
where team_id = (
	select country_id
	from soccer_country
	where country_name = 'Germany')
and
where team_id = (
	select country_id
	from soccer_country
	where country_name = 'Poland'); #RM:  no results returned 1*90
select *
from match_details
where team_id = 1208 and team_id = 1213; #RM:  no results returned
select *
from match_details, soccer_country
where team_id = country_id
and team_id in (1208, 1213)
and match_no=match_no;  #RM:  incorrect
#official solution
select match_no, count(*)
from match_details 
where team_id=(
	select country_id 
	from soccer_country 
	where country_name='Germany') 
or team_id=(
	select country_id 
	from soccer_country 
	where country_name='Poland') 
group by match_no 
having count(distinct team_id)=2;  #RM:  having count(*)=2; works, too.
#user solution
select match_no 
from match_details
where team_id in (
	select country_id
	from soccer_country
	where country_name = 'Germany')
and match_no in (
	select match_no 
	from match_details
	where team_id in (
		select country_id
		from soccer_country
		where country_name = 'Poland'));  #RM:  correct solution from the above reference 1*90
select *
from match_details
where team_id in (
	select country_id
	from soccer_country
	where country_name = 'Germany')
and * in (
	select match_no 
	from match_details
	where team_id in (
		select country_id
		from soccer_country
		where country_name = 'Poland')); #RM:  doesn't work for select *


#5. Write a query in SQL to find the match no, play stage, date of match, number of gole scored, and the result of the match where Portugal played against Hungary.  #RM:  override print the goal_score results not adding goals scored.
select match_no, play_stage, play_date, goal_score, results
from match_mast
where match_no in (
	select match_no
	from match_details
	where team_id in (
		select country_id
		from soccer_country
		where country_name in ('Portugal','Hungary')));  #RM:  obviously incorrect
select match_no, play_stage, play_date, goal_score, results
from match_mast
where match_no in (
	select match_no
	from match_details
	where team_id in (
		select country_id
		from soccer_country
		where country_name in ('Portugal')))
and match_no in (
	select match_no
	from match_details
	where team_id in (
		select country_id
		from soccer_country
		where country_name in ('Hungary')));

#6. Write a query in SQL to display the list of players scored number of goals in every matches.  #RM:  solution is match_no, country_name, player_name, and sum goals scored per player.
select goal_details.match_no, soccer_country.country_name, player_mast.player_name, count(goal_details.player_id)
from goal_details, soccer_country, player_mast
where goal_details.team_id = soccer_country.country_id
and goal_details.player_id = player_mast.player_id
group by goal_details.match_no, soccer_country.country_name, player_mast.player_name
order by goal_details.match_no;

#7. Write a query in SQL to find the teams who played the heighest audence match.  #RM:  dumb question.  What if no goals where scored?  match_no doesn't appear in goal_details table.
select country_name
from soccer_country
where country_id in (
	select team_id
	from goal_details
	where match_no = (
		select match_no
		from match_mast
		where audence = (
			select max(audence)
			from match_mast)));