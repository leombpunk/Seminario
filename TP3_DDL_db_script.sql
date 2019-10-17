create database tp3_ddl
go
use tp3_ddl
go

--drop table Estaciones
create table Estaciones(
ANSICode char(8),
Nombre varchar(50) not null,
constraint Pk_Estaciones_ANSICode primary key(ANSICode),
constraint Ck_Estaciones_ANSICode check(ANSICode like '[a-z][a-z][a-z][a-z][0-9][0-9][0-9][0-9]'),
constraint Ck_Estaciones_Nombre check(Nombre like '_____%')
)
create index Ix_Estaciones_Nombre on Estaciones(Nombre)

--drop table Mantenimientos
create table Mantenimientos(
Id int identity,
FechaHora date not null default getdate(),
Descripcion varchar(100) not null,
ANSICode char(8) not null,
constraint Pk_Mantenimientos_Id primary key(Id),
constraint Ck_Mantenimientos_Descripcion check(Descripcion like '[a-z][a-z]%'),
constraint Fk_Mantenimientos_ANSICode foreign key(ANSICode) references Estaciones(ANSICode)
	on delete no action on update cascade
)
create index Ix_Mantenimientos_ANSICode on Mantenimientos(ANSICode)

--drop table Sensores
create table Sensores(
Tipo char(1) not null, --el check paso de largo con null
Activo bit default 1, --le mande un 2, tomo el default, no dio error
Alta date,
ANSICode char(8) not null, -- <--primary key?
constraint Ck_Sensores_Tipo check(Tipo like '[a,h,t]'),
constraint Ck_Sensores_fecha check(Alta <= getdate()),
constraint Uk_Sensores_TipoANSICode unique(Tipo,ANSICode),--o como primary?
constraint Fk_Sensores_ANSICode foreign key(ANSICode) references Estaciones(ANSICode)
	on delete no action on update cascade
)
create index Ix_Sensores_ANSICode on Sensores(ANSICode)


--drop table Lecturas
create table Lecturas(
FechaHora datetime default getdate(),
Tipo char not null,
ANSICode char(8) not null,
constraint Fk_Lecturas_TipoANSICode foreign key(Tipo,ANSICode) references Sensores(Tipo,ANSICode)
	on delete no action on update no action
)
create index Ix_Lecturas_FechaHora on Lecturas(FechaHora desc)
--cual?
/*create index Ix_Sensores_Tipo on Lecturas(Tipo)
create index Ix_Sensores_ANSICode on Lecturas(ANSICode)
create index Ix_Sensores_TipoANSICode on Lecturas(Tipo,ANSICode)*/


--drop table Humedales
create table Humedales(
Porcentaje tinyint not null,
Tipo char not null,
ANSICode char(8) not null,
constraint Fk_Humedales_TipoANSICode foreign key(Tipo,ANSICode) references Sensores(Tipo,ANSICode)
	on delete cascade on update no action,
constraint Ck_Humedales_Porcentaje check(Porcentaje >= 0)
)
--cual?
/*create index Ix_Humedales_Tipo on Humedales(Tipo)
create index Ix_Humedales_ANSICode on Humedales(ANSICode)
create index Ix_Humedales_TipoANSICode on Humedales(Tipo,ANSICode)*/

--drop table Temperaturas
create table Temperaturas(
Centigrados tinyint not null,
Tipo char not null,
ANSICode char(8) not null,
constraint Fk_Temperaturas_TipoANSICode foreign key(Tipo,ANSICode) references Sensores(Tipo,ANSICode)
	on delete cascade on update no action,
constraint Ck_Temperaturas_Centigrados check(Centigrados between -100 and 100)
)
--cual?
/*create index Ix_Temperaturas_Tipo on Temperaturas(Tipo)
create index Ix_Temperaturas_ANSICode on Temperaturas(ANSICode)
create index Ix_Temperaturas_TipoANSICode on Temperaturas(Tipo,ANSICode)*/

--drop table Vientos
create table Vientos(
Direccion smallint not null, 
Velocidad smallint not null,
Tipo char not null,
ANSICode char(8) not null,
constraint Fk_Vientos_TipoANSICode foreign key(Tipo,ANSICode) references Sensores(Tipo,ANSICode)
	on delete cascade on update no action,
constraint Ck_Vientos_Direccion check(Direccion >= 0),
constraint Ck_Vientos_Velocidad check(Velocidad >= 0)
)
--cual?
/*create index Ix_Vientos_Tipo on Vientos(Tipo)
create index Ix_Vientos_ANSICode on Vientos(ANSICode)
create index Ix_Vientos_TipoANSICode on Vientos(Tipo,ANSICode)*/