# load packages
library(tidyverse)
library(DBI)
library(RPostgres)

# connect to database
con <- dbConnect(RPostgres::Postgres(),dbname = 'postgres',
                 host = 'localhost',
                 port = 5432,
                 user = 'postgres',
                 password = 'vannah')

#---- make and execute query ----
res <- dbSendQuery(con, "
-- top 100 players overall by goals scored

SELECT p.name, COUNT(a.game_id) AS tot_appearances, SUM(a.goals) AS tot_goals,
	SUM(a.shots) AS tot_shots,  SUM(a.assists) AS tot_assists,
	 SUM(a.key_passes) AS tot_k_passes,  SUM(a.yellow_card) AS tot_cautions,
	  SUM(a.red_card) AS tot_ejections,
	  ROUND(AVG(a.time)) AS avg_game_time
FROM players AS p
LEFT JOIN appearances AS a
ON p.player_id = a.player_id
WHERE goals IS NOT NULL
GROUP BY p.name
ORDER BY tot_goals DESC
LIMIT 100;
                   ")

query_1 <- dbFetch(res)

# clear query
dbClearResult(res)

# write csv
write_csv(query_1, "data/sql/top_100_scorers.csv")

#---- make and execute query ----
res <- dbSendQuery(con, "
-- Has last name like 'Tour'
-- target -> Touré brothers

SELECT p.name, 
    COUNT(a.game_id) AS tot_appearances, 
    SUM(a.goals) AS tot_goals,
    SUM(a.shots) AS tot_shots,  
    SUM(a.assists) AS tot_assists,
    SUM(a.key_passes) AS tot_k_passes,  
    SUM(a.yellow_card) AS tot_cautions,
    SUM(a.red_card) AS tot_ejections,
    ROUND(AVG(a.time)) AS avg_game_time
FROM players AS p
LEFT JOIN appearances AS a ON p.player_id = a.player_id
WHERE goals IS NOT NULL AND p.name LIKE '%Tour%'
GROUP BY p.name
ORDER BY tot_goals DESC;
                   ")

query_2 <- dbFetch(res)

# clear query
dbClearResult(res)

# write csv
write_csv(query_2, "data/sql/tour_brothers.csv")

#---- make and execute query ----
res <- dbSendQuery(con, "
-- EPL team stats by season

SELECT t.name, 
    s.season, 
    g.league_id,
    SUM(s.goals) AS tot_goals, 
    SUM(s.shots) AS tot_shots, 
    SUM(s.shots_on_target) AS tot_shots_on_target,
    SUM(s.fouls) AS tot_fouls, 
    SUM(s.corners) AS tot_corners, 
    SUM(s.deep) AS tot_deep_passes,
    SUM(s.yellow_cards) AS tot_yellows, 
    SUM(s.red_cards) AS tot_reds
FROM teams AS t
LEFT JOIN teamstats AS s ON t.team_id = s.team_id
LEFT JOIN games AS g ON s.game_id = g.game_id
WHERE g.league_id = 1
GROUP BY s.season, t.name, g.league_id
ORDER BY s.season DESC, t.name DESC;
                   ")

query_3 <- dbFetch(res)

# clear query
dbClearResult(res)

# write csv
write_csv(query_3, "data/sql/epl_teams.csv")

#---- make and execute query ----
res <- dbSendQuery(con, "
-- shot data from EPL

SELECT p.name, 
    s.minute, 
    s.situation, 
    s.last_action, 
    s.shot_type, 
    s.shot_result, 
    s.position_x, 
    s.position_y
FROM players AS p
LEFT JOIN shots AS s ON p.player_id = s.shooter_id
LEFT JOIN games AS g ON s.game_id = g.game_id
WHERE league_id = 1;
                   ")

query_4 <- dbFetch(res)

# clear query
dbClearResult(res)

# write csv
write_csv(query_4, "data/sql/epl_shots.csv")

#---- make and execute query ----
res <- dbSendQuery(con, "
-- get shot data with league field

SELECT l.name, 
    s.minute, 
    s.situation, 
    s.last_action, 
    s.shot_type, 
    s.shot_result, 
    s.position_x, 
    s.position_y
FROM shots AS s
LEFT JOIN games AS g ON s.game_id = g.game_id
LEFT JOIN leagues AS l ON g.league_id = l.league_id;
                   ")

query_5 <- dbFetch(res)

# clear query
dbClearResult(res)

# write csv
write_csv(query_5, "data/sql/all_shots.csv")

#---- disconnect from database ----
dbDisconnect(con)
