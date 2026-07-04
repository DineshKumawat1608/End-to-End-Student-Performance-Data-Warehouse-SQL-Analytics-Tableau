/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - Explore the structure of the Gold layer.
    - Review the available views and their metadata before starting analysis.

Tables Used:
    - INFORMATION_SCHEMA.VIEWS
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

USE Database_SQL_Project_1;
GO

-- =============================================================================
-- List all views in the Gold layer
-- =============================================================================
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'gold'
ORDER BY TABLE_NAME;


-- =============================================================================
-- View metadata (Columns, Data Types, Nullability)
-- =============================================================================
SELECT
    TABLE_NAME,
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold'
ORDER BY
    TABLE_NAME,
    ORDINAL_POSITION;