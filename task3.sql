SELECT TOP 3
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM 
    Employees e
JOIN 
    Orders o ON e.EmployeeID = o.EmployeeID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    e.EmployeeID, e.FirstName, e.LastName
ORDER BY 
    TotalSales DESC;
