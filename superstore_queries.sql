-- ============================================
-- PROJECT 1: Superstore Sales EDA
-- Dataset: Kaggle Superstore Dataset
-- Tools: PostgreSQL
-- Author: Venkat Anirudh Kalpatapu
-- ============================================

-- Query 1: Sales by Category
-- Which category generates the most revenue?
SELECT 
    category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Result: Technology $836K | Furniture $742K | Office Supplies $719K


-- Query 2: Top 5 States by Revenue
-- Which states should we prioritize?
SELECT 
    state,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;

-- Result: California $457K (20% of total revenue!)


-- Query 3: Profit Margin by Region
-- Is high sales always high profit?
SELECT 
    region,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100::NUMERIC, 2) AS margin_pct
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- Key Finding: Central region only 7.92% margin vs West 14.94%


-- Query 4: Loss-Making Sub-Categories
-- Where are we actively losing money?
SELECT 
    "Sub-Category",
    ROUND(SUM(profit)::NUMERIC, 2) AS total_profit
FROM superstore
GROUP BY "Sub-Category"
ORDER BY total_profit ASC;

-- Key Finding: Tables -$17,725 | Bookcases -$3,472 | Supplies -$1,189


-- Query 5: Customer Segment Analysis
-- Which segment drives most sales and highest order value?
SELECT 
    segment,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(sales)::NUMERIC, 1) AS total_sales,
    ROUND(AVG(sales)::NUMERIC, 2) AS avg_order_value
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;

-- Key Finding: Home Office has highest AOV at $240 despite fewest orders
-- Recommendation: Upsell strategy for Home Office segment
