WITH MonthlySales AS (
    SELECT
        YEAR(o.OrderDate) AS Year,
        MONTH(o.OrderDate) AS Month,
        od.ProductID,
        SUM(od.UnitPrice * od.Quantity) AS TotalSales
    FROM 
        Orders o
    JOIN 
        OrderDetails od ON o.OrderID = od.OrderID
    JOIN 
        Products p ON od.ProductID = p.ProductID
    GROUP BY 
        YEAR(o.OrderDate), MONTH(o.OrderDate), od.ProductID
)

SELECT
    m1.Year,
    m1.Month,
    m1.ProductID,
    m1.TotalSales AS CurrentMonthSales,
    (m1.TotalSales - COALESCE(m2.TotalSales, 0)) AS SalesGrowth
FROM 
    MonthlySales m1
LEFT JOIN 
    MonthlySales m2 ON m1.ProductID = m2.ProductID
    AND m1.Year = m2.Year
    AND m1.Month = m2.Month + 1
ORDER BY 
    m1.ProductID, m1.Year, m1.Month;
