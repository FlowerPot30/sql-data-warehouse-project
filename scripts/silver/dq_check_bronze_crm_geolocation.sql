-- =========================================================
-- Data Quality Checks for bronze.crm_geolocation
-- Expectation: All queries should return zero rows
-- =========================================================

-- Check Unwanted Spaces in each column (except geolocation_lat and geolocation_lng columns)
-- Expectation: No records should contain unwanted spaces
SELECT * 
FROM bronze.crm_geolocation
WHERE geolocation_zip_code_prefix != TRIM(geolocation_zip_code_prefix)
	OR geolocation_city != TRIM(geolocation_city)
	OR geolocation_state != TRIM(geolocation_state);

-- Check zip code length
-- Expectation: geolocation_zip_code_prefix must contain exactly 5 characters
SELECT *
FROM bronze.crm_geolocation
WHERE LEN(TRIM(geolocation_zip_code_prefix)) != 5

-- Check geolocation_lat and geoloation_lng 
-- Expectation: latitude must have value between -90 and 90 
--				longtitude must have value between -180 and 180
SELECT *
FROM bronze.crm_geolocation
WHERE geolocation_lat NOT BETWEEN -90 AND 90
	OR geolocation_lng NOT BETWEEN -180 AND 180

-- Check geolocation city format
-- Expectation: geolocation_city allowed to have only specific letter
SELECT UPPER(geolocation_city)
FROM bronze.crm_geolocation
WHERE UPPER(TRIM(geolocation_city)) LIKE '%[^A-Z -'']%'
-- Result show that there are row that contain special character 
-- We will solve this problem by using COLLATE when import this data to silver table

-- Check geolocation state format
-- Expectation: geolocation_state must be a 2-character uppercase alphabetic code
SELECT *
FROM bronze.crm_geolocation
WHERE LEN(TRIM(geolocation_state)) != 2
	OR UPPER(geolocation_state) LIKE '%[^A-Z]%';

-- Check for duplicate customer_id values
-- Expectation: geolocation_zip_code_prefix should be unique
SELECT geolocation_zip_code_prefix, COUNT(*) AS duplicated_amount
FROM bronze.crm_geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;
