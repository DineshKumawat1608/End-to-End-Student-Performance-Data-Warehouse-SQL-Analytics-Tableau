/*
===============================================================================
Date Exploration
===============================================================================
Purpose:
    - Determine the temporal boundaries of the dataset.
    - Understand the available date ranges for attendance, homework,
      parent communication, and student birth dates.

Views Used:
    - gold.fact_attendance
    - gold.fact_homework
    - gold.fact_teacher_parent_communication
    - gold.dim_students

SQL Functions Used:
    - MIN()
    - MAX()
    - DATEDIFF()
    - GETDATE()
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- 1. Determine the first and last attendance date and the total duration in days.
SELECT
    MIN(attendance_date) AS first_attendance_date,
    MAX(attendance_date) AS last_attendance_date,
    DATEDIFF(MONTH, MIN(attendance_date), MAX(attendance_date)) AS attendance_range_days
FROM gold.fact_attendance;


-- 2. Determine the first and last birth date and Find the youngest and oldest students in years
SELECT
    MIN(Date_of_Birth) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(Date_of_Birth), GETDATE()) AS oldest_student_age,
    MAX(Date_of_Birth) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(Date_of_Birth), GETDATE()) AS youngest_student_age
FROM gold.dim_students;


-- 3. Determine the first and last assignment_due_date to check outliars.
SELECT
    MIN(assignment_due_date) AS first_due_date,
    MAX(assignment_due_date) AS last_due_date
FROM gold.fact_homework;


-- 4. Determine the first and last last_communication_date to check outliars.
SELECT
    MIN(communication_date) AS first_communication_date,
    MAX(communication_date) AS last_communication_date
FROM gold.fact_teacher_parent_communication;
