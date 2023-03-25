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