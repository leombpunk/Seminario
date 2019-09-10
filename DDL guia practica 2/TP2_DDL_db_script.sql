use master
go
drop database aerolinea_ddl_tp
go
create database aerolinea_ddl_tp
go
use aerolinea_ddl_tp
go

create table aeronaves(
	aeronaveid char(5) not null,
	matricula char(5) not null,
	modelo char(4) not null,
	maximopasajeros smallint not null,
	maximocarga tinyint not null,
	constraint ck_aeronaves_aeronaveid check(aeronaveid like '[0-9,A-F][0-9,A-F][0-9,A-F][0-9,A-F][0-9,A-F]'),
	constraint ck_aeronaves_matricula check(matricula like 'LV___'),
	constraint ck_aeronaves_modelo check(modelo like '[A,B,J][0-9][0-9][0-9]'),
	constraint ck_aeronaves_maximopasajeros check(maximopasajeros >= 0),
	constraint ck_aeronaves_maximocarga check(maximocarga >=0),
	constraint uk_aeronaves_aeronaveid unique(aeronaveid),
	constraint uk_aeronaves_matricula unique(matricula)
)

create table aeropuertos(
	aeropuertoid char(3) not null,
	constraint ck_aeropuertos_aeropueertoid check(aeropuertoid like '[A-Z][A-Z][A-Z]'),
	constraint uk_aeropuertos_aeropuertoid unique(aeropuertoid)
)

create table cuidades(
	ciudadid int identity, --not null,--es licito poner not null a un identity, o no hace falta?
	--No se permite el valor Null para atributos definidos con esta propiedad.(del apunte)
	nombre varchar(50) not null,
	constraint ck_ciudades_ciudadid check(ciudadid > 0),
	constraint uk_ciudades_ciudadid unique(ciudadid)
	--al ser identity no hace falta agregar como unique, sql se asegura de eso?
	--La propiedad identidad de una columna no garantiza la unicidad del
	--valor, esta debe aplicarse mediante una restricción PRIMARY KEY o
	--UNIQUE.(del apunete)
)
