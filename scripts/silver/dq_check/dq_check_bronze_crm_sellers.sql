-- =========================================================
-- Data Quality Checks for bronze.crm_sellers
-- Expectation: All queries should return zero rows
-- =========================================================

SELECT * FROM bronze.crm_sellers

-- Check for duplicate seller_id values
-- Expectation: seller_id should be unique
SELECT seller_id
FROM bronze.crm_sellers
GROUP BY seller_id
HAVING COUNT(*) > 1

-- Check Unwanted Spaces in each column 
-- Expectation: No records should contain unwanted spaces
SELECT *
FROM bronze.crm_sellers
WHERE seller_id != TRIM(seller_id)
	OR seller_zip_code_prefix != TRIM(seller_zip_code_prefix)
	OR seller_city != TRIM(seller_city)
	OR seller_state != TRIM(seller_state);

-- Check zip code length
-- Expectation: seller_zip_code_prefix must contain exactly 5 characters
SELECT *
FROM bronze.crm_sellers
WHERE LEN(TRIM(seller_zip_code_prefix)) != 5; 

-- Check zip code format
-- Expectation: seller_zip_code_prefix must contain only numeric characters
SELECT * 
FROM bronze.crm_sellers
WHERE seller_zip_code_prefix LIKE '%[^0-9]%';

-- Check serller state format
-- Expectation: seller_state must be a 2-character uppercase alphabetic code
SELECT seller_state
FROM bronze.crm_sellers
WHERE LEN(TRIM(seller_state)) != 2
	OR UPPER(seller_state) LIKE '%[^A-Z]%';

