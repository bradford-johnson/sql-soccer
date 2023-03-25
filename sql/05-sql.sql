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