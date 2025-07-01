# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_PROJECT`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_PROJECT`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_PROJECT;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM RETAIL_SALES;
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMER FROM RETAIL_SALES;
SELECT COUNT(DISTINCT CATEGORY) AS TOTAL_CATEGORY FROM  RETAIL_SALES;

SELECT * FROM RETAIL_SALES
WHERE 
    SALE_DATE IS NULL OR SALE_TIME IS NULL OR CUSTOMER_ID IS NULL OR 
    GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR 
    QUANTITY IS NULL OR PRICE_PER_UNIT IS NULL OR COGS IS NULL;


DELETE FROM RETAIL_SALES
WHERE 
    SALE_DATE IS NULL OR SALE_TIME IS NULL OR CUSTOMER_ID IS NULL OR 
    GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR 
    QUANTITY IS NULL OR PRICE_PER_UNIT IS NULL OR COGS IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT*
FROM RETAIL_SALES 
WHERE SALE_DATE="2022-11-05";
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than equal 4 in the month of Nov-2022**:
```sql
SELECT*
FROM RETAIL_SALES
WHERE
     YEAR(SALE_DATE)=2022
     AND
     MONTH(SALE_DATE)=11
     AND 
     CATEGORY="CLOTHING"
     AND
     QUANTITY>=4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
      CATEGORY,
      SUM(TOTAL_SALE) AS NET_SALE 
FROM RETAIL_SALES
GROUP BY CATEGORY;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
       ROUND(AVG(AGE),2) AS AVG_AGE 
FROM RETAIL_SALES
WHERE CATEGORY = "BEAUTY";
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
 SELECT*FROM RETAIL_SALES
 WHERE TOTAL_SALE>1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
      CATEGORY,GENDER,COUNT(*) 
FROM RETAIL_SALES
GROUP BY CATEGORY,GENDER 
ORDER BY 1 ;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
YEAR(SALE_DATE) AS YEAR ,
MONTH(SALE_DATE) AS MONTH ,
AVG(TOTAL_SALE) AS AVG_SALE ,
RANK() OVER (PARTITION BY YEAR(SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC ) AS RANKING 
FROM RETAIL_SALES
GROUP BY 1,2
ORDER BY 1,3 DESC;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT
	CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALE 
FROM RETAIL_SALES
GROUP BY CUSTOMER_ID
ORDER BY SUM(TOTAL_SALE) DESC 
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
     CATEGORY ,
     COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMER 
FROM RETAIL_SALES
GROUP BY CATEGORY;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH HOURLY_SALE AS
(
SELECT*,
 CASE
    WHEN HOUR(SALE_TIME)<12 THEN  "MORNING"
    WHEN HOUR(SALE_TIME) BETWEEN 12 AND 17 THEN "AFTERNOON"
    ELSE "EVENING"
 END AS SHIFT
FROM RETAIL_SALES 
)

SELECT 
     SHIFT, COUNT(*) AS TOTAL_ORDERS 
FROM HOURLY_SALE
GROUP BY SHIFT;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `SQL_PROJECT` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `SQL_QUERY_RETAIL_SALES` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - HEMANTH KUMAR H C

gmail_id : hemanthkumarr057@gmail.com


Thank you and I look forward to connecting with you!
