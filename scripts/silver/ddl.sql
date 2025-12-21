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
FROM bronze.crm_sellers

SELECT 
	review_id,
	order_id,
	review_score,
	NULLIF(TRIM(review_comment_title), '') AS review_comment_title,
	NULLIF(TRIM(review_comment_message), '') AS review_comment_message,
	review_creation_date,
	review_answer_timestamp
FROM bronze.crm_order_reviews

SELECT 
	LOWER(product_category_name) AS product_category_name,
	LOWER(product_category_name_english) AS product_category_name_english
FROM bronze.erp_category_name_translation;
