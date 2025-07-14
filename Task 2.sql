DROP TABLE IF EXISTS student_table;

CREATE TABLE student_table (
    Student_id INTEGER PRIMARY KEY,
    Stu_name TEXT,
    Department TEXT,
    email_id TEXT,
    Phone_no NUMERIC,
    Address TEXT,
    Date_of_birth DATE,
    Gender TEXT,
    Major TEXT,
    GPA NUMERIC,
    Grade TEXT CHECK (Grade IN ('A', 'B', 'C', 'D', 'F'))
);

INSERT INTO student_table VALUES
(1, 'Alice', 'Computer Science', 'alice@example.com', 9876543210, 'Chennai', '2001-03-10', 'Female', 'AI', 8.7, 'A'),
(2, 'Bob', 'Mechanical', 'bob@example.com', 9123456780, 'Mumbai', '2000-04-21', 'Male', 'Thermodynamics', 6.5, 'B'),
(3, 'Charlie', 'Electronics', 'charlie@example.com', 9988776655, 'Delhi', '2002-01-15', 'Male', 'Embedded Systems', 4.8, 'C'),
(4, 'David', 'Computer Science', 'david@example.com', 9911223344, 'Bangalore', '2001-06-30', 'Male', 'Cybersecurity', 9.1, 'A'),
(5, 'Eve', 'Electrical', 'eve@example.com', 9876501234, 'Pune', '2003-09-12', 'Female', 'Power Systems', 5.9, 'B'),
(6, 'Frank', 'Mechanical', 'frank@example.com', 9900112233, 'Hyderabad', '2000-11-05', 'Male', 'Design', 3.2, 'D'),
(7, 'Grace', 'Civil', 'grace@example.com', 8899776655, 'Kolkata', '2001-12-01', 'Female', 'Structural Engg.', 7.0, 'B'),
(8, 'Hank', 'Computer Science', 'hank@example.com', 9988001122, 'Delhi', '2002-08-25', 'Male', 'Software Engg.', 8.0, 'A'),
(9, 'Ivy', 'Electronics', 'ivy@example.com', 9776655443, 'Chennai', '2003-03-15', 'Female', 'VLSI', 4.5, 'C'),
(10, 'Jack', 'Electrical', 'jack@example.com', 9112233445, 'Mumbai', '2000-10-10', 'Male', 'Control Systems', 5.2, 'B');

SELECT * 
FROM student_table 
ORDER BY Grade DESC;

SELECT * 
FROM student_table 
WHERE Gender = 'Male';

SELECT * 
FROM student_table 
WHERE GPA < 5.0;

UPDATE student_table
SET email_id = 'charlie_new@example.com',
    Grade = 'B'
WHERE Student_id = 3;

SELECT 
    Stu_name,
    DATE_PART('year', AGE(Date_of_birth)) AS Age
FROM 
    student_table
WHERE 
    Grade = 'B';

SELECT 
    Department,
    Gender,
    ROUND(AVG(GPA), 2) AS Avg_GPA
FROM 
    student_table
GROUP BY 
    Department, Gender
ORDER BY 
    Department, Gender;

ALTER TABLE student_table RENAME TO student_info;

SELECT Stu_name
FROM student_info
WHERE GPA = (SELECT MAX(GPA) FROM student_info);
