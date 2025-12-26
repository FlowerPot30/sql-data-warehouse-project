/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('silver.crm_customer') IS NOT NULL
    DROP TABLE silver.crm_customer;
GO 

CREATE TABLE silver.crm_customer (
    customer_id                 VARCHAR(32),
    customer_unique_id          VARCHAR(32),
    customer_zip_code_prefix    VARCHAR(5),
    customer_city               VARCHAR(100),
    customer_state              VARCHAR(2),

    dwh_create_date             DATETIME2 DEFAULT GETDATE(),
    
    PRIMARY KEY (customer_id),
);

IF OBJECT_ID('silver.crm_geolocation') IS NOT NULL
    DROP TABLE silver.crm_geolocation;
GO

CREATE TABLE silver.crm_geolocation (
    geolocation_zip_code_prefix VARCHAR(5),
    geolocation_lat             DECIMAL(10, 8),
    geolocation_lng             DECIMAL(11, 8),
    geoloaction_city            VARCHAR(100),
    geolocation_state           VARCHAR(2),


)

