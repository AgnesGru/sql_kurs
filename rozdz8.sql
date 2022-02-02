select h.customerid, c.companyname, c.firstname, c.lastname, c.emailaddress
from SalesLT.SalesOrderHeader as h
join SalesLT.Customer as c
on h.CustomerID = c.CustomerID
where SalesOrderNumber = 'SO71832';

--podzapytanie niepowi¹zane
select customerid, companyname, firstname, lastname, emailaddress
from SalesLT.Customer
where customerid = 
(select CustomerID 
from SalesLT.SalesOrderHeader
where SalesOrderNumber = 'SO71832'); 

--
select name, listprice, listprice -(select avg(listprice)
from SalesLT.Product) as ró¿nica_od_œredniej
from SalesLT.Product;

-- podzapytanie zwracaj¹ce listê
select companyname, firstname, lastname, emailaddress
from saleslt.Customer
where customerid in
(select customerid
from saleslt.salesorderheader
where cast(duedate as date) = '2008-06-20');
-- zagnie¿d¿anie podzapytañ
select Z.city
from SalesLT.Address as z
where z.AddressID in 
(select w.shiptoAddressid
from SalesLT.SalesOrderHeader as w
where w.ShipDate - w.OrderDate>7);

-- imiona i nazwiska osób które kiedykolwiek kupi³y jakiœ produkt z 40% zni¿k¹

select c.customerid, c.firstname, c.lastname
from SalesLT.Customer as c
where c.customerid in
	(select h.customerid
	from SalesLT.SalesOrderHeader as h
	where h.SalesOrderID in 
		(select d.salesorderid
		from SalesLT.SalesOrderDetail as d
		where UnitPriceDiscount = 0.4));

-- podzapytania powi¹zane
-- klienci którzy z³o¿yli przynajmniej jedno zamówienie > 100000
select c.lastname, round(h.totaldue, 0) as totaldue 
from SalesLT.Customer as c
join SalesLT.SalesOrderHeader as h
	on c.CustomerID = h.CustomerID
where h.totaldue > 100000;

-- to samo z podzapytaniem (uwaga tutaj c.customerid s¹ rózna dla tej samej osoby
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

-- nazwa produktu który jest na drugim miejscu pod wzglêdem ceny

select name, listprice
from SalesLT.Product as p
where listprice =
	(select max(ListPrice)
	from SalesLT.product as w1
	where w1.ListPrice <
		(select max(listprice) 
		from SalesLT.Product as w2));

-- co to jest za tworek ;)
select distinct listprice, Name
from SalesLT.Product
where listprice <
	(select top 1 max(listprice) 
	from SalesLT.Product
	group by listprice
	order by listprice desc)
order by ListPrice desc;

-- sposób z ksi¹¿ki
select name, listprice 
from SalesLT.Product as Z
where 1 =
	(select count(distinct listprice)
	from SalesLT.Product as W
	where W.ListPrice > Z.ListPrice);

-- najwiêksze i najmniejsze op³aty w danym dniu poniesione przez poszczególnych sprzedawców

select cast (orderdate as date), sum(totaldue),  customerId
from SalesLT.SalesOrderHeader
group by CustomerID, OrderDate
order by 1, 2 desc;


select Z.SalesOrderid, Z.customerId, z.orderdate, 'Max Freight: ' + Cast(z.freight as char(7))
from SalesLT.SalesOrderHeader as Z
where Z.Freight =
	(select max(W.Freight)
	from SalesLT.SalesOrderHeader as w
	where w.OrderDate = z.orderdate)
union all
select Z.SalesOrderid, Z.customerId, z.orderdate, 'Min Freight: ' + Cast(z.freight as char(7))
from SalesLT.SalesOrderHeader as Z
where Z.Freight =
	(select min(W.Freight)
	from SalesLT.SalesOrderHeader as w
	where w.OrderDate = z.orderdate);

-- podzapytania a z³¹czenia
select c.lastname, h.totaldue
from SalesLT.Customer as c
join SalesLT.SalesOrderHeader as h
on c.CustomerID = h.CustomerID
where TotalDue > 100000
order by LastName;

-- tabele pochodne jako przyk³ad zapytañ wewnêtrznych zwracaj¹cych dane tabelaryczne
select name, color 
from (
	select name, listprice, size, weight, color, sellenddate 
	from SalesLT.Product
	where SellEndDate is null
	and ListPrice > 50) as w
where color = 'Black';

-- liczba klientów o ró¿nych tytu³ach mieszkaj¹cych w ró¿nych krajach i miastach

select Fulltitle, adress, count(Z.Addressid) as nr
from
	(select 'title: ' + C.title as Fulltitle, A.CountryRegion + ' ' + A.City as adress, CA.AddressId
from SalesLT.Customer as C
join SalesLT.CustomerAddress as CA
	on C.CustomerID = CA.CustomerID
join SalesLT.Address as A
	 on CA.AddressID = A.AddressID) as Z
where Fulltitle = 'Title: Ms.'
group by Fulltitle, adress;

-- 
select SalesOrderID, totaldue,
ROW_NUMBER() over (order by totaldue desc) as Rnk
from SalesLT.SalesOrderHeader;

select * 
from (
select SalesOrderID, totaldue,
ROW_NUMBER() over (order by totaldue desc) as Rnk
from SalesLT.SalesOrderHeader) as w
where Rnk between 10 and 15;

-- CTE (common Table Expressions)
-- liczba klientek z poszczególnych krajów i miast

with CTE as (
select 'title: ' + C.title as Fulltitle, A.CountryRegion + ' ' + A.City as adress, CA.AddressId
from SalesLT.Customer as C
join SalesLT.CustomerAddress as CA
	on C.CustomerID = CA.CustomerID
join SalesLT.Address as A
	 on CA.AddressID = A.AddressID
	 )
select Fulltitle, adress, count(addressid) as Nr
from CTE
where Fulltitle = 'Title: Ms.'
Group by Fulltitle, adress;

--podzia³ zamówien na 5 przedzia³ów

select salesOrderid, totaldue,
ntile(5) over (order by salesorderid desc) as page
from SalesLT.SalesOrderHeader;

with Pages as (
select salesOrderid, totaldue,
ntile(5) over (order by salesorderid desc) as page
from SalesLT.SalesOrderHeader)
select page, min(totaldue) as MIN, max(Totaldue) as MAX, AVG(Totaldue) as AVG
from Pages
group by page
order by page;

