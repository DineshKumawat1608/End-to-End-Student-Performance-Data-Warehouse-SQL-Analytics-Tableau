/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - Calculate key metrics to understand the overall performance of the school.
    - Generate a summary report To identify overall trends or spot anomalies.

Views Used:
    - gold.dim_students
    - gold.dim_subjects
    - gold.fact_attendance
    - gold.fact_homework
    - gold.fact_performance
    - gold.fact_teacher_parent_communication

SQL Functions Used:
    - COUNT()
    - SUM()
    - AVG()
    - DISTINCT
    - UNION ALL
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- 1. Total Students
SELECT COUNT(*) AS total_students
FROM gold.dim_students;

-- 2. Total Subjects
SELECT COUNT(*) AS total_subjects
FROM gold.dim_subjects;

-- 3. Average Exam Score
SELECT ROUND(AVG(CAST(exam_score AS FLOAT)), 2) AS average_exam_score
FROM gold.fact_performance;

-- 4. Average Homework Completion Percentage
SELECT AVG(homework_completion_percentage) AS average_homework_completion_percentage
FROM gold.fact_performance;

-- 5. Total Attendance Records
SELECT COUNT(*) AS total_attendance_records
FROM gold.fact_attendance;

-- 6. Total Homework Assignments
SELECT COUNT(*) AS total_homework_assignments
FROM gold.fact_homework;

-- 7. Total Parent Communications
SELECT COUNT(*) AS total_parent_communications
FROM gold.fact_teacher_parent_communication;

-- ------------------------------------------------------------
-- Generate a Report that shows all key metrics of the School.
-- ------------------------------------------------------------
SELECT 'Total Students' AS measure_name, ROUND(CAST(COUNT(*) AS FLOAT), 2) AS measure_value FROM gold.dim_students
UNION ALL

SELECT 'Total Subjects', COUNT(*) FROM gold.dim_subjects
UNION ALL

SELECT 'Average Exam Score', ROUND(AVG(exam_score), 2) FROM gold.fact_performance
UNION ALL

SELECT 'Average Homework Completion %', AVG(homework_completion_percentage) FROM gold.fact_performance
UNION ALL

SELECT 'Total Attendance Records', COUNT(*) FROM gold.fact_attendance
UNION ALL 

SELECT 'Total Homework Assignments', COUNT(*) FROM gold.fact_homework
UNION ALL

SELECT 'Total Parent Communications', COUNT(*) FROM gold.fact_teacher_parent_communication;