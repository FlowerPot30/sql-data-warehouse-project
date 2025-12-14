-- =========================================================
-- Data Quality Checks for bronze.crm_customers
-- Expectation: All queries should return zero rows
-- =========================================================

-- Check Unwanted Spaces in each column
-- Expectation of query: Null
SELECT * 
FROM bronze.crm_customers
WHERE customer_id != TRIM(customer_id)
	OR customer_unique_id != TRIM(customer_unique_id)
	OR customer_zip_code_prefix != TRIM(customer_zip_code_prefix)
	OR customer_city != TRIM(customer_city)
	OR customer_state != TRIM(customer_state);
	
-- Check for duplicate customer_id values
-- Expectation of query: Null
SELECT customer_id
FROM bronze.crm_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check for missing primary identifiers 
-- Expectation of query: Null
SELECT customer_id, customer_unique_id
FROM bronze.crm_customers
WHERE customer_id IS NULL 
	OR customer_unique_id IS NULL;

-- Check zip code length
-- Expectation of query: Null
SELECT *
FROM bronze.crm_customers
WHERE LEN(customer_zip_code_prefix) != 5; 

-- Check zip code format
-- Expectation of query: Null
SELECT * 
FROM bronze.crm_customers
WHERE customer_zip_code_prefix LIKE '%[^0-9]%';

-- Check customer state format
-- Expectation of query: Null
SELECT *
FROM bronze.crm_customers
WHERE LEN(customer_state) != 2
	OR customer_state LIKE '%[^A-Z]%';
