-- Check Unwanted Spaces in each column
-- Expectation of query: Null
SELECT * 
FROM bronze.crm_customers
WHERE customer_id != TRIM(customer_id)
	OR customer_unique_id != TRIM(customer_unique_id)
	OR customer_zip_code_prefix != TRIM(customer_zip_code_prefix)
	OR customer_city != TRIM(customer_city)
	OR customer_state != TRIM(customer_state);
	
-- Check Unique of customer_id column 
-- Expectation of query: Null
SELECT customer_id
FROM bronze.crm_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check Unique of customer_id and customer_unique_id column 
-- Expectation of query: Null
SELECT customer_id, customer_unique_id
FROM bronze.crm_customers
WHERE customer_id IS NULL 
	OR customer_unique_id IS NULL;

-- Check zip code if it contains only 5 letter
-- Expectation of query: Null
SELECT *
FROM bronze.crm_customers
WHERE LEN(customer_zip_code_prefix) != 5; 

-- Check zip code if it containes only number
-- Expectation of query: Null
SELECT * 
FROM bronze.crm_customers
WHERE customer_zip_code_prefix LIKE '%[^0-9]%';

-- Check customer_state if it contains only 2 letter 
-- Expectation of query: Null
SELECT *
FROM bronze.crm_customers
WHERE LEN(customer_state) != 2
	OR customer_state LIKE '%[^A-Z]%';
