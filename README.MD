# Walmart Sales Analysis

## Project Overview

This project analyzes Walmart weekly sales data using SQL to identify sales trends, store performance, holiday effects, and other factors that may influence sales.

## Dataset

The dataset contains weekly sales data for 45 Walmart stores. The main columns include:

- Store
- Date
- Weekly Sales
- Holiday Flag
- Temperature
- Fuel Price
- CPI
- Unemployment

## Tools Used

- SQL
- SQLite
- Visual Studio Code
- DB Browser for SQLite

## Business Questions

**Store Performance-

Which stores generated the highest total sales?

Which stores generated the lowest total sales?

What is the average weekly sales for each store? 

Which stores have the most consistent weekly sales (lowest variation)?

Which stores experience the largest fluctuations in sales?

**Weekly & Seasonal Trends-

What were the top 10 highest-selling weeks?

What were the top 10 lowest-selling weeks?

Which months generate the highest average sales?

Which years generated the highest total sales?

How do weekly sales trend over time?

**Holiday Analysis- 

Do holiday weeks generate higher average sales than non-holiday weeks?

Which stores benefit the most from holidays?

Which stores benefit the least from holidays?

**External Factors- 

Is there a relationship between temperature and weekly sales?

Is there a relationship between fuel prices and weekly sales?

Is there a relationship between CPI and weekly sales?

Is there a relationship between unemployment and weekly sales?

Rank every store by total sales.

Find stores performing above the company average.

Find stores performing below the company average.

Calculate each store's cumulative (running) sales over time.

Compare each week's sales to the previous week (LAG()).

Identify each store's best-performing week.

Identify each store's worst-performing week.

Classify stores into High, Medium, and Low performers using CASE.**

## Key Insights

1. Monthly Sales Trends

FINDINGS: December consistently outperformed every other month in average weekly sales.

SUPPORTING EVIDENCE: Month twelve had an average weekly sales value of around $1,281,864.00 with the average weekly sales value for the whole data being around $1,046,965.00.

   ![Monthly Sales Performance](images/monthly_sales.png)

Business RECOMMENDATION: Walmart could figure out what factors led to an increase in December Sales compared to other months.

2. Holiday Performance  

FINDING: Store 20 had the highest average weekly sales during the holidays.

SUPPORTING EVIDENCE: Store 20 had an average weekly sales value of around 
$2,249,035.00 with the average weekly sales value during the holidays being around $1,122,888.00.

 ![Holiday Store Performance](images/holiday_store_sales.png)


BUSINESS RECOMMENDATION: Walmart could follow strategies that Store 20 employ to boost the sales of other stores during the Holidays.

3. External Economic Factor  

FINDINGS: Higher unemployment levels were associated with lower average weekly sales

SUPPORTING EVIDENCE: Average weekly sales consistently decreased as unemployment categories increased from low to very high. Stores in the low unemployment category averaged approximately $1.18 million in weekly sales, while stores in the very high unemployment category averaged approximately $842,000 per week.

 ![Unemployment Analysis](images/unemployment_analysis.png)


BUSINESS RECOMMENDATION: Walmart should monitor unemployment trends when forecasting weekly sales, as higher unemployment levels in this dataset were associated with lower average weekly sales.

## Advanced SQL Techniques

This project also demonstrates SQL window functions to perform calculations that preserve individual rows while analyzing trends over time.

### Running Total by Store

The query below uses a SQL window function (`SUM() OVER`) to calculate cumulative weekly sales for each store while maintaining the chronological order of sales.

![Running Total by Store](images/running_total.png)