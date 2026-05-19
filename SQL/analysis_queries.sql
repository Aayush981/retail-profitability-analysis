USE ecommerce_analysis;

-- Calculate total revenue and total profit
SELECT 
	SUM(sales) as Total_Revenue ,
	SUM(profit) as Total_Profit 
FROM sales_data;

-- Analyze category-wise sales and profitability
SELECT 
	category ,
    SUM(sales) as Total_Revenue ,
	SUM(profit) as Total_Profit 
FROM sales_data
GROUP BY category
ORDER BY Total_Profit DESC;

-- Identify top-performing and loss-making sub-categories
SELECT 
	sub_category,
    category,
    SUM(sales) as Total_Revenue ,
	SUM(profit) as Total_Profit 
FROM sales_data
GROUP BY sub_category,category
ORDER BY Total_Profit ASC;
    
-- Analyze the impact of discounts on profitability
SELECT 
	discount,
    COUNT(*) as total_orders,
    SUM(sales) as Total_Revenue ,
	SUM(profit) as Total_Profit 
FROM sales_data
GROUP BY discount 
ORDER BY discount;
    
-- Evaluate customer segment performance
SELECT 
	segment,
    SUM(sales) as Total_Revenue ,
	SUM(profit) as Total_Profit 
FROM sales_data
GROUP BY segment
ORDER BY Total_Profit desc;    
    
-- Analyze monthly revenue and profit trends
SELECT
	DATE_FORMAT(order_date,'%y-%m') as Monthly_date,
    SUM(sales) as Total_Revenue ,
	SUM(profit) as Total_Profit 
FROM sales_data
GROUP BY Monthly_date
ORDER BY Monthly_date ASC;
    
-- Compare regional sales and profitability
SELECT 
	region,
    SUM(sales) as Total_Revenue ,
	SUM(profit) as Total_Profit 
FROM sales_data
GROUP BY region
ORDER BY Total_Profit DESC;