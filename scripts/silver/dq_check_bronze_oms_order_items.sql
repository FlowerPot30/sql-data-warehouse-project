-- =========================================================
-- Data Quality Checks for bronze.oms_order_items
-- Expectation: All queries should return zero rows
-- =========================================================

SELECT * FROM bronze.oms_order_items;

-- Check Unwanted spaces
-- Expectation: No records should contain unwanted spaces
SELECT * 
FROM bronze.oms_order_items
WHERE order_id != TRIM(order_id)
	OR product_id != TRIM(product_id)
	OR seller_id != TRIM(seller_id)

-- Check duplicated Primary Key
-- Expectation: order_id and order_item_id should not be duplicated, since both are composite primary key
SELECT order_id, order_item_id
FROM bronze.oms_order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- Check NULL or empty keys
-- Expectation: order_id, order_item_id, product_id must not be NULL
SELECT *
FROM bronze.oms_order_items
WHERE order_id IS NULL
	OR product_id IS NULL
	OR seller_id IS NULL;

-- Check order_item_id validity
-- Expectation: order_item_id must be a positive integer starting from 1
SELECT *
FROM bronze.oms_order_items
WHERE order_item_id <= 0;

-- Check orphan order references
-- Expectation: every order_item must reference an existing order
SELECT oi.*
FROM bronze.oms_order_items oi
LEFT JOIN bronze.erp_orders o
  ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Check orphan product references
-- Expectation: every order_item must reference an existing product
SELECT oi.*
FROM bronze.oms_order_items oi
LEFT JOIN bronze.erp_products p
  ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Check orphan seller references
-- Expectation: every order_item must reference an existing seller
SELECT oi.*
FROM bronze.oms_order_items oi
LEFT JOIN bronze.crm_sellers s
  ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

-- Check invalid price or freight values
-- Expectation: price and freight_value must be >= 0
SELECT *
FROM bronze.oms_order_items
WHERE price < 0
   OR freight_value < 0;

