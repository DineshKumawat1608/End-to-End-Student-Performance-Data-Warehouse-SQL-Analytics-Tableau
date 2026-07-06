/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/



CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CSV Tables';
		PRINT '------------------------------------------------';
		--------------------------------------------------------------------------------------------------
		-- Loading silver.attendance
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.attendance';
		TRUNCATE TABLE silver.attendance;
		PRINT '>> Inserting Data Into: silver.attendance';
		;WITH cleaned AS
		(
			SELECT
				Student_ID,
				CAST(Date AS DATE) AS Date,
				TRIM(Subject) AS Subject,
				CASE LOWER(TRIM(Attendance_Status))
					WHEN 'absnt' THEN 'absent'
					ELSE LOWER(TRIM(Attendance_Status))
				END AS Attendance_Status
			FROM bronze.attendance
		),
		dedup AS
		(
			SELECT *,
				   ROW_NUMBER() OVER (PARTITION BY Student_ID, Date, Subject, Attendance_Status ORDER BY Student_ID) AS rnk
			FROM cleaned
		)
		INSERT INTO silver.attendance
		(
			Student_ID,
			Date,
			Subject,
			Attendance_Status
		)
		SELECT
			Student_ID,
			Date,
			Subject,
			Attendance_Status
		FROM dedup
WHERE rnk = 1;
				
		SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
		--------------------------------------------------------------------------------------------------
		-- Loading silver.homework
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.homework';
		TRUNCATE TABLE silver.homework;
		PRINT '>> Inserting Data Into: silver.homework';
		INSERT INTO silver.homework (
			Student_ID,
			Subject,
			Assignment_Name,
			Due_Date,
			Status,
			Grade_Feedback,
			Guardian_Signature
		)
		SELECT
			Student_ID,
			TRIM(Subject) AS Subject,
			TRIM(Assignment_Name) AS Assignment_Name,
			Due_Date,
			CASE LOWER(TRIM(Status))
				WHEN 'notdone' THEN 'not done' -- Standardize inconsistent homework status values
				WHEN 'pend' THEN 'pending'
				ELSE LOWER(TRIM(Status))
			END AS Status,
			TRIM(Grade_Feedback) AS Grade_Feedback,
			CASE REPLACE(TRIM(Guardian_Signature), CHAR(13), '')
				WHEN 'Yes' THEN 'Yes'
				WHEN 'No' THEN 'No'
				ELSE 'n/a' -- Replace invalid or blank values with 'n/a'
			END AS Guardian_Signature
		FROM bronze.homework;

        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
		--------------------------------------------------------------------------------------------------
        -- Loading silver.performance
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.performance';
		TRUNCATE TABLE silver.performance;
		PRINT '>> Inserting Data Into: silver.performance';
		INSERT INTO silver.performance (
			Student_ID,
			Subject,
			Exam_Score,
			Homework_Completion_Percentage,
			Teacher_Comments
		)
		SELECT
			Student_ID,
			TRIM(Subject) AS Subject,
			Exam_Score,
			ABS(CAST(REPLACE(Homework_Completion_Percentage, '%', '') AS INT))
				AS Homework_Completion_Percentage, -- Remove '%' and convert to integer
			CASE TRIM(Teacher_Comments)
				WHEN '' THEN 'n/a' -- Replace blank comments with 'n/a'
				ELSE TRIM(Teacher_Comments)
			END AS Teacher_Comments
		FROM bronze.performance
		where Exam_Score <= 100; -- Exclude invalid exam scores above 100
		
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
		--------------------------------------------------------------------------------------------------
        -- Loading silver.students
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.students';
		TRUNCATE TABLE silver.students;
		PRINT '>> Inserting Data Into: silver.students';
		;WITH cleaned_students AS (
			SELECT
				Student_ID,
				Full_Name,
				Date_of_Birth,
				Grade_Level,
				COALESCE(
					REPLACE(
						REPLACE(
							REPLACE(
								REPLACE(TRIM(Emergency_Contact), '(', ''),
							')', ''),
						'.', ''),
					'-', ''),
					'n/a'
				) AS Emergency_Contact_clean -- Remove special characters and replace blank values with 'n/a'
			FROM bronze.students
		)
		INSERT INTO silver.students (
			Student_ID,
			Full_Name,
			Date_of_Birth,
			Grade_Level,
			Emergency_Contact
		)
		SELECT
			Student_ID,
			LOWER(TRIM(Full_Name)) AS Full_Name,
			Date_of_Birth,
			Grade_Level,
			CASE
				WHEN Emergency_Contact_clean LIKE '+1%' THEN Emergency_Contact_clean
				WHEN Emergency_Contact_clean LIKE '+%' THEN '+1' + SUBSTRING(Emergency_Contact_clean, 2, LEN(Emergency_Contact_clean))
				WHEN Emergency_Contact_clean LIKE '001%' THEN '+1' + SUBSTRING(Emergency_Contact_clean, 4, LEN(Emergency_Contact_clean))
				WHEN Emergency_Contact_clean = 'n/a' THEN 'n/a'
				ELSE '+1' + Emergency_Contact_clean
			END AS Emergency_Contact-- Standardize contact numbers by adding the '+1' country code
		FROM cleaned_students;

	    SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

		--------------------------------------------------------------------------------------------------
        -- Loading silver.teacher_parent_communication
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.teacher_parent_communication';
		TRUNCATE TABLE silver.teacher_parent_communication;
		PRINT '>> Inserting Data Into: silver.teacher_parent_communication';
		INSERT INTO silver.teacher_parent_communication (
			Student_ID,
			Date,
			Message_Type,
			Message_Content
		)
		SELECT
			Student_ID,
			CAST(Date AS DATE) AS Date,
			TRIM(Message_Type) AS Message_Type,
			CASE TRIM(Message_Content)
				WHEN '' THEN 'n/a' -- Replace blank message content with 'n/a'
				ELSE TRIM(Message_Content)
			END AS Message_Content
		FROM bronze.teacher_parent_communication;

	    SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
		--------------------------------------------------------------------------------------------------
		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
		
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END