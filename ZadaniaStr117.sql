--1/117
select C.FirstName, P.Name
from SalesLT.Customer as C 
join SalesLT.SalesOrderHeader as H
on C.CustomerID=H.CustomerID
join SalesLT.SalesOrderDetail as D
on D.SalesOrderID=H.SalesOrderID
join SalesLT.Product as P
on D.ProductID=P.ProductID
where C.FirstName='Jeffrey' 
order by P.Name; 

--2/117
select C.FirstName, C.LastName, H.CustomerID
from SalesLT.Customer as C
left outer join SalesLT.SalesOrderHeader as H
on C.CustomerID=H.CustomerID
where H.CustomerID is null;

--3/117
select SalesOrderID, Freight, 'high' as 'H/L'
from SalesLT.SalesOrderHeader as H
where Freight > 100
union all
select SalesOrderID, Freight, 'low'
from SalesLT.SalesOrderHeader
where Freight <= 100;
-- z wykorzystaniem case
select SalesOrderId, Freight,
case
	when Freight > 100 then 'high'
	else 'low'
end
from SalesLT.SalesOrderHeader;