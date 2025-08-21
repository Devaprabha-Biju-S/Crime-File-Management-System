-- DROP TABLES IF EXIST
DROP TABLE IF EXISTS firs, crimes, suspects, police_officers CASCADE;

-- 1. Police Officers Table
CREATE TABLE police_officers (
    officer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rank VARCHAR(50),
    station VARCHAR(100)
);

-- 2. Suspects Table
CREATE TABLE suspects (
    suspect_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 0),
    address TEXT,
    criminal_record BOOLEAN DEFAULT FALSE
);

-- 3. Crimes Table
CREATE TABLE crimes (
    crime_id SERIAL PRIMARY KEY,
    crime_type VARCHAR(100),
    location VARCHAR(100),
    date DATE,
    description TEXT,
    status VARCHAR(50)
);

-- 4. FIRs Table
CREATE TABLE firs (
    fir_id SERIAL PRIMARY KEY,
    crime_id INT REFERENCES crimes(crime_id) ON DELETE CASCADE,
    suspect_id INT REFERENCES suspects(suspect_id),
    officer_id INT REFERENCES police_officers(officer_id),
    remarks TEXT,
    filed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data
INSERT INTO police_officers (name, rank, station) VALUES
('Ravi Kumar', 'Inspector', 'Delhi North'),
('Neha Singh', 'Sub-Inspector', 'Bangalore South');

INSERT INTO suspects (name, age, address, criminal_record) VALUES
('Rahul Verma', 32, 'Delhi Sector 5', TRUE),
('Anita Joshi', 28, 'Bangalore MG Road', FALSE);

INSERT INTO crimes (crime_type, location, date, description, status) VALUES
('Theft', 'Delhi Sector 5', '2024-08-20', 'Mobile phone stolen', 'Open'),
('Assault', 'Bangalore MG Road', '2024-09-10', 'Physical altercation at a pub', 'Closed');

INSERT INTO firs (crime_id, suspect_id, officer_id, remarks) VALUES
(1, 1, 1, 'Suspect seen on CCTV'),
(2, 2, 2, 'Statements taken from witnesses');

-- View: Crime FIR Summary
CREATE VIEW crime_fir_summary AS
SELECT c.crime_id, c.crime_type, c.location, c.status,
       f.fir_id, f.remarks, p.name AS officer_name
FROM crimes c
JOIN firs f ON c.crime_id = f.crime_id
JOIN police_officers p ON f.officer_id = p.officer_id;

-- Trigger Example: Log updates to crimes table
CREATE TABLE crime_log (
    log_id SERIAL PRIMARY KEY,
    crime_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_crime_status_change()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status <> OLD.status THEN
        INSERT INTO crime_log (crime_id, old_status, new_status)
        VALUES (OLD.crime_id, OLD.status, NEW.status);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_crime_status_update
AFTER UPDATE ON crimes
FOR EACH ROW
EXECUTE FUNCTION log_crime_status_change();
