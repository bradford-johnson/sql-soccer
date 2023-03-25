-- get shot data with league field

SELECT g.league_id, 
    s.minute, 
    s.situation, 
    s.last_action, 
    s.shot_type, 
    s.shot_result, 
    s.position_x, 
    s.position_y
FROM shots AS s
LEFT JOIN games AS g ON s.game_id = g.game_id