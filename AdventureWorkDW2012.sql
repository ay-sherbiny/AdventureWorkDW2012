-- Total Revenue per Customer

SELECT 
    c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    SUM(sod.LineTotal) AS TotalSpent
FROM [AdventureWorksLT2022].[SalesLT].[Customer] c
JOIN [AdventureWorksLT2022].[SalesLT].[SalesOrderHeader] soh 
    ON c.CustomerID = soh.CustomerID
JOIN [AdventureWorksLT2022].[SalesLT].[SalesOrderDetail] sod 
    ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName;



--Average Order Value

SELECT AVG(soh.TotalDue) AS AvgOrderValue
FROM [AdventureWorksLT2022].[SalesLT].[SalesOrderHeader] soh;




--Best-Selling Products

SELECT 
    sod.ProductID, 
    SUM(sod.OrderQty) AS TotalSold, 
    SUM(sod.LineTotal) AS TotalRevenue
FROM [AdventureWorksLT2022].[SalesLT].[SalesOrderDetail] sod
GROUP BY sod.ProductID
ORDER BY TotalRevenue DESC;



--Discount Impact Analysis

SELECT 
    CASE WHEN sod.UnitPriceDiscount > 0 THEN 'Discounted' ELSE 'No Discount' END AS DiscountStatus,
    SUM(sod.OrderQty) AS TotalSold,
    SUM(sod.LineTotal) AS TotalRevenue
FROM [AdventureWorksLT2022].[SalesLT].[SalesOrderDetail] sod
GROUP BY CASE WHEN sod.UnitPriceDiscount > 0 THEN 'Discounted' ELSE 'No Discount' END;




SELECT 
    CustomerID,
    FirstName,
    LastName,
    CASE 
        WHEN TotalSpent >= 30000 THEN 'High Spender'
        WHEN TotalSpent >= 25000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS SpendingCategory
FROM (
    SELECT 
        c.CustomerID, 
        c.FirstName,
        c.LastName,
        SUM(sod.LineTotal) AS TotalSpent
    FROM [AdventureWorksLT2022].[SalesLT].[Customer] c
    JOIN [AdventureWorksLT2022].[SalesLT].[SalesOrderHeader] soh 
        ON c.CustomerID = soh.CustomerID
    JOIN [AdventureWorksLT2022].[SalesLT].[SalesOrderDetail] sod 
        ON soh.SalesOrderID = sod.SalesOrderID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
) AS Subquery;



-- Missing Customer Information
SELECT 
    CustomerID, 
    FirstName, 
    LastName
FROM [AdventureWorksLT2022].[SalesLT].[Customer]
WHERE MiddleName IS NULL OR CompanyName IS NULL;
