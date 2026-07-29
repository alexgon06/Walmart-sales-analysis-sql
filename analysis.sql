-- =====================================================
-- WALMART SALES ANALYSIS
-- =====================================================


-- =====================================================
-- 1. DATA EXPLORATION
-- =====================================================


-- -----------------------------------------------------
-- Query 1: View the Complete Dataset
-- Description:
-- Displays every row and column in the Walmart sales
-- dataset to understand its structure and contents.
-- -----------------------------------------------------

SELECT * FROM "walmart_sales";


-- -----------------------------------------------------
-- Query 2: Find the Highest Individual Weekly Sale
-- Description:
-- Identifies the maximum weekly sales value recorded
-- in the dataset.
-- -----------------------------------------------------

SELECT 
STORE,
DATE,
MAX(Weekly_Sales)
FROM "walmart_sales";  


-- -----------------------------------------------------
-- Query 3: Find the Lowest Individual Weekly Sale
-- Description:
-- Identifies the minimum weekly sales value recorded
-- in the dataset.
-- -----------------------------------------------------

SELECT 
STORE,
DATE,
MIN(Weekly_Sales)
FROM "walmart_sales";  


-- -----------------------------------------------------
-- Query 4: Calculate the Overall Average Weekly Sales
-- Description:
-- Calculates the average weekly sales value across
-- every store and every week in the dataset.
-- -----------------------------------------------------

SELECT AVG(Weekly_Sales)
FROM "walmart_sales";


-- =====================================================
-- 2. STORE PERFORMANCE
-- =====================================================


-- -----------------------------------------------------
-- Query 5: Compare Average Weekly Sales by Store
-- Description:
-- Calculates each store's average weekly sales and
-- ranks the stores from highest to lowest.
-- -----------------------------------------------------

SELECT 
AVG(Weekly_Sales),
Store
FROM "walmart_sales"
GROUP BY Store
ORDER BY AVG(Weekly_Sales) DESC;


-- -----------------------------------------------------
-- Query 6: Find the Top 10 Individual Weekly Sales
-- Description:
-- Displays the ten rows with the highest weekly sales
-- values in the dataset.
-- -----------------------------------------------------

SELECT * FROM "walmart_sales"
ORDER BY Weekly_Sales DESC
LIMIT 10;


-- -----------------------------------------------------
-- Query 7: Find the Bottom 10 Individual Weekly Sales
-- Description:
-- Displays the ten rows with the lowest weekly sales
-- values in the dataset.
-- -----------------------------------------------------

SELECT * FROM "walmart_sales"
ORDER BY Weekly_Sales ASC
LIMIT 10;


-- =====================================================
-- 3. MONTHLY AND YEARLY SALES TRENDS
-- =====================================================


-- -----------------------------------------------------
-- Query 8: Compare Average Weekly Sales by Month
-- Description:
-- Extracts the month from each date, calculates average
-- weekly sales for each month, and ranks the months.
-- -----------------------------------------------------

SELECT 
    substr(Date, 4, 2) AS Month,
    AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY Month
ORDER BY AVG_Weekly_Sales DESC;


-- -----------------------------------------------------
-- Query 9: Find the Highest Weekly Sale by Year
-- Description:
-- Identifies the largest individual weekly sales value
-- recorded during each year.
-- -----------------------------------------------------

SELECT 
    substr(Date, 7, 4) AS Year,
    MAX(Weekly_Sales) AS Highest_Sale
FROM "walmart_sales"
GROUP BY Year
ORDER BY MAX(Weekly_Sales) DESC;


-- -----------------------------------------------------
-- Query 10: Compare Average Weekly Sales by Year
-- Description:
-- Calculates the average weekly sales value for each
-- year and ranks the years from highest to lowest.
-- -----------------------------------------------------

SELECT 
    substr(Date, 7, 4) AS Year,
    AVG(Weekly_Sales) AS Avg_weekly_Sale
FROM "walmart_sales"
GROUP BY Year
ORDER BY AVG(Weekly_Sales) DESC; 


-- -----------------------------------------------------
-- Query 11: Compare Total Sales by Year
-- Description:
-- Calculates the total sales generated during each
-- year and ranks the years by total performance.
-- -----------------------------------------------------

SELECT 
    substr(Date, 7, 4) AS Year,
    SUM(Weekly_Sales) AS Total_Sales
FROM "walmart_sales"
GROUP BY Year
ORDER BY SUM(Weekly_Sales) DESC;


-- -----------------------------------------------------
-- Query 12: Track Average Sales Across Each Date
-- Description:
-- Calculates average sales across all stores for each
-- date and sorts the dates in chronological order.
-- -----------------------------------------------------

SELECT 
    Date, 
    AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY Date
ORDER BY 
substr(Date, 7, 4),
substr(Date, 4, 2),
substr(Date, 1, 2) ASC;


