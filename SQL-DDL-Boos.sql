create database ddl_practica
use ddl_practica
go

/*1.1 Crear las tablas y columnas con los nombres especificados en el diagrama y las tablas
siguientes. Utilizar el tipo de dato más adecuado al dominio correspondiente. Crear al
menos dos comandos Insert por cada tabla para testeo.*/

create table Rubros(
Idrubro smallint,
Descripcion varchar(30))

insert into Rubros
values(123,'rubro libre')
insert into Rubros
values(654,'asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd')

select *
from Rubros
-------------------------
create table Articulos(
IdArticulo char(5),
Nombre varchar(30),
Precio decimal(10,2))

insert into Articulos
values('ax8w9','zapatillas falopa',99.99)
insert into Articulos
values(12345,'algo caro',987654321.99)

select *
from Articulos
-------------------------
create table Stock(
Cantidad smallint)

insert into Stock
values(12345678)
insert into Stock
values(50)

select * 
from Stock
-------------------------
create table Depositos(
IdDeposito char(3),
Nombre varchar(50))

insert into Depositos
values('123','Deposito de la esquina')
insert into Depositos
values('avc','Jacinta Pichimahuida')

select * 
from Depositos
-------------------------
create table Movimientos(
IdMovimiento int,
Cantidad smallint,
Fecha datetime)

insert into Movimientos
values(123,123,'2019-07-04')
insert into Movimientos
values(3333,1234,'2000')
insert into Movimientos
values(3333,1234,'19')

select * 
from Movimientos
-------------------------
create table Operaciones(
IdOperacion tinyint,
Operando char(1),--podria poner simplemente char
Descripcion varchar(30))

insert into Operaciones
values(100,'+','no se, le puse un mas de onda')
insert into Operaciones
values(101,'as','ni idea capo')

select * 
from Operaciones
-------------------------
/*1.2 Establecer valores predeterminados a las columnas según la siguiente tabla. Verificar
mediante comandos insert ignorando estas columnas.*/

alter table Movimientos 
drop column Cantidad

alter table Movimientos
add Cantidad smallint default 1

alter table Movimientos 
drop column Fecha

alter table Movimientos
add Fecha datetime default getdate()

insert into Movimientos(IdMovimiento)
values(10)
insert into Movimientos(IdMovimiento)
values(11)

select * 
from Movimientos
-----------------------