--i. Aggregate + Group by + Having

SELECT type, COUNT(*) AS num_cases
FROM crimes
GROUP BY type
HAVING COUNT(*) > 0;

--ii. Order by

SELECT * FROM crimes ORDER BY date DESC;

--iii. Join + Outer Join

SELECT f.fir_id, c.type, s.name AS suspect_name, p.name AS officer_name
FROM firs f
LEFT JOIN crimes c ON f.crime_id = c.crime_id
LEFT JOIN suspects s ON f.suspect_id = s.suspect_id
LEFT JOIN police_officers p ON f.officer_id = p.officer_id;

--iv. Boolean Operators

SELECT * FROM crimes
WHERE status = 'Open' AND location = 'Kochi';

--v. Arithmetic Operators

SELECT name, EXTRACT(YEAR FROM AGE(dob)) AS age FROM suspects
WHERE EXTRACT(YEAR FROM AGE(dob)) > 30;

--vi. Search using string operators (ILIKE)

SELECT * FROM crimes WHERE description ILIKE '%jewelry%';

--vii. TO_CHAR and EXTRACT

SELECT crime_id, TO_CHAR(date, 'Month DD, YYYY') AS formatted_date,
EXTRACT(YEAR FROM date) AS year FROM crimes;

--viii. BETWEEN, IN, NOT IN

SELECT * FROM crimes WHERE date BETWEEN '2023-08-01' AND '2023-09-30';

SELECT * FROM suspects WHERE name IN ('Arun Das', 'Ravi Pillai');

--ix. Set Operations (UNION)

SELECT name FROM suspects
UNION
SELECT name FROM police_officers;

--x. Subquery with EXISTS

SELECT * FROM suspects s
WHERE EXISTS (
    SELECT 1 FROM firs f
    WHERE f.suspect_id = s.suspect_id
);



