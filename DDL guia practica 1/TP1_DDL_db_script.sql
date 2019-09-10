use master 
go
drop database deposito_ddl_tp
go
create database deposito_ddl_tp
go
use deposito_ddl_tp
go

select '1.1. Crear las tablas y columnas con los nombres especificados en el diagrama y las tablas
siguientes. Utilizar el tipo de dato más adecuado al dominio correspondiente. Crear al
menos dos comandos Insert por cada tabla para testeo.'
/*create table rubros(
	idrubro smallint,
	descripcion varchar(30)
)

create table articulos(
	idarticulo char(5), 
	nombre varchar(30), 
	precio money
)

create table stock(
	cantidad smallint
)

create table depositos(
	iddeposito char(3),
	nombre varchar(50)
)

create table movimientos(
	idmovimiento int,
	cantidad smallint,
	fecha date
)

create table operaciones(
	idoperacion tinyint,
	operando char(1),
	descripcion varchar(30)
)*/

select '1.2. Establecer valores predeterminados a las columnas según la siguiente tabla. Verificar
mediante comandos insert ignorando estas columnas.'
/*create table rubros(
	idrubro smallint,
	descripcion varchar(30)
)

create table articulos(
	idarticulo char(5), 
	nombre varchar(30), 
	precio money
)

create table stock(
	cantidad smallint
)

create table depositos(
	iddeposito char(3),
	nombre varchar(50)
)

create table movimientos(
	idmovimiento int,
	cantidad smallint default 1,
	fecha date default getdate()
)

create table operaciones(
	idoperacion tinyint,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso'
)*/

select '1.3. Establecer columna identidad en las siguientes tablas: Rubros, Movimientos y
Operaciones. Probar mediante comandos insert que ignoran estas columnas.'
/*create table rubros(
	idrubro smallint identity,
	descripcion varchar(30)
)

create table articulos(
	idarticulo char(5) , 
	nombre varchar(30), 
	precio money
)

create table stock(
	cantidad smallint
)

create table depositos(
	iddeposito char(3),
	nombre varchar(50)
)

create table movimientos(
	idmovimiento int identity,
	cantidad smallint default 1,
	fecha date default getdate()
)

create table operaciones(
	idoperacion tinyint identity,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso'
)*/

select '1.4. Establecer las siguientes columnas para que no admitan nulos. Probar con insert que
ignoran estas columnas.'
/*create table rubros(
	idrubro smallint identity,
	descripcion varchar(30) not null
)

create table articulos(
	idarticulo char(5) not null, 
	nombre varchar(30) not null, 
	precio money not null
)

create table stock(
	cantidad smallint not null
)

create table depositos(
	iddeposito char(3) not null,
	nombre varchar(50) not null
)

create table movimientos(
	idmovimiento int identity,
	cantidad smallint default 1,
	fecha date default getdate()
)

create table operaciones(
	idoperacion tinyint identity,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso'
)*/

select '1.5. Establecer que las siguientes columnas solo admitan las siguientes reglas dominios de
valores'
/*create table rubros(
	idrubro smallint identity,
	descripcion varchar(30) not null,
	constraint ck_rubros_descripcion check(descripcion like '___%')
)

create table articulos(
	idarticulo char(5) /*collate Modern_Spanish_CS_AS*/ not null , 
	nombre varchar(30) not null, 
	precio money not null,
	constraint ck_articulos_idarticulo check(idarticulo like '[A-Z][A-Z][0-9][0-9][0-9]'),
	constraint ck_articulos_nombre check(nombre like '___%'),
	constraint ck_articulos_precio check(precio > 0) 
)

create table stock(
	cantidad smallint not null,
	constraint ck_stock_cantidad check(cantidad > 0)
)

create table depositos(
	iddeposito char(3) not null,
	nombre varchar(50) not null,
	constraint ck_depositos_iddeposito check(iddeposito like '[a-z][0-9]_'),
	constraint ck_depositos_nombre check(nombre like '___%')
)

create table movimientos(
	idmovimiento int identity,
	cantidad smallint default 1,
	fecha date default getdate(),
	constraint ck_movimientos_cantidad check(cantidad > 0),
	constraint ck_movimientos_fecha check(fecha between getdate()-7 and getdate())
)

create table operaciones(
	idoperacion tinyint identity,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso',
	constraint ck_operaciones_operando check(operando like '[+,-]'),
	constraint ck_operaciones_descripcion check(descripcion like '___%')
)*/

select '1.6. Establecer regla de valores únicos para las siguientes columnas'
/*create table rubros(
	idrubro smallint identity,
	descripcion varchar(30) not null,
	constraint ck_rubros_descripcion check(descripcion like '___%')
)

create table articulos(
	idarticulo char(5) /*collate Modern_Spanish_CS_AS*/ not null , 
	nombre varchar(30) not null, 
	precio money not null,
	constraint ck_articulos_idarticulo check(idarticulo like '[A-Z][A-Z][0-9][0-9][0-9]'),
	constraint ck_articulos_nombre check(nombre like '___%'),
	constraint ck_articulos_precio check(precio > 0),
	constraint uk_articulos_nombre unique(nombre)
)

