select Top 10
c.CustomerID,customername,
SUM(OD.Quntity * p.Price) as Total_Revenue
from Customers c
join Orderss o on o.customerID=c.CustomerID
join OederDetails OD on OD.OrderID=o.OrderID
join Product p on p.ProductID=OD.ProductID
group by c.CustomerID,CustomerName 
order by Total_Revenue desc

with CustomerSpend as (
select o.customerID,SUM(OD.Quntity * p.Price) as Total_Spend
from Orderss o
join OederDetails OD on OD.OrderID=o.OrderID
join Product p on p.ProductID=OD.ProductID
group by o.CustomerID
)
select Customername ,
	CASE
		when Total_Spend>5 then 'Gold'
		when Total_Spend>10 then 'Platinum'
		when Total_Spend>50 then 'Dimond'
		end as CustomerLevel
	from CustomerSpend cs
	join Customers c on c.CustomerID=cs.customerID

select Top 5 p.ProductID,Productname,SUM(OD.Quntity) as top_5_ProductSales
from OederDetails OD
join Product p on p.ProductID=OD.ProductID
group by p.ProductID,Productname
order by top_5_ProductSales desc;

with sold as(
	select ProductID,SUM(Quntity) as TotalQTY
	from OederDetails
	group by ProductID
),
Retruned as(
select ProductID,SUM(OD.Quntity) as TotalQTYReturned
	from OederDetails OD
	join Orderss o on o.OrderID=od.OrderID
	where IsReturned=1
	group by ProductID
)
select Productname,Round((TotalQTYReturned/TotalQTY),2) as returnrate
from Product p
join sold s on s.ProductID=p.ProductID
join Retruned r on r.ProductID=p.ProductID
order by returnrate desc