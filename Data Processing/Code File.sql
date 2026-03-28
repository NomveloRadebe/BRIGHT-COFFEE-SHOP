select * from `workspace`.`default`.`1773680391797_bright_coffee_shop_analysis_case_study_1` limit 100;




-- -------------------------------------------------------------
-- 1. CHECKING THE DATE RANGE
-- --------------------------------------------------------------
---Query 2: Viewing first 10 rows of the table
SELECT DISTINCT store_location 
FROM `workspace`.`default`.`brightcoffee_consultation`;






---Query 3: Checking start date= 2023-01-01
SELECT MIN(transaction_date)start_date
FROM `workspace`.`default`.`brightcoffee_consultation`;






---Query 4: The last day of data collection= 2023-06-30
SELECT  MAX(transaction_date)AS Last_Date
FROM `workspace`.`default`.`brightcoffee_consultation`;






-- ---------------------------------------------------------------
-- 2. CHECKING TIME 
-- ---------------------------------------------------------------

---Query 6: Checking the first transaction of the day  = 06:00:
SELECT MIN(Transaction_Time)
FROM `workspace`.`default`.`brightcoffee_consultation`;

---Query 7: Checking the last sale of the day. =  20:59:
SELECT MAX(Transaction_Time)
FROM `workspace`.`default`.`brightcoffee_consultation`;


---Query 8: Purchase times 
SELECT transaction_date, unit_price,
date_format(transaction_time, 'Hm:mm:ss') AS purchase_time
FROM `workspace`.`default`.`brightcoffee_consultation`;






