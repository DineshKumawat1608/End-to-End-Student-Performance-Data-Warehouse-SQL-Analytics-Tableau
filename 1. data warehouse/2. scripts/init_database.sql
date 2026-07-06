/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'Database_SQL_Project_1' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'Database_SQL_Project_1' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/
USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Database_SQL_Project_1')
BEGIN
    ALTER DATABASE Database_SQL_Project_1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Database_SQL_Project_1;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE Database_SQL_Project_1;
GO

USE Database_SQL_Project_1;
GO

-- Create Bronze, Silver, and Gold schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
