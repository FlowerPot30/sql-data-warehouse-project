/*
=============================================================
Create Database and Schemas
=============================================================

Sciprt Purpose: 
  This script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
within the database : 'bronze', 'silver' and 'gold'.
*/

USE master;
GO

IF EXISTS(SELECT 1 FROM sys.databases WHERE name ='DataWarehouse')
BEGIN
  DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create 'bronze', 'silver' and 'gold' Schemas
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
