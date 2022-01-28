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