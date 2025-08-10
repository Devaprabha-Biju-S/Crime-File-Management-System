-- Police Officers
INSERT INTO police_officers (name, rank, station) VALUES
('Rajesh Kumar', 'Inspector', 'Sector 17'),
('Asha Nair', 'Sub-Inspector', 'MG Road'),
('John Dsouza', 'Head Constable', 'Central');

-- Suspects
INSERT INTO suspects (name, gender, dob, address) VALUES
('Arun Das', 'Male', '1990-05-12', 'Kochi'),
('Sneha Menon', 'Female', '1988-11-23', 'Trivandrum'),
('Ravi Pillai', 'Male', '1982-07-30', 'Calicut');

-- Crimes
INSERT INTO crimes (type, location, date, description, status) VALUES
('Theft', 'Kochi', '2023-09-12', 'Jewelry stolen from residence', 'Open'),
('Assault', 'Trivandrum', '2023-08-22', 'Fight in public space', 'Closed'),
('Cybercrime', 'Online', '2023-10-05', 'Phishing scam report', 'Open');

-- FIRs
INSERT INTO firs (crime_id, suspect_id, officer_id, date_filed, remarks) VALUES
(1, 1, 1, '2023-09-13', 'Investigation started'),
(2, 2, 2, '2023-08-23', 'Case closed with evidence'),
(3, 3, 1, '2023-10-06', 'Tracking IPs');
