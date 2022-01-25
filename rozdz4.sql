  select ProductNumber, round(ListPrice, 1)
  from SalesLT.Product
  where ListPrice < 10;
  --
  select Name, left(SellStartDate, 11)
  from SalesLT.Product
  where SellStartDate > '20070601'
  order by SellStartDate Desc;
  --
  select Name, left(SellStartDate, 11) as SellStartDate
  from SalesLT.Product
  where year(SellStartDate) = 2021
  order by SellStartDate Desc;
  --
select Name, StandardCost, ListPrice
from SalesLT.Product
where StandardCost*2<ListPrice;

-- operatory

select Name, ListPrice
from SalesLT.Product
where ListPrice between 10 and 20;
--
select SalesOrderID, OrderDate
from SalesLT.SalesOrderHeader
where OrderDate between '20140101' and '20140601';
-- 
select LastName 
from SalesLT.Customer
where left(LastName, 1) between 'B' and 'D';
--like % i _
select ProductID, Name from SalesLT.Product
where Name like 'S%l';
--
select ProductID, ProductNumber from SalesLT.Product
where ProductNumber like 'S_-M%';
-- is null
select ProductNumber
from SalesLT.Product
where SellEndDate is Null;

-- z³o¿one warunki logiczne
select Name, ListPrice
from SalesLT.Product
where ProductCategoryID in (5, 16, 19)
and SellEndDate is not null
and Color = 'Black'
or ListPrice < 50;

-- hierarhia operatorów

select CustomerID, FirstName, LastName, CompanyName 
from SalesLT.Customer
where not CompanyName = 'A Bike Store'
and CustomerID>100
order by CompanyName, CustomerID;

select CustomerID, FirstName, LastName, CompanyName 
from SalesLT.Customer
where not (CompanyName = 'A Bike Store'
and CustomerID>100)
order by CompanyName, CustomerID;

select ProductCategoryID, ListPrice, StandardCost 
from SalesLT.Product
where not (StandardCost > 20
and ProductCategoryID = 1)
or ListPrice between 10 and 20;

--TOP 3 With TIES
select top 3 with ties Name, ListPrice
from SalesLT.Product
order by ListPrice desc;

select top 5 percent with ties Name, ListPrice
from SalesLT.Product
order by ListPrice desc;
-- stronicowanie wierszy

select name, ProductModelID
from SalesLT.Product
order by ProductModelID
offset 3 rows
fetch next 5 rows only;
