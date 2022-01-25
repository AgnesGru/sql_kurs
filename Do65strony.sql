-- Eliminowanie duplikatów
select count(distinct FirstName) from SalesLT.Customer;

select count(FirstName) from SalesLT.Customer;

select Name , ListPrice, Weight*ListPrice as iloczyn, Weight
from SalesLT.Product;

-- £¹czenie danyc tekstowych za pomoca + tu gdy jedna z kolumn ma puste wiersze to po z³¹czeniu bêdzie pusty wiersz
select ProductNumber + ' ' + Color as linked
from SalesLT.Product;

-- £¹czenie danyc tekstowych za pomoca Concat
select concat(ProductNumber, Color) as linked
from SalesLT.Product;

-- funkcje systemowe
select rand();
select sqrt(9);

-- funkcje systemowe znakowe
select len('Aga');
select lower('Aga');
select upper('Aga');
select rtrim(ltrim('  Aga   '));
select replace('Aga', 'Ag', 'Gag')
select replicate('Aga ', 3);
select substring('Agnieszka', 1, 2)+'a';
select month(getdate());
-- Konwersja typów CAST i Convert

select '1' + 1 + '1';
select '1' + '1' + 1;

-- CAST
select ProductNumber + '   ' + cast(ListPrice as varchar(15))
from SalesLT.Product;

-- Convert(typ, wyra¿enie)
select ProductNumber + '   ' + convert(varchar(15), ListPrice)
from SalesLT.Product;

--CASE jako odpowiednik IF
select ListPrice,
	case
		when ListPrice < 10 then 'Tani'
		when ListPrice < 50 then 'Œredni'
		else 'Drogi'
	end as 'kategorie'
from SalesLT.Product;

-- Formatowanie wyników
-- Aliasy
 select P.ListPrice, Round(ListPrice, 0) as w_zaokr¹gleniu
 from SalesLt.Product as P;

 --litera³y
 select distinct 'Zamowienie ' + Cast(SalesOrderNumber as char(5)) + ' zosta³o z³o¿one w roku' 
 + convert(char(4), Datepart(Year, OrderDate))
 from SalesLT.SalesOrderHeader;

 -- sortowanie Order by domyœlnie dane s¹  sortowane rosn¹co
 select Name, ListPrice
 from SalesLT.Product
 order by ListPrice desc;

 select ProductNumber, Color, ListPrice
 from SalesLT.Product
 order by Color desc, 3;

 select Color
 from SalesLT.Product
 order by ListPrice desc;

 -- sortowanie danych textowych
 -- alfabetyczne
 select imie from imiona order by imie;
 -- binarne
 select imie from imiona
 order by imie collate Polish_BIN;

