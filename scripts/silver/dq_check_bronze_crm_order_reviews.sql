-- =========================================================
-- Data Quality Checks for bronze.crm_order_reviews
-- Expectation: All queries should return zero rows
-- =========================================================

SELECT * FROM bronze.crm_order_reviews

-- Check Unwanted Spaces in review_id, order_id, review_comment_title and review_comment_message columns
-- Expectation: No records should contain unwanted spaces
SELECT review_id
FROM bronze.crm_order_reviews
WHERE review_id != TRIM(review_id) OR review_id IS NULL;

SELECT order_id
FROM bronze.crm_order_reviews
WHERE order_id != TRIM(order_id) OR order_id IS NULL;

SELECT review_comment_title
FROM bronze.crm_order_reviews
WHERE review_comment_title != TRIM(review_comment_title) OR review_comment_title IS NULL;
--> There are rows contain unwanted spaces

SELECT review_comment_title
FROM bronze.crm_order_reviews
WHERE review_comment_message != TRIM(review_comment_message) OR review_comment_message IS NULL;
--> There are rows contain unwanted spaces

-- Check for review score range
-- Expectation: review_score must be an integer between 1 and 5
SELECT review_score
FROM bronze.crm_order_reviews
WHERE review_score LIKE '[^1-5]'

-- Check review creation and answer timestamps
-- Expectation: review_creation_date must be earlier than or equal to review_answer_timestamp
SELECT review_creation_date, review_answer_timestamp
FROM bronze.crm_order_reviews
WHERE review_creation_date > review_answer_timestamp

-- Check empty content
-- Expectation: review_comment_title and review_comment_message must not containe empty content
SELECT review_comment_title, review_comment_message
FROM bronze.crm_order_reviews
WHERE review_comment_message = '' OR review_comment_title = '';
--> There are empty rows in both review_comment_title and review_comment_message

