/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the Silver layer, dropping existing tables
    if they already exist.

    Run this script to recreate the Silver layer table structure.
===============================================================================
*/

-- =============================================================================
-- Table: attendance
-- =============================================================================
IF OBJECT_ID('silver.attendance', 'U') IS NOT NULL
    DROP TABLE silver.attendance;
GO

CREATE TABLE silver.attendance (
    Student_ID          VARCHAR(10),
    Date                DATE,
    Subject             VARCHAR(50),
    Attendance_Status   VARCHAR(50),
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO

-- =============================================================================
-- Table: homework
-- =============================================================================
IF OBJECT_ID('silver.homework', 'U') IS NOT NULL
    DROP TABLE silver.homework;
GO

CREATE TABLE silver.homework (
    Student_ID          VARCHAR(10),
    Subject             VARCHAR(20),
    Assignment_Name     VARCHAR(50),
    Due_Date            DATE,
    Status              VARCHAR(10),
    Grade_Feedback      VARCHAR(5),
    Guardian_Signature  VARCHAR(5),
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO

-- =============================================================================
-- Table: performance
-- =============================================================================
IF OBJECT_ID('silver.performance', 'U') IS NOT NULL
    DROP TABLE silver.performance;
GO

CREATE TABLE silver.performance (
    Student_ID                      VARCHAR(10),
    Subject                         VARCHAR(10),
    Exam_Score                      DECIMAL(6,2),
    Homework_Completion_Percentage  VARCHAR(10),
    Teacher_Comments                VARCHAR(300),
    dwh_create_date                 DATETIME2 DEFAULT GETDATE()
);
GO

-- =============================================================================
-- Table: students
-- =============================================================================
IF OBJECT_ID('silver.students', 'U') IS NOT NULL
    DROP TABLE silver.students;
GO

CREATE TABLE silver.students (
    Student_ID          VARCHAR(10) PRIMARY KEY,
    Full_Name           VARCHAR(50),
    Date_of_Birth       DATE,
    Grade_Level         VARCHAR(20),
    Emergency_Contact   VARCHAR(25),
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO

-- =============================================================================
-- Table: teacher_parent_communication
-- =============================================================================
IF OBJECT_ID('silver.teacher_parent_communication', 'U') IS NOT NULL
    DROP TABLE silver.teacher_parent_communication;
GO

CREATE TABLE silver.teacher_parent_communication (
    Student_ID          VARCHAR(10),
    Date                DATE,
    Message_Type        VARCHAR(50),
    Message_Content     VARCHAR(300),
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO