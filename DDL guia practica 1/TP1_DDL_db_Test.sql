use deposito_ddl_tp
go
/*1.1 Crear las tablas y columnas con los nombres especificados en el diagrama y las tablas
siguientes. Utilizar el tipo de dato más adecuado al dominio correspondiente. Crear al
menos dos comandos Insert por cada tabla para testeo.*/
insert into rubros
values(123,'rubro libre')
insert into rubros
values(654,'asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd')

select *
from rubros
-------------------------
insert into Articulos
values('ax8w9','zapatillas falopa',99.99)
insert into Articulos
values(12345,'algo caro',987654321.99)

select *
from Articulos
-------------------------
insert into Stock
values(12345678)
insert into Stock
values(50)

select * 
from Stock
-------------------------
insert into Depositos
values('123','Deposito de la esquina')
insert into Depositos
values('avc','Jacinta Pichimahuida')

select * 
from Depositos
-------------------------
insert into Movimientos
values(123,123,'2019-07-04')
insert into Movimientos
values(3333,1234,'2000')
insert into Movimientos
values(3333,1234,'19')

select * 
from Movimientos
-------------------------
insert into Operaciones
values(100,'+','no se, le puse un mas de onda')
insert into Operaciones
values(101,'as','ni idea capo')

select * 
from Operaciones
-------------------------
/*1.2 Establecer valores predeterminados a las columnas según la siguiente tabla. Verificar
mediante comandos insert ignorando estas columnas.*/
insert into Movimientos(IdMovimiento)
values(10)
insert into Movimientos(IdMovimiento)
values(11)

select * 
from Movimientos
-----------------------
insert into Operaciones(IdOperacion,Descripcion)
values(1,'operacion123')

insert into Operaciones(IdOperacion)
values(2)

insert into Operaciones(IdOperacion,Operando)
values(3,'-')

select * 
from Operaciones
-----------------------
/*1.3. Establecer columna identidad en las siguientes tablas: Rubros, Movimientos y
Operaciones. Probar mediante comandos insert que ignoran estas columnas.*/
insert into Rubros
values('dudosa procedencia')

insert into Rubros
values('carne')

select *
from Rubros
-----------------------
insert into Movimientos
values(10)

insert into Movimientos
values(25)

insert into Movimientos
values(32,'2019-07-12')

insert into Movimientos
values(12,30,'2019-06-10')

select *
from Movimientos
-----------------------
insert into Operaciones(Descripcion,Operando)
values('egreso','+')

insert into Operaciones(Descripcion,Operando)
values('ingreso','-')

select *
from Operaciones
-----------------------
/*1.4. Establecer las siguientes columnas para que no admitan nulos. Probar con insert que
ignoran estas columnas.*/
insert into Rubros(Descripcion)
values(null)

insert into Rubros(Descripcion)
values('lacteos')

insert into Rubros(Descripcion)
values('legumbres')

select *
from Rubros
-----------------------
insert into Articulos
values(null,null,null)

insert into Articulos
values('ac158','articulo-1',25.99)

select *
from Articulos
-----------------------
insert into Stock
values(null)

insert into Stock
values(99)

select *
from Stock
-----------------------
insert into Depositos
values(null,'deposito-1')

insert into Depositos
values('1',null)

insert into Depositos
values('1','Deposito-2')

select *
from Depositos
-----------------------
/*1.7. Implementar las restricciones anteriores con cláusulas “constraint” y dando el nombre
según las convenciones conocidas.
1.5. Establecer que las siguientes columnas solo admitan las siguientes reglas dominios de
valores.*/
insert into Rubros
values('la')

insert into Rubros
values('?la')

insert into Rubros
values('l?a')

insert into Rubros
values('asd')

insert into Rubros
values('bebidas')

select *
from Rubros
-----------------------
insert into Articulos(IdArticulo,Nombre,Precio)
values('as456','falopita',-1)

insert into Articulos(IdArticulo,Nombre,Precio)
values('AS456','pastafrola',100)

select * 
from Articulos
-----------------------
insert into Stock
values(-5)

insert into Stock
values(5)

select *
from Stock
-----------------------
insert into Depositos(IdDeposito,Nombre)
values('a','desposito mal escrito')

insert into Depositos(IdDeposito,Nombre)
values('a9?','khe guen kodigo')

select * 
from Depositos

--update Depositos set IdDeposito = 'a3p'
--where Nombre like '%o'
-----------------------
insert into Movimientos(Cantidad,Fecha)
values(-1,'2019/08/22')

insert into Movimientos(Cantidad,Fecha)
values(15,'2019/08/14')

insert into Movimientos(Cantidad,Fecha)
values(1,getdate())

select *
from Movimientos

--select getdate()-7

--update Movimientos set Fecha = getdate()

--update Movimientos set Cantidad = 2
--where IdMovimiento = 1
-----------------------
insert into Operaciones(Operando,Descripcion)
values('?','jajaajaja')

insert into Operaciones(Operando,Descripcion)
values('-','salida')

select *
from Operaciones

/*update Operaciones set Descripcion = 'asd'
where IdOperacion = 2*/
-----------------------
/*1.7. Implementar las restricciones anteriores con cláusulas “constraint” y dando el nombre
según las convenciones conocidas.
1.6. Establecer regla de valores únicos para las siguientes columnas*/
select * 
from Articulos

insert into Articulos
values('DC654','pastafrola',50)

exec sp_help Articulos
-----------------------
select * 
from Depositos

insert into Depositos
values('b2o','desposito mal escrito')

exec sp_help Depositos
-----------------------
select *
from Operaciones

insert into Depositos
values('b2o','desposito mal escrito')

exec sp_help Depositos
/*Operaciones tiene como valor predeterminado para descripcion 'ingreso'
con lo que solo va aceptar un insert por valor predeterminado de descripcion
despues se vienen los errores copados, como ya tengo datos cargados conviene
hacer un drop table y crearla de nuevo*/
-----------------------
/*1.8. Crear las claves primarias en las siguientes columnas:*/
select * 
from Rubros

exec sp_help Rubros

--set identity_insert Rubros on
--set identity_insert Rubros off

insert into Rubros(Idrubro,Descripcion)
values(2,'rubro 9')
-----------------------
select *
from Articulos

insert into Articulos(IdArticulo,Nombre,Precio)
values('AC158','caja sorpresa',100000)
-----------------------
select *
from Depositos

insert into Depositos
values('a2p','ya existe el id')
-----------------------
select *
from Movimientos

--set identity_insert Movimientos on
--set identity_insert Movimientos off

insert into Movimientos(IdMovimiento,Fecha,Cantidad)
values(2,GETDATE(),10)
-----------------------
select *
from Operaciones

--set identity_insert Operaciones on
--set identity_insert Operaciones off

insert into Operaciones(IdOperacion,Descripcion,Operando)
values(1,'no hago nada','-')
-----------------------
/*1.9. Crear las columnas y sus claves foráneas, establecer que estas columnas no acepten
valores nulos y probar con Insert caso éxito y falla para las siguientes relaciones:*/
/*
Entidad fuerte		Entidad debil
---------------------------------
Rubros				Articulos
Articulos			Stock
Articulos			Movimientos
Depositos			Stock
Depositos			Movimientos
Operaciones			Movimientos
*/
exec sp_help Rubros

select * 
from Rubros

select * 
from Articulos

insert into Articulos(IdArticulo,Nombre,Precio,Idrubro)
values('PP123','fideo',60,4)

insert into Articulos(IdArticulo,Nombre,Precio,Idrubro)
values('PP123','fideo',60,2)
-----------------------

-----------------------

-----------------------

-----------------------

-----------------------

-----------------------
/*1.10. Crear índices para las columnas de clave foránea en las entidades débiles y para las
siguientes columnas*/

-----------------------