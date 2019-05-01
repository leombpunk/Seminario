use editorial
/*Comandos del Lenguaje de Manipulación de Datos o DML
(Data Manipulation Languaje)*/
--1 Consultas básicas
select *
from empleados
/*1.1Listar los cargos*/
select *
from cargos

/*1.2Listar todas las columnas de empleados y la descripción del cargo que tienen.*/
select e.*, c.cargo_descripcion
from empleados as e, cargos as c
where e.cargo_id = c.cargo_id

/*1.3Listar la tabla empleados y reemplazar los nombres de columnas que tengan guion
bajo por espacio*/
select empleado_id as 'empleado id',nombre, inicial_segundo_nombre as 'inicail segundo nombre',apellido,cargo_id as 'cargo id',
'nivel cargo'=nivel_cargo,editorial_id as 'editorial id',fecha_contratacion as 'fecha contratacion'
from empleados

/*1.4Calcular A=PI.r**2 donde r = 10 y la función Pi() para PI*/
select A = pi()*(10*10)

/*1.5Mostrar por cada título su nombre y cuanto corresponde de regalías por cada 1000
títulos vendidos. Esta columna se debe mostrar como “Regalías x cada 1000
unidades”. Titulo.regalías es un porcentaje.*/
select titulo,precio,regalias,venta_anual
from titulos
order by venta_anual asc

select titulo, 'regalias x cada 1000 unidades'=((((venta_anual*precio)*regalias)/100)*1000)/venta_anual
from titulos
--where venta_anual >= 1000
order by venta_anual asc

/*1.6Listar los nombres de autores sin repetirlos*/
select distinct autor_nombre
from autores

/*1.7Listar los países de las editoriales sin repetirlos*/
select distinct pais
from editoriales

/*1.8Listar los nombres de almacén que hayan tenido ventas sin repetirlos*/
select distinct a.almacen_nombre
from almacenes as a,ventas as v
where v.almacen_id = a.almacen_id

/*1.9Listar las primeras 5 ventas.*/
select top 5 *
from ventas

--2 Consultas básicas con Where
/*2.1Listar los títulos pertenecientes al editor 1389. Por cada fila, listar el título, el tipo y la
fecha de publicación.*/
select titulo,genero,fecha_publicacion
from titulos
where editorial_id=1389

/*2.2Tomando las ventas mostrar el id de título, el título y el total de ventas que se obtiene
de multiplicar la cantidad por precio. Renombrar a la columna calculada como “Total
de venta”*/
select *
from ventas

select ventas.titulo_id,titulos.titulo,'Total de venta'=titulos.precio*ventas.cantidad
from ventas,titulos
where ventas.titulo_id=titulos.titulo_id

/*2.3Listar los id de almacén, números de orden y la cantidad para las ventas que realizo el
título “Prolonged Data Deprivation: Four Case Studies” el día 29 de mayo de 2013.*/
select ventas.almacen_id,ventas.numero_orden,titulos.venta_anual
from ventas,titulos
where titulos.titulo = 'Prolonged Data Deprivation: Four Case Studies' and fecha_orden='20130529'

/*2.4Listar el nombre, la inicial del segundo nombre y el apellido de los empleados de las
editoriales “Lucerne Publishing” y “New Moon Books”*/
select emp.nombre,emp.inicial_segundo_nombre,emp.apellido
from editoriales as edi,empleados as emp
where edi.editorial_nombre='Lucerne Publishing' or edi.editorial_nombre='New Moon Books'

/*2.5Mostrar los títulos que no sean de la editorial “Algodata Infosystems”. Informar titulo
y Editorial*/
select ti.titulo,edi.editorial_nombre
from titulos as ti,editoriales as edi
where not edi.editorial_nombre = 'Algodata Infosystems' --edi.editorial_nombre <> 'Algodata Infosystems'

/*2.6Listar los títulos que tengan más regalías que cualquier otro título.*/
select regalias
from titulos
order by regalias desc

select titulo--,regalias 
from titulos
where regalias=(select max(regalias)
from titulos)

--arreglado
select distinct t1.titulo
from titulos as t1, titulos as t2
where t1.regalias > t2.regalias

/*2.7Informar los empleados contratados en febrero, junio y agosto de cualquier año.
Mostrar apellido, nombre y fecha de contratación y ordenar por mes empezando por
los de febrero.*/
select apellido,nombre,fecha_contratacion
from empleados
where MONTH(fecha_contratacion)=2 or MONTH(fecha_contratacion)=6 or MONTH(fecha_contratacion)=8
order by MONTH(fecha_contratacion) asc

/*2.8Informar las ventas de los siguientes títulos: 'Cooking with Computers: Surreptitious
Balance Sheets', 'The Psychology of Computer Cooking', 'Emotional Security: A New
Algorithm'. Mostrar titulo, nombre de almacén, fecha de orden, número de orden y
cantidad. Ordenar por títulos.*/
select titulo 
from titulos --titulos = 18
select count(*)--,*
from ventas --ventas = 23
select *--,count(*)
from almacenes --almacenes = 6

select ti.titulo,al.almacen_nombre,v.fecha_orden,v.numero_orden,v.cantidad
from titulos as ti, ventas as v, almacenes as al
where ti.titulo_id=v.titulo_id and v.almacen_id=al.almacen_id and 
(ti.titulo = 'Cooking with Computers: Surreptitious Balance Sheets' 
or ti.titulo = 'The Psychology of Computer Cooking'
or ti.titulo = 'Emotional Security: A New Algorithm')
order by titulo asc

/*2.9Informar las publicaciones del año 2011 exceptuando las de los géneros business,
psychology y trad_cook. Mostrar titulo y género. Ordenar por género y titulo.*/
select titulo,genero
from titulos as ti
where year(fecha_publicacion)=2011 and (genero <> 'business' and genero <> 'psychology' and not genero='trad_cook')
order by 2 asc, 1 asc

--3 Manejo de valores nulos
/*3.1Mostrar aquellos libros que tienen el precio en nulo. Mostrar id de título, nombre y
nombre del editor.*/
select titulo_id,titulo,editorial_nombre
from titulos as t,editoriales as e
where t.editorial_id = e.editorial_id and precio is null 

/*3.2Mostrar todos los libros. Mostrar id de título, nombre y nombre del editor y el precio.
Aquellos que tienen el precio en nulo cambiarlo por 0.*/
select titulo_id,titulo,editorial_nombre,isnull(precio,0)
from titulos as t,editoriales as e
where t.editorial_id = e.editorial_id 

/*3.3Mostrar los descuentos que tengan una cantidad mínima establecida. Informar tipo
descuento, cantidad mínima y descuento*/
select *
from descuentos
where cantidad_minima is not null

/*3.4Mostrar los títulos y el adelanto que le corresponde a cada uno, si este valor fuera
nulo informar le valor predeterminado de 1000 pesos.*/
select titulo,isnull(adelanto,1000)
from titulos

--4 Operaciones con cadenas
/*4.1Mostrar los nombres de los autores que empiecen con “L”.*/
select autor_nombre
from autores
where autor_nombre like 'L%'

/*4.2Mostrar los nombres de los autores que tengan una “A” en su nombre.*/
select autor_nombre
from autores
where autor_nombre like '%A%'

/*4.3Mostrar los nombres de los autores que empiecen con letras que van de la T a la Y.*/
select autor_nombre
from autores
where autor_nombre like '[T-Y]%'

/*4.4Mostrar los títulos que no tengan un “Computer” en su titulo.*/
select titulo
from titulos
where titulo not like '%Computer%'

--5 Ordenacion
/*5.1Listar los empleados ordenados por apellido, por nombre y por inicial del segundo
nombre.*/
select nombre,apellido,inicial_segundo_nombre
from empleados
order by apellido, nombre, inicial_segundo_nombre

/*5.2Listar los títulos pertenecientes al género ‘business’. Por cada fila, listar el id, el título
y el precio. Ordenar los datos por precio en forma descendente e id de artículo en
forma ascendente.*/
select titulo_id,titulo,precio
from titulos
where genero = 'business'
order by precio desc,titulo_id asc

/*5.3Informar la venta más importante con forma de pago a 60 días. Mostrar el almacén, el
número de orden, la fecha de la factura y el título.*/
select *
from ventas

--hacer
select top 1 almacenes.almacen_nombre,ventas.numero_orden,ventas.fecha_orden,titulos.titulo
from ventas,almacenes,titulos
where almacenes.almacen_id=ventas.almacen_id and titulos.titulo_id=ventas.titulo_id 
	and forma_pago='60 días'
order by ventas.cantidad*precio desc

--6 Funciones agregadas. No olvidar renombrar las columnas obtenidas por función agregada
/*6.1Mostrar el promedio de venta anual de todos los títulos*/
select titulo,venta_anual 
from titulos

select 'Promedio de venta anual de todos los titulos'= AVG(venta_anual)
--avg ignora los null, es decir, 
--no cuenta los titulos con null
from titulos

/*6.2Mostrar el máximo de adelanto de todos los títulos*/
select adelanto
from titulos
order by adelanto DESC

select 'Maximo de adelanto de todos los titulos'=MAX(adelanto)
from titulos

/*6.3Informar cuantos planes de regalías tiene el título MC3021*/
select *
from plan_regalias

select 'Cantidad de Planes de regalias para MC3021'=COUNT(regalias)
from plan_regalias
where titulo_id = 'MC3021'

/*6.4Obtener el total de ventas realizadas a 30 días en el año 2014*/
select *
from ventas

select 'Total ventas realizadas a 30 días en el año 2014'=COUNT(titulo_id)
from ventas
where forma_pago like '30 d[i,í]as' and YEAR(fecha_orden)=2014

/*6.5Informar cuantas formas de pago existen*/
select 'Cantidad de formas de pago'=COUNT(distinct forma_pago)
from ventas

select forma_pago
from ventas
group by forma_pago

--7 Funciones agregadas con agrupación. Renombrar las columnas obtenidas por función
--agregada.
/*7.1. Informar cuantos títulos tiene cada autor. Mostrar código de autor y cantidad de
libros.*/
select distinct autor_id
from titulo_autor

select 'Codigo autor'=autor_id, 'Cantidad de libros'=COUNT(titulo_id)
from titulo_autor
group by autor_id

/*7.2. Informar el total de unidades vendidas por número de orden del almacén 7131.
Mostrar número de orden y total vendido.*/
select *
from ventas

select 'Numero de orden'=numero_orden,'Total vendido'=SUM(cantidad)
from ventas
where almacen_id=7131
group by numero_orden

/*7.3. Informar la última orden generada por cada almacén con forma de pago a 30 días y 60
días. Mostrar código de almacén, fecha de la orden y forma de pago. Ordenar por
fecha de orden.*/
select almacen_id,fecha_orden,forma_pago
from ventas
order by almacen_id desc

--select 'Codigo almacen'=v1.almacen_id,'Fecha de orden'= max(v1.fecha_orden),'Forma de pago'= v1.forma_pago
--from ventas as v1, ventas as v2
--where v1.almacen_id=v2.almacen_id 
--	and (v1.forma_pago like '30 d[i,í]as' /*and v1.fecha_orden > v2.fecha_orden*/)
--	or (v1.forma_pago like '60 d[i,í]as' /*and v1.fecha_orden > v2.fecha_orden*/)
--group by v1.almacen_id, v1.forma_pago, v1.fecha_orden 
--order by v1.almacen_id 

select almacen_id,forma_pago,max(fecha_orden) as fecha
from ventas
where ventas.forma_pago = '30 días' or ventas.forma_pago = '60 días'
group by almacen_id,forma_pago
--order by fecha
order by max(fecha_orden)

/*7.4. Informar el nivel de cargo más alto alcanzado por algún empleado de cada editorial.
Mostrar Nombre de la editorial y nivel de cargo. Ordenar por nivel de cargo máximo
empezando por el mayor*/
select editorial_nombre,editorial_id
from editoriales
order by editorial_id

select cargo_descripcion,nivel_maximo,cargo_id
from cargos
order by nivel_maximo desc

select empleados.apellido,empleados.cargo_id,editorial_id
from empleados
where (cargo_id=4 or cargo_id=5) or cargo_id=2
order by editorial_id

select editorial_nombre,max(nivel_maximo) as 'nivel maximo'
from cargos,editoriales,empleados
where empleados.cargo_id = cargos.cargo_id and empleados.editorial_id = editoriales.editorial_id
group by editorial_nombre
order by max(nivel_maximo)

/*7.5. Mostrar los tres primeros géneros más vendidos. Mostrar género y total de ventas
ordenado por mayor total de venta.*/
select titulos.titulo,ventas.cantidad,genero
from titulos,ventas
where ventas.titulo_id = titulos.titulo_id
order by genero

select top 3 genero, sum(cantidad) as 'total de ventas'
from titulos, ventas
where ventas.titulo_id = titulos.titulo_id
group by genero
order by sum(cantidad) desc

/*7.6. Informar aquellos títulos que tengan más de un autor. Mostrar código de título y
cantidad de autores.*/
select *
from titulo_autor
order by titulo_id

select titulo_id, count(autor_id) as 'cantidad de autores'
from titulo_autor
group by titulo_id
having count(autor_id) > 1

/*7.7. Informar el total de regalías obtenidas por cada título que haya tenido 40 o más
unidades vendidas. Mostrar el título y el monto en pesos de las regalías y ordenar por
mayor regalía primero.*/
select titulo, sum(((precio*cantidad)*regalias)/100) as 'monto regalias en pesos',SUM(cantidad) as 'cantidad vendida'
from titulos, ventas
where ventas.titulo_id = titulos.titulo_id
group by titulos.titulo
having sum(ventas.cantidad) >= 40
order by sum(((precio*cantidad)*regalias)/100) desc

/*7.8. Informar los autores que hayan escrito varios géneros de títulos. Mostrar nombre y
cantidad de géneros ordenados por esta última columna empezando por el mayor.*/
select a.autor_id,autor_nombre,ta.titulo_id,genero
from titulos as t, titulo_autor as ta, autores as a
where t.titulo_id = ta.titulo_id and a.autor_id = ta.autor_id
order by a.autor_id

--titulos para saber el genero, autores para saber el nombre
--titulo_autor para saber que libro escribio tal autor
select a.autor_nombre, count(distinct t.genero) as 'cantidad de generos'
from titulos as t, titulo_autor as ta, autores as a
where t.titulo_id = ta.titulo_id and a.autor_id = ta.autor_id
group by a.autor_nombre
having count(distinct t.genero) > 1
order by count(t.genero) desc