select count(SalesorderID)
from SalesLT.SalesOrderHeader;

select count(distinct CustomerID)
from SalesLT.SalesOrderHeader;

select sum(ListPrice) as suma_ceny,
avg(ListPrice) as srednia_cena
from SalesLT.Product;

-- tworzenie tabeli tymczasowej
create table #Tab 
(id int identity,
val int)
go
insert into #Tab (val)
values
(2), (4);
select * from #Tab;
select sum(val), avg(val)from #Tab;
insert into #Tab (val)
values
(null);
select * from #Tab;
select sum(val) as suma_val, count(*) as licba_wierszy,
count(val) as ile_niemustych_val from #Tab;

select min(cast(OrderDate as date)) as min_date,
max(cast(OrderDate as date)) as max_date
from SalesLT.SalesOrderHeader;

select min(name), max(name)
from SalesLT.Product;

select min(ProductID) as min,
max(ProductID) as max,
count(*) as ile_wierszy, count(ProductID) as ile_ID,
max(ProductID)-min(ProductID)-count(*) as róznica
from SalesLT.Product;

-- stdev() odch standardowe, var() wariancja
select round(stdev(ListPrice),2) std,
round(avg(ListPrice),2) mean
from SalesLT.Product;

select avg(ListPrice*1.23)
from SalesLT.Product;

select avg(ListPrice)*1.23
from SalesLT.Product;

-- group by
select avg(ListPrice) as srednia, ProductCategoryID,
count(ProductID) as liczba
from SalesLT.Product
group by ProductCategoryID;

select P.ProductNumber, sum(od.lineTotal) as sum_lineTotal
from SalesLT.Product as P
join SalesLT.SalesOrderDetail as od
on P.ProductID=od.ProductID
group by p.ProductNumber;

select color, count(*)
from SalesLT.Product
group by color;

select left(color,1), count(*)
from SalesLT.Product
group by left(color,1);

-- chcemy poznaæ liczbê oraz œredni¹ cene produktów  z poszcz kategorii z rozbiciem na kolory
select C.name, P.color, count(*) as liczba, avg(ListPrice) as sr_cena
from SalesLT.Product as P
join SalesLT.ProductCategory as C
on P.ProductCategoryID=C.ProductCategoryID
group by C.Name, P.Color
order by C.name;

select C.name, P.color, count(*) as liczba, sum(listprice) as suma
from SalesLT.Product as P
join SalesLT.ProductCategory as C
on P.ProductCategoryID = C.ProductCategoryID
group by rollup (C.Name, P.Color)
order by C.Name;

select C.name, P.color, count(*) as liczba, sum(listprice) as suma
from SalesLT.Product as P
join SalesLT.ProductCategory as C
on P.ProductCategoryID = C.ProductCategoryID
group by cube (C.Name, P.Color)
order by C.Name;

select top 20 cat.Name, C.lastname, sum(od.linetotal) as total
from SalesLT.SalesOrderDetail as OD
join SalesLT.SalesOrderHeader as H
on OD.SalesOrderID = H.SalesOrderID
join SalesLT.Product as P
on P.ProductID=OD.ProductID
join SalesLT.ProductCategory as cat
on cat.ProductCategoryID = P.ProductCategoryID
join SalesLT.Customer as C
on C.CustomerID = H.CustomerID
group by cat.Name, C.LastName
order by cat.Name;

select top 20 cat.Name, C.lastname, sum(od.linetotal) as total
into #TabPivot
from SalesLT.SalesOrderDetail as OD
join SalesLT.SalesOrderHeader as H
on OD.SalesOrderID = H.SalesOrderID
join SalesLT.Product as P
on P.ProductID=OD.ProductID
join SalesLT.ProductCategory as cat
on cat.ProductCategoryID = P.ProductCategoryID
join SalesLT.Customer as C
on C.CustomerID = H.CustomerID
group by cat.Name, C.LastName
order by cat.Name;

select P.lastname, [bike racks], [Bottles and Ccges], [Bottom Brackets], [brakes]
from #TabPivot
pivot(sum(total) for name in ([bike racks], [Bottles and Ccges], [Bottom Brackets], [brakes])) as p
order by p.LastName;
--unpivot
select P.LastName, [Bike Racks], [Bottles and Cages], [Bottom Brackets], [Brakes]
into #TabUnpivot
from #TabPivot 
Pivot(
sum(Total)
for Name in ([Bike Racks], [Bottles and Cages], [Bottom Brackets], [Brakes]))
as P  Order by P.LastName;

select Unpiv.Name, Unpiv.LastName, Unpiv.Total
from #TabUnpivot
unpivot(Total for name in ([Bike Racks], [Bottles and Cages], [Bottom Brackets], [Brakes]))
as Unpiv;

--Having jest wykonywana poklauzuli group by
-- bez having 
select PC.Name, count(*), avg(ListPrice)
from SalesLT.Product as P
join SalesLT.ProductCategory as PC
on P.ProductCategoryID = PC.ProductCategoryID
group by PC.Name
having count(*) > 10;

select PC.Name, count(*) as liczba, avg(ListPrice) as srednia
from SalesLT.Product as P
join SalesLT.ProductCategory as PC
	on P.ProductCategoryID = PC.ProductCategoryID
where P.ListPrice > 200
group by PC.Name;

select PC.Name, count(*) as liczba, avg(ListPrice) as srednia
from SalesLT.Product as P
join SalesLT.ProductCategory as PC
	on P.ProductCategoryID = PC.ProductCategoryID
group by PC.Name
having avg(p.ListPrice)>200;

select PC.Name, count(*), avg(ListPrice)
from SalesLT.Product as P
join SalesLT.ProductCategory as PC
on P.ProductCategoryID = PC.ProductCategoryID
where SellEndDate is not null
and PC.Name like 'R%'
group by PC.Name
having count(*) > 10;

