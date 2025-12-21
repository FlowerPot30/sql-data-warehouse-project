-- =========================================================
-- Data Quality Checks for bronze.erp_orders
-- Expectation: All queries should return zero rows
-- =========================================================

-- Check duplicate order_id
-- Expectation: order_id must be unique
SELECT order_id
FROM bronze.erp_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check allowed order_status values
-- Expectation: order_status must be within the expected domain
SELECT DISTINCT order_status
FROM bronze.erp_orders
ORDER BY order_status;

-- Check Unwanted Spaces
-- Expectation: No records should contain unwanted spaces
SELECT order_id 
FROM bronze.erp_orders
WHERE order_id != TRIM(order_id) 
	OR customer_id != TRIM(customer_id)
	OR order_status != TRIM(order_status)

-- Check NULL and '' in order_id, customer_id and order_status columns
-- Expectation: No records should contain NULL and ''
SELECT *
FROM bronze.erp_orders
WHERE order_id IS NULL OR order_id = ''
	OR customer_id IS NULL OR customer_id = ''
	OR order_status IS NULL OR order_status = '';

-- Check NULL in DATETIME table
-- Expectation: No records should contain NULL
SELECT *
FROM bronze.erp_orders
WHERE order_purchase_timestamp IS NULL
	OR order_approved_at IS NULL
	OR order_delivered_carrier_date IS NULL
	OR order_delivered_customer_date IS NULL
	OR order_estimated_delivery_date IS NULL;

-- Check missing approval timestamp for progressed orders
-- Expectation: Orders with status approved or beyond must have order_approved_at
SELECT *
FROM bronze.erp_orders
WHERE order_status IN ('approved','processing','shipped','delivered')
  AND order_approved_at IS NULL;
--> There are missing approval order_approved_at

-- Check delivered orders missing customer delivery timestamp
-- Expectation: Delivered orders must have order_delivered_customer_date
SELECT *
FROM bronze.erp_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;
--> There are missing order_delivered_customer_date

-- Check shipped or delivered orders missing carrier delivery timestamp
-- Expectation: Shipped or delivered orders must have order_delivered_carrier_date
SELECT *
FROM bronze.erp_orders
WHERE order_status IN ('shipped','delivered')
  AND order_delivered_carrier_date IS NULL;
--> There are missing order_delivered_carrier_date

-- Check invalid lifecycle timestamp ordering
-- Expectation: timestamps must follow the logical order when present
SELECT *
FROM bronze.erp_orders
WHERE (order_approved_at IS NOT NULL AND order_approved_at < order_purchase_timestamp)
   OR (order_delivered_carrier_date IS NOT NULL AND order_approved_at IS NOT NULL
       AND order_delivered_carrier_date < order_approved_at)
   OR (order_delivered_customer_date IS NOT NULL AND order_delivered_carrier_date IS NOT NULL
       AND order_delivered_customer_date < order_delivered_carrier_date);
--> There are issue row
