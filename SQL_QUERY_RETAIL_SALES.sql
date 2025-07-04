-- SQL RETAIL SALES ANALYSIS

-- CREATE DATABASE

CREATE DATABASE SQL_PROJECT;


-- CREATE TABLE

CREATE TABLE RETAIL_SALES
		(
            transactions_id INT PRIMARY KEY ,
            sale_date DATE,
		    sale_time TIME,	
            customer_id INT,
            gender VARCHAR(10),
            age	INT,
            category VARCHAR(15),
			quantity INT,
            price_per_unit FLOAT,
            cogs FLOAT,
			total_sale FLOAT
		)
        


-- DATA EXPLORATION

-- TOTAL NUMBER OF RECORDS IN YOUR TABLE ?
SELECT COUNT(*) FROM RETAIL_SALES;


-- HOW MANY UNIQUE CISTOMER WE HAVE ?
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMER FROM RETAIL_SALES;


-- HOW MANY CATEGORY WE HAVE ?
SELECT COUNT(DISTINCT CATEGORY) AS TOTAL_CATEGORY FROM  RETAIL_SALES;

-- HOW MANY NULL VALUES IN THE TABLE AND DELETE RECORDS WITH MISSING DATA.
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
    
    
-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS


-- 1. WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON "2022-11-05"
SELECT*
FROM RETAIL_SALES 
WHERE SALE_DATE="2022-11-05";


-- 2. WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS "CLOTHING" AND QUANTITY SOLD IS MORE THAN EQUAL 4 IN THE MONTH OF NOV-2022
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

 
-- 3. WRIRE A SQL QUERY TO CALUCLATE THE TOTAL SALES (TOTAL_SALES) FOR EACH CATEGORY 
SELECT 
      CATEGORY,
      SUM(TOTAL_SALE) AS NET_SALE 
FROM RETAIL_SALES
GROUP BY CATEGORY;

 
 -- 4. WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE "BEAUTY" CATEGORY
SELECT 
       ROUND(AVG(AGE),2) AS AVG_AGE 
FROM RETAIL_SALES
WHERE CATEGORY = "BEAUTY";

 
 -- 5. WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALE IN GREATER THAN 1000
 SELECT*FROM RETAIL_SALES
 WHERE TOTAL_SALE>1000;


 -- 6. WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTION (TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY 
SELECT 
      CATEGORY,GENDER,COUNT(*) 
FROM RETAIL_SALES
GROUP BY CATEGORY,GENDER 
ORDER BY 1 ;


 -- 7. WRITE A SQL QUERY TO CALCUCLATE AVERAGE SALE FOR EACH MONTH . FIND OUT BEST SELLING MONTH IN EACH YEAR
SELECT 
YEAR(SALE_DATE) AS YEAR ,
MONTH(SALE_DATE) AS MONTH ,
AVG(TOTAL_SALE) AS AVG_SALE ,
RANK() OVER (PARTITION BY YEAR(SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC ) AS RANKING 
FROM RETAIL_SALES
GROUP BY 1,2
ORDER BY 1,3 DESC;

 
 
 -- 8. WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
SELECT
	CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALE 
FROM RETAIL_SALES
GROUP BY CUSTOMER_ID
ORDER BY SUM(TOTAL_SALE) DESC 
LIMIT 5;
 
 
 -- 9. WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY
SELECT 
     CATEGORY ,
     COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMER 
FROM RETAIL_SALES
GROUP BY CATEGORY;

 
 -- 10. WRIET A SQL QUERY TO CEATE EACH SHIFT AND NUMBER OF ORDERS ( EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17, EVENING>17)
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


-- END OF PROJECT