---Query 9: Adding a column for time_buckets
SELECT date_format(transaction_time, 'Hm:mm:ss') AS purchase_time,
CASE
    WHEN date_format(transaction_time, 'Hm:mm:ss') BETWEEN '06:00:00'AND '11:59:59' THEN '01.Morning'
    WHEN date_format(transaction_time, 'Hm:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.AFTERNOON'
    WHEN date_format(transaction_time, 'Hm:mm:ss')>= '17:00:00' THEN '03.EVENING'
END AS time_buckets
FROM `workspace`.`default`.`brightcoffee_consultation`;




 


-- -----------------------------------------------------------
-- 3. Checking the store locations
-- ------------------------------------------------------------
---Query 10:Store locations. = 3 Locations- Lower Manhattan, Hells Kitchen and Astoria
SELECT DISTINCT store_location
FROM `workspace`.`default`.`brightcoffee_consultation`;

---Query 11: Store Count. = 3
SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`brightcoffee_consultation`;

-- -------------------------------------------------
-- 4. Checking products sold at our stores 
-- ------------------------------------------------
---Query 12: Checking the different product categories
SELECT DISTINCT product_category
FROM `workspace`.`default`.`brightcoffee_consultation`;

---Query 13: Checking the different product details
SELECT DISTINCT product_detail
FROM `workspace`.`default`.`brightcoffee_consultation`;

---Query 14:Checking the different product types
SELECT DISTINCT product_type
FROM `workspace`.`default`.`brightcoffee_consultation`;

---Query 15: Checking the category each product belongs to
SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM `workspace`.`default`.`brightcoffee_consultation`;

-- ----------------------------------------------------------
-- 5. Finding Maximum and Minimum prices
-- --------------------------------------------------------
---Query 16: Finding minimum and maximum values
SELECT MIN(unit_price) AS min_price
FROM `workspace`.`default`.`brightcoffee_consultation`;






---Query 17: Finding maximum unit price 
SELECT MAX(unit_price) AS Max_price
FROM `workspace`.`default`.`brightcoffee_consultation`;






-- ----------------------------------------------------------------
-- 6. Counting the sales and number of products
-- -------------------------------------------------------------
---Query 18:Counts
SELECT 
COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`brightcoffee_consultation`;

-- ---------------------------------------------------------------
-- 7. FINDING THE DAY AND MONTH NAMES TOGETHER WITH REVENUE PER TRANSACTION
-- ----------------------------------------------------------------
---Query 19:DAY NAME, MONTH NAME, REVENUE PER TRANSACTION
SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      transaction_qty*unit_price AS revenue_per_tranaction
FROM `workspace`.`default`.`brightcoffee_consultation`;

---QUERY20:EXTRACTING THE NUMBER OF SALES PER DAY AND REVENUE PER DAY
SELECT 
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      SUM(transaction_qty*unit_price) AS revenue_per_day
FROM `workspace`.`default`.`brightcoffee_consultation`
GROUP BY transaction_date,
         Day_name,
         Month_name;




      
-- ----------------------------------------------------------
-- 8. Calculating Revenue and Product Perfomance
-- --------------------------------------------------------

---Query 21: Calculate total sales
SELECT SUM(transaction_qty* unit_price)AS Total_Sales
FROM `workspace`.`default`.`brightcoffee_consultation`;







---QUERY 22: Calculate total sales in each location 
SELECT SUM(transaction_qty* unit_price)AS Total_Sales, store_location
FROM `workspace`.`default`.`brightcoffee_consultation`
GROUP BY store_location;






---QUERY 23: CALCULTE THE MOST PURCHASED PRODUCT
SELECT COUNT(product_id) AS Total_Orders, Product_Category
FROM `workspace`.`default`.`brightcoffee_consultation`
GROUP BY product_category 
ORDER BY Total_Orders DESC;

---QUERY 24: CALCULTE THE LEAST PURCHASED PRODUCT
SELECT COUNT(product_id) AS Total_Orders, Product_Category
FROM `workspace`.`default`.`brightcoffee_consultation`
GROUP BY Product_Category 
ORDER BY Total_Orders ASC;

---QUERY 25:CALCULATE THE PRODUCT THAT GENERATES THE MOST REVENUE
SELECT SUM(unit_price*transaction_qty) AS Total_Revenue, product_category
FROM `workspace`.`default`.`brightcoffee_consultation`
GROUP BY product_category
ORDER BY total_revenue DESC;






---QUERY 26:CALCULATE THE PRODUCT THAT GENERATES THE LEAST REVENUE
SELECT SUM(unit_price*transaction_qty) AS Total_Revenue, product_category
FROM `workspace`.`default`.`brightcoffee_consultation`
GROUP BY product_category
ORDER BY total_revenue ASC;






-- -----------------------------------------------------------------------------
-- 9. Checking for Null Values
-- ----------------------------------------------------------------------------
---Query 27:Checking for Nulls on unit_price
SELECT*
FROM `workspace`.`default`.`brightcoffee_consultation`
WHERE unit_price IS Null;

---Query 28: Checking for Nulls on transaction_qty and date
SELECT*
FROM `workspace`.`default`.`brightcoffee_consultation`
WHERE transaction_qty IS Null
OR transaction_date IS Null;





-- --------------------------------------------------------------------------------

SELECT 
--Dates
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      date_format(transaction_time, 'HH:mm:ss') AS purchase_time,
      CASE
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00'AND '11:59:59' THEN '01.Morning'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.AFTERNOON'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '17:00:00' AND '23:59:59' THEN '03.Evening'
END AS time_buckets,

CASE 
    WHEN Dayname(transaction_date) IN('Sun', 'Sat') THEN 'Weekend'
    ELSE 'Weekday'
END AS day_classification,

--Counts of IDs
 COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores,

--Revenue 
     SUM(transaction_qty* unit_price)AS revenue_per_day,  

     CASE 
     WHEN revenue_per_day<=50 THEN '01.Low Spend'
     WHEN revenue_per_day BETWEEN 51 AND 100 THEN '02.Medium Spend'
     ELSE '03.High Spend'
     END AS spend_bucket, 

--Categorical
store_location,
product_category,
product_detail
FROM `workspace`.`default`.`brightcoffee_consultation`
GROUP BY transaction_date,
         transaction_time,
         Dayname(transaction_date),
         Monthname(transaction_date),
         store_location,
         product_category,
         product_detail,
         date_format(transaction_time, 'HH:mm:ss'),
         CASE
WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00'AND '11:59:59' THEN '01.Morning'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.AFTERNOON'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '17:00:00' AND '23:59:59' THEN '03.Evening'
END,
         CASE 
    WHEN Dayname(transaction_date) IN('Sun', 'Sat') THEN 'Weekend'
    ELSE 'Weekday'
END;
