select YEAR(OrderDate) as YEAR,
		MONTH(OrderDate)as Month,
		SUM(OD.Quntity*p.Price) as REVENUE
from Orderss o
join OederDetails OD on OD.OrderID=O.OrderID
join Product p on p.ProductID=OD.ProductID
where OrderDate <= DATEADD(MONTH, -12, GETDATE())
group by YEAR(OrderDate),MONTH(OrderDate)
order by REVENUE DESC

WITH T1 AS (
    SELECT 
        r.Regionname, 
        COUNT(DISTINCT o.OrderID) AS OrderVOLUME
    FROM Orderss o
    JOIN Customers c ON c.CustomerID = o.customerID
    JOIN Region r ON r.RegionID = c.RegionID
    GROUP BY r.Regionname
),
T2 AS (
    SELECT 
        r.Regionname,
        SUM(OD.Quntity * p.Price) AS TotalValue
    FROM Orderss o
    JOIN Customers c ON c.CustomerID = o.customerID
    JOIN Region r ON r.RegionID = c.RegionID
    JOIN OederDetails OD ON OD.OrderID = o.OrderID
    JOIN Product p ON p.ProductID = OD.ProductID
    GROUP BY r.Regionname
)

SELECT TOP 5
    T1.Regionname,
    T2.TotalValue,
    T1.OrderVOLUME
FROM T1
JOIN T2 ON T1.Regionname = T2.Regionname
ORDER BY T2.TotalValue DESC;

select Regionname,ROUND(
        SUM(CASE WHEN o.IsReturned = 1 THEN 1 ELSE 0 END)
        / COUNT(o.OrderID), 
    2) AS ReturnRate
from Orderss o 
join Customers c on c.CustomerID=o.customerID 
join Region r on r.RegionID=c.RegionID
group by Regionname 
order by ReturnRate DESC

select c.CustomerID,customername, Count(o.OrderID) as CustomerReturn
from Orderss o
join Customers c on c.CustomerID=o.customerID
group by c.CustomerID,CustomerName
order by CustomerReturn DESC