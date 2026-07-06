/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - Analyze how student activities change over time.
    - Identify trends in attendance, homework, and parent communication.

Views Used:
    - gold.fact_attendance
    - gold.fact_homework
    - gold.fact_teacher_parent_communication

SQL Functions Used:
    - YEAR()
    - MONTH()
    - DATETRUNC()
    - FORMAT()
    - COUNT()
    - AVG()
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- ---------------------------
-- 1. Monthly Attendance Trend
-- ---------------------------
SELECT
    YEAR(attendance_date) AS attendance_year,
    MONTH(attendance_date) AS attendance_month,
    COUNT(*) AS total_attendance_records
FROM gold.fact_attendance
WHERE attendance_date IS NOT NULL
GROUP BY
    YEAR(attendance_date),
    MONTH(attendance_date)
ORDER BY attendance_year, attendance_month;


-- -------------------------------
-- 2. Monthly Homework Assignments
-- -------------------------------
SELECT
    FORMAT(assignment_due_date, 'MMM-yyyy') AS assignment_month,
    COUNT(*) AS total_assignments
FROM gold.fact_homework
WHERE assignment_due_date IS NOT NULL
GROUP BY FORMAT(assignment_due_date, 'MMM-yyyy')
ORDER BY MIN(assignment_due_date);


-- --------------------------------
-- 3. Monthly Parent Communications
-- --------------------------------
SELECT
    FORMAT(communication_date, 'MMM-yyyy') AS communication_month,
    COUNT(*) AS total_communications
FROM gold.fact_teacher_parent_communication
WHERE communication_date IS NOT NULL
GROUP BY FORMAT(communication_date, 'MMM-yyyy')
ORDER BY MIN(communication_date);