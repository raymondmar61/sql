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

#19. Write a query in SQL to find the players with other information under contract to Liverpool were in the Squad of England in 2016 EURO cup.  #RM:  find Liverpool players in Team England.
select player_name
from player_mast
where playing_club = 'Liverpool'
and team_id = (
	select country_id
	from soccer_country
	where country_name = 'England');

#20. Write a query in SQL to find the player with other infromation Who scored the last goal in the 2nd semi final i.e. 50th match in EURO cub 2016.
select player_name, soccer_country.country_name
from player_mast, soccer_country
where player_id in (
	select player_id
	from goal_details
	where match_no = 50
	and goal_id in (
		select max(goal_id)
		from goal_details
		where match_no = 50))
and player_mast.team_id = soccer_country.country_id;
#user solution
select player_name, country_name, goal_time, goal_half
from player_mast pm join soccer_country sc
on pm.team_id=sc.country_id 
join goal_details gd
on pm.player_id=gd.player_id
where goal_time in (
	select max(goal_time)
	from goal_details 
	where match_no = 50)
and match_no = 50;

#21. Write a query in SQL to find the player Who was the captain of the EURO cup 2016 winning team from Portugal.  #RM:  get player_name from player_mast.  get captain from match_captain matching player_id and player_captain.  get final game winning team team_id from match_details play_stage is final and win_lose is winner.  match winning team_id with winning captain.
select player_name
from player_mast
where player_id in (
	select player_captain
	from match_captain
	where team_id in (
		select team_id
		from match_details
		where play_stage = 'F' and win_lose = 'W'));

#22. Write a query in SQL to find the number of players played for france in the final.
select (count(*)/2) + 11
from player_in_out
where match_no in (
	select match_no
	from match_mast
	where play_stage = 'F')
and team_id in (
	select country_id
	from soccer_country
	where country_name = 'France');

#23. Write a query in SQL to find the goalkeeper of the team Germany who didn't concede any goal in their group stage matches.
select player_name
from player_mast
where player_id in (
	select player_gk
	from match_details
	where play_stage = 'G'
	and goal_score = 0
	and team_id in (
		select country_id
		from soccer_country
		where country_name = 'Germany'));

#24. Write a query in SQL to find the runners-up in Football EURO cup 2016.
select country_name
from soccer_country
where country_id in (
	select team_id
	from match_details
	where play_stage = 'F'
	and win_lose = 'L');

#25. Write a query in SQL to find the maximum penalty shots taken by the teams.  #RM:  find teams took most penalty shots
select sc.country_name, count(sc.country_name)
from soccer_country sc, penalty_shootout ps
where sc.country_id = ps.team_id
and team_id in (
	select team_id
	from penalty_shootout)
group by sc.country_name
order by count(sc.country_name) desc limit 1;  #RM:  doesn't work because there are three countries with nine penalty shots.  Returns Germany one of the three countries with nine penalty shots.
select sc.country_name, count(sc.country_name)
from soccer_country sc, penalty_shootout ps
where sc.country_id = ps.team_id
and team_id in (
	select team_id
	from penalty_shootout)
group by sc.country_name
having count(sc.country_name) in (
	select count(team_id)
	from penalty_shootout
	group by team_id
	order by count(team_id) desc limit 1);  #RM:  find highest count or maximum count or high count or max count.  The having count(sc.country_name) subquery retuerns the highest count or maximum count or max count.

#user solution
select country_name, count(kick_id)
from penalty_shootout ps join soccer_country sc
on ps.team_id=sc.country_id
group by country_name
having count(kick_id) in (
	select max(abc)
	from (
		select count(kick_id) abc
		from penalty_shootout
		group by team_id) d);  #from subquery from.  Find highest count or maximum count or high count or max count.
select sc.country_name, count(ps.*)
from soccer_country as sc join penalty_shootout as ps
on sc.country_id = ps.team_id 
group by sc.country_name
having count(ps.kick_id) = (
	select max(x.shots)
	from (
		select count(*) as shots
		from penalty_shootout
		group by team_id) as x);

