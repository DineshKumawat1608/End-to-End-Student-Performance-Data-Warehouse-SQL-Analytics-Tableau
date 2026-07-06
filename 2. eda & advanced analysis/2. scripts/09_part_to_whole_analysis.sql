/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - Determine the percentage contribution of different categories to the
      overall dataset.
    - Understand the distribution of attendance, homework, and students
      across different categories.

Views Used:
    - gold.dim_students
    - gold.fact_attendance
    - gold.fact_homework

SQL Functions Used:
    - COUNT()
    - AVG()
    - SUM() OVER()
    - ROUND()
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- ==============================
-- Attendance Status Distribution
-- ==============================
WITH attendance_distribution AS (
    SELECT
        attendance_status,
        COUNT(*) AS total_records
    FROM gold.fact_attendance
    GROUP BY attendance_status
)
SELECT
    attendance_status,
    total_records,
    SUM(total_records) OVER () AS overall_records,
    ROUND(total_records * 100.0 / SUM(CAST(total_records AS FLOAT)) OVER (), 2) AS percentage_of_total
FROM attendance_distribution
ORDER BY percentage_of_total DESC;


-- ============================
-- Homework Status Distribution
-- ============================
WITH homework_distribution AS (
    SELECT
        assignment_status,
        COUNT(*) AS total_assignments
    FROM gold.fact_homework
    GROUP BY assignment_status
)
SELECT
    assignment_status,
    total_assignments,
    SUM(total_assignments) OVER () AS overall_assignments,
    ROUND(total_assignments * 100.0 / SUM(CAST(total_assignments AS FLOAT)) OVER (), 2) AS percentage_of_total
FROM homework_distribution
ORDER BY percentage_of_total DESC;


-- ==============================
-- Student Distribution by Grade
-- ==============================
WITH grade_distribution AS (
    SELECT
        grade,
        COUNT(*) AS total_students
    FROM gold.dim_students
    GROUP BY grade
)
SELECT
    grade,
    total_students,
    SUM(total_students) OVER () AS overall_students,
    ROUND(total_students * 100.0 / SUM(CAST(total_students AS FLOAT)) OVER (), 2) AS percentage_of_total
FROM grade_distribution
ORDER BY percentage_of_total DESC;