CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

-- Remove existing table if present
DROP TABLE IF EXISTS sales_data;

-- Create sales table
CREATE TABLE sales_data (
	id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    region VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    customer_id VARCHAR(50),
    segment VARCHAR(50),
    sales DECIMAL(10,2),
    profit DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(3,2),
    profit_status VARCHAR(10)
);

-- Check secure import directory
SHOW VARIABLES LIKE 'secure_file_priv';


-- Import CSV data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore 1.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_date, region, state, city, category, sub_category, product_name, customer_id, segment, sales, profit, quantity, discount, profit_status);

-- Verify row count
SELECT COUNT(*) FROM sales_data;
