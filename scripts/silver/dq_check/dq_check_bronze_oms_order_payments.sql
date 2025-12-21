-- =========================================================
-- Data Quality Checks for bronze.oms_order_payments
-- Expectation: All queries should return zero rows
-- =========================================================

-- Check duplicate payment records per order
-- Expectation: (order_id, payment_sequential) must be unique
SELECT order_id, payment_sequential
FROM bronze.oms_order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

-- Check payment_type domain
-- Expectation: payment_type should be within the expected set of values
SELECT DISTINCT payment_type
FROM bronze.oms_order_payments
ORDER BY payment_type;


-- Check unwanted spaces
-- Expectation: no records should contain unwated spaces
SELECT * 
FROM bronze.oms_order_payments
WHERE order_id != TRIM(order_id)
	OR payment_type != TRIM(payment_type)

-- Check payment_sequential validity
-- Expectation: payment_sequential must be a positive integer starting from 1 
SELECT * 
FROM bronze.oms_order_payments
WHERE payment_sequential <= 0

-- Check orphan payments
-- Expectation: every payment must reference an existing order_id
SELECT p.*
FROM bronze.oms_order_payments p
LEFT JOIN bronze.erp_orders o
  ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Check payment_value validity
-- Expectation: payment_value must be >= 0
SELECT *
FROM bronze.oms_order_payments
WHERE payment_value IS NULL
   OR payment_value < 0;

