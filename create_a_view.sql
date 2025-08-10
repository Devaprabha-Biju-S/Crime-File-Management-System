CREATE VIEW open_cases AS
SELECT crime_id, type, location, date FROM crimes
WHERE status = 'Open';
