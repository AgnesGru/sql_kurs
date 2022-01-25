select * from dbo.atrakcje;
select count(*) as liczba_wycieczek 
from cena where KwotaProwizji > 500;
-- ile zosta³o dokonanaych zakupów i za jak¹ sumaryczn¹ kwotê
select count(*) as sprzedane_wycieczki, sum(cena) as suma_cena from zakup;
-- znajdz klientów me¿czyzna urodzonych w latach 70-tych
select * from Podrozny 
where SUBSTRING(PESEL, 10, 1) in ('1', '3', '5', '7', '9')
and left(PESEL, 1) = '7';
-- znajdz wszystkie 4 gwiazdkowe oferty hoteli dla dwóch osób z cen¹ ob¹wi¹zuj¹c¹ w czerwcu 2020
select * from StandardHotelu sh
inner join Hotel h
on sh.IdStandardHotelu = h.IdStandardu
inner join OfertaHotelu oh
on h.IdHotel = oh.IdHotelu
inner join Cena c
on c.IdOfertyHotelu = oh.IdOfertaHotelu 
where sh.Opis ='4*'
and cast(DataObowiazywaniaOd as date) < '20200630'
and DataObowiazywaniaDo >= '20200601'
and c.IloscOsob =2;
-- zakupy za cenewy¿sz¹ niz srednia cena
select * 
from Zakup
where Cena > (select Avg(Cena) from zakup);
-- inny sposób
DECLARE @sredniaCena AS decimal(10,2)
SELECT @sredniaCena = AVG(Cena) FROM Zakup
SELECT *
FROM Zakup 
WHERE Cena > @sredniaCena;
