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