create table stock(
	cantidad smallint not null,
	constraint ck_stock_cantidad check(cantidad > 0)
)

create table depositos(
	iddeposito char(3) not null,
	nombre varchar(50) not null,
	constraint ck_depositos_iddeposito check(iddeposito like '[a-z][0-9]_'),
	constraint ck_depositos_nombre check(nombre like '___%'),
	constraint uk_depositos_nombre unique(nombre)
)

create table movimientos(
	idmovimiento int identity,
	cantidad smallint default 1,
	fecha date default getdate(),
	constraint ck_movimientos_cantidad check(cantidad > 0),
	constraint ck_movimientos_fecha check(fecha between getdate()-7 and getdate())
)

create table operaciones(
	idoperacion tinyint identity,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso',
	constraint ck_operaciones_operando check(operando like '[+,-]'),
	constraint ck_operaciones_descripcion check(descripcion like '___%'),
	constraint uk_operaciones_descripcion unique(descripcion)
)*/

select '1.7. Implementar las restricciones anteriores con cláusulas “constraint” y dando el nombre
según las convenciones conocidas.'

select '1.8. Crear las claves primarias en las siguientes columnas:'
/*create table rubros(
	idrubro smallint identity,
	descripcion varchar(30) not null,
	constraint ck_rubros_descripcion check(descripcion like '___%'),
	constraint pk_rubros_idrubro primary key(idrubro)
)

create table articulos(
	idarticulo char(5) /*collate Modern_Spanish_CS_AS*/ not null , 
	nombre varchar(30) not null, 
	precio money not null,
	constraint ck_articulos_idarticulo check(idarticulo like '[A-Z][A-Z][0-9][0-9][0-9]'),
	constraint ck_articulos_nombre check(nombre like '___%'),
	constraint ck_articulos_precio check(precio > 0),
	constraint uk_articulos_nombre unique(nombre),
	constraint pk_articulos_idarticulo primary key(idarticulo)
)

create table stock(
	cantidad smallint not null,
	constraint ck_stock_cantidad check(cantidad > 0)
)

create table depositos(
	iddeposito char(3) not null,
	nombre varchar(50) not null,
	constraint ck_depositos_iddeposito check(iddeposito like '[a-z][0-9]_'),
	constraint ck_depositos_nombre check(nombre like '___%'),
	constraint uk_depositos_nombre unique(nombre),
	constraint pk_depositos_iddeposito primary key(iddeposito)
)

create table movimientos(
	idmovimiento int identity,
	cantidad smallint default 1,
	fecha date default getdate(),
	constraint ck_movimientos_cantidad check(cantidad > 0),
	constraint ck_movimientos_fecha check(fecha between getdate()-7 and getdate()),
	constraint pk_movimientos_idmovimiento primary key(idmovimiento)
)

create table operaciones(
	idoperacion tinyint identity,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso',
	constraint ck_operaciones_operando check(operando like '[+,-]'),
	constraint ck_operaciones_descripcion check(descripcion like '___%'),
	constraint uk_operaciones_descripcion unique(descripcion),
	constraint pk_operaciones_idoperacion primary key(idoperacion)
)*/

select '1.9. Crear las columnas y sus claves foráneas, establecer que estas columnas no acepten
valores nulos y probar con Insert caso éxito y falla para las siguientes relaciones:'
/*create table rubros(
	idrubro smallint identity,
	descripcion varchar(30) not null,
	constraint ck_rubros_descripcion check(descripcion like '___%'),
	constraint pk_rubros_idrubro primary key(idrubro)
)

create table articulos(
	idarticulo char(5) /*collate Modern_Spanish_CS_AS*/ not null , 
	nombre varchar(30) not null, 
	precio money not null,
	idrubro smallint not null,
	constraint ck_articulos_idarticulo check(idarticulo like '[A-Z][A-Z][0-9][0-9][0-9]'),
	constraint ck_articulos_nombre check(nombre like '___%'),
	constraint ck_articulos_precio check(precio > 0),
	constraint uk_articulos_nombre unique(nombre),
	constraint pk_articulos_idarticulo primary key(idarticulo),
	constraint fk_articulos_idrubro foreign key (idrubro) references rubros(idrubro)
)

create table depositos(
	iddeposito char(3) not null,
	nombre varchar(50) not null,
	constraint ck_depositos_iddeposito check(iddeposito like '[a-z][0-9]_'),
	constraint ck_depositos_nombre check(nombre like '___%'),
	constraint uk_depositos_nombre unique(nombre),
	constraint pk_depositos_iddeposito primary key(iddeposito)
)

