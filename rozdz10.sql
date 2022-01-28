use master;
create database Test;

use Test;
create table t1 (
ID int,
Name varchar(50),
Price Money,
PurchuaseDate Date);

select * from t1;

alter table t1
add Color varchar (10);

alter table t1
drop column Color;

alter table t1
add Rabat Money not null;

alter table t1
alter column Color varchar (10) not null;

alter table t1
alter column ID int not null;

alter table t1
add constraint PK_t1 Primary Key (ID);

create table t2 (
ID int Primary Key,
Nazwa varchar (10) not null);

drop table t2;