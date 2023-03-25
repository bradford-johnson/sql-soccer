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