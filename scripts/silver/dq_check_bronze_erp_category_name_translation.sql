-- =========================================================
-- Data Quality Checks for bronze.erp_category_name_translation
-- Expectation: All queries should return zero rows
-- =========================================================

SELECT * FROM bronze.erp_category_name_translation;

-- Check unwanted spaces 
-- Expectation: No records should contain unwanted spaces
SELECT *
FROM bronze.erp_category_name_translation
WHERE product_category_name != TRIM(product_category_name) 
	OR product_category_name_english != TRIM(product_category_name_english);

-- Check NULL or Empty 
-- Expectation: No records should contain NULL or Empty spaces
SELECT *
FROM bronze.erp_category_name_translation
WHERE product_category_name IS NULL 
	OR product_category_name_english IS NULL
	OR TRIM(product_category_name) = '' 
	OR TRIM(product_category_name_english ) = '';
