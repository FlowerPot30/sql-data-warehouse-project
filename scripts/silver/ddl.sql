SELECT
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	UPPER(customer_city) COLLATE Latin1_General_CI_AI AS customer_city,
	customer_state
FROM bronze.crm_customers;

SELECT
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	UPPER(customer_city) COLLATE Latin1_General_CI_AI AS customer_city,
	customer_state
FROM bronze.crm_customers;

SELECT 
	seller_id,
	seller_zip_code_prefix,
	UPPER(seller_city) AS seller_city,
	seller_state
FROM bronze.crm_sellers;

SELECT 
	review_id,
	order_id,
	review_score,
	NULLIF(TRIM(review_comment_title), '') AS review_comment_title,
	NULLIF(TRIM(review_comment_message), '') AS review_comment_message,
	review_creation_date,
	review_answer_timestamp
FROM bronze.crm_order_reviews;

SELECT 
	LOWER(product_category_name) AS product_category_name,
	LOWER(product_category_name_english) AS product_category_name_english
FROM bronze.erp_category_name_translation;

SELECT
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date,

    -- Missing timestamp flags (status-aware)
    CASE
        WHEN order_status IN ('approved','processing','shipped','delivered')
         AND order_approved_at IS NULL
        THEN 1 ELSE 0
    END AS is_missing_order_approved_at,

    CASE
        WHEN order_status = 'delivered'
         AND order_delivered_customer_date IS NULL
        THEN 1 ELSE 0
    END AS is_missing_delivered_customer_date,

    CASE
        WHEN order_status IN ('shipped','delivered')
         AND order_delivered_carrier_date IS NULL
        THEN 1 ELSE 0
    END AS is_missing_carrier_date,

    -- Timestamp ordering flags
    CASE
        WHEN order_approved_at IS NOT NULL
         AND order_purchase_timestamp IS NOT NULL
         AND order_approved_at < order_purchase_timestamp
        THEN 1 ELSE 0
    END AS is_approved_before_purchase,

    CASE
        WHEN order_delivered_carrier_date IS NOT NULL
         AND order_approved_at IS NOT NULL
         AND order_delivered_carrier_date < order_approved_at
        THEN 1 ELSE 0
    END AS is_carrier_before_approval,

    CASE
        WHEN order_delivered_customer_date IS NOT NULL
         AND order_delivered_carrier_date IS NOT NULL
         AND order_delivered_customer_date < order_delivered_carrier_date
        THEN 1 ELSE 0
    END AS is_customer_before_carrier,

    -- Overall anomaly flag
    CASE
        WHEN
            (order_status IN ('approved','processing','shipped','delivered') AND order_approved_at IS NULL)
         OR (order_status = 'delivered' AND order_delivered_customer_date IS NULL)
         OR (order_status IN ('shipped','delivered') AND order_delivered_carrier_date IS NULL)
         OR (order_approved_at IS NOT NULL AND order_purchase_timestamp IS NOT NULL
             AND order_approved_at < order_purchase_timestamp)
         OR (order_delivered_carrier_date IS NOT NULL AND order_approved_at IS NOT NULL
             AND order_delivered_carrier_date < order_approved_at)
         OR (order_delivered_customer_date IS NOT NULL AND order_delivered_carrier_date IS NOT NULL
             AND order_delivered_customer_date < order_delivered_carrier_date)
        THEN 1 ELSE 0
    END AS has_anomaly
FROM bronze.erp_orders;

SELECT 
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    -- product name category flag
    CASE 
        WHEN product_category_name IS NULL 
        THEN 1
        ELSE 0
    END AS is_missing_category,

    -- product name length flag
    CASE 
        WHEN product_name_length IS NULL
        THEN 1
        ELSE 0
    END AS is_missing_product_length,

    -- product description length flag
    CASE 
        WHEN product_description_length IS NULL
        THEN 1
        ELSE 0
    END AS is_missing_product_desription_length,

    -- product photos quantity flag
    CASE 
        WHEN product_photos_qty IS NULL
        THEN 1
        ELSE 0
    END AS is_missing_product_qty
FROM bronze.erp_products;

SELECT 
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date,
	price,
	freight_value
FROM bronze.oms_order_items;

SELECT	
	order_id,
	payment_sequential,
	payment_type,
	payment_installments,
	payment_value
FROM bronze.oms_order_payments
