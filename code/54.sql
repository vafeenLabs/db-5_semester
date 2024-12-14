SELECT ROUND(AVG(numguns), 2)
FROM (
SELECT name, numGuns, type
FROM classes, ships
WHERE classes.class = ships.class
UNION
SELECT ship, numGuns, type
FROM classes, outcomes
WHERE classes.class = outcomes.ship
WHERE type = 'bb';