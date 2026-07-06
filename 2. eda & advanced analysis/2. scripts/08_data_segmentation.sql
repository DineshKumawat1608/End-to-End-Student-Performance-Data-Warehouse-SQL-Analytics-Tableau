/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - Segment students into meaningful groups based on academic performance,
      attendance, and homework completion.
    - Help identify high-performing students and students who may require
      additional academic support.

Views Used:
    - gold.dim_students
    - gold.dim_subjects
    - gold.fact_performance

SQL Functions Used:
    - CASE
    - COUNT()
    - AVG()
    - GROUP BY
    - ORDER BY
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- ----------------------------------------
-- 1. Segment Students by Average Exam Score
-- ----------------------------------------
WITH student_performance_segments AS (
    SELECT
        student_key,
        CASE
            WHEN average_exam_score >= 85 THEN 'Excellent'
            WHEN average_exam_score >= 70 THEN 'Good'
            WHEN average_exam_score >= 50 THEN 'Average'
            ELSE 'Needs Improvement'
        END AS performance_segment
    FROM (  SELECT
                ds.student_key,
                AVG(fp.exam_score) AS average_exam_score
            FROM gold.fact_performance fp
            LEFT JOIN gold.dim_students ds ON fp.student_key = ds.student_key
            GROUP BY ds.student_key) t
)
SELECT
    performance_segment,
    COUNT(student_key) AS total_students
FROM student_performance_segments
GROUP BY performance_segment
ORDER BY total_students DESC;


-- ----------------------------------------
-- 2. Segment Students by Homework Completion
-- ----------------------------------------
WITH student_homework_segments AS (
    SELECT
        student_key,
        CASE
            WHEN average_completion >= 90 THEN 'Highly Consistent'
            WHEN average_completion >= 70 THEN 'Consistent'
            WHEN average_completion >= 50 THEN 'Moderate'
            ELSE 'Low Completion'
        END AS homework_segment
    FROM (
            SELECT
                ds.student_key,
                AVG(fp.homework_completion_percentage) AS average_completion
            FROM gold.fact_performance fp
            LEFT JOIN gold.dim_students ds ON fp.student_key = ds.student_key
            GROUP BY ds.student_key) t
)
SELECT
    homework_segment,
    COUNT(student_key) AS total_students
FROM student_homework_segments
GROUP BY homework_segment
ORDER BY total_students DESC;


-- -----------------------------------------
-- 3. Segment Subjects by Average Exam Score
-- -----------------------------------------
WITH subject_performance_segments AS (
    SELECT
        subject_key,
        CASE
            WHEN average_exam_score >= 85 THEN 'High Performing'
            WHEN average_exam_score >= 70 THEN 'Moderate Performing'
            ELSE 'Needs Attention'
        END AS subject_segment
    FROM (
            SELECT
                dsub.subject_key,
                AVG(fp.exam_score) AS average_exam_score
            FROM gold.fact_performance fp
            LEFT JOIN gold.dim_subjects dsub ON fp.subject_key = dsub.subject_key
            GROUP BY dsub.subject_key) t
)
SELECT
    subject_segment,
    COUNT(subject_key) AS total_subjects
FROM subject_performance_segments
GROUP BY subject_segment
ORDER BY total_subjects DESC;