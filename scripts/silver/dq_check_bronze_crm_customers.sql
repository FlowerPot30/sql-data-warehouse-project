-- =========================================================
-- Data Quality Checks for bronze.crm_customers
-- Expectation: All queries should return zero rows
-- =========================================================

-- Check Unwanted Spaces in each column
-- Expectation: No records should contain unwanted spaces
SELECT * 
FROM bronze.crm_customers
WHERE customer_id != TRIM(customer_id)
	OR customer_unique_id != TRIM(customer_unique_id)
	OR customer_zip_code_prefix != TRIM(customer_zip_code_prefix)
	OR customer_city != TRIM(customer_city)
	OR customer_state != TRIM(customer_state);

-- Check for duplicate customer_id values
-- Expectation: customer_id should be unique
SELECT customer_id
FROM bronze.crm_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check for missing primary identifiers 
-- Expectation: customer_id and customer_unique_id should not be NULL
SELECT customer_id, customer_unique_id
FROM bronze.crm_customers
WHERE customer_id IS NULL 
	OR customer_unique_id IS NULL;

-- Check zip code length
-- Expectation: customer_zip_code_prefix must contain exactly 5 characters
SELECT *
FROM bronze.crm_customers
WHERE LEN(TRIM(customer_zip_code_prefix)) != 5; 

-- Check zip code format
-- Expectation: customer_zip_code_prefix must contain only numeric characters
SELECT * 
FROM bronze.crm_customers
WHERE customer_zip_code_prefix LIKE '%[^0-9]%';

-- Check customer city format
-- Expectation: customer_city
SELECT customer_city
FROM bronze.crm_customers
WHERE customer_city LIKE '%[^A-Z ]%';
-- Result show that there are row that contain special character 
-- We will solve this problem by using COLATE when import this data to silver table

-- Check customer state format
-- Expectation: customer_state must be a 2-character uppercase alphabetic code
SELECT *
FROM bronze.crm_customers
WHERE LEN(TRIM(customer_state)) != 2
	OR UPPER(customer_state) LIKE '%[^A-Z]%';


