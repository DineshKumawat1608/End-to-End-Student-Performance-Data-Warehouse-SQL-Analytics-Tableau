/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - Explore the descriptive attributes available in the dimension views.
    - Understand the available categories used for filtering and grouping data
      during analytical reporting.

Views Used:
    - gold.dim_students
    - gold.dim_subjects

SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- 1. Retrieve a list of unique assignment_status to explore the different types of assignment statuses.
SELECT
    DISTINCT assignment_status
FROM gold.fact_homework
ORDER BY assignment_status ASC;


-- 2. Retrieve a list of unique guardian_signature to explore the different types of signatures by the guardians.
SELECT
    DISTINCT guardian_signature
FROM gold.fact_homework
ORDER BY guardian_signature ASC;


-- 3. Retrieve a list of unique grades obtained by the students.
SELECT
    DISTINCT grade
FROM gold.dim_students
ORDER BY grade ASC;


-- 4. Retrieve a list of unique subjects studied by the students.
SELECT DISTINCT
    subject_name
FROM gold.dim_subjects
ORDER BY subject_name ASC;