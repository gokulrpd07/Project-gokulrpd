DROP TABLE IF EXISTS Registrations;
DROP TABLE IF EXISTS Attendees;
DROP TABLE IF EXISTS Events;

CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name TEXT NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location TEXT NOT NULL,
    Event_Description TEXT
);

CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name TEXT NOT NULL,
    Attendee_Phone TEXT,
    Attendee_Email TEXT,
    Attendee_City TEXT
);

CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount NUMERIC(8,2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description) VALUES
('Tech Conference 2025', '2025-08-15', 'Bangalore', 'A technology event focused on AI and ML.'),
('Startup Meetup', '2025-09-01', 'Hyderabad', 'Meet and pitch to investors.'),
('Music Fest', '2025-07-30', 'Goa', 'A grand celebration of music with multiple bands.');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) VALUES
('Alice', '9876543210', 'alice@example.com', 'Chennai'),
('Bob', '9123456780', 'bob@example.com', 'Mumbai'),
('Charlie', '9988776655', 'charlie@example.com', 'Delhi'),
('David', '9911223344', 'david@example.com', 'Bangalore');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount) VALUES
(1, 1, '2025-07-01', 500.00),
(1, 2, '2025-07-03', 500.00),
(2, 3, '2025-07-05', 300.00),
(3, 4, '2025-07-10', 700.00);

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Design Thinking Workshop', '2025-10-10', 'Pune', 'Workshop on design principles and innovation.');

UPDATE Events
SET Event_Location = 'Online', Event_Date = '2025-10-15'
WHERE Event_Name = 'Design Thinking Workshop';

DELETE FROM Events
WHERE Event_Id = 4;

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Eve', '9990001112', 'eve@example.com', 'Kolkata');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (2, 5, '2025-07-12', 300.00);

-- =========================
-- 6. ANALYTICAL QUERIES
-- =========================

SELECT * FROM Events;

SELECT 
    A.Attendee_Name, A.Attendee_Email, E.Event_Name
FROM 
    Registrations R
JOIN 
    Attendees A ON R.Attendee_Id = A.Attendee_Id
JOIN 
    Events E ON R.Event_Id = E.Event_Id
WHERE 
    E.Event_Name = 'Tech Conference 2025';

SELECT 
    E.Event_Name,
    COUNT(R.Attendee_Id) AS Total_Attendees
FROM 
    Events E
LEFT JOIN 
    Registrations R ON E.Event_Id = R.Event_Id
GROUP BY 
    E.Event_Name
ORDER BY 
    Total_Attendees DESC;

SELECT 
    E.Event_Name,
    COALESCE(SUM(R.Registration_Amount), 0) AS Total_Revenue
FROM 
    Events E
LEFT JOIN 
    Registrations R ON E.Event_Id = R.Event_Id
GROUP BY 
    E.Event_Name;

SELECT 
    E.Event_Name
FROM 
    Events E
LEFT JOIN 
    Registrations R ON E.Event_Id = R.Event_Id
WHERE 
    R.Registration_Id IS NULL;
