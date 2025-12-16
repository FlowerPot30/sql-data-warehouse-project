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

