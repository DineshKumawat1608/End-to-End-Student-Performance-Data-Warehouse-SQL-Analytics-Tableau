/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads raw data from external CSV files into the
    Bronze layer.

    The procedure performs the following actions:
    - Truncates existing Bronze tables.
    - Loads data from CSV files using BULK INSERT.
    - Records the load duration for each table and the overall batch.

Parameters:
    None.

Usage:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @start_time       DATETIME,
        @end_time         DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time   DATETIME;

    BEGIN TRY

        SET @batch_start_time = GETDATE();

        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading Tables';
        PRINT '------------------------------------------------';

        -- =============================================================================
        -- Table: attendance
        -- =============================================================================
        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.attendance';
        TRUNCATE TABLE bronze.attendance;

        PRINT '>> Loading Data Into: bronze.attendance';

        BULK INSERT bronze.attendance
        FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\1_dataset\Student Performance and Attendance Dataset\attendance.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';
        PRINT '------------------------------------------------';


        -- =============================================================================
        -- Table: homework
        -- =============================================================================
        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.homework';
        TRUNCATE TABLE bronze.homework;

        PRINT '>> Loading Data Into: bronze.homework';

        BULK INSERT bronze.homework
        FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\1_dataset\Student Performance and Attendance Dataset\homework.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';
        PRINT '------------------------------------------------';


        -- =============================================================================
        -- Table: performance
        -- =============================================================================
        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.performance';
        TRUNCATE TABLE bronze.performance;

        PRINT '>> Loading Data Into: bronze.performance';

        BULK INSERT bronze.performance
        FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\1_dataset\Student Performance and Attendance Dataset\performance.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';
        PRINT '------------------------------------------------';


        -- =============================================================================
        -- Table: students
        -- =============================================================================
        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.students';
        TRUNCATE TABLE bronze.students;

        PRINT '>> Loading Data Into: bronze.students';

        BULK INSERT bronze.students
        FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\1_dataset\Student Performance and Attendance Dataset\students.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';
        PRINT '------------------------------------------------';


        -- =============================================================================
        -- Table: teacher_parent_communication
        -- =============================================================================
        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.teacher_parent_communication';
        TRUNCATE TABLE bronze.teacher_parent_communication;

        PRINT '>> Loading Data Into: bronze.teacher_parent_communication';

        BULK INSERT bronze.teacher_parent_communication
        FROM 'D:\Projects\SQL_P1_Student_Performance_and_Attendance\1_dataset\Student Performance and Attendance Dataset\teacher_parent_communication.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';
        PRINT '------------------------------------------------';


        SET @batch_end_time = GETDATE();

        PRINT '================================================';
        PRINT 'Bronze Layer Loaded Successfully';
        PRINT 'Total Load Duration: '
            + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR)
            + ' seconds';
        PRINT '================================================';

    END TRY

    BEGIN CATCH

        PRINT '================================================';
        PRINT 'ERROR OCCURRED WHILE LOADING THE BRONZE LAYER';
        PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT '================================================';

    END CATCH

END;
GO