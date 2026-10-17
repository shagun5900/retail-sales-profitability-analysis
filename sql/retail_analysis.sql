/*
Retail Sales & Profitability Analysis
Dialect: SQL Server (T-SQL)

Import the CSVs into tables named Sales, Products, Customers, Stores, and Exchange_Rates.
Clean Products[Unit Cost USD] and [Unit Price USD] to DECIMAL in Power Query or staging tables first.
The source has no transaction-level selling price or discount, so calculations below are list-price estimates.
*/

-- 1. Basic row counts
SELECT COUNT(*) AS SalesRows FROM dbo.Sales;
SELECT COUNT(*) AS CustomerRows FROM dbo.Customers;
SELECT COUNT(*) AS ProductRows FROM dbo.Products;
SELECT COUNT(*) AS StoreRows FROM dbo.Stores;
SELECT COUNT(*) AS ExchangeRateRows FROM dbo.Exchange_Rates;

-- 2. Validate line-level key uniqueness
SELECT [Order Number], [Line Item], COUNT(*) AS DuplicateCount
FROM dbo.Sales
GROUP BY [Order Number], [Line Item]
HAVING COUNT(*) > 1;

-- 3. Check unmatched foreign keys
SELECT COUNT(*) AS UnmatchedCustomers
FROM dbo.Sales s
LEFT JOIN dbo.Customers c ON s.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;

SELECT COUNT(*) AS UnmatchedProducts
FROM dbo.Sales s
LEFT JOIN dbo.Products p ON s.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;

SELECT COUNT(*) AS UnmatchedStores
FROM dbo.Sales s
LEFT JOIN dbo.Stores st ON s.StoreKey = st.StoreKey
WHERE st.StoreKey IS NULL;

-- 4. Overall list-price sales estimate and estimated gross profit
SELECT
    SUM(CAST(s.Quantity AS BIGINT)) AS TotalQuantity,
    COUNT(DISTINCT s.[Order Number]) AS OrderCount,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * p.[Unit Price USD]) AS EstimatedListPriceSalesUSD,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * (p.[Unit Price USD] - p.[Unit Cost USD])) AS EstimatedGrossProfitUSD,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * (p.[Unit Price USD] - p.[Unit Cost USD]))
      / NULLIF(SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * p.[Unit Price USD]), 0) AS EstimatedGrossMargin
FROM dbo.Sales s
JOIN dbo.Products p ON s.ProductKey = p.ProductKey;

-- 5. Category performance (list-price estimate)
SELECT
    p.Category,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * p.[Unit Price USD]) AS EstimatedListPriceSalesUSD,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * (p.[Unit Price USD] - p.[Unit Cost USD])) AS EstimatedGrossProfitUSD
FROM dbo.Sales s
JOIN dbo.Products p ON s.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY EstimatedListPriceSalesUSD DESC;

-- 6. Monthly trend
SELECT
    DATEFROMPARTS(YEAR(s.[Order Date]), MONTH(s.[Order Date]), 1) AS OrderMonth,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * p.[Unit Price USD]) AS EstimatedListPriceSalesUSD,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * (p.[Unit Price USD] - p.[Unit Cost USD])) AS EstimatedGrossProfitUSD
FROM dbo.Sales s
JOIN dbo.Products p ON s.ProductKey = p.ProductKey
GROUP BY DATEFROMPARTS(YEAR(s.[Order Date]), MONTH(s.[Order Date]), 1)
ORDER BY OrderMonth;

-- 7. Store/channel performance; StoreKey 0 is the Online channel
SELECT
    st.Country,
    st.State,
    CASE WHEN st.StoreKey = 0 THEN 'Online' ELSE 'Physical Store' END AS ChannelType,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * p.[Unit Price USD]) AS EstimatedListPriceSalesUSD,
    SUM(CAST(s.Quantity AS DECIMAL(18, 4)) * (p.[Unit Price USD] - p.[Unit Cost USD])) AS EstimatedGrossProfitUSD
FROM dbo.Sales s
JOIN dbo.Products p ON s.ProductKey = p.ProductKey
JOIN dbo.Stores st ON s.StoreKey = st.StoreKey
GROUP BY st.Country, st.State, CASE WHEN st.StoreKey = 0 THEN 'Online' ELSE 'Physical Store' END
ORDER BY EstimatedListPriceSalesUSD DESC;
