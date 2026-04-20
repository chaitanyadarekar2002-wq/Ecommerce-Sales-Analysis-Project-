
--What is the total revenue generated over the entire period?(Revenue = Quantity × Price)
select * from Customers;
select SUM(OD.Quntity * P.Price) as Total_Revenue
from OederDetails OD
join Product p on P.ProductID=OD.ProductID;

--Revenue excluding returned orders
SELECT SUM(OD.Quntity * P.Price) AS Total_Return
FROM Orderss O
JOIN OederDetails OD ON OD.OrderID = O.OrderID
JOIN Product P ON P.ProductID = OD.ProductID
WHERE O.IsReturned = 1;

--Total revenue per Year / Month
select YEAR(OrderDate) as 'year',Month(OrderDate) as 'month',
SUM(OD.Quntity * P.Price) AS MonthlyYearly_Return
FROM Orderss O
JOIN OederDetails OD ON OD.OrderID = O.OrderID
JOIN Product P ON P.ProductID = OD.ProductID
group by YEAR(O.OrderDate),
    MONTH(O.OrderDate)
order by YEAR(O.OrderDate),
    MONTH(O.OrderDate)

--Revenue by Product / Category
select Productname,category,SUM(OD.Quntity * P.Price) as ProductRevenue
from OederDetails OD
join Product p on P.ProductID=OD.ProductID
group by Productname,category
order by ProductRevenue desc;