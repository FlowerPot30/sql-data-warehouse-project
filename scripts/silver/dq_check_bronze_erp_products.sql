-- =========================================================
-- Data Quality Checks for bronze.erp_products
-- Expectation: All queries should return zero rows
-- =========================================================

-- Checkc unwanted spaces
-- Expectation: No records contain unwanted spaces
SELECT product_id, product_category_name
FROM bronze.erp_products
WHERE product_id != TRIM(product_id)
	OR product_category_name != TRIM(product_category_name);

-- Check duplicate product_id
-- Expectation: product_id must be unique
SELECT product_id
FROM bronze.erp_products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check NULL and ''
SELECT product_id, product_category_name
FROM bronze.erp_products
WHERE product_id IS NULL OR TRIM(product_id) = ''
	OR product_category_name IS NULL OR TRIM(product_category_name) = '';
--> There are uncategorized records

-- Check range value
-- Expectation: numeric attributes should not be negative
SELECT *
FROM bronze.erp_products
WHERE product_name_lenght < 0
   OR product_description_lenght < 0
   OR product_photos_qty < 0
   OR product_weight_g < 0
   OR product_length_cm < 0
   OR product_height_cm < 0
   OR product_width_cm < 0;
