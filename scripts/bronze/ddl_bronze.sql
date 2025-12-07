/* 
==================================================================================
DDL Script : Create Bronze Tables
==================================================================================
Script Purpose :
	This script creates tables in the 'bronze' schema, dropping existing tables
	if they already exist.
	Run this script to re-define the DDL structure of 'bronze' Tables
==================================================================================
*/

IF OBJECT_ID('bronze.crm_customers', 'U') IS NOT NULL
	DROP TABLE bronze.crm_customers;
GO
CREATE TABLE bronze.crm_customers (
	customer_id VARCHAR(50),
	customer_unique_id VARCHAR(50),
	customer_zip_code_prefix VARCHAR(10),
	customer_city VARCHAR(50),
	customer_state VARCHAR(10)
);
GO

IF OBJECT_ID('bronze.crm_geolocation', 'U') IS NOT NULL
	DROP TABLE bronze.crm_geolocation;
GO
CREATE TABLE bronze.crm_geolocation (
	geolocation_zip_code_prefix VARCHAR(50),
	geolocation_lat DECIMAL(12, 8),
	geolocation_lng DECIMAL(12, 8),
	geolocation_city VARCHAR(50),
	geolocation_state VARCHAR(2)
);
GO

IF OBJECT_ID('bronze.crm_order_reviews', 'U') IS NOT NULL
	DROP TABLE bronze.crm_order_reviews;
GO
CREATE TABLE bronze.crm_order_reviews (
	review_id VARCHAR(50),
	order_id VARCHAR(50),
	review_score INT,
	review_comment_title VARCHAR(100),
	review_comment_message VARCHAR(500),
	review_creation_date DATETIME,
	review_answer_timestamp DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sellers', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sellers;
GO
CREATE TABLE bronze.crm_sellers (
	seller_id VARCHAR(50),
	seller_zip_code_prefix INT,
	seller_city VARCHAR(50),
	seller_state VARCHAR(5)
);
GO

IF OBJECT_ID('bronze.erp_category_name_translation', 'U') IS NOT NULL
	DROP TABLE bronze.erp_category_name_translation;
GO
CREATE TABLE bronze.erp_category_name_translation (
	product_category_name VARCHAR(50),
	product_category_name_english VARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_orders', 'U') IS NOT NULL
	DROP TABLE bronze.erp_orders;
GO
CREATE TABLE bronze.erp_orders (
	order_id VARCHAR(50),
	customer_id VARCHAR(50),
	order_status VARCHAR(50),
	order_purchase_timestamp DATETIME,
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME
);
GO

IF OBJECT_ID('bronze.erp_products', 'U') IS NOT NULL
	DROP TABLE bronze.erp_products;
GO
CREATE TABLE bronze.erp_products (
	product_id VARCHAR(50),
	perfumaria VARCHAR(50),
	product_name_lenght INT,
	product_description_lenght INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
);
GO

IF OBJECT_ID('bronze.oms_order_items', 'U') IS NOT NULL
	DROP TABLE bronze.oms_order_items;
GO
CREATE TABLE bronze.oms_order_items (
	order_id VARCHAR(50),
	order_item_id INT,
	product_id VARCHAR(50),
	seller_id VARCHAR(50),
	shipping_limit_date DATETIME,
	price DECIMAL(9,2),
	freight_value DECIMAL(9,2)
);
GO

IF OBJECT_ID('bronze.oms_order_payments', 'U') IS NOT NULL
	DROP TABLE bronze.oms_order_payments;
GO
CREATE TABLE bronze.oms_order_payments (
	order_id VARCHAR(50),
	payment_sequential INT,
	payment_type VARCHAR(50),
	payment_installments INT,
	payment_value DECIMAL(12,2),
);
GO
