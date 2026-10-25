
-- Drop tables if they already exist 
DROP TABLE IF EXISTS fact_orders_lists CASCADE;
DROP TABLE IF EXISTS dim_customers CASCADE;
DROP TABLE IF EXISTS dim_sellers CASCADE;
DROP TABLE IF EXISTS dim_products CASCADE;
DROP TABLE IF EXISTS dim_calendar CASCADE;
DROP TABLE IF EXISTS dim_payments_reviews CASCADE;

-----------------------------------------------------------------
-- 1. DIMENSION: CUSTOMERS
-----------------------------------------------------------------
CREATE TABLE dim_customers (
    customer_unique_id VARCHAR(64) not null , 
    customer_id VARCHAR(64) primary key ,
    customer_zip_code_prefix VARCHAR(10),       
    customer_city VARCHAR(100),
    customer_state VARCHAR(2),
    latitude NUMERIC(10, 8),
    longitude NUMERIC(11, 8)
);

-----------------------------------------------------------------
-- 2. DIMENSION: SELLERS
-----------------------------------------------------------------
CREATE TABLE dim_sellers (
    seller_id VARCHAR(64) PRIMARY KEY,
    seller_city VARCHAR(100),
    seller_state VARCHAR(2),
    seller_zip_code_prefix VARCHAR(10),
    seller_lat NUMERIC(10, 8),
    seller_lon NUMERIC(11, 8)                   
);

-----------------------------------------------------------------
-- 3. DIMENSION: PRODUCTS
-----------------------------------------------------------------
CREATE TABLE dim_products (
    product_id VARCHAR(64) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INTEGER,                 
    product_description_length INTEGER,          
    product_photos_qty INTEGER,
    product_weight_g NUMERIC(10, 2),
    product_length_cm NUMERIC(10, 2),
    product_height_cm NUMERIC(10, 2),
    product_width_cm NUMERIC(10, 2)
);

-----------------------------------------------------------------
-- 4. DIMENSION: CALENDAR (Time Dim)
-----------------------------------------------------------------
CREATE TABLE dim_calendar (
    date_id INTEGER PRIMARY KEY,                 
    full_date DATE NOT NULL,
    year INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    day INTEGER,
    day_of_week INTEGER,
    day_name VARCHAR(20),
    is_weekend VARCHAR(5),                     
    quarter_name VARCHAR(10)
);

-----------------------------------------------------------------
-- 5. DIMENSION: PAYMENTS & REVIEWS
-----------------------------------------------------------------
CREATE TABLE dim_payments_reviews (
    payment_review_id SERIAL PRIMARY KEY,        
    order_id VARCHAR(64) NOT NULL,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_sequential INTEGER,
    payment_value NUMERIC(12, 2),
    review_score INTEGER
);

-----------------------------------------------------------------
-- 6. FACT TABLE: ORDERS LISTS
-----------------------------------------------------------------
CREATE TABLE fact_orders_lists (
    order_id VARCHAR(64) NOT NULL,
    item_id INTEGER NOT NULL,
    product_id VARCHAR(64),
    seller_id VARCHAR(64),
    price NUMERIC(12, 2),
    freight_value NUMERIC(12, 2),
    date_limit_of_shipping TIMESTAMP,
    customer_id VARCHAR(64),
    order_status VARCHAR(50),
    order_approved_at TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    total_item_cost NUMERIC(12, 2),
    quantity INTEGER,
    date_id INTEGER,
    
);

-----------------------------------------------------------------
-- PERFORMANCE INDEXES
-----------------------------------------------------------------
-- creating index 
CREATE INDEX idx_fact_orders_customer ON fact_orders_lists(customer_id);
CREATE INDEX idx_fact_orders_seller ON fact_orders_lists(seller_id);
CREATE INDEX idx_fact_orders_product ON fact_orders_lists(product_id);
CREATE INDEX idx_fact_orders_date ON fact_orders_lists(date_id);


