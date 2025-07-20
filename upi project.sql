CREATE TABLE my_database.upi_raw (
    Month VARCHAR(20),
    Volume_Mn FLOAT,
    Value_Cr FLOAT
);
SELECT *
FROM upi_raw;

CREATE TABLE upi_raw_cleaned AS
SELECT
  STR_TO_DATE(CONCAT('01-', Month), '%d-%b-%y') AS Month_Date,
  Volume_Mn,
  Value_Cr
FROM upi_raw;

select*
from upi_raw_cleaned;

CREATE TABLE upi_final AS
SELECT
  Month_Date,
  Volume_Mn,
  Value_Cr,
  YEAR(Month_Date) AS Year,
  MONTHNAME(Month_Date) AS Month_Name,
  MONTH(Month_Date) AS Month_Num,
  CONCAT('Q', QUARTER(Month_Date)) AS Quarter
FROM upi_raw_cleaned;

SELECT *
FROM upi_final 
ORDER BY Month_Date;

ALTER TABLE 
upi_final 
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

-- Total Volume & Value by Year
SELECT 
  Year, 
  ROUND(SUM(Volume_Mn), 2) AS Total_Volume_Mn,
  ROUND(SUM(Value_Cr), 2) AS Total_Value_Cr
FROM upi_final
GROUP BY Year
ORDER BY Year;

-- Month-over-Month Growth (%)
SELECT 
  Month_Date,
  Volume_Mn,
  Value_Cr, 
  ROUND(
    (Volume_Mn - LAG(Volume_Mn) OVER (ORDER BY Month_Date)) * 100 /
    LAG(Volume_Mn) OVER (ORDER BY Month_Date), 2
  ) AS MoM_Volume_Growth_Percent,
  ROUND(
    (Value_Cr - LAG(Value_Cr) OVER (ORDER BY Month_Date)) * 100 /
    LAG(Value_Cr) OVER (ORDER BY Month_Date), 2
  ) AS MoM_Value_Growth_Percent
FROM upi_final;

-- Year-on-Year Growth (%)
SELECT 
  Month_Name,
  Month_Num,
  Year,
  Value_Cr,
  ROUND(
    (Value_Cr - LAG(Value_Cr) OVER (PARTITION BY Month_Num ORDER BY Year)) * 100 /
    LAG(Value_Cr) OVER (PARTITION BY Month_Num ORDER BY Year), 2
  ) AS YoY_Value_Growth_Percent
FROM upi_final
ORDER BY Month_Num, Year;

-- Quarter-Wise Total Volume & Value
SELECT 
  Year,
  Quarter,
  ROUND(SUM(Volume_Mn), 2) AS Total_Volume_Mn,
  ROUND(SUM(Value_Cr), 2) AS Total_Value_Cr
FROM upi_final
GROUP BY Year, Quarter
ORDER BY Year, Quarter;

-- Month-Wise Average (Across Years)
SELECT 
  Month_Name,
  Month_Num,
  ROUND(AVG(Volume_Mn), 2) AS Avg_Monthly_Volume,
  ROUND(AVG(Value_Cr), 2) AS Avg_Monthly_Value
FROM upi_final
GROUP BY Month_Name, Month_Num
ORDER BY Month_Num;

 -- Avg. Ticket Size per Month
 SELECT 
  Month_Date,
  ROUND((Value_Cr * 10000000) / (Volume_Mn * 1000000), 2) AS Avg_Ticket_Size_INR
FROM upi_final
ORDER BY Month_Date;

-- Highest/Lowest Volume or Value Month
-- Highest volume month
SELECT Month_Date, Volume_Mn
FROM upi_final
ORDER BY Volume_Mn DESC
LIMIT 1;

-- Lowest volume month
SELECT Month_Date, Volume_Mn
FROM upi_final
ORDER BY Volume_Mn ASC
LIMIT 1;

-- Compare Volume Growth vs Value Growth Trend
SELECT 
  Month_Date,
  Volume_Mn,
  Value_Cr,
  ROUND(Value_Cr / Volume_Mn, 2) AS Value_per_Mn_Transactions
FROM upi_final
ORDER BY Month_Date;

-- Outlier Detection (High Volume, Low Value)
SELECT 
  Month_Date, Volume_Mn, Value_Cr,
  ROUND((Value_Cr * 10^7) / (Volume_Mn * 10^6), 2) AS Avg_Ticket_Size_INR
FROM upi_final
WHERE 
  ROUND((Value_Cr * 10^7) / (Volume_Mn * 10^6), 2) < 600 -- arbitrary threshold
ORDER BY Avg_Ticket_Size_INR ASC;

-- Quarter with Highest Value
SELECT 
  Year, Quarter, ROUND(SUM(Value_Cr), 2) AS Total_Value_Cr
FROM upi_final
GROUP BY Year, Quarter
ORDER BY Total_Value_Cr DESC
LIMIT 1;

