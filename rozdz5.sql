select C.Name category_name, P.Name product_name 
from SalesLT.ProductCategory as C
join SalesLT.Product as P
on P.ProductCategoryID = C.ProductCategoryID;
--
select * 
from SalesLT.Customer as C
join SalesLT.SalesOrderHeader as OH
on C.CustomerID= OH.CustomerID
where SalesOrderID = 71796;

-- left outer join
select ProductNumber, C.Name
from SalesLT.Product as P
left outer join SalesLT.ProductCategory as C
on C.ProductCategoryID = P.ProductCategoryID
where P.Color = 'White';

--right outer join
Select ProductNumber, C.Name
from SalesLT.ProductCategory as C
right outer join SalesLT.Product as P
on C.ProductCategoryID = P.ProductCategoryID
where P.Color = 'white';

--full outer join
--cross join
select P.Name, C.FirstName, C.LastName
from SalesLT.Product as P
cross join SalesLT.Customer as C;

-- z³¹czenia wielokrotne
select C.LastName, P.Name
from SalesLT.Customer as C
join SalesLT.SalesOrderHeader as H
on C.CustomerID = H.CustomerID
join SalesLT.SalesOrderDetail as D
on H.SalesOrderID=D.SalesOrderID
join SalesLT.Product as P
on P.ProductID=D.ProductID
order by C.LastName; 

--okreslanie kolejnoœci z³¹czeñ
select P.ProductNumber, D.SalesOrderID, H.TotalDue
from SalesLT.Product as P
left outer join 
	(SalesLT.SalesOrderDetail as D
	join SalesLT.SalesOrderHeader as H
	on H.SalesOrderId = D.SalesOrderId)
on P.ProductID = D.ProductID;

select count(*)
from SalesLT.Product as P
left outer join 
	(SalesLT.SalesOrderDetail as D
	join SalesLT.SalesOrderHeader as H
	on H.SalesOrderId = D.SalesOrderId)
on P.ProductID = D.ProductID;

-- £¹czenie tabeli z sam¹ sob¹
select distinct P1.ProductId, P1.ListPrice, P2.ProductId, P2.ListPrice
from SalesLT.Product as P1
join SalesLT.Product as P2
on P1.ProductCategoryID= P2.ProductCategoryID
where P1.ListPrice*6<P2.ListPrice
order by P1.ListPrice;

-- ³¹czenie wyników zapytañ Union
select name from SalesLT.Product
union 
select name from SalesLT.ProductCategory
order by 1;

select AddressID from SalesLT.Address
union all 
select CustomerID 
from SalesLT.Customer;

--czêœc wspólna INTERSECT
select AddressID from SalesLT.Address
Intersect 
select CustomerID 
from SalesLT.Customer;
--ró¿nica Except
select AddressID from SalesLT.Address
except
select CustomerID 
from SalesLT.Customer;

--funkcje tabelaryczne
select * 
from dbo.ufnGetAllCategories();
select *
from SalesLT.vGetAllCategories;

select *
from dbo.ufnGetCustomerInformation(5);

--cross apply
select C.CustomerId, F.*
from SalesLT.Customer as C
cross apply dbo.ufnGetCustomerInformation(C.CustomerId) as F
where Title = 'Ms.';
--outeer apply
select C.FirstName, C.CustomerID, F.*
from SalesLT.Customer as C
outer apply dbo.udf LastOrders(C.CustomerID,2) as F;