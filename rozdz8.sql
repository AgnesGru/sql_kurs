select h.customerid, c.companyname, c.firstname, c.lastname, c.emailaddress
from SalesLT.SalesOrderHeader as h
join SalesLT.Customer as c
on h.CustomerID = c.CustomerID
where SalesOrderNumber = 'SO71832';

--podzapytanie niepowi�zane
select customerid, companyname, firstname, lastname, emailaddress
from SalesLT.Customer
where customerid = 
(select CustomerID 
from SalesLT.SalesOrderHeader
where SalesOrderNumber = 'SO71832'); 

--
select name, listprice, listprice -(select avg(listprice)
from SalesLT.Product) as r�nica_od_�redniej
from SalesLT.Product;

-- podzapytanie zwracaj�ce list�
select companyname, firstname, lastname, emailaddress
from saleslt.Customer
where customerid in
(select customerid
from saleslt.salesorderheader
where cast(duedate as date) = '2008-06-20');
-- zagnie�d�anie podzapyta�
select Z.city
from SalesLT.Address as z
where z.AddressID in 
(select w.shiptoAddressid
from SalesLT.SalesOrderHeader as w
where w.ShipDate - w.OrderDate>7);

-- imiona i nazwiska os�b kt�re kiedykolwiek kupi�y jaki� produkt z 40% zni�k�

select c.customerid, c.firstname, c.lastname
from SalesLT.Customer as c
where c.customerid in
	(select h.customerid
	from SalesLT.SalesOrderHeader as h
	where h.SalesOrderID in 
		(select d.salesorderid
		from SalesLT.SalesOrderDetail as d
		where UnitPriceDiscount = 0.4));

-- podzapytania powi�zane
-- klienci kt�rzy z�o�yli przynajmniej jedno zam�wienie > 100000
select c.lastname, round(h.totaldue, 0) as totaldue 
from SalesLT.Customer as c
join SalesLT.SalesOrderHeader as h
	on c.CustomerID = h.CustomerID
where h.totaldue > 100000;

-- to samo z podzapytaniem (uwaga tutaj c.customerid s� r�zna dla tej samej osoby
select c.CustomerID, c.lastname, c.FirstName
from SalesLT.Customer as c
where 100000 <= any
	(select TotalDue
	from SalesLT.SalesOrderHeader as h
	where c.CustomerID = h.CustomerID);

select * 
from SalesLT.Customer
where CustomerID in (29736, 448);

--
select name, listprice
from SalesLT.Product
where ListPrice =
	(select max(ListPrice)
	from SalesLT.Product);

-- nazwa produktu kt�ry jest na drugim miejscu pod wzgl�dem ceny

select name, listprice
from SalesLT.Product as p
where listprice =
	(select max(ListPrice)
	from SalesLT.product as w1
	where w1.ListPrice <
		(select max(listprice) 
		from SalesLT.Product as w2));

select distinct listprice
from SalesLT.Product
order by ListPrice desc;