-- =====================================================
-- 4. HOLIDAY SALES ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- Query 13: Calculate Holiday Average Weekly Sales
-- Description:
-- Calculates average weekly sales for weeks identified
-- as holiday weeks in the dataset.
-- -----------------------------------------------------

SELECT AVG(Weekly_Sales) AS Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 1;


-- -----------------------------------------------------
-- Query 14: Calculate Non-Holiday Average Weekly Sales
-- Description:
-- Calculates average weekly sales for weeks that were
-- not identified as holiday weeks.
-- -----------------------------------------------------

SELECT AVG(Weekly_Sales) AS Non_Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 0;


-- -----------------------------------------------------
-- Query 15: Find the Strongest Holiday Stores
-- Description:
-- Calculates each store's average sales during holiday
-- weeks and ranks stores from highest to lowest.
-- -----------------------------------------------------

SELECT  STORE, AVG(Weekly_Sales) AS HIGH_Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 1
GROUP BY STORE 
ORDER BY HIGH_Holiday_Avg_Weekly_Sales DESC;


-- -----------------------------------------------------
-- Query 16: Find the Weakest Holiday Stores
-- Description:
-- Calculates each store's average sales during holiday
-- weeks and ranks stores from lowest to highest.
-- -----------------------------------------------------

SELECT  STORE,AVG(Weekly_Sales) AS LOW_Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 1
GROUP BY STORE 
ORDER BY LOW_Holiday_Avg_Weekly_Sales ASC;


-- =====================================================
-- 5. STORE TOTALS AND AVERAGES
-- =====================================================


-- -----------------------------------------------------
-- Query 17: Calculate Total Sales by Store
-- Description:
-- Adds together every weekly sales value for each store
-- to calculate its total sales across the dataset.
-- -----------------------------------------------------

SELECT  STORE, SUM(Weekly_Sales) AS Total_Weekly_Sales
FROM "walmart_sales"
GROUP BY STORE 
ORDER BY STORE ASC;


-- -----------------------------------------------------
-- Query 18: Find Stores Above the Overall Average
-- Description:
-- Identifies stores whose average weekly sales exceed
-- the overall dataset average.
-- -----------------------------------------------------

SELECT STORE, AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY STORE 
HAVING Avg_Weekly_Sales > 1046964.87756177
ORDER BY Avg_Weekly_Sales DESC;


-- -----------------------------------------------------
-- Query 19: Find Stores Below the Overall Average
-- Description:
-- Identifies stores whose average weekly sales fall
-- below the overall dataset average.
-- -----------------------------------------------------

SELECT STORE, AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY STORE 
HAVING Avg_Weekly_Sales < 1046964.87756177
ORDER BY Avg_Weekly_Sales DESC;


-- =====================================================
-- 6. WINDOW FUNCTIONS
-- =====================================================


-- -----------------------------------------------------
-- Query 20: Calculate Running Sales by Store
-- Description:
-- Creates a cumulative sales total for each store over
-- time while keeping every weekly row visible.
-- -----------------------------------------------------

Select  
Date,
Store, 
weekly_Sales,
SUM(weekly_Sales) OVER(
PARTITION BY Store
ORDER BY 
substr(Date, 7, 4),
substr(Date, 4, 2),
substr(Date, 1, 2) ASC) 
AS Running_Total
FROM "walmart_sales";


-- -----------------------------------------------------
-- Query 21: Compare Each Week With the Previous Week
-- Description:
-- Uses LAG to display the previous week's sales beside
-- the current week's sales for each store.
-- -----------------------------------------------------

Select  
Date,
Store, 
weekly_Sales,
LAG(weekly_Sales) OVER(
PARTITION BY Store
ORDER BY 
substr(Date, 7, 4),
substr(Date, 4, 2),
substr(Date, 1, 2) ASC) 
AS previous_Week_Sales
FROM "walmart_sales";


-- =====================================================
-- 7. HIGHEST AND LOWEST STORE SALES
-- =====================================================


-- -----------------------------------------------------
-- Query 22: Find Each Store's Highest Weekly Sale
-- Description:
-- Identifies the highest weekly sales value recorded
-- by each individual store.
-- -----------------------------------------------------

Select 
Store,
MAX(Weekly_Sales) AS Highest_Weekly_Sale
FROM "walmart_sales"
GROUP BY Store
ORDER BY Highest_Weekly_Sale DESC;


-- -----------------------------------------------------
-- Query 23: Find Each Store's Lowest Weekly Sale
-- Description:
-- Identifies the lowest weekly sales value recorded
-- by each individual store.
-- -----------------------------------------------------

Select 
Store,
MIN(Weekly_Sales) AS Lowest_Weekly_Sale
FROM "walmart_sales"
GROUP BY Store
ORDER BY Lowest_Weekly_Sale ASC;


-- =====================================================
-- 8. STORE SALES CATEGORIES
-- =====================================================


-- -----------------------------------------------------
-- Query 24: Categorize Stores by Total Sales
-- Description:
-- Groups stores into High, Medium, and Low categories
-- based on their total sales across the dataset.
-- -----------------------------------------------------

