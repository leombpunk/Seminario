use editorial
/*Comandos del Lenguaje de Manipulaci�n de Datos o DML
(Data Manipulation Languaje)*/
--1 Consultas b�sicas
select *
from empleados
/*1.1Listar los cargos*/
select *
from cargos

/*1.2Listar todas las columnas de empleados y la descripci�n del cargo que tienen.*/
select e.*, c.cargo_descripcion
from empleados as e, cargos as c
where e.cargo_id = c.cargo_id

/*1.3Listar la tabla empleados y reemplazar los nombres de columnas que tengan guion
bajo por espacio*/
select empleado_id as 'empleado id',nombre, inicial_segundo_nombre as 'inicail segundo nombre',apellido,cargo_id as 'cargo id',
'nivel cargo'=nivel_cargo,editorial_id as 'editorial id',fecha_contratacion as 'fecha contratacion'
from empleados

/*1.4Calcular A=PI.r**2 donde r = 10 y la funci�n Pi() para PI*/
select A = pi()*(10*10)

/*1.5Mostrar por cada t�tulo su nombre y cuanto corresponde de regal�as por cada 1000
t�tulos vendidos. Esta columna se debe mostrar como �Regal�as x cada 1000
unidades�. Titulo.regal�as es un porcentaje.*/
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

/*1.7Listar los pa�ses de las editoriales sin repetirlos*/
select distinct pais
from editoriales

/*1.8Listar los nombres de almac�n que hayan tenido ventas sin repetirlos*/
select distinct a.almacen_nombre
from almacenes as a,ventas as v
where v.almacen_id = a.almacen_id

/*1.9Listar las primeras 5 ventas.*/
select top 5 *
from ventas

--2 Consultas b�sicas con Where
/*2.1Listar los t�tulos pertenecientes al editor 1389. Por cada fila, listar el t�tulo, el tipo y la
fecha de publicaci�n.*/
select titulo,genero,fecha_publicacion
from titulos
where editorial_id=1389

/*2.2Tomando las ventas mostrar el id de t�tulo, el t�tulo y el total de ventas que se obtiene
de multiplicar la cantidad por precio. Renombrar a la columna calculada como �Total
de venta�*/
select *
from ventas

select ventas.titulo_id,titulos.titulo,'Total de venta'=titulos.precio*ventas.cantidad
from ventas,titulos
where ventas.titulo_id=titulos.titulo_id

/*2.3Listar los id de almac�n, n�meros de orden y la cantidad para las ventas que realizo el
t�tulo �Prolonged Data Deprivation: Four Case Studies� el d�a 29 de mayo de 2013.*/
select ventas.almacen_id,ventas.numero_orden,titulos.venta_anual
from ventas,titulos
where titulos.titulo = 'Prolonged Data Deprivation: Four Case Studies' and fecha_orden='20130529'

/*2.4Listar el nombre, la inicial del segundo nombre y el apellido de los empleados de las
editoriales �Lucerne Publishing� y �New Moon Books�*/
select emp.nombre,emp.inicial_segundo_nombre,emp.apellido
from editoriales as edi,empleados as emp
where edi.editorial_nombre='Lucerne Publishing' or edi.editorial_nombre='New Moon Books'

/*2.5Mostrar los t�tulos que no sean de la editorial �Algodata Infosystems�. Informar titulo
y Editorial*/
select ti.titulo,edi.editorial_nombre
from titulos as ti,editoriales as edi
where not edi.editorial_nombre = 'Algodata Infosystems' --edi.editorial_nombre <> 'Algodata Infosystems'

/*2.6Listar los t�tulos que tengan m�s regal�as que cualquier otro t�tulo.*/
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

/*2.7Informar los empleados contratados en febrero, junio y agosto de cualquier a�o.
Mostrar apellido, nombre y fecha de contrataci�n y ordenar por mes empezando por
los de febrero.*/
select apellido,nombre,fecha_contratacion
from empleados
where MONTH(fecha_contratacion)=2 or MONTH(fecha_contratacion)=6 or MONTH(fecha_contratacion)=8
order by MONTH(fecha_contratacion) asc