#26. Write a query in SQL to find the maximum number of penalty shots taken by the players.  #RM:  find playes took most penalty shots
select pm.player_name, count(pm.player_name)
from player_mast pm, penalty_shootout ps
where pm.player_id = ps.player_id
group by pm.player_name
having count(pm.player_name) in (
	select count(player_id)
	from penalty_shootout
	group by player_id
	order by count(player_id) desc limit 1);  #RM:  find highest count or maximum count or high count or max count.  The having count(sc.country_name) subquery retuerns the highest count or maximum count or max count.

#27. Write a query in SQL to find the match no. where highest number of penalty shots taken.
select match_no
from penalty_shootout
where kick_no = (
	select max(kick_no)
	from penalty_shootout);  #RM:  the kick_no column contains the penalty shot number.  I searched for the highest penalty shot number.  The highest penalty shot number is the number of penalty shots taken.
#official solution
select match_no, count(*) shots
from penalty_shootout
group by match_no
having count(*) = (
	select max(shots)
	from (
		select count(*) shots
		from penalty_shootout
		group by match_no) inner_result);  #RM:  find highest count or maximum count or high count or max count same table.

#28. Write a query in SQL to find the match no. and teams who played the match where highest number of penalty shots had been taken.
select distinct team_id, match_no
from penalty_shootout
where match_no in (
	select match_no
	from penalty_shootout
	where kick_no = (
		select max(kick_no)
		from penalty_shootout));

#29. Write a query in SQL to find the player of portugal who taken the 7th kick against poland.
select *
from player_mast
where player_id in (
	select player_id
	from penalty_shootout
	where kick_no = 7)
and team_id in (
	select country_id
	from soccer_country
	where country_name = 'Portugal'); #return Nani kick number 7 for Portugal
select *.player_mast, match_no
from player_mast
where player_id in (
	select player_id
	from penalty_shootout
	where kick_no = 7)
and team_id in (
	select country_id
	from soccer_country
	where country_name = 'Portugal')
and match_no in (
	select match_no
	from match_details
	where team_id in (
		select country_id
		from soccer_country
		where country_name in ('Portugal','Poland'))); #return nothing
select match_no
from match_details
where team_id in (
	select country_id
	from soccer_country
	where country_name in ('Portugal'))
union
select match_no
from match_details
and team_id in (
	select country_id
	from soccer_country
	where country_name in ('Poland')); #return error message
#official solution
select a.match_no, b.player_name, a.kick_no
from penalty_shootout a, player_mast b
where a.player_id=b.player_id
  and kick_no = 7
  and match_no = (
  	select match_no
    from penalty_shootout
    where team_id = (
    	select country_id
    	from soccer_country
    	where country_name= 'Portugal')
    group by match_no)
group by match_no, player_name, kick_id;  #RM:  official solution doesn't take the opponent Poland into consideration.

#30. Write a query in SQL to find the stage of match where the penalty kick number 23 had been taken.
select match_no, play_stage
from match_mast
where match_no in (
	select match_no
	from penalty_shootout
	where kick_id = 23);

#31. Write a query in SQL to find the venues where penalty shootout matches played.
select venue_name
from soccer_venue
where venue_id in (
	select venue_id
	from match_mast
	where match_no in (
		select distinct match_no
		from penalty_shootout));

#32. Write a query in SQL to find the date when penalty shootout matches played.
select play_date
from match_mast
where match_no in (
	select distinct match_no
	from penalty_shootout);

#33. Write a query in SQL to find the most quickest goal at the EURO cup 2016, after 5 minutes.  #RM:  find the quickest goal
select min(goal_time)
from goal_details;  #return 2
select min(goal_time)
from goal_details
where goal_time >5;  #return 6
#official solution
select min(goal_time) as "Most quickest goal after 5 minutes"
from (
	select match_no, goal_time
	from goal_details
	where goal_time > 5
	group by match_no, goal_time
	order by goal_time) hh;