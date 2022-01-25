-- zad 1/89
select ProductNumber, StandardCost, ListPrice from SalesLT.Product
where 
2*StandardCost < ListPrice 
and 
(ProductNumber like '%4' or ProductNumber like '%8');

select ProductNumber, StandardCost, ListPrice from SalesLT.Product
where 
2*StandardCost < ListPrice 
and 
(right(ProductNumber, 1) in ('4', '8'));

-- zad 2/89
select Top 5 Percent with Ties SalesOrderID, Freight, OrderDate 
from SalesLT.SalesOrderHeader
where OrderDate between '20080106' and '20081231'
order by Freight; 

--3/89
select top 1 name 
from SalesLT.Product
order by NEWID();
