/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the Bronze layer, dropping existing tables
    if they already exist.

    Run this script to recreate the Bronze layer table structure.

NOTE (Medallion Architecture):
    Bronze layer stores raw data exactly as received from the source files.
    Only essential constraints (such as Primary Keys where appropriate) are
    applied. Foreign Key constraints are intentionally omitted to preserve
    raw data integrity and are implemented in downstream layers if required.
===============================================================================
*/

-- =============================================================================
-- Table: attendance
-- =============================================================================
IF OBJECT_ID('bronze.attendance', 'U') IS NOT NULL
    DROP TABLE bronze.attendance;
GO

CREATE TABLE bronze.attendance (
    Student_ID          VARCHAR(10),
    Date                DATETIME2,
    Subject             VARCHAR(50),
    Attendance_Status   VARCHAR(50)
);
GO

-- =============================================================================
-- Table: homework
-- =============================================================================
IF OBJECT_ID('bronze.homework', 'U') IS NOT NULL
    DROP TABLE bronze.homework;
GO

CREATE TABLE bronze.homework (
    Student_ID          VARCHAR(10),
    Subject             VARCHAR(50),
    Assignment_Name     VARCHAR(50),
    Due_Date            DATE,
    Status              VARCHAR(50),
    Grade_Feedback      VARCHAR(50),
    Guardian_Signature  VARCHAR(50)
);
GO

-- =============================================================================
-- Table: performance
-- =============================================================================
IF OBJECT_ID('bronze.performance', 'U') IS NOT NULL
    DROP TABLE bronze.performance;
GO

CREATE TABLE bronze.performance (
    Student_ID                      VARCHAR(10),
    Subject                         VARCHAR(50),
    Exam_Score                      DECIMAL(6,2),
    Homework_Completion_Percentage  VARCHAR(50),
    Teacher_Comments                VARCHAR(300)
);
GO

-- =============================================================================
-- Table: students
-- =============================================================================
IF OBJECT_ID('bronze.students', 'U') IS NOT NULL
    DROP TABLE bronze.students;
GO

CREATE TABLE bronze.students (
    Student_ID          VARCHAR(10) PRIMARY KEY,
    Full_Name           VARCHAR(50),
    Date_of_Birth       DATE,
    Grade_Level         VARCHAR(50),
    Emergency_Contact   VARCHAR(55)
);
GO

-- =============================================================================
-- Table: teacher_parent_communication
-- =============================================================================
IF OBJECT_ID('bronze.teacher_parent_communication', 'U') IS NOT NULL
    DROP TABLE bronze.teacher_parent_communication;
GO

CREATE TABLE bronze.teacher_parent_communication (
    Student_ID          VARCHAR(10),
    Date                DATETIME2,
    Message_Type        VARCHAR(100),
    Message_Content     VARCHAR(300)
);
GO