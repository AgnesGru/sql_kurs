select SalesOrderId, totalDue, 
avg(totalDue) over() as œrednia
from SalesLT.SalesOrderHeader; -- œrednia ze qszystkich zamówieñ

select salesOrderId, totaldue, 
	min(TotalDue) over() as min,
	max(totaldue) over() as max,
	avg(totaldue) over() as avg,
	totaldue - avg(totaldue) over() as diff
from SalesLT.SalesOrderHeader;

-- policzenie sumy zamówieñ dla poszcz klientów
select customerid, sum(totaldue) as totalsum
from SalesLT.SalesOrderHeader
group by CustomerID;

-- obliczanie procentowej wartoœci na poziomie poszczególnych grup
select customerid, sum(totaldue) as total_sum,
sum(totaldue*100)/sum(sum(totaldue)) over() as pct
from SalesLT.SalesOrderHeader
group by CustomerID
order by pct desc;

--Partycjonowanie danych Partition by
-- zapytanie zwracaj¹ce nazwy kategorii i liczby nale¿¹cych do nich produktów

select distinct C.Name, 
count(*) over(Partition by C.ProductCategoryID) as liczba_zamówieñ
from SalesLT.ProductCategory as C 
join SalesLT.Product as P
on C.ProductCategoryID = P.ProductCategoryID;

-- do ka¿dego klienta dodamy kolumnê wyliczaj¹c¹ liczbê zamówieñ
select CustomerID, SalesOrderID, TotalDue,
sum(Totaldue) over(Partition by CustomerID) as SumTotalDue
from SalesLT.SalesOrderHeader
order by CustomerID;

--
select CustomerID, SalesOrderID, TotalDue,
cast(100*TotalDue/Sum(totaldue) over(partition by customerid) as numeric(5,2)) as PctCust,
cast(100*TotalDue/Sum(totaldue) over() as numeric(5,2)) as PctTotal
from SalesLT.SalesOrderHeader;
-- funkcje rankingu
select firstname, 
row_number() over (order by firstname) as row_number,
rank() over (order by FirstName) as rank,
dense_rank() over (order by FirstName) as dense_rank,
ntile(3) over (order by FirstName) as ntile
from SalesLT.Customer
where FirstName in ('Andrew', 'Juanita', 'Christopher');

select title, firstname, 
row_number() over (partition by title order by firstname) as row_number
from SalesLT.Customer
where FirstName in ('Andrew', 'Juanita');

-- okienka
select SalesOrderid, Day(DueDate) as dzieñ, totaldue,
sum(totaldue) over (partition by day(duedate) 
order by duedate) 
as Day_total
from SalesLT.SalesOrderHeader
order by duedate;

select SalesOrderid, Day(DueDate) as dzieñ, totaldue,
sum(totaldue) over (partition by day(duedate) 
order by duedate
rows between 1 preceding and 1 preceding) 
as Day_total_previous_row
from SalesLT.SalesOrderHeader
order by duedate;

-- sumy narastaj¹ce
select SalesOrderid, Day(DueDate) as dzieñ, totaldue,
sum(totaldue) over (partition by day(duedate) 
order by duedate
rows between 1 preceding and current row) 
as running_total_due
from SalesLT.SalesOrderHeader
order by duedate;

-- obliczanie œrednich ruchomych
select SalesOrderid, Day(DueDate) as dzieñ, totaldue,
sum(totaldue) over (partition by day(duedate) 
order by duedate
rows between 1 preceding and 1 following) 
as movingAvg
from SalesLT.SalesOrderHeader
order by duedate;

-- funkcje okienkowe
select cast(Duedate as Date) as Date, SalesOrderId, TotalDue,
 first_value (TotalDue) over (Partition by DueDate order by DueDate)
 as FirstTotalDue
 from SalesLT.SalesOrderHeader
 order by DueDate;

 -- funkcje analityczne
select ProductCategoryID, ProductNumber, ListPrice,
	Cume_Dist () over (Partition by ProductCategoryID order by ListPrice Desc) as CumeDist,
	Percent_Rank () over (Partition by ProductCategoryID order by ListPrice Desc) as PercentRank
from SalesLT.Product
where ProductCategoryID in (8,9);

select ProductCategoryID, ProductNumber, ListPrice
from SalesLT.Product
where ProductCategoryID in (8,9);

select productCategoryid, ProductNumber, ListPrice,
percentile_cont(0.5) within group (order by listPrice desc)
	over (Partition by ProductCategoryID) as MedianCount,
percentile_disc(0.5) within group (order by ListPrice desc)
	over (Partition by ProductCategoryID) as MedinDisc
from SalesLT.Product
where ProductCategoryID in (16, 17);
