/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - Rank students, subjects, and grades based on academic performance.
    - Identify top and bottom performers using aggregate and ranking functions.

Views Used:
    - gold.dim_students
    - gold.dim_subjects
    - gold.fact_performance

SQL Functions Used:
    - RANK()
    - DENSE_RANK()
    - ROW_NUMBER()
    - AVG()
    - GROUP BY
    - ORDER BY
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- 1. Top 10 Students by Total Exam Score ( RANK() ).
WITH ranked_query AS (
    SELECT 
        ds.student_key,
        ds.student_name,
        ds.grade,
        ROUND(SUM(CAST(fp.exam_score AS FLOAT)), 1) AS total_exam_score,
        RANK() OVER (ORDER BY SUM(fp.exam_score) DESC) AS student_rank
    FROM gold.fact_performance fp
    LEFT JOIN gold.dim_students ds
        ON fp.student_key = ds.student_key
    GROUP BY
        ds.student_key,
        ds.student_name,
        ds.grade
)
SELECT * FROM ranked_query
WHERE student_rank <= 10;


-- 2. Top Students by Average Exam Score ( DENSE_RANK() ).
WITH ranked_query AS (
    SELECT 
        ds.student_key,
        ds.student_name,
        ds.grade,
        ROUND(AVG(CAST(fp.exam_score AS FLOAT)), 2) AS avg_exam_score,
        DENSE_RANK() OVER (ORDER BY AVG(fp.exam_score) DESC) AS student_rank
    FROM gold.fact_performance fp
    LEFT JOIN gold.dim_students ds ON fp.student_key = ds.student_key
    GROUP BY
        ds.student_key,
        ds.student_name,
        ds.grade
)
SELECT * 
FROM ranked_query
WHERE student_rank <= 10;


-- 3. Bottom 10 Students by Average Exam Score ( DENSE_RANK() ).
WITH ranked_query AS (
    SELECT
        ds.student_name,
        ds.grade,
        ROUND(AVG(CAST(fp.exam_score AS FLOAT)), 0) AS average_exam_score,
        DENSE_RANK() OVER (ORDER BY AVG(fp.exam_score) ASC) AS student_rank
    FROM gold.fact_performance fp
    LEFT JOIN gold.dim_students ds ON fp.student_key = ds.student_key
    GROUP BY 
        ds.student_name, 
        ds.grade
)
SELECT * 
FROM ranked_query
WHERE student_rank <= 10;


-- 4. Rank Subjects by Average Exam Score ( DENSE_RANK() )
SELECT
    dsub.subject_name,
    ROUND(AVG(CAST(fp.exam_score AS FLOAT)), 2) AS average_exam_score,
    DENSE_RANK() OVER (ORDER BY AVG(fp.exam_score) DESC) AS subject_rank
FROM gold.fact_performance fp
LEFT JOIN gold.dim_subjects dsub ON fp.subject_key = dsub.subject_key
GROUP BY dsub.subject_name
ORDER BY  subject_rank;



-- 5. Rank Grades by Average Exam Score ( ROW_NUMBER() )
SELECT
    ds.grade,
    ROUND(AVG(CAST(fp.exam_score AS FLOAT)), 2) AS average_exam_score,
    ROW_NUMBER() OVER (ORDER BY AVG(fp.exam_score) DESC) AS grade_rank
FROM gold.fact_performance fp
LEFT JOIN gold.dim_students ds ON fp.student_key = ds.student_key
GROUP BY ds.grade
ORDER BY grade_rank;