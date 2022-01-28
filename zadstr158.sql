-- zad 1
select P.ProductNumber, count(D.SalesOrderDetailID) as sales_count,
Row_number() over (Order by count(D.SalesOrderDetailID) desc) as row_number,
Dense_Rank() over (Order by count(D.SalesOrderDetailID) desc) as dense_rank
from SalesLT.Product as P
left outer join SalesLT.SalesOrderDetail as D
on P.ProductID = D.ProductID
group by P.ProductNumber
order by count(D.SalesOrderDetailID) Desc;

-- zad 2
select Year(DueDate) as year, 
Month(DueDate) as month,
Day(DueDate) as day, 
sum(TotalDue) over (Partition by Day(DueDate) order by DueDate) as DailyDue,
sum(TotalDue) over (Partition by Month(DueDate) order by DueDate) as MonthlyDue,
sum(TotalDue) over (Partition by Year(DueDate) order by DueDate) as YearlyDue,
sum(TotalDue) over() as Total
from SalesLT.SalesOrderHeader
order by DueDate;

--zad 3
select SalesOrderId, TotalDue,
TotalDue - lag (totaldue) over (order by SalesOrderId)
from SalesLT.SalesOrderHeader;
	