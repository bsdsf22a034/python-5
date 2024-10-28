WITH ProductSales AS (
    SELECT 
        YEAR(o.OrderDate) AS SaleYear,
        p.ProductID, 
        CAST(p.ProductName AS NVARCHAR(255)) AS ProductName,  -- Convert ProductName
        e.EmployeeID, 
        CAST(e.FirstName AS NVARCHAR(255)) AS FirstName,  -- Convert FirstName
        CAST(e.LastName AS NVARCHAR(255)) AS LastName,    -- Convert LastName
        SUM(od.UnitPrice * od.Quantity) AS TotalSales
    FROM Orders o
    JOIN [OrderDetails] od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Employees e ON o.EmployeeID = e.EmployeeID
    GROUP BY 
        YEAR(o.OrderDate), 
        p.ProductID, 
        CAST(p.ProductName AS NVARCHAR(255)),  -- Ensure grouping for ProductName
        e.EmployeeID, 
        CAST(e.FirstName AS NVARCHAR(255)),    -- Ensure grouping for FirstName
        CAST(e.LastName AS NVARCHAR(255) )     -- Ensure grouping for LastName
)

SELECT 
    ps.SaleYear,
    ps.ProductID,
    ps.ProductName,
    ps.EmployeeID,
    ps.FirstName,
    ps.LastName,
    ps.TotalSales
FROM ProductSales ps
WHERE ps.TotalSales = (
    SELECT MAX(ps2.TotalSales)
    FROM ProductSales ps2
    WHERE ps2.ProductID = ps.ProductID AND ps2.SaleYear = ps.SaleYear
)
ORDER BY ps.SaleYear, ps.ProductID;