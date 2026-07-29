SELECT * FROM "walmart_sales";

SELECT 
STORE,
DATE,
MAX(Weekly_Sales)
FROM "walmart_sales";  

SELECT 
STORE,
DATE,
MIN(Weekly_Sales)
FROM "walmart_sales";  

SELECT AVG(Weekly_Sales)
FROM "walmart_sales";

SELECT 
AVG(Weekly_Sales),
Store
FROM "walmart_sales"
GROUP BY Store
ORDER BY AVG(Weekly_Sales) DESC;


SELECT * FROM "walmart_sales"
ORDER BY Weekly_Sales DESC
LIMIT 10;

SELECT * FROM "walmart_sales"
ORDER BY Weekly_Sales ASC
LIMIT 10;

SELECT 
    substr(Date, 4, 2) AS Month,
    AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY Month
ORDER BY AVG_Weekly_Sales DESC;

SELECT 
    substr(Date, 7, 4) AS Year,
    MAX(Weekly_Sales) AS Highest_Sale
FROM "walmart_sales"
GROUP BY Year
ORDER BY MAX(Weekly_Sales) DESC;

SELECT 
    substr(Date, 7, 4) AS Year,
    AVG(Weekly_Sales) AS Avg_weekly_Sale
FROM "walmart_sales"
GROUP BY Year
ORDER BY AVG(Weekly_Sales) DESC; 

SELECT 
    substr(Date, 7, 4) AS Year,
    SUM(Weekly_Sales) AS Total_Sales
FROM "walmart_sales"
GROUP BY Year
ORDER BY SUM(Weekly_Sales) DESC;

SELECT 
    Date, 
    AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY Date
ORDER BY 
substr(Date, 7, 4),
substr(Date, 4, 2),
substr(Date, 1, 2) ASC;

SELECT AVG(Weekly_Sales) AS Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 1;

SELECT AVG(Weekly_Sales) AS Non_Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 0;

SELECT  STORE, AVG(Weekly_Sales) AS HIGH_Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 1
GROUP BY STORE 
ORDER BY HIGH_Holiday_Avg_Weekly_Sales DESC;

SELECT  STORE,AVG(Weekly_Sales) AS LOW_Holiday_Avg_Weekly_Sales
FROM "walmart_sales"
WHERE Holiday_Flag = 1
GROUP BY STORE 
ORDER BY LOW_Holiday_Avg_Weekly_Sales ASC;

SELECT  STORE, SUM(Weekly_Sales) AS Total_Weekly_Sales
FROM "walmart_sales"
GROUP BY STORE 
ORDER BY STORE ASC;

SELECT STORE, AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY STORE 
HAVING Avg_Weekly_Sales > 1046964.87756177
ORDER BY Avg_Weekly_Sales DESC;

SELECT STORE, AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM "walmart_sales"
GROUP BY STORE 
HAVING Avg_Weekly_Sales < 1046964.87756177
ORDER BY Avg_Weekly_Sales DESC;

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

Select 
Store,
MAX(Weekly_Sales) AS Highest_Weekly_Sale
FROM "walmart_sales"
GROUP BY Store
ORDER BY Highest_Weekly_Sale DESC;


Select 
Store,
MIN(Weekly_Sales) AS Lowest_Weekly_Sale
FROM "walmart_sales"
GROUP BY Store
ORDER BY Lowest_Weekly_Sale ASC;


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

SELECT
Store,
(AVG(Weekly_Sales * Weekly_Sales) - 
AVG(Weekly_Sales) * AVG(Weekly_Sales)) AS LOW_Sales_Variance
FROM "walmart_sales"
GROUP BY Store
ORDER BY LOW_Sales_Variance ASC;

SELECT
Store,
(AVG(Weekly_Sales * Weekly_Sales) - 
AVG(Weekly_Sales) * AVG(Weekly_Sales)) AS HIGH_Sales_Variance
FROM "walmart_sales"
GROUP BY Store
ORDER BY HIGH_Sales_Variance DESC;


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

