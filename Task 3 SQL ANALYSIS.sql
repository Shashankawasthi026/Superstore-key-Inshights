CREATE DATABASE SuperstoreDB;
USE SuperstoreDB;

SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales,
    SUM(Profit) AS Monthly_Profit
FROM orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

SELECT
    t1.Month,
    t1.Monthly_Sales,
    ((t1.Monthly_Sales - t2.Monthly_Sales)
      / t2.Monthly_Sales) * 100 AS Growth_Percentage
FROM
(
SELECT MONTH(Order_Date) Month,
SUM(Sales) Monthly_Sales
FROM Orders
GROUP BY MONTH(Order_Date)
) t1
JOIN
(
SELECT MONTH(Order_Date) Month,
SUM(Sales) Monthly_Sales
FROM orders
GROUP BY MONTH(Order_Date)
) t2
ON t1.Month = t2.Month + 1;


SELECT
Order_ID,
Sales,
CASE
WHEN Sales > 1000 THEN 'High Value'
WHEN Sales BETWEEN 500 AND 1000 THEN 'Medium Value'
ELSE 'Low Value'
END AS Order_Type
FROM orders;


SELECT
c.Region,
SUM(o.Profit) AS Total_Profit
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region
HAVING SUM(o.Profit) < 10000;