create table stock(
	cantidad smallint not null,
	idarticulo char(5) not null,
	iddeposito char(3) not null,
	constraint ck_stock_cantidad check(cantidad > 0),
	constraint fk_stock_idarticulo foreign key(idarticulo) references articulos(idarticulo),
	constraint fk_stock_iddeposito foreign key(iddeposito) references depositos(iddeposito)
)

create table operaciones(
	idoperacion tinyint identity,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso',
	constraint ck_operaciones_operando check(operando like '[+,-]'),
	constraint ck_operaciones_descripcion check(descripcion like '___%'),
	constraint uk_operaciones_descripcion unique(descripcion),
	constraint pk_operaciones_idoperacion primary key(idoperacion)
)

create table movimientos(
	idmovimiento int identity,
	cantidad smallint default 1,
	fecha date default getdate(),
	idarticulo char(5) not null,
	iddeposito char(3) not null,
	idoperacion tinyint not null,
	constraint ck_movimientos_cantidad check(cantidad > 0),
	constraint ck_movimientos_fecha check(fecha between getdate()-7 and getdate()),
	constraint pk_movimientos_idmovimiento primary key(idmovimiento),
	constraint fk_movimientos_idarticulo foreign key(idarticulo) references articulos(idarticulo),
	constraint fk_movimientos_iddeposito foreign key(iddeposito) references depositos(iddeposito),
	constraint fk_movimientos_idoperaion foreign key(idoperacion) references operaciones(idoperacion)
)*/

select '1.10. Crear índices para las columnas de clave foránea en las entidades débiles y para las
siguientes columnas'
/*create table rubros(
	idrubro smallint identity,
	descripcion varchar(30) not null,
	constraint ck_rubros_descripcion check(descripcion like '___%'),
	constraint pk_rubros_idrubro primary key(idrubro)
)

create table articulos(
	idarticulo char(5) /*collate Modern_Spanish_CS_AS*/ not null , 
	nombre varchar(30) not null, 
	precio money not null,
	idrubro smallint not null,
	constraint ck_articulos_idarticulo check(idarticulo like '[A-Z][A-Z][0-9][0-9][0-9]'),
	constraint ck_articulos_nombre check(nombre like '___%'),
	constraint ck_articulos_precio check(precio > 0),
	constraint uk_articulos_nombre unique(nombre),
	constraint pk_articulos_idarticulo primary key(idarticulo),
	constraint fk_articulos_idrubro foreign key (idrubro) references rubros(idrubro)
)

create index ix_articulos_idrubro on articulos(idrubro)

create table depositos(
	iddeposito char(3) not null,
	nombre varchar(50) not null,
	constraint ck_depositos_iddeposito check(iddeposito like '[a-z][0-9]_'),
	constraint ck_depositos_nombre check(nombre like '___%'),
	constraint uk_depositos_nombre unique(nombre),
	constraint pk_depositos_iddeposito primary key(iddeposito)
)

create table stock(
	cantidad smallint not null,
	idarticulo char(5) not null,
	iddeposito char(3) not null,
	constraint ck_stock_cantidad check(cantidad > 0),
	constraint fk_stock_idarticulo foreign key(idarticulo) references articulos(idarticulo),
	constraint fk_stock_iddeposito foreign key(iddeposito) references depositos(iddeposito)
)

create index ix_stock_idarticulo on stock(idarticulo)
create index ix_stock_iddeposito on stock(iddeposito)

create table operaciones(
	idoperacion tinyint identity,
	operando char(1) default '+',
	descripcion varchar(30) default 'Ingreso',
	constraint ck_operaciones_operando check(operando like '[+,-]'),
	constraint ck_operaciones_descripcion check(descripcion like '___%'),
	constraint uk_operaciones_descripcion unique(descripcion),
	constraint pk_operaciones_idoperacion primary key(idoperacion)
)

create table movimientos(
	idmovimiento int identity,
	cantidad smallint default 1,
	fecha date default getdate(),
	idarticulo char(5) not null,
	iddeposito char(3) not null,
	idoperacion tinyint not null,
	constraint ck_movimientos_cantidad check(cantidad > 0),
	constraint ck_movimientos_fecha check(fecha between getdate()-7 and getdate()),
	constraint pk_movimientos_idmovimiento primary key(idmovimiento),
	constraint fk_movimientos_idarticulo foreign key(idarticulo) references articulos(idarticulo),
	constraint fk_movimientos_iddeposito foreign key(iddeposito) references depositos(iddeposito),
	constraint fk_movimientos_idoperaion foreign key(idoperacion) references operaciones(idoperacion)
)

create index ix_movimientos_idarticulo on movimientos(idarticulo)
create index ix_movimientos_iddeposito on movimientos(iddeposito)
create index ix_movimientos_idoperacion on movimientos(idoperacion)*/