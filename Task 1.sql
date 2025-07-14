DROP TABLE IF EXISTS EnrollmentInfo;
DROP TABLE IF EXISTS CoursesInfo;
DROP TABLE IF EXISTS StudentInfo;


CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS TEXT
);

CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20), 
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);


INSERT INTO StudentInfo VALUES
(1, 'Alice', '2001-03-10', '9876543210', 'alice@example.com', 'Chennai'),
(2, 'Bob', '2002-05-20', '9123456780', 'bob@example.com', 'Mumbai'),
(3, 'Charlie', '2000-11-15', '9988776655', 'charlie@example.com', 'Delhi'),
(4, 'David', '2001-09-25', '9911223344', 'david@example.com', 'Bangalore');

INSERT INTO CoursesInfo VALUES
(101, 'Mathematics', 'Dr. Smith'),
(102, 'Physics', 'Dr. Ray'),
(103, 'Computer Science', 'Prof. Anand');

INSERT INTO EnrollmentInfo VALUES
(1, 1, 101, 'Enrolled'),
(2, 1, 103, 'Enrolled'),
(3, 2, 102, 'Enrolled'),
(4, 3, 101, 'Enrolled'),
(5, 3, 102, 'Not Enrolled'),
(6, 4, 103, 'Enrolled');

SELECT 
    S.STU_NAME, S.PHONE_NO, S.EMAIL_ID, E.ENROLL_STATUS
FROM 
    StudentInfo S
LEFT JOIN 
    EnrollmentInfo E ON S.STU_ID = E.STU_ID;

SELECT 
    C.COURSE_NAME
FROM 
    CoursesInfo C
JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE 
    E.STU_ID = 1 AND E.ENROLL_STATUS = 'Enrolled';

SELECT 
    COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo;

SELECT 
    * 
FROM 
    CoursesInfo
WHERE 
    COURSE_ID = 101;

SELECT 
    * 
FROM 
    CoursesInfo
WHERE 
    COURSE_ID IN (101, 103);

SELECT 
    C.COURSE_NAME,
    COUNT(E.STU_ID) AS Total_Enrolled
FROM 
    CoursesInfo C
JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE 
    E.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    C.COURSE_NAME;

SELECT 
    S.STU_NAME
FROM 
    StudentInfo S
JOIN 
    EnrollmentInfo E ON S.STU_ID = E.STU_ID
WHERE 
    E.COURSE_ID = 101 AND E.ENROLL_STATUS = 'Enrolled';

SELECT 
    C.COURSE_INSTRUCTOR_NAME,
    COUNT(E.STU_ID) AS Enrolled_Students
FROM 
    CoursesInfo C
JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE 
    E.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    C.COURSE_INSTRUCTOR_NAME;

SELECT 
    S.STU_NAME,
    COUNT(E.COURSE_ID) AS No_of_Courses
FROM 
    StudentInfo S
JOIN 
    EnrollmentInfo E ON S.STU_ID = E.STU_ID
WHERE 
    E.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    S.STU_ID, S.STU_NAME
HAVING 
    COUNT(E.COURSE_ID) > 1;

SELECT 
    C.COURSE_NAME,
    COUNT(E.STU_ID) AS Enrolled_Count
FROM 
    CoursesInfo C
JOIN 
    EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
WHERE 
    E.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    C.COURSE_NAME
ORDER BY 
    Enrolled_Count DESC;
