/*
===============================================================================
Script: Silver Data Quality Checks
===============================================================================
Script Purpose:
    This script validates the data loaded into the Silver layer after the ETL
    process. Each query verifies that data cleansing and transformation rules
    have been applied successfully.

Expected Result:
    Unless otherwise stated, each validation query should return 0 rows.
===============================================================================
*/

-- =============================================================================
-- Table: silver.attendance
-- =============================================================================

-- Check for duplicate records
SELECT
    Student_ID,
    Date,
    Subject,
    Attendance_Status,
    COUNT(*) AS duplicate_count
FROM silver.attendance
GROUP BY
    Student_ID,
    Date,
    Subject,
    Attendance_Status
HAVING COUNT(*) > 1;

-- Check for NULL values
SELECT *
FROM silver.attendance
WHERE Student_ID IS NULL
   OR Date IS NULL
   OR Subject IS NULL
   OR Attendance_Status IS NULL;

-- Verify attendance status values
SELECT *
FROM silver.attendance
WHERE Attendance_Status NOT IN ('present', 'absent', 'late', 'excused', 'left early');

-- Check for leading/trailing spaces in Subject
SELECT *
FROM silver.attendance
WHERE Subject <> TRIM(Subject);



-- =============================================================================
-- Table: silver.homework
-- =============================================================================

-- Check for duplicate records
SELECT
    Student_ID,
    Subject,
    Assignment_Name,
    Due_Date,
    COUNT(*) AS duplicate_count
FROM silver.homework
GROUP BY
    Student_ID,
    Subject,
    Assignment_Name,
    Due_Date
HAVING COUNT(*) > 1;

-- Check for NULL values
SELECT *
FROM silver.homework
WHERE Student_ID IS NULL
   OR Subject IS NULL
   OR Assignment_Name IS NULL
   OR Due_Date IS NULL
   OR Status IS NULL
   OR Grade_Feedback IS NULL
   OR Guardian_Signature IS NULL;

-- Verify homework status values
SELECT *
FROM silver.homework
WHERE Status NOT IN ('done', 'pending', 'not done');

-- Verify guardian signature values
SELECT *
FROM silver.homework
WHERE Guardian_Signature NOT IN ('Yes', 'No', 'n/a');

-- Check for leading/trailing spaces
SELECT *
FROM silver.homework
WHERE Subject <> TRIM(Subject)
   OR Assignment_Name <> TRIM(Assignment_Name)
   OR Grade_Feedback <> TRIM(Grade_Feedback);



-- =============================================================================
-- Table: silver.performance
-- =============================================================================

-- Check for duplicate records
SELECT
    Student_ID,
    Subject,
    Exam_Score,
    Homework_Completion_Percentage,
    Teacher_Comments,
    COUNT(*) AS duplicate_count
FROM silver.performance
GROUP BY
    Student_ID,
    Subject,
    Exam_Score,
    Homework_Completion_Percentage,
    Teacher_Comments
HAVING COUNT(*) > 1;

-- Check for NULL values
SELECT *
FROM silver.performance
WHERE Student_ID IS NULL
   OR Subject IS NULL
   OR Exam_Score IS NULL
   OR Homework_Completion_Percentage IS NULL
   OR Teacher_Comments IS NULL;

-- Verify homework completion percentage
SELECT *
FROM silver.performance
WHERE Homework_Completion_Percentage NOT BETWEEN 0 AND 100;

-- Verify teacher comments
SELECT *
FROM silver.performance
WHERE Teacher_Comments = '';

-- Check for leading/trailing spaces
SELECT *
FROM silver.performance
WHERE Subject <> TRIM(Subject)
   OR Teacher_Comments <> TRIM(Teacher_Comments);

-- Check for Exam_Score < 0 or Exam_Score > 100
SELECT *
FROM silver.performance
WHERE Exam_Score < 0
   OR Exam_Score > 100;

-- =============================================================================
-- Table: silver.students
-- =============================================================================

-- Check for duplicate records
SELECT
    Student_ID,
    COUNT(*) AS duplicate_count
FROM silver.students
GROUP BY Student_ID
HAVING COUNT(*) > 1;

-- Check for NULL values
SELECT *
FROM silver.students
WHERE Student_ID IS NULL
   OR Full_Name IS NULL
   OR Date_of_Birth IS NULL
   OR Grade_Level IS NULL
   OR Emergency_Contact IS NULL;

-- Check for leading/trailing spaces
SELECT *
FROM silver.students
WHERE Full_Name <> TRIM(Full_Name)
   OR Grade_Level <> TRIM(Grade_Level);

-- Verify contact number format
SELECT *
FROM silver.students
WHERE Emergency_Contact <> 'n/a'
  AND Emergency_Contact NOT LIKE '+1%';

-- Check for names if they are lowercase or not
SELECT *
FROM silver.students
WHERE Full_Name <> LOWER(Full_Name);

-- =============================================================================
-- Table: silver.teacher_parent_communication
-- =============================================================================

-- Check for NULL values
SELECT *
FROM silver.teacher_parent_communication
WHERE Student_ID IS NULL
   OR Date IS NULL
   OR Message_Type IS NULL
   OR Message_Content IS NULL;

-- Check for leading/trailing spaces
SELECT *
FROM silver.teacher_parent_communication
WHERE Message_Type <> TRIM(Message_Type)
   OR Message_Content <> TRIM(Message_Content);

-- Verify message content
SELECT *
FROM silver.teacher_parent_communication
WHERE Message_Content = '';