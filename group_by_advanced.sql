-- left(string, number_of_characters)
select left(color, 2)
from SalesLT.Product
where color is not null
group by color;

-- grouping sets
SELECT Year(Orderdate)  as Rok, DatePart(q,Orderdate)  as Q , count(salesOrderId) as OrderQty
FROM SalesLT.SalesOrderHeader
WHERE YEAR(OrderDate) between  1900 and 2020
GROUP BY GROUPING SETS
(
	(),
	(Year(Orderdate)) ,
	(Year(Orderdate)  , DatePart(q,Orderdate))

)
ORDER BY Rok, Q
