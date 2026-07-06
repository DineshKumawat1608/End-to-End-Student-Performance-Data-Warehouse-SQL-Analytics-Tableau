/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - Calculate cumulative moving averages to monitor long-term academic
      performance and student engagement trends.
    - Track whether the school's average exam scores and homework completion
      rates are improving or declining over time.
    - Identify overall performance trends using window aggregate functions.

Views Used:
    - gold.fact_attendance
    - gold.fact_performance

SQL Functions Used:
    - DATETRUNC()
    - AVG()
    - AVG() OVER()
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- ============================================================================
-- 1. Running Average Exam Score by Attendance Month
-- ============================================================================
SELECT
    attendance_month,
    ROUND(average_exam_score, 2) AS average_exam_score,
    ROUND(AVG(average_exam_score) OVER(ORDER BY attendance_month), 2) AS running_average_exam_score
FROM
(
    SELECT
        DATETRUNC(MONTH, fa.attendance_date) AS attendance_month,
        AVG(CAST(fp.exam_score AS FLOAT)) AS average_exam_score
    FROM gold.fact_attendance fa
    INNER JOIN gold.fact_performance fp ON fa.student_key = fp.student_key
       AND fa.subject_key = fp.subject_key
    GROUP BY DATETRUNC(MONTH, fa.attendance_date)
) t
ORDER BY attendance_month;


-- ============================================================================
-- 2. Running Average Homework Completion by Attendance Month
-- ============================================================================

SELECT
    attendance_month,
    ROUND(average_homework_completion,2) AS average_homework_completion,
    ROUND(AVG(average_homework_completion) OVER (ORDER BY attendance_month), 2) AS running_average_homework_completion
FROM
(
    SELECT
        DATETRUNC(MONTH, fa.attendance_date) AS attendance_month,
        AVG(CAST(fp.homework_completion_percentage AS FLOAT)) AS average_homework_completion
    FROM gold.fact_attendance fa INNER JOIN gold.fact_performance fp ON fa.student_key = fp.student_key
       AND fa.subject_key = fp.subject_key
    GROUP BY DATETRUNC(MONTH, fa.attendance_date)
) t
ORDER BY attendance_month;