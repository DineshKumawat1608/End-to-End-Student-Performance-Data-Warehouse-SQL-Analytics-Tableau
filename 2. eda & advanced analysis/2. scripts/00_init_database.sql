/*
===============================================================================
Create Analytics Database
===============================================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after
    checking if it already exists.

    It then creates the Gold schema along with all dimension and fact tables
    using the cleaned analytical datasets exported from the Gold layer.

WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics'
    database if it already exists.

    All data in the database will be permanently deleted.
    Ensure you have proper backups before running this script.
===============================================================================
*/

USE master;
GO

IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'Database_SQL_Project_1_Analytics'
)
BEGIN
    ALTER DATABASE Database_SQL_Project_1_Analytics
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE Database_SQL_Project_1_Analytics;
END;
GO

CREATE DATABASE Database_SQL_Project_1_Analytics;
GO

USE Database_SQL_Project_1_Analytics;
GO

-- ============================================================================
-- Create Schema
-- ============================================================================

CREATE SCHEMA gold;
GO

-- ============================================================================
-- Create Dimension Tables
-- ============================================================================

CREATE TABLE gold.dim_students
(
    student_key             BIGINT,
    student_id              VARCHAR(50),
    student_name            VARCHAR(255),
    date_of_birth           DATE,
    grade                   VARCHAR(50),
    contact_number          VARCHAR(50)
);
GO

CREATE TABLE gold.dim_subjects
(
    subject_key             INT,
    subject_name            VARCHAR(100)
);
GO

-- ============================================================================
-- Create Fact Tables
-- ============================================================================

CREATE TABLE gold.fact_attendance
(
    student_key             BIGINT,
    subject_key             INT,
    attendance_date         DATE,
    attendance_status       VARCHAR(50)
);
GO

CREATE TABLE gold.fact_homework
(
    student_key                     BIGINT,
    subject_key                     INT,
    assignment_name                 VARCHAR(255),
    assignment_due_date             DATE,
    assignment_status               VARCHAR(50),
    grade_feedback                  VARCHAR(100),
    guardian_signature              VARCHAR(20)
);
GO

CREATE TABLE gold.fact_performance
(
    student_key                     BIGINT,
    subject_key                     INT,
    exam_score                      DECIMAL(5,2),
    homework_completion_percentage  INT,
    teacher_comments                VARCHAR(255)
);
GO

CREATE TABLE gold.fact_teacher_parent_communication
(
    student_key         BIGINT,
    communication_date  DATE,
    message_type        VARCHAR(100),
    message_content     VARCHAR(500)
);
GO

-- ============================================================================
-- Load Dimension Tables
-- ============================================================================

TRUNCATE TABLE gold.dim_students;
GO

BULK INSERT gold.dim_students
FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\3_eda_&_advanced_analysis_project\1. datasets\dim_students.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

TRUNCATE TABLE gold.dim_subjects;
GO

BULK INSERT gold.dim_subjects
FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\3_eda_&_advanced_analysis_project\1. datasets\dim_subjects.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

-- ============================================================================
-- Load Fact Tables
-- ============================================================================

TRUNCATE TABLE gold.fact_attendance;
GO

BULK INSERT gold.fact_attendance
FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\3_eda_&_advanced_analysis_project\1. datasets\fact_attendance.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

TRUNCATE TABLE gold.fact_homework;
GO

BULK INSERT gold.fact_homework
FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\3_eda_&_advanced_analysis_project\1. datasets\fact_homework.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

TRUNCATE TABLE gold.fact_performance;
GO

BULK INSERT gold.fact_performance
FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\3_eda_&_advanced_analysis_project\1. datasets\fact_performance.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

TRUNCATE TABLE gold.fact_teacher_parent_communication;
GO

BULK INSERT gold.fact_teacher_parent_communication
FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\3_eda_&_advanced_analysis_project\1. datasets\fact_teacher_parent_communication.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO