/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold layer represents the final dimension and fact tables (Star Schema).

    Each view performs transformations and combines data from the Silver layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- =============================================================================
-- Create Dimension: gold.dim_students
-- =============================================================================
IF OBJECT_ID('gold.dim_students', 'V') IS NOT NULL
    DROP VIEW gold.dim_students;
GO

CREATE VIEW gold.dim_students AS
SELECT
    ROW_NUMBER() OVER (ORDER BY Student_ID) AS student_key, -- Surrogate Key
    Student_ID                              AS student_id,
    Full_Name                               AS student_name,
    Date_of_Birth                           AS date_of_birth,
    Grade_Level                             AS grade,
    Emergency_Contact                       AS contact_number
FROM silver.students;
GO

-- =============================================================================
-- Create Dimension: gold.dim_subjects
-- =============================================================================
IF OBJECT_ID('gold.dim_subjects', 'V') IS NOT NULL
    DROP VIEW gold.dim_subjects;
GO

CREATE VIEW gold.dim_subjects AS
SELECT
    CAST(ROW_NUMBER() OVER (ORDER BY subject) as INT) AS subject_key, -- Surrogate Key
    subject                              AS subject_name
FROM (
    SELECT subject FROM silver.attendance
    UNION
    SELECT subject FROM silver.homework
    UNION
    SELECT subject FROM silver.performance
) s;
GO

-- =============================================================================
-- Create Fact: gold.fact_attendance
-- =============================================================================
IF OBJECT_ID('gold.fact_attendance', 'V') IS NOT NULL
    DROP VIEW gold.fact_attendance;
GO

CREATE VIEW gold.fact_attendance AS
SELECT
    ds.student_key               AS student_key,
    dsub.subject_key             AS subject_key,
    a.Date                       AS attendance_date,
    a.Attendance_Status          AS attendance_status
FROM silver.attendance a
INNER JOIN gold.dim_students ds
    ON a.Student_ID = ds.student_id
INNER JOIN gold.dim_subjects dsub
    ON a.Subject = dsub.subject_name;
GO

-- =============================================================================
-- Create Fact: gold.fact_homework
-- =============================================================================
IF OBJECT_ID('gold.fact_homework', 'V') IS NOT NULL
    DROP VIEW gold.fact_homework;
GO

CREATE VIEW gold.fact_homework AS
SELECT
    ds.student_key                       AS student_key,
    dsub.subject_key                     AS subject_key,
    h.Assignment_Name                    AS assignment_name,
    h.Due_Date                           AS assignment_due_date,
    h.Status                             AS assignment_status,
    h.Grade_Feedback                     AS grade_feedback,
    h.Guardian_Signature                 AS guardian_signature
FROM silver.homework h
INNER JOIN gold.dim_students ds
    ON h.Student_ID = ds.student_id
INNER JOIN gold.dim_subjects dsub
    ON h.Subject = dsub.subject_name;
GO

-- =============================================================================
-- Create Fact: gold.fact_performance
-- =============================================================================
IF OBJECT_ID('gold.fact_performance', 'V') IS NOT NULL
    DROP VIEW gold.fact_performance;
GO

CREATE VIEW gold.fact_performance AS
SELECT
    ds.student_key                                  AS student_key,
    dsub.subject_key                                AS subject_key,
    p.Exam_Score                                    AS exam_score,
    CAST(p.Homework_Completion_Percentage as INT)   AS homework_completion_percentage,
    p.Teacher_Comments                              AS teacher_comments
FROM silver.performance p
INNER JOIN gold.dim_students ds
    ON p.Student_ID = ds.student_id
INNER JOIN gold.dim_subjects dsub
    ON p.Subject = dsub.subject_name;
GO

-- =============================================================================
-- Create Fact: gold.fact_teacher_parent_communication
-- =============================================================================
IF OBJECT_ID('gold.fact_teacher_parent_communication', 'V') IS NOT NULL
    DROP VIEW gold.fact_teacher_parent_communication;
GO

CREATE VIEW gold.fact_teacher_parent_communication AS
SELECT
    ds.student_key               AS student_key,
    c.Date                       AS communication_date,
    c.Message_Type               AS message_type,
    c.Message_Content            AS message_content
FROM silver.teacher_parent_communication c
INNER JOIN gold.dim_students ds
    ON c.Student_ID = ds.student_id;
GO