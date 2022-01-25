select cast(OrderDate as date) as OrderDate, CustomerID, max(Freight) as max_przesy�ka
into #Tab4_141
from SalesLT.SalesOrderHeader
group by CustomerID, OrderDate;

--3 etapy
select F.CustomerID, [1905-06-28], [2008-06-01], [2014-04-01]
from #Tab4_141
pivot(
max(max_przesy�ka)
for OrderDate in ([1905-06-28], [2008-06-01], [2014-04-01]))
as F
order by CustomerID;
-- zad 2 str 141
--odczytaj nazwy produkt�w  kt�re zosta�y sprzedane wi�cej ni� 3 razy . dodaj do wyniku liczb� tych produkt�w
select P.Name, count(OD.ProductID) as liczba
from SalesLT.Product as P
join SalesLT.SalesOrderDetail as OD
	on P.ProductID=OD.ProductID
group by P.Name
Having count(OD.ProductID) > 3;

--3/142
create table #Sprzedaz
([ID klient] int not null,
Miesi�c int not null,
Warto�� Money not null);
go
Insert into #Sprzedaz
select [CustomerID], DATEPART(Month, [OrderDate]), TotalDue 
from SaleslT.SalesOrderHeader;
go
select * from #Sprzedaz;

select *
from #Sprzedaz
pivot(
sum(Warto��)
for Miesi�c in ([6], [4]))
as F;
