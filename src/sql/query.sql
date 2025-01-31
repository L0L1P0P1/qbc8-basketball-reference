-- 1st Hypothesis Test
-- Retrieve the rank, player ID, team year, height, and weight of players ranked in the top 20 for specific years
use basketball_reference;
SELECT 
	pr.rank, 
	pr.player_id, 
    pr.team_year_id, 
    p.height_cm , 
    p.weight_kg
FROM 
	player_rank pr
JOIN 
	players p 
ON 
	pr.player_id = p.player_id
WHERE 
	pr.rank <= 20 -- Only players ranked in the top 20
AND 
	SUBSTRING_INDEX(pr.team_year_id, '/', -1) IN ('2021', '2022', '2023', '2024'); -- Filter by team year (2021-2024)

-- 2nd Hypothesis Test
-- Retrieve player name, experience, age, team year ID, and team standing for players who were part of the top-ranked teams
SELECT 
    p.player_id, 
    p.experience, 
    (YEAR(CURDATE()) - p.birthdate) AS age, -- Calculate player's age based on birthdate
    pty.team_year_id,
    s.standing
FROM player_team_year pty
JOIN team_year_id tyi ON pty.team_year_id = tyi.team_year_id
JOIN standings s ON tyi.team_year_id = s.team_year_id
JOIN players p ON pty.player_id = p.player_id
WHERE s.standing = 1  -- Only consider the top-ranked teams
AND SUBSTRING_INDEX(s.team_year_id, '/', -1) IN ('2021', '2022', '2023', '2024'); -- Filter for data from 2021-2024


-- Descriptive statistics 1
-- Retrieve MVP players' height and categorize them under 'Michael Jordan Trophy'
SELECT
    'Michael Jordan Trophy' AS category,
    m.player_id,
    MAX(p.height_cm) AS height_cm,  -- Getting the maximum height (in case of duplicates)
    MAX(m.team_year_id) AS team_year_id  -- Selecting one team-year ID using MAX()
FROM
    mvp m
JOIN 
    players p ON m.player_id = p.player_id
GROUP BY 
    m.player_id  -- Grouping by player ID to ensure unique records

UNION 

-- Retrieve top 50 ranked players and categorize them under 'Player Rank'
SELECT
    'Player Rank' AS category,
    pr.player_id,
    p.height_cm, 
    pr.team_year_id
FROM
    player_rank pr
JOIN 
    players p ON pr.player_id = p.player_id  -- Joining to get player details
WHERE 
    pr.`rank` <= 50  -- Filtering only the top 50 ranked players
ORDER BY 
    category, team_year_id, player_id;


-- Descriptive statistics 2
-- Champion Team and Top 15 Players
-- Retrieve players who were part of the championship-winning teams from 2022-2023
SELECT 
    'Champion Team' AS category,
    p.player_id,
    p.height_cm,
    p.experience,
    tyi.team_year_id 
FROM player_team_year pty
JOIN players p ON pty.player_id = p.player_id
JOIN team_year_id tyi ON pty.team_year_id = tyi.team_year_id
JOIN standings s ON s.team_year_id = tyi.team_year_id
WHERE s.standing = 1  -- Only consider the top-ranked (champion) teams
AND tyi.year BETWEEN 2023 AND 2024 -- Filter by team year (2022-2023)

UNION ALL

-- Retrieve top 15 players and categorize them as 'Top 15 Players', including their rank and team year
SELECT 
    'Top 15 Players' AS category,
    p.player_id,
    p.height_cm,
    p.experience,
    tyi.team_year_id
FROM player_rank pr
JOIN players p ON pr.player_id = p.player_id
JOIN team_year_id tyi ON pr.team_year_id = tyi.team_year_id
WHERE pr.rank <= 15 -- Only top 15 players
AND tyi.year BETWEEN 2023 AND 2024 -- Filter by team year (2023-2024)

-- Descriptive statistics 3 - before
-- Count the number of MVP wins for each point guard and order by the most MVP wins
WITH PointGuard AS (
    SELECT 
        players.player_id,
        pr.player_name,
        pr.team_year_id
    FROM 
        player_rank pr
    JOIN 
        player_position pp 
	ON 
		pr.player_id = pp.player_id
    JOIN 
        players p ON m.player_id = p.player_id
    WHERE 
        pp.position = 'Point Guard'
        AND SUBSTRING_INDEX(m.team_year_id, '/', -1) IN ('2020', '2021', '2022', '2023', '2024') -- Filtering only specific years
)

SELECT 
    player_name, 
    COUNT(*) AS mvp_wins -- Counting MVP wins per player
FROM 
    PointGuardMVPs
GROUP BY 
    player_name
ORDER BY 
    mvp_wins DESC;
    
-- Descriptive statistics 3 - after
WITH PointGuard AS (
    SELECT 
        pp.player_id,
        pp.position,
        p.player_name,
        pr.rank,

        pr.team_year_id
    FROM 
        player_position pp
    JOIN 
        players p
	ON 
		pp.player_id = p.player_id
    JOIN 
        player_rank pr
	ON 
		pr.player_id = p.player_id
    WHERE 
        pp.position = 'Point Guard'
        AND SUBSTRING_INDEX(pr.team_year_id, '/', -1) IN ('2020', '2021', '2022', '2023', '2024') -- Filtering only specific years
)

SELECT 
    player_id, 
    COUNT(*) AS wins -- Counting MVP wins per player
FROM 
    PointGuard
GROUP BY 
    player_id
ORDER BY 
    wins DESC;