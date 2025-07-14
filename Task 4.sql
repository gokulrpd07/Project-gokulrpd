DROP TABLE IF EXISTS sales_sample;

CREATE TABLE sales_sample (
    Product_Id INTEGER,
    Region VARCHAR(50),
    Sales_Date DATE,
    Sales_Amount NUMERIC(10,2)
);

INSERT INTO sales_sample VALUES
(101, 'East',  '2025-07-01', 1500.00),
(102, 'West',  '2025-07-01', 1200.00),
(101, 'East',  '2025-07-02', 1700.00),
(103, 'North', '2025-07-01', 900.00),
(102, 'West',  '2025-07-02', 1300.00),
(101, 'South', '2025-07-01', 1800.00),
(104, 'North', '2025-07-02', 950.00),
(105, 'East',  '2025-07-03', 2000.00),
(104, 'West',  '2025-07-03', 1100.00),
(105, 'South', '2025-07-01', 1400.00);

SELECT 
    Region, 
    Product_Id, 
    SUM(Sales_Amount) AS Total_Sales
FROM 
    sales_sample
GROUP BY 
    Region, Product_Id
ORDER BY 
    Region, Product_Id;

SELECT 
    Region,
    Product_Id,
    SUM(Sales_Amount) AS Total_Sales
FROM 
    sales_sample
GROUP BY ROLLUP (Region, Product_Id)
ORDER BY Region NULLS LAST, Product_Id NULLS LAST;

SELECT 
    Product_Id,
    Region,
    Sales_Date,
    SUM(Sales_Amount) AS Total_Sales
FROM 
    sales_sample
GROUP BY CUBE (Product_Id, Region, Sales_Date)
ORDER BY Product_Id NULLS LAST, Region NULLS LAST, Sales_Date NULLS LAST;

SELECT *
FROM sales_sample
WHERE Region = 'East';

SELECT *
FROM sales_sample
WHERE 
    Product_Id IN (101, 102) AND
    Region IN ('East', 'West') AND
    Sales_Date BETWEEN '2025-07-01' AND '2025-07-02';
