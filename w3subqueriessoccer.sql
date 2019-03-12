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

#8. Write a query in SQL to find the player who scored the last goal for Portugal against Hungary.
select player_name
from player_mast
where player_id in (
	select player_id
	from goal_details
	where goal_id in (
		select max(goal_id)
		from goal_details
		where match_no in (
			select match_no
			from match_details
			where team_id in (
				select country_id
				from soccer_country
				where country_name = 'Portugal')
			and match_no in (
				select match_no
				from match_details
				where team_id = (
					select country_id
					from soccer_country
					where country_name = 'Hungary')))));

#9. Write a query in SQL to find the 2nd highest stoppage time which had been added in 2nd half of play.
select stop2_sec
from match_mast
where stop2_sec in (
	select stop2_sec from (
		select stop2_sec, rank() over (order by stop2_sec desc) rank from match_mast) columnname
	where rank = 2);
#official solution
select max(stop2_sec) 
from match_mast
where stop2_sec <> (
	select max(stop2_sec) 
	from match_mast);

#10. Write a query in SQL to find the teams played the match where 2nd highest stoppage time had been added in 2nd half of play.
select country_name
from soccer_country
where country_id in (
	select team_id
	from match_details
	where match_no in (
		select match_no
		from match_mast
		where stop2_sec in (
			select stop2_sec from (
				select stop2_sec, rank() over (order by stop2_sec desc) rank from match_mast) columnname
			where rank = 2)));

#11. Write a query in SQL to find the match no, date of play and the 2nd highest stoppage time which have been added in the 2nd half of play.
select *
from match_mast
where stop2_sec in (
	select stop2_sec
	from match_mast
	where stop2_sec in (
		select stop2_sec from (
			select stop2_sec, rank() over (order by stop2_sec desc) rank from match_mast) columnname
		where rank = 2));

#12. Write a query in SQL to find the team which was defeated by Portugal in EURO cup 2016 final.
select country_name
from soccer_country
where country_id = (
	select team_id
	from match_details
	where play_stage = 'F' and win_lose = 'L');

#13. Write a query in SQL to find the club which supplied the most number of players to the 2016 EURO cup.
select playing_club, count(*)
from player_mast
group by playing_club
order by count(*) desc;  #RM:  list of playing_club and the counts descending
#official solution
select playing_club, count(playing_club)
from player_mast
group by playing_club
having count(playing_club) = (
	select max(mycount)
	from (
		select playing_club, count(playing_club) mycount
		from player_mast
		group by playing_club) pm);
#user solution
select playing_club
from player_mast
group by playing_club
having count(playing_club) = (
	select count(playing_club)
	from player_mast
	group by playing_club
	order by count(playing_club) desc limit 1);
#another user solution
select playing_club, count(playing_club)
from player_mast
group by playing_club
having count(playing_club) = (
	select max(x.rows)
	from (
		select count(playing_club) as rows
		from player_mast
		group by playing_club) as x);

#14. Write a query in SQL to find the player and his jersey number Who scored the first penalty of the tournament. #RM:  exclude penalty shots during shootouts.
select player_name, jersey_no
from player_mast
where player_id in (
	select player_id
	from goal_details
	where goal_type = 'P'
	and goal_id = (
		select min(goal_id)
		from goal_details
		where goal_type = 'P' and play_stage = 'G'));
#user solution
select player_name, jersey_no
from player_mast
where player_id = (
	select player_id
	from goal_details
	where goal_id = (
		select goal_id
		from goal_details
		where goal_type ='P'
		order by goal_id asc limit 1));  #RM:  added order by asc

#15. Write a query in SQL to find the player along with his team and jersey number who scored the first penalty of the tournament.
select player_name, jersey_no, soccer_country.country_name
from player_mast, soccer_country
where player_id in (
	select player_id
	from goal_details
	where goal_type = 'P'
	and goal_id = (
		select min(goal_id)
		from goal_details
		where goal_type = 'P' and play_stage = 'G'))
and player_mast.team_id = soccer_country.country_id;

#16. Write a query in SQL to find the player who was the goalkeeper for Italy in penalty shootout against Germany in Football EURO cup 2016.
select player_name
from player_mast
where player_id in (
	select player_gk
	from penalty_gk
	where team_id in (
		select country_id
		from soccer_country
		where country_name = 'Italy'));

#17. Write a query in SQL to find the number of Germany scored at the tournament.  #RM:  looked at solution.  Number of Germany players scored
select count(*)
from goal_details
where team_id = (
	select country_id
	from soccer_country
	where country_name = 'Germany');

#18. Write a query in SQL to find the players along with their jersey no., and playing club, who were the goalkeepers for the England squad for 2016 EURO cup.
select player_name, jersey_no, playing_club
from player_mast
where posi_to_play = 'GK'
and team_id = (
	select country_id
	from soccer_country
	where country_name = 'England');