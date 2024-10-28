SELECT
    c.CategoryID,
    YEAR(o.OrderDate) AS Year,
    MONTH(o.OrderDate) AS Month,
    SUM(od.UnitPrice * od.Quantity) AS MonthlySales,
    SUM(SUM(od.UnitPrice * od.Quantity)) OVER (PARTITION BY c.CategoryID, YEAR(o.OrderDate) ORDER BY MONTH(o.OrderDate)) AS YTD_Sales
FROM 
    Categories c
JOIN 
    Products p ON c.CategoryID = p.CategoryID
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
JOIN 
    Orders o ON od.OrderID = o.OrderID
GROUP BY 
    c.CategoryID, 
    YEAR(o.OrderDate), 
    MONTH(o.OrderDate);