SELECT 
Store,  
CASE
    WHEN sum(weekly_sales) >= 200000000 THEN 'High'
    WHEN sum(weekly_sales) >= 100000000 AND sum(weekly_sales) < 200000000 THEN 'Medium'
    WHEN sum(weekly_sales) < 100000000 THEN 'Low'
END AS SALES_Category
FROM "walmart_sales"
GROUP BY Store
Order BY Store DESC;


-- =====================================================
-- 9. SALES VARIANCE
-- =====================================================


-- -----------------------------------------------------
-- Query 25: Find the Most Consistent Stores
-- Description:
-- Calculates weekly sales variance for each store and
-- ranks stores from lowest variance to highest.
-- Lower variance represents more consistent sales.
-- -----------------------------------------------------

SELECT
Store,
(AVG(Weekly_Sales * Weekly_Sales) - 
AVG(Weekly_Sales) * AVG(Weekly_Sales)) AS LOW_Sales_Variance
FROM "walmart_sales"
GROUP BY Store
ORDER BY LOW_Sales_Variance ASC;


-- -----------------------------------------------------
-- Query 26: Find Stores With the Largest Fluctuations
-- Description:
-- Calculates weekly sales variance for each store and
-- ranks stores from highest variance to lowest.
-- Higher variance represents greater sales fluctuation.
-- -----------------------------------------------------

SELECT
Store,
(AVG(Weekly_Sales * Weekly_Sales) - 
AVG(Weekly_Sales) * AVG(Weekly_Sales)) AS HIGH_Sales_Variance
FROM "walmart_sales"
GROUP BY Store
ORDER BY HIGH_Sales_Variance DESC;


-- =====================================================
-- 10. FUEL PRICE ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- Query 27: Compare Sales Across Fuel Price Categories
-- Description:
-- Divides fuel prices into four ranges and calculates
-- average weekly sales within each fuel price category.
-- -----------------------------------------------------

SELECT 
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
CASE
    WHEN Fuel_Price >= 4.0 AND Fuel_Price < 6.0 THEN 'Very High Fuel'
    WHEN Fuel_Price >= 3.5 AND Fuel_Price < 4.0 THEN 'High Fuel'
    WHEN Fuel_Price >= 3.0 AND Fuel_Price < 3.5 THEN 'Medium Fuel'
    WHEN Fuel_Price < 3.0 THEN 'Low Fuel'
END AS Fuel_Price_Category
FROM "walmart_sales"
GROUP BY Fuel_Price_Category
ORDER BY Avg_Weekly_Sales DESC;


-- =====================================================
-- 11. TEMPERATURE ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- Query 28: Compare Sales Across Temperature Categories
-- Description:
-- Divides temperatures into Cold, Cool, Warm, and Hot
-- ranges and compares average weekly sales across them.
-- -----------------------------------------------------

SELECT 
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
CASE
    WHEN Temperature >= 80 THEN 'Hot'
    WHEN Temperature >= 60 AND Temperature < 80 THEN 'Warm'
    WHEN Temperature >= 30 AND Temperature < 60 THEN 'Cool'
    WHEN Temperature < 30 THEN 'Cold'
END AS Temperature_Category
FROM "walmart_sales"
GROUP BY Temperature_Category
ORDER BY Avg_Weekly_Sales DESC;


-- =====================================================
-- 12. CPI ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- Query 29: Compare Sales Across CPI Categories
-- Description:
-- Divides CPI values into four ranges and calculates
-- average weekly sales within each CPI category.
-- -----------------------------------------------------

SELECT 
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
CASE
    WHEN CPI >= 200 THEN 'Very High CPI'
    WHEN CPI >= 175 AND CPI < 200 THEN 'High CPI'
    WHEN CPI >= 150 AND CPI < 175 THEN 'Medium CPI'
    WHEN CPI >=125 AND CPI < 150 THEN 'Low CPI'
END AS CPI_Category
FROM "walmart_sales"
GROUP BY CPI_Category
ORDER BY Avg_Weekly_Sales DESC;


-- =====================================================
-- 13. UNEMPLOYMENT ANALYSIS
-- =====================================================


-- -----------------------------------------------------
-- Query 30: Compare Sales Across Unemployment Categories
-- Description:
-- Divides unemployment values into four ranges and
-- calculates average weekly sales within each category.
-- -----------------------------------------------------

SELECT
AVG(Weekly_Sales) AS Avg_Weekly_Sales,
CASE
    WHEN Unemployment >= 10 THEN 'Very High Unemployment'
    WHEN Unemployment >= 8 AND Unemployment < 10 THEN 'High Unemployment'
    WHEN Unemployment >= 6 AND Unemployment < 8 THEN 'Medium Unemployment'
    WHEN Unemployment < 6 THEN 'Low Unemployment'
    END AS Unemployment_Category
FROM "walmart_sales"
GROUP BY Unemployment_Category
ORDER BY Avg_Weekly_Sales DESC;