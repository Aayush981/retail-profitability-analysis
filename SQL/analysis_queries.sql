USE ecommerce_analysis;

-- =====================================================================
-- Retail Profitability & Discount Impact Analysis
-- Dataset: Sample Superstore (9,994 transactions)
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. Headline KPIs: revenue, profit, and the margin that started this
-- FINDING: $2.3M revenue but only a 12.5% margin
-- ---------------------------------------------------------------------
SELECT
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data;


-- ---------------------------------------------------------------------
-- 2. Category performance: where does revenue come from, and does
--    profit follow?
-- FINDING: Furniture carries strong revenue with a weak margin
-- ---------------------------------------------------------------------
SELECT
    category,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
GROUP BY category
ORDER BY total_profit DESC;


-- ---------------------------------------------------------------------
-- 3. Sub-category performance, worst first
-- FINDING: Tables and Bookcases run at a loss
-- ---------------------------------------------------------------------
SELECT
    category,
    sub_category,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
GROUP BY category, sub_category
ORDER BY total_profit ASC;


-- ---------------------------------------------------------------------
-- 4. Which sub-categories drag the business below its own average
--    margin? (subquery computes the company-wide benchmark)
-- ---------------------------------------------------------------------
SELECT
    sub_category,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
GROUP BY sub_category
HAVING SUM(profit) / SUM(sales) < (
    SELECT SUM(profit) / SUM(sales) FROM sales_data
)
ORDER BY profit_margin_pct ASC;


-- ---------------------------------------------------------------------
-- 5. Discount impact, bucketed into tiers
-- FINDING: margin turns negative once discounts pass a clear threshold
-- ---------------------------------------------------------------------
WITH tiered AS (
    SELECT
        CASE
            WHEN discount = 0     THEN '0%'
            WHEN discount <= 0.10 THEN '1-10%'
            WHEN discount <= 0.20 THEN '11-20%'
            WHEN discount <= 0.30 THEN '21-30%'
            ELSE '30%+'
        END AS discount_tier,
        sales,
        profit
    FROM sales_data
)
SELECT
    discount_tier,
    COUNT(*)                                  AS total_orders,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM tiered
GROUP BY discount_tier
ORDER BY FIELD(discount_tier, '0%', '1-10%', '11-20%', '21-30%', '30%+');


-- ---------------------------------------------------------------------
-- 6. Raw discount levels, for the granular view behind query 5
-- ---------------------------------------------------------------------
SELECT
    discount,
    COUNT(*)                                  AS total_orders,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
GROUP BY discount
ORDER BY discount;


-- ---------------------------------------------------------------------
-- 7. Are the loss-making sub-categories a regional problem, or
--    structural? (checks whether losses repeat across every region)
-- ---------------------------------------------------------------------
SELECT
    sub_category,
    region,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
WHERE sub_category IN ('Tables', 'Bookcases')
GROUP BY sub_category, region
ORDER BY sub_category, total_profit ASC;


-- ---------------------------------------------------------------------
-- 8. Best and worst sub-category within each category
--    (window function ranks inside the category, not across all)
-- ---------------------------------------------------------------------
SELECT
    category,
    sub_category,
    total_profit,
    RANK() OVER (PARTITION BY category ORDER BY total_profit DESC) AS profit_rank
FROM (
    SELECT
        category,
        sub_category,
        SUM(profit) AS total_profit
    FROM sales_data
    GROUP BY category, sub_category
) AS sub_totals
ORDER BY category, profit_rank;


-- ---------------------------------------------------------------------
-- 9. Customer segment performance
-- ---------------------------------------------------------------------
SELECT
    segment,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
GROUP BY segment
ORDER BY total_profit DESC;


-- ---------------------------------------------------------------------
-- 10. Regional performance
-- ---------------------------------------------------------------------
SELECT
    region,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
GROUP BY region
ORDER BY total_profit DESC;


-- ---------------------------------------------------------------------
-- 11. Monthly revenue vs profit trend
-- FINDING: year-end revenue spikes are not matched by profit
-- ---------------------------------------------------------------------
SELECT
    DATE_FORMAT(order_date, '%Y-%m')          AS month,
    SUM(sales)                                AS total_revenue,
    SUM(profit)                               AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)  AS profit_margin_pct
FROM sales_data
GROUP BY month
ORDER BY month ASC;