/*2.8Informar las ventas de los siguientes t�tulos: 'Cooking with Computers: Surreptitious
Balance Sheets', 'The Psychology of Computer Cooking', 'Emotional Security: A New
Algorithm'. Mostrar titulo, nombre de almac�n, fecha de orden, n�mero de orden y
cantidad. Ordenar por t�tulos.*/
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

/*2.9Informar las publicaciones del a�o 2011 exceptuando las de los g�neros business,
psychology y trad_cook. Mostrar titulo y g�nero. Ordenar por g�nero y titulo.*/
select titulo,genero
from titulos as ti
where year(fecha_publicacion)=2011 and (genero <> 'business' and genero <> 'psychology' and not genero='trad_cook')
order by 2 asc, 1 asc

--3 Manejo de valores nulos
/*3.1Mostrar aquellos libros que tienen el precio en nulo. Mostrar id de t�tulo, nombre y
nombre del editor.*/
select titulo_id,titulo,editorial_nombre
from titulos as t,editoriales as e
where t.editorial_id = e.editorial_id and precio is null 

/*3.2Mostrar todos los libros. Mostrar id de t�tulo, nombre y nombre del editor y el precio.
Aquellos que tienen el precio en nulo cambiarlo por 0.*/
select titulo_id,titulo,editorial_nombre,isnull(precio,0)
from titulos as t,editoriales as e
where t.editorial_id = e.editorial_id 

/*3.3Mostrar los descuentos que tengan una cantidad m�nima establecida. Informar tipo
descuento, cantidad m�nima y descuento*/
select *
from descuentos
where cantidad_minima is not null

/*3.4Mostrar los t�tulos y el adelanto que le corresponde a cada uno, si este valor fuera
nulo informar le valor predeterminado de 1000 pesos.*/
select titulo,isnull(adelanto,1000)
from titulos

--4 Operaciones con cadenas
/*4.1Mostrar los nombres de los autores que empiecen con �L�.*/
select autor_nombre
from autores
where autor_nombre like 'L%'

/*4.2Mostrar los nombres de los autores que tengan una �A� en su nombre.*/
select autor_nombre
from autores
where autor_nombre like '%A%'

/*4.3Mostrar los nombres de los autores que empiecen con letras que van de la T a la Y.*/
select autor_nombre
from autores
where autor_nombre like '[T-Y]%'

/*4.4Mostrar los t�tulos que no tengan un �Computer� en su titulo.*/
select titulo
from titulos
where titulo not like '%Computer%'

--5 Ordenacion
/*5.1Listar los empleados ordenados por apellido, por nombre y por inicial del segundo
nombre.*/
select nombre,apellido,inicial_segundo_nombre
from empleados
order by apellido, nombre, inicial_segundo_nombre

/*5.2Listar los t�tulos pertenecientes al g�nero �business�. Por cada fila, listar el id, el t�tulo
y el precio. Ordenar los datos por precio en forma descendente e id de art�culo en
forma ascendente.*/
select titulo_id,titulo,precio
from titulos
where genero = 'business'
order by precio desc,titulo_id asc

/*5.3Informar la venta m�s importante con forma de pago a 60 d�as. Mostrar el almac�n, el
n�mero de orden, la fecha de la factura y el t�tulo.*/
select *
from ventas

--hacer
select top 1 almacenes.almacen_nombre,ventas.numero_orden,ventas.fecha_orden,titulos.titulo
from ventas,almacenes,titulos
where almacenes.almacen_id=ventas.almacen_id and titulos.titulo_id=ventas.titulo_id 
	and forma_pago='60 d�as'
order by ventas.cantidad*precio desc

--6 Funciones agregadas. No olvidar renombrar las columnas obtenidas por funci�n agregada
/*6.1Mostrar el promedio de venta anual de todos los t�tulos*/
select titulo,venta_anual 
from titulos

select 'Promedio de venta anual de todos los titulos'= AVG(venta_anual)
--avg ignora los null, es decir, 
--no cuenta los titulos con null
from titulos

/*6.2Mostrar el m�ximo de adelanto de todos los t�tulos*/
select adelanto
from titulos
order by adelanto DESC

select 'Maximo de adelanto de todos los titulos'=MAX(adelanto)
from titulos

/*6.3Informar cuantos planes de regal�as tiene el t�tulo MC3021*/
select *
from plan_regalias

select 'Cantidad de Planes de regalias para MC3021'=COUNT(regalias)
from plan_regalias
where titulo_id = 'MC3021'

/*6.4Obtener el total de ventas realizadas a 30 d�as en el a�o 2014*/
select *
from ventas

select 'Total ventas realizadas a 30 d�as en el a�o 2014'=COUNT(titulo_id)
from ventas
where forma_pago like '30 d[i,�]as' and YEAR(fecha_orden)=2014

/*6.5Informar cuantas formas de pago existen*/
select 'Cantidad de formas de pago'=COUNT(distinct forma_pago)
from ventas

select forma_pago
from ventas
group by forma_pago

--7 Funciones agregadas con agrupaci�n. Renombrar las columnas obtenidas por funci�n
--agregada.
/*7.1. Informar cuantos t�tulos tiene cada autor. Mostrar c�digo de autor y cantidad de
libros.*/
select distinct autor_id
from titulo_autor

select 'Codigo autor'=autor_id, 'Cantidad de libros'=COUNT(titulo_id)
from titulo_autor
group by autor_id

/*7.2. Informar el total de unidades vendidas por n�mero de orden del almac�n 7131.
Mostrar n�mero de orden y total vendido.*/
select *
from ventas

select 'Numero de orden'=numero_orden,'Total vendido'=SUM(cantidad)
from ventas
where almacen_id=7131
group by numero_orden

/*7.3. Informar la �ltima orden generada por cada almac�n con forma de pago a 30 d�as y 60
d�as. Mostrar c�digo de almac�n, fecha de la orden y forma de pago. Ordenar por
fecha de orden.*/
select almacen_id,fecha_orden,forma_pago
from ventas
order by almacen_id desc

--select 'Codigo almacen'=v1.almacen_id,'Fecha de orden'= max(v1.fecha_orden),'Forma de pago'= v1.forma_pago
--from ventas as v1, ventas as v2
--where v1.almacen_id=v2.almacen_id 
--	and (v1.forma_pago like '30 d[i,�]as' /*and v1.fecha_orden > v2.fecha_orden*/)
--	or (v1.forma_pago like '60 d[i,�]as' /*and v1.fecha_orden > v2.fecha_orden*/)
--group by v1.almacen_id, v1.forma_pago, v1.fecha_orden 
--order by v1.almacen_id 

select almacen_id,forma_pago,max(fecha_orden) as fecha
from ventas
where ventas.forma_pago = '30 d�as' or ventas.forma_pago = '60 d�as'
group by almacen_id,forma_pago
--order by fecha
order by max(fecha_orden)

/*7.4. Informar el nivel de cargo m�s alto alcanzado por alg�n empleado de cada editorial.
Mostrar Nombre de la editorial y nivel de cargo. Ordenar por nivel de cargo m�ximo
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

/*7.5. Mostrar los tres primeros g�neros m�s vendidos. Mostrar g�nero y total de ventas
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

/*7.6. Informar aquellos t�tulos que tengan m�s de un autor. Mostrar c�digo de t�tulo y
cantidad de autores.*/
select *
from titulo_autor
order by titulo_id

select titulo_id, count(autor_id) as 'cantidad de autores'
from titulo_autor
group by titulo_id
having count(autor_id) > 1

/*7.7. Informar el total de regal�as obtenidas por cada t�tulo que haya tenido 40 o m�s
unidades vendidas. Mostrar el t�tulo y el monto en pesos de las regal�as y ordenar por
mayor regal�a primero.*/
select titulo, sum(((precio*cantidad)*regalias)/100) as 'monto regalias en pesos',SUM(cantidad) as 'cantidad vendida'
from titulos, ventas
where ventas.titulo_id = titulos.titulo_id
group by titulos.titulo
having sum(ventas.cantidad) >= 40
order by sum(((precio*cantidad)*regalias)/100) desc

/*7.8. Informar los autores que hayan escrito varios g�neros de t�tulos. Mostrar nombre y
cantidad de g�neros ordenados por esta �ltima columna empezando por el mayor.*/
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