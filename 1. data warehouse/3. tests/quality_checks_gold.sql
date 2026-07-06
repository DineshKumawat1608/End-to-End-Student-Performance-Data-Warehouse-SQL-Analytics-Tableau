/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity,
    consistency, and accuracy of the Gold layer.

    These checks ensure:
        - Uniqueness of surrogate keys in dimension views.
        - Referential integrity between fact and dimension views.
        - Validation of relationships in the star schema.

Usage Notes:
    - Each query should return 0 rows unless otherwise stated.
    - Investigate any returned records before using the data for reporting.
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- =============================================================================
-- Check: gold.dim_students
-- =============================================================================

-- Verify uniqueness of Student Key
SELECT
    student_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_students
GROUP BY student_key
HAVING COUNT(*) > 1;


-- =============================================================================
-- Check: gold.dim_subjects
-- =============================================================================

-- Verify uniqueness of Subject Key
SELECT
    subject_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_subjects
GROUP BY subject_key
HAVING COUNT(*) > 1;


-- =============================================================================
-- Check: gold.fact_attendance
-- =============================================================================

-- Verify relationship with dimensions
SELECT *
FROM gold.fact_attendance fa
LEFT JOIN gold.dim_students ds
    ON fa.student_key = ds.student_key
LEFT JOIN gold.dim_subjects dsub
    ON fa.subject_key = dsub.subject_key
WHERE ds.student_key IS NULL
   OR dsub.subject_key IS NULL;


-- Check for Duplicate Rows
SELECT
    student_key,
    subject_key,
    attendance_date,
    attendance_status,
    COUNT(*) AS duplicate_count
FROM gold.fact_attendance
GROUP BY
    student_key,
    subject_key,
    attendance_date,
    attendance_status
HAVING COUNT(*) > 1;

-- =============================================================================
-- Check: gold.fact_homework
-- =============================================================================

-- Verify relationship with dimensions
SELECT *
FROM gold.fact_homework fh
LEFT JOIN gold.dim_students ds
    ON fh.student_key = ds.student_key
LEFT JOIN gold.dim_subjects dsub
    ON fh.subject_key = dsub.subject_key
WHERE ds.student_key IS NULL
   OR dsub.subject_key IS NULL;


-- =============================================================================
-- Check: gold.fact_performance
-- =============================================================================

-- Verify relationship with dimensions
SELECT *
FROM gold.fact_performance fp
LEFT JOIN gold.dim_students ds
    ON fp.student_key = ds.student_key
LEFT JOIN gold.dim_subjects dsub
    ON fp.subject_key = dsub.subject_key
WHERE ds.student_key IS NULL
   OR dsub.subject_key IS NULL;


-- =============================================================================
-- Check: gold.fact_teacher_parent_communication
-- =============================================================================

-- Verify relationship with Student Dimension
SELECT *
FROM gold.fact_teacher_parent_communication fc
LEFT JOIN gold.dim_students ds
    ON fc.student_key = ds.student_key
WHERE ds.student_key IS NULL;