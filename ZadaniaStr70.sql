--1/70
select Name, ListPrice, ListPrice*1.2 as plus20prc from  SalesLT.Product;
--2/70
select OrderDate, ShipDate, DateDiff(Day,OrderDate,ShipDate) as time_of_order from SalesLT.SalesOrderHeader;
-- 3/71
select 'Produkt ' + Name, 'koszuje', round(ListPrice,1)
from SalesLT.Product
order by ListPrice desc; 
--4/71
select distinct cast(year(OrderDate) as char(4)) + '-'+
cast(month(OrderDate) as char(2))  +
'-' + cast(day(OrderDate) as char(2))
from SalesLT.SalesOrderHeader 
order by cast(year(OrderDate) as char(4)) + '-'+
cast(month(OrderDate) as char(2))  + '-' +
cast(day(OrderDate) as char(2)) desc;
--5/71
select ProductNumber, Size
from SalesLT.Product
order by case
		when Size is Null then 1
		else 0
	end,
Size;
