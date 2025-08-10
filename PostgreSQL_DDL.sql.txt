-- Table: police_officers
CREATE TABLE police_officers (
    officer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rank VARCHAR(50),
    station VARCHAR(100)
);

-- Table: suspects
CREATE TABLE suspects (
    suspect_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    dob DATE,
    address TEXT
);

-- Table: crimes
CREATE TABLE crimes (
    crime_id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    location VARCHAR(100),
    date DATE NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'Open'
);

-- Table: firs
CREATE TABLE firs (
    fir_id SERIAL PRIMARY KEY,
    crime_id INT REFERENCES crimes(crime_id) ON DELETE CASCADE,
    suspect_id INT REFERENCES suspects(suspect_id),
    officer_id INT REFERENCES police_officers(officer_id),
    date_filed DATE DEFAULT CURRENT_DATE,
    remarks TEXT
);
