/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - Quantify key metrics by grouping data across different dimensions.
    - Understand the distribution of attendance, homework, performance,
      and communication data.

Views Used:
    - gold.dim_students
    - gold.dim_subjects
    - gold.fact_attendance
    - gold.fact_homework
    - gold.fact_performance
    - gold.fact_teacher_parent_communication

SQL Functions Used:
    - COUNT()
    - AVG()
    - GROUP BY
    - ORDER BY
    - JOINS

===============================================================================
*/

USE Database_SQL_Project_1;
GO


-- 1. Total Students by Grade
SELECT
    grade,
    COUNT(student_key) AS total_students
FROM gold.dim_students
GROUP BY grade
ORDER BY total_students DESC;


-- 2. Average Exam Score by Subject
SELECT
    ds.subject_name,
    ROUND(AVG(CAST(fp.exam_score AS FLOAT)), 2) AS average_exam_score
FROM gold.fact_performance fp
LEFT JOIN gold.dim_subjects ds
    ON fp.subject_key = ds.subject_key
GROUP BY ds.subject_name
ORDER BY average_exam_score DESC;


-- 3. Total Attendance Records by Subject
SELECT
    ds.subject_name,
    COUNT(*) AS total_attendance_records
FROM gold.fact_attendance fa
LEFT JOIN gold.dim_subjects ds
    ON fa.subject_key = ds.subject_key
GROUP BY ds.subject_name
ORDER BY total_attendance_records DESC;


-- 4. Homework Assignments by Subject
SELECT
    ds.subject_name,
    COUNT(*) AS total_homework_assignments
FROM gold.fact_homework fh
LEFT JOIN gold.dim_subjects ds
    ON fh.subject_key = ds.subject_key
GROUP BY ds.subject_name
ORDER BY total_homework_assignments DESC;


-- 5. Average Homework Completion Percentage by Grade
SELECT
    s.grade,
    AVG(fp.homework_completion_percentage) AS average_homework_completion_percentage
FROM gold.fact_performance fp
LEFT JOIN gold.dim_students s
    ON fp.student_key = s.student_key
GROUP BY s.grade
ORDER BY average_homework_completion_percentage DESC;


-- 6. Parent Communications by Grade
SELECT
    s.grade,
    COUNT(*) AS total_parent_communications
FROM gold.fact_teacher_parent_communication fc
LEFT JOIN gold.dim_students s
    ON fc.student_key = s.student_key
GROUP BY s.grade
ORDER BY total_parent_communications DESC;