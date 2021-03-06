use editorial
go
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

select 'Numero de orden' = numero_orden,'Total vendido' = SUM(cantidad)
from ventas
where almacen_id = 7131
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

select editorial_nombre,max(nivel_cargo) as 'nivel maximo cargo'
from editoriales,empleados
where empleados.editorial_id = editoriales.editorial_id
group by editoriales.editorial_id, editorial_nombre
order by [nivel maximo cargo] desc
--group editorial_id porque es la clave, y evita agrupar editoriales con
--nombres iguales, ej.: el nombre de un cliente, alumno, empleado

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
order by [total de ventas] desc

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
select titulo, sum(precio*cantidad*regalias/100) as 'monto regalias en pesos',SUM(cantidad) as 'cantidad vendida'
from titulos, ventas
where ventas.titulo_id = titulos.titulo_id
group by titulos.titulo_id, titulos.titulo
having sum(ventas.cantidad) >= 40
order by [monto regalias en pesos] desc

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
group by a.autor_id, a.autor_nombre
having count(distinct t.genero) > 1
order by count(t.genero) desc

--8. Juntas
/*8.1. Informar las ventas a 60 d�as. Mostrar el id de t�tulo, el t�tulo y el total de ventas
(cantidad por precio). Renombrar a la columna calculada.*/
select t.titulo_id, t.titulo, sum(v.cantidad*t.precio) as 'total de ventas'
from titulos as t inner join ventas as v 
on t.titulo_id = v.titulo_id
where v.forma_pago = '60 d�as'
group by t.titulo_id, t.titulo

/*8.2. Informar los autores que hayan escrito varios g�neros de libros. Mostrar nombre y
cantidad de g�neros ordenados por esta �ltima columna empezando por el mayor.*/
select a.autor_nombre, count(distinct t.genero) as 'cantidad de generos'
from titulos as t inner join titulo_autor as ta
on t.titulo_id = ta.titulo_id
inner join autores as a on a.autor_id = ta.autor_id
group by a.autor_id, a.autor_nombre
having count(distinct t.genero) > 1
order by count(t.genero) desc

--correccion
select a.autor_nombre, count(distinct t.genero) as 'cantidad de generos'
from titulos as t inner join titulo_autor as ta
on t.titulo_id = ta.titulo_id
inner join autores as a on a.autor_id = ta.autor_id
group by a.autor_id, a.autor_nombre
having count(distinct t.genero) > 1
order by [cantidad de generos] desc

/*8.3. Informar para que editorial ha trabajado cada autor. Mostrar Apellido y nombre del
autor y nombre de la editorial. Ordenar por Apellido y nombre del autor y nombre de
la editorial.*/
select a.autor_apellido, a.autor_nombre, e.editorial_nombre
from autores as a inner join titulo_autor as ta
on a.autor_id = ta.autor_id
inner join titulos as ti on ti.titulo_id = ta.titulo_id
inner join editoriales as e on e.editorial_id = ti.editorial_id

--correccion
select distinct a.autor_apellido, a.autor_nombre, e.editorial_nombre
from autores as a inner join titulo_autor as ta
on a.autor_id = ta.autor_id
inner join titulos as ti on ti.titulo_id = ta.titulo_id
inner join editoriales as e on e.editorial_id = ti.editorial_id
order by a.autor_apellido, a.autor_nombre, e.editorial_nombre

/*8.4. Informar las ventas por t�tulo. Mostrar t�tulo, fecha de orden y cantidad, si no tienen
venta al menos mostrar una fila que indique la cantidad en 0. Ordenar por t�tulo y
mayor cantidad vendida primero.*/
select titulo_id, titulo
from titulos --resulta 18 filas/titulos

select *
from ventas --23 titulos vendidos

select t.titulo, sum(isnull(v.cantidad,0)) as cantidad_ventas, max(v.fecha_orden) as fecha_de_orden
from titulos as t left outer join ventas as v on t.titulo_id = v.titulo_id
group by t.titulo_id, t.titulo
order by cantidad_ventas desc, t.titulo

--correccion
--fecha de orden en este caso no aplicar el max y agregarlo al group by 
--y dejar los 21 registros que salen xd
--isnull(sum(v.cantidad,0)) as cantidad_ventas
--dejar el codigo original agregar el codigo modificado
select t.titulo, sum(isnull(v.cantidad,0)) as cantidad_ventas, max(v.fecha_orden) as fecha_de_orden
from titulos as t left outer join ventas as v on t.titulo_id = v.titulo_id
group by t.titulo_id, t.titulo
order by cantidad_ventas desc, t.titulo

/*8.5. Informar los autores que no tienen t�tulos. Mostrar nombre y apellido*/
select a.autor_nombre, a.autor_apellido
from autores as a --son 23 autores

select a.autor_nombre, a.autor_apellido
from autores as a inner join titulo_autor as ta on a.autor_id = ta.autor_id
group by autor_nombre, a.autor_apellido --19 autores tienen titulos, entonces 4 no escribieron nada

select a.autor_nombre, a.autor_apellido
from autores as a left outer join titulo_autor as ta on a.autor_id = ta.autor_id --con full tambien funciona
where ta.titulo_id is null

/*8.6. Informar todos los cargos y los empleados que le corresponden de la editorial 'New
Moon Books', si alg�n cargo est� vacante informar como 'Vacante' en apellido.
Mostrar descripci�n del cargo, apellido y nombre. Ordenar por descripci�n del cargo,
apellido y nombre.*/
select * from cargos --14 cargos

select apellido, nombre from empleados as e --43 empleados
inner join editoriales as ed 
on e.editorial_id = ed.editorial_id and ed.editorial_nombre = 'New Moon Books' -- tiene 10 empleados
--order by empleado_id 

select c.cargo_descripcion, isnull(e.apellido,'Vacante') as empleado, e.nombre
from empleados as e inner join editoriales as ed 
on e.editorial_id = ed.editorial_id and ed.editorial_nombre = 'New Moon Books'
right outer join cargos as c on c.cargo_id = e.cargo_id -- con full tambien funciona
--where ed.editorial_nombre = 'New Moon Books'

--correccion
select c.cargo_descripcion, isnull(e.apellido,'Vacante') as empleado, e.nombre
from empleados as e inner join editoriales as ed 
on e.editorial_id = ed.editorial_id and ed.editorial_nombre = 'New Moon Books'
right outer join cargos as c on c.cargo_id = e.cargo_id
order by c.cargo_descripcion, empleado, e.nombre

/*8.7. Informar cuantos t�tulos escribi� cada autor inclusive aquellos que no lo hayan hecho
a�n. Mostrar nombre y apellido del autor y cantidad. Ordenar por cantidad mayor
primero, apellido y nombre.*/
select a.autor_apellido,a.autor_nombre, count(titulo_id) as cantidad
from autores as a left outer join titulo_autor as ta on a.autor_id = ta.autor_id
group by a.autor_id ,autor_apellido, a.autor_nombre

--correccion
select a.autor_apellido,a.autor_nombre, count(titulo_id) as cantidad
from autores as a left outer join titulo_autor as ta on a.autor_id = ta.autor_id
group by a.autor_id ,autor_apellido, a.autor_nombre
order by cantidad, a.autor_apellido, a.autor_nombre

/*8.8. �Informar cuantos t�tulos �Is Anger the Enemy?� vendi� cada almac�n. Si un almac�n
no tuvo ventas del mismo informar con un cero. Mostrar c�digo de almac�n y
cantidad.*/
select * from almacenes -- son 6 alamcenes

select al.almacen_id, sum(isnull(v.cantidad,0)) as cantidad
from titulos as ti inner join ventas as v on ti.titulo_id = v.titulo_id and ti.titulo = 'Is Anger the Enemy?'
right outer join almacenes as al on al.almacen_id = v.almacen_id
group by al.almacen_id

/*8.9. Informar los totales de ventas (pesos) al contado entre abril y septiembre del 2014
por cada almac�n. Mostrar nombre de almac�n, y total de venta. Si un almac�n no
tiene ventas mostrar en cero.*/
--son 6 almacenes
select distinct(forma_pago)
from ventas-- formas de pago

select a.almacen_nombre, sum(isnull((ti.precio*v.cantidad),0)) as cantidad
from ventas as v inner join titulos as ti on v.titulo_id = ti.titulo_id
right outer join almacenes as a on a.almacen_id = v.almacen_id 
and v.forma_pago = 'Al contado' and ((MONTH(v.fecha_orden) >= 4 and MONTH(v.fecha_orden) <= 9) 
and YEAR(v.fecha_orden) = 2014)
group by a.almacen_id ,almacen_nombre

--correccion
select a.almacen_nombre, sum(isnull((ti.precio*v.cantidad),0)) as cantidad
from ventas as v inner join titulos as ti on v.titulo_id = ti.titulo_id
right outer join almacenes as a on a.almacen_id = v.almacen_id 
and v.forma_pago = 'Al contado' and month(v.fecha_orden) between 4 and 9
and YEAR(v.fecha_orden) = 2014
group by a.almacen_id ,almacen_nombre

/*8.10. Informar el monto de regal�as a pagar por cada autor, inclusive aquellos que no
tengan ventas, de las ventas del a�o 2013 de la editorial �Binnet & Hardley�. Mostrar
apellido y nombre del autor y monto a pagar. Tener en cuenta que hay que operar la
regal�a del t�tulo y sobre esta la regal�a del autor respecto a ese libro.*/
select a.autor_nombre, a.autor_apellido
from autores as a --son 23 autores

select a.autor_apellido, a.autor_nombre, sum(isnull((t.precio*v.cantidad),0)) as monto_regalia
from ventas as v inner join titulos as t on v.titulo_id = t.titulo_id 
	and YEAR(v.fecha_orden) = 2013 --ventas |r| titulos
inner join editoriales as ed on ed.editorial_id = t.editorial_id 
	and ed.editorial_nombre = 'Binnet & Hardley' --editoriales |r| titulos
inner join titulo_autor as ta on ta.titulo_id = t.titulo_id --titulos |r| titulo_autor
right outer join autores as a on a.autor_id = ta.autor_id --autores |r| titulo_autor
group by a.autor_id, autor_apellido, autor_nombre

--correccion
--corregido el calculo de la regalia por autor segun el libro y la mar en coche xd
select a.autor_apellido, a.autor_nombre, 
sum(t.precio * v.cantidad * t.regalias / 100 * ta.porcentaje_regalias / 100) as monto_regalia
from ventas as v inner join titulos as t on v.titulo_id = t.titulo_id 
	and YEAR(v.fecha_orden) = 2013 --ventas |r| titulos
inner join editoriales as ed on ed.editorial_id = t.editorial_id 
	and ed.editorial_nombre = 'Binnet & Hardley' --editoriales |r| titulos
inner join titulo_autor as ta on ta.titulo_id = t.titulo_id --titulos |r| titulo_autor
right join autores as a on a.autor_id = ta.autor_id --autores |r| titulo_autor
group by a.autor_id, autor_apellido, autor_nombre

--correccion de la correccion
--el 8.10 esta re-copado, lindo para fedear en el parcial
select a.autor_apellido, a.autor_nombre, 
sum(t.precio * v.cantidad * t.regalias / 100 * ta.porcentaje_regalias / 100) as monto_regalia
from autores as a 
inner join titulo_autor as ta on ta.autor_id = a.autor_id --autores |r| titulo_autor
inner join titulos as t on ta.titulo_id = t.titulo_id --titulos |r| titulo_autor
inner join editoriales as ed on ed.editorial_id = t.editorial_id 
	and ed.editorial_nombre = 'Binnet & Hardley' --editoriales |r| titulos
left join ventas as v on v.titulo_id = ta.titulo_id
	and YEAR(v.fecha_orden) = 2013 --ventas |r| autores
group by a.autor_id, autor_apellido, autor_nombre

--9. Uni�n
/*9.1. Informar las ciudades y estado donde residen los autores, las editoriales y los
almacenes descartando valores duplicados. Ordenar por nombre de ciudad.*/
select a.ciudad, a.estado
from autores as a
union
select e.ciudad, e.estado
from editoriales as e
union
select al.ciudad, al.estado
from almacenes as al
order by ciudad

/*9.2. Informar cuantos t�tulos se han publicado primer semestre del 2011 y en el primer
semestre del 2017. Mostrar dos columnas y dos filas: en la primera columna la
descripci�n del periodo y en la segunda la cantidad de t�tulos.*/
select fecha_publicacion
from titulos --no hay publicanciones en 2017 xd

select periodo='primer semestre del 2011',COUNT(*) as cantidad_de_titulos_publicados
from titulos as t
where MONTH(fecha_publicacion) between 1 and 6 and YEAR(fecha_publicacion)=2011
union
select periodo='primer semestre del 2017',COUNT(*) as cantidad_de_titulos_publicados
from titulos as t
where MONTH(fecha_publicacion) between 1 and 6 and YEAR(fecha_publicacion)=2017

--correccion
select periodo='primer semestre del 2011',COUNT(*) as cantidad_de_titulos_publicados
from titulos as t
where MONTH(fecha_publicacion) between 1 and 6 and YEAR(fecha_publicacion)=2011
union
select 'primer semestre del 2017',COUNT(*)
from titulos as t
where MONTH(fecha_publicacion) between 1 and 6 and YEAR(fecha_publicacion)=2017

/*9.3. Emitir un informe comparativo entre las ventas del a�o 2012 y el a�o 2014. El informe
debe tener las siguientes columnas: c�digo de t�tulo, titulo, a�o y cantidad de vendida
en el a�o (cada uno correspondiente al c�digo de t�tulo de la fila correspondiente).
Tener presente que un t�tulo puede tener ventas en un a�o y no en el otro, en cuyo
caso debe aparecer igual en el informe el a�o sin ventas. Ordenar por t�tulo y a�o.*/

select t.titulo_id, t.titulo, sum(isnull(v.cantidad,0)) as cantidad_ventas, anio = 2012--max(year(fecha_orden)) as anio
from titulos as t left outer join ventas as v on t.titulo_id = v.titulo_id and year(fecha_orden)=2012
group by t.titulo_id, t.titulo
union
select t.titulo_id, t.titulo, sum(isnull(v.cantidad,0)) as cantidad_ventas, anio = 2014
from titulos as t left outer join ventas as v on t.titulo_id = v.titulo_id and year(fecha_orden)=2014
group by t.titulo_id, t.titulo
order by t.titulo, anio

--correccion
select t.titulo_id, t.titulo, sum(v.cantidad) as cantidad_ventas, anio = 2012
from titulos as t left join ventas as v on t.titulo_id = v.titulo_id and year(fecha_orden)=2012
group by t.titulo_id, t.titulo
union
select t.titulo_id, t.titulo, sum(v.cantidad), 2014
from titulos as t left join ventas as v on t.titulo_id = v.titulo_id and year(fecha_orden)=2014
group by t.titulo_id, t.titulo
order by t.titulo, anio

--10. Subconsultas
/*10.1. Informar los t�tulos que no hayan tenido ventas entre el a�o 2011 y 2013
exceptuando los que se hayan publicado posteriormente. Mostrar t�tulo, y nombre de
editorial. Resolver este problema dos veces usando In y Exists*/
select titulo from titulos --18 titulos

select distinct t.titulo 
from titulos as t 
inner join ventas as v on v.titulo_id = t.titulo_id --2 titulos no tiene ventas sin evaluar el rango en a�os

--In
select t.titulo, e.editorial_nombre
from titulos as t
inner join editoriales as e on e.editorial_id = t.editorial_id
where t.titulo_id not in(
	select distinct v.titulo_id
	from ventas as v
	where year(v.fecha_orden) between 2011 and 2013)--13 de 18 titulos se vendieron en este rango de a�os
order by t.titulo

--Exists
select t.titulo, e.editorial_nombre
from titulos as t
inner join editoriales as e on e.editorial_id = t.editorial_id
where not exists(
	select 1
	from ventas as v
	where year(v.fecha_orden) between 2011 and 2013 and t.titulo_id=v.titulo_id)
order by t.titulo

--correccion
--In
select t.titulo, e.editorial_nombre
from titulos as t
inner join editoriales as e on e.editorial_id = t.editorial_id
where t.titulo_id not in(
	select distinct v.titulo_id
	from ventas as v
	where year(v.fecha_orden) between 2011 and 2013)--13 de 18 titulos se vendieron en este rango de a�os
	and year(t.fecha_publicacion) < 2014 
--order by t.titulo

--Exists
select t.titulo, e.editorial_nombre
from titulos as t
inner join editoriales as e on e.editorial_id = t.editorial_id
where not exists(
	select 1
	from ventas as v
	where year(v.fecha_orden) between 2011 and 2013 and t.titulo_id=v.titulo_id)
	and year(t.fecha_publicacion) < 2014 
--order by t.titulo

/*10.2. Informar las editoriales que no hayan contratado empleados en el a�o 2010
excepto que sean Director editorial, Dise�ador o Editor. Mostrar nombre de editorial.
Ordenar.*/
select editorial_nombre 
from editoriales --8 editoriales

select cargo_descripcion
from cargos --14 cargos

select edi.editorial_nombre
from editoriales as edi
where edi.editorial_id not in(
	select e.editorial_id
	from empleados as e 
	inner join cargos as c on c.cargo_id = e.cargo_id 
		and c.cargo_descripcion in('Director editorial','Dise�ador','Editor')
	where year(e.fecha_contratacion) = 2010)

--correccion
select edi.editorial_nombre
from editoriales as edi
where edi.editorial_id not in(
	select e.editorial_id
	from empleados as e 
	inner join cargos as c on c.cargo_id = e.cargo_id 
		and c.cargo_descripcion not in('Director editorial','Dise�ador','Editor')
	where year(e.fecha_contratacion) = 2010)

/*10.3. Informar los autores que han hecho alg�n t�tulo juntos. Mostrar los nombres y
apellidos de a pares, �sea en una misma fila apellido y nombre de un autor seguido de
apellido y nombre del otro autor. Ordenar por apellido y nombre de un autor seguido
de apellido y nombre del otro autor.*/
select * 
from titulo_autor
order by titulo_id

--solucion 
select t1.autor_id, t2.autor_id
from titulo_autor as t1, titulo_autor as t2
--los 2 where son validos, producen el mismo resultado
where t1.titulo_id = t2.titulo_id
	and t1.autor_id < t2.autor_id
/*where t1.titulo_id = t2.titulo_id
	and t1.autor_id <> t2.autor_id
	and t1.autor_orden > t2.autor_orden*/

select a1.autor_apellido, a1.autor_nombre, a2.autor_apellido, a2.autor_nombre
from autores as a1, autores as a2,(
	select t1.autor_id as autor1, t2.autor_id as autor2
	from titulo_autor as t1, titulo_autor as t2
	--los 2 where son validos, producen el mismo resultado
	where t1.titulo_id = t2.titulo_id
		and t1.autor_id < t2.autor_id
	) as ta
where ta.autor1 = a1.autor_id and ta.autor2 = a2.autor_id
order by a1.autor_apellido, a1.autor_nombre, a2.autor_apellido, a2.autor_nombre

/*10.4. Informar aquellos t�tulos que hayan tenido alguna venta mejor que las ventas
del t�tulo �Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean�. Mostrar
t�tulo y g�nero. Ordenar por t�tulo.*/

--primer intento
--select t.titulo, t.genero
--from titulos as t
--inner join ventas as v on t.titulo_id = v.titulo_id
--where sum(t.precio*v.cantidad) > some(
--	select sum(t.precio*v.cantidad)
--	from ventas as v
--	where t.titulo_id = v.titulo_id 
--	and t.titulo = 'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean'	
--	)
--group by t.titulo_id, t.titulo, t.genero
--order by t.titulo

--sub 1
select v.titulo_id as t1id, sum(v.cantidad*ti.precio) as cantidad1
from ventas as v
inner join titulos as ti on ti.titulo_id = v.titulo_id 
	and ti.titulo='Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean'
group by v.titulo_id

--sub 2
select v.titulo_id as t2id, sum(v.cantidad*ti.precio) as cantidad2
from ventas as v
inner join titulos as ti on ti.titulo_id = v.titulo_id 
	and ti.titulo<>'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean'
group by v.titulo_id
--having sum(v.cantidad*ti.precio) >= 838

--consulta final �?
select /*t.titulo_id,*/ t.titulo, t.genero
from titulos as t,(
	select v.titulo_id as t1id, sum(v.cantidad*ti.precio) as cantidad1
	from ventas as v
	inner join titulos as ti on ti.titulo_id = v.titulo_id 
		and ti.titulo='Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean'
	group by v.titulo_id
	) as v1, (select v.titulo_id as t2id, sum(v.cantidad*ti.precio) as cantidad2
				from ventas as v
				inner join titulos as ti on ti.titulo_id = v.titulo_id 
					and ti.titulo<>'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean'
				group by v.titulo_id
				) as v2
where v2.cantidad2 >= v1.cantidad1 and t.titulo_id = v2.t2id
order by t.titulo

--correccion
select /*t.titulo_id,*/ t.titulo, t.genero
from titulos as t
inner join ventas as v on v.titulo_id = t.titulo_id
where cantidad > some (
	select cantidad
	from ventas as v
	inner join titulos as t on t.titulo_id = v.titulo_id
	where titulo = 'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean'
	--where titulo = 'Secrets of Silicon Valley'
	)
order by titulo

/*10.5. Informar los almacenes que hayan vendido m�s del doble que cualquier otro
almac�n. Mostrar Nombre de almac�n y cantidad. Ordenar por mayor venta primero.*/

--sub 1
select top 1 v.almacen_id, sum(v.cantidad) as total_cantidad
from ventas as v, almacenes as al
where v.almacen_id = al.almacen_id
group by v.almacen_id, al.almacen_nombre
order by total_cantidad
---------------------------------------------------------------------------------------------------------
select v.almacen_id, sum(v.cantidad*2) as total_cantidad
from ventas as v inner join almacenes as al
on v.almacen_id = al.almacen_id
group by v.almacen_id, al.almacen_nombre
--consulta
select distinct a.almacen_id,a.almacen_nombre, a.total_venta
from (select v.almacen_id, al.almacen_nombre, sum(v.cantidad) as total_venta
		from ventas as v, almacenes as al
		where v.almacen_id = al.almacen_id
		group by v.almacen_id, al.almacen_nombre
		) as a, (select v.almacen_id, al.almacen_nombre, sum(v.cantidad) as total_venta
			from ventas as v, almacenes as al
			where v.almacen_id = al.almacen_id
			group by v.almacen_id, al.almacen_nombre
			) as b
where a.total_venta > b.total_venta*2 and a.almacen_id<>b.almacen_id
order by a.total_venta
---------------------------------------------------------------------------------------------------------
select a.almacen_id,a.almacen_nombre, a.total_venta
from (select v.almacen_id, al.almacen_nombre, sum(v.cantidad) as total_venta
		from ventas as v, almacenes as al
		where v.almacen_id = al.almacen_id
		group by v.almacen_id, al.almacen_nombre
		) as a, (select v.almacen_id, al.almacen_nombre, sum(v.cantidad) as total_venta
			from ventas as v, almacenes as al
			where v.almacen_id = al.almacen_id
			group by v.almacen_id, al.almacen_nombre
			) as b
where a.total_venta > b.total_venta*2 and a.almacen_id<>b.almacen_id
group by a.almacen_id,a.almacen_nombre, a.total_venta
order by a.total_venta

--nuevo agregado
--31%
select al.almacen_nombre, sum(v.cantidad) as total_cantidad
from almacenes as al 
inner join ventas as v on v.almacen_id = al.almacen_id
group by v.almacen_id, al.almacen_nombre
having sum(v.cantidad) > some (
	select sum(v.cantidad*2)
	from ventas as v inner join almacenes as al
	on v.almacen_id = al.almacen_id
	group by v.almacen_id
	)
order by total_cantidad desc

--esta consulta 69% contra 31%
--select al.almacen_id, sum(v.cantidad) as total_cantidad
--from almacenes as al 
--inner join ventas as v on v.almacen_id = al.almacen_id
--group by al.almacen_id

/*10.6. Informar el almac�n o los almacenes que haya vendido m�s que todos los
otros. Mostrar Nombre de almac�n y cantidad.*/

select a1.almacen_nombre, vendido = SUM(v1.cantidad)
from ventas as v1
inner join almacenes as a1 on v1.almacen_id = a1.almacen_id
group by a1.almacen_id, a1.almacen_nombre
having SUM(v1.cantidad) >= all(
	select cantidad_vendida = SUM(v.cantidad) 
	from ventas as v
	inner join almacenes as a on v.almacen_id = a.almacen_id 
	group by a.almacen_id
	)

/*10.7. Informar el o los t�tulos que se vendieron m�s que cualquier otro con forma de
pago a 60 d�as.*/

select *
from ventas

select t.titulo_id, t.titulo,titulos_vendidos = SUM(v.cantidad)
from ventas as v
inner join titulos as t on v.titulo_id = t.titulo_id and v.forma_pago = '60 d�as'
group by t.titulo_id, t.titulo
having SUM(v.cantidad) >= all(
	select titulos_vendidos = SUM(v1.cantidad)
	from ventas as v1
	inner join titulos as t1 on v1.titulo_id = t1.titulo_id and v1.forma_pago = '60 d�as'
	group by t1.titulo_id
	)

/*10.8. Informar cuantos t�tulos tiene cada autor. Mostrar c�digo de autor, nombre,
apellido y cantidad de libros.*/

--esta consigna es la que va en la serio 8? o algo asi xd

--select xd.autor_id, xd.autor_nombre, xd.autor_apellido ,total_titulos = count(ta.titulo_id)
--from (--aca lo que hace es minimizar los datos de la tabla
--	select autor_id, autor_nombre, autor_apellido
--	from autores
--	) as xd
--left join titulo_autor as ta on ta.autor_id = xd.autor_id
--group by xd.autor_id, xd.autor_nombre, xd.autor_apellido

/*10.9. Informar el nivel de cargo m�s alto alcanzado por alg�n empleado de cada
editorial. Mostrar Nombre de la editorial y nivel de cargo. Ordenar por nivel de cargo
m�ximo empezando por el mayor.*/

select *
from empleados --43 empleados

select *
from editoriales --8 editoriales

select e.editorial_id, e.editorial_nombre, nv.maximo_nivel_cargo
from editoriales as e
inner join (
	select editorial_id, max(nivel_cargo) as maximo_nivel_cargo
	from empleados
	group by editorial_id
	) as nv on e.editorial_id = nv.editorial_id
order by nv.maximo_nivel_cargo desc

/*10.10. Mostrar los tres primeros g�neros m�s vendidos. Mostrar g�nero y total de
ventas ordenado por mayor total de venta.*/

--total ventas en cantidad o en pasta?

select distinct genero
from titulos --6 generos

select top 3 t.genero, total_ventas = sum(v.cantidad*t.precio)
from titulos as t
inner join /*ventas*/(
	select titulo_id, cantidad
	from ventas
	) as v on t.titulo_id = v.titulo_id
group by t.genero
order by total_ventas desc

select top 3 t.genero, total_ventas = sum(v.cantidad)
from titulos as t
inner join /*ventas*/(
	select titulo_id, cantidad
	from ventas
	) as v on t.titulo_id = v.titulo_id
group by t.genero
order by total_ventas desc

/*10.11. Informar los autores que hayan escrito varios g�neros de t�tulos. Mostrar
nombre y cantidad de g�neros ordenados por esta �ltima columna empezando por el
mayor.*/

/*10.12. Informar cuantos t�tulos escribi� cada autor inclusive aquellos que no lo hayan
hecho a�n. Mostrar nombre y apellido del autor y cantidad. Ordenar por cantidad
mayor primero, apellido y nombre.*/

/*10.13. Informar el monto de regal�as a pagar por cada autor, inclusive aquellos que no
tengan ventas, de las ventas del a�o 2013 de la editorial �Binnet & Hardley�. Mostrar
apellido y nombre del autor y monto a pagar. Tener en cuenta que hay que operar la
regal�a del t�tulo y sobre esta la regal�a del autor respecto a ese libro.*/

--11. Serie libre
/*11.1. Informar las editoriales que solo tengan como empleado un editor y
ning�n otro cargo.*/

--cuento cantidad de empleados
--tengo las editoriales que tienen un solo empleado
--en este caso da la casualidad que justo todas estas 
--tienen contratado un editor
select ed.editorial_id--, count(em.empleado_id) as cantidad_cargos
from editoriales as ed
inner join empleados as em on em.editorial_id = ed.editorial_id
--inner join cargos as c on c.cargo_id = em.cargo_id --and cargo_descripcion = 'Editor'
group by ed.editorial_id
having count(em.empleado_id) = 1
-----------------------------

--esto me dice que hay 7 editores en total
--de cualquier editorial
select cargo_descripcion, count(e.empleado_id)
from empleados as e
inner join cargos as c on c.cargo_id = e.cargo_id and c.cargo_descripcion = 'Editor'
group by c.cargo_descripcion
------------------------------------------

--el id de cargo editor
select cargo_id
from cargos
where cargo_descripcion = 'Editor'
-----------------------

--aca muestra a las editoriales sus empleados y cargos
select ed.editorial_nombre, em.empleado_id, c.cargo_descripcion
from editoriales as ed
inner join empleados as em on em.editorial_id = ed.editorial_id
inner join cargos as c on c.cargo_id = em.cargo_id
order by ed.editorial_nombre
------------------------------------------------------

/*11.2. Listar los almacenes que vendieron todos los t�tulos. Mostrar nombre de
almac�n.*/

/*11.3. Informar los empleados que en su cargo tengan mejor nivel que otros
empleados en el mismo cargo. Mostrar nombre y apellido del empleado, editorial,
cargo y nivel de cargo.*/

/*11.4. Informar los t�tulos que hayan sido �Best sellers� (m�s vendidos) por cada
editorial. Puede haber m�s de un t�tulo por editorial. Mostrar nombre de la editorial,
nombre del t�tulo y nombre y apellido el autor principal. Ordenar por nombre de
editorial y t�tulo.*/

/*11.5. Informar cuantas unidades de cada t�tulo deben venderse para cubrir el
adelanto (en concepto de regal�as). Mostrar t�tulo y cantidad estimada.*/

/*11.6. Informar cuantos g�neros tienen en su cat�logo cada editorial. Mostrar
nombre de editorial y cantidad. Ordenar por mayor cantidad de g�neros.*/

/*11.7. Informar los almacenes que no han vendido alg�n t�tulo publicado el a�o 2011.
Mostrar nombre de almac�n y ordenar por esta columna.*/

/*11.8. Informar las ciudades donde existan editoriales, almacenes y autores y cuantos
son de cada uno. Mostrar nombre de ciudad, estado, la entidad existente (editorial,
almac�n o autor) y la cantidad.*/

--12. Inserci�n, actualizaci�n y borrado.
/*12.1. Agregar los nuevos autores Facundo Manes (id 541-54-5643) y Mateo Niro (id
541-25-5641). El primero tiene tel�fono 011-4515-9897, direcci�n Av. Libertador
2354, CP 10445 y el segundo tel�fono 011-4554-7856, direcci�n Av. De Mayo 564, CP
10056. Ambos viven en C.A.B.A. (BA) y est�n contratados.*/

select *
from autores
order by estado

--el numero de telefono 13 trunca char(12)
insert into autores
values('541-54-5643','Facundo','Manes','011-4515-9897','Av. Libertador 2354','C.A.B.A.','BA','10445',1),
	  ('541-25-5641','Mateo','Niro','011-4554-7856','Av. De Mayo 564','C.A.B.A.','BA','10056',1)

select *--delete
from autores
where autor_id = '541-54-5643' or autor_id = '541-25-5641'

/*12.2. Agregar la editorial Planeta (id 5684) ubicada en C.A.B.A. (BA), Argentina.*/

select *
from editoriales

insert into editoriales
values('5684','Planeta','C.A.B.A.','BA','Argentina')

select *--delete
from editoriales
where editorial_id = 5684

/*12.3. Agregar el t�tulo Usar el cerebro, ID NC5001, g�nero Neurociencia, de la
editorial Planeta, precio $12, adelanto $3000, regal�as 18%, publicado el 1� de marzo
de 2014. Notas: Conocer nuestra mente para vivir mejor.*/

/*12.4. Agregar al t�tulo �Usar el cerebro� los autores Facundo Manes y Mateo Niro en
ese orden. Para el primero las regal�as son 70% y para el segundo 30%.*/

/*12.5. Agregar una venta al almac�n 7896 con los siguientes datos:
Orden JJ3598
Fecha: 30 de abril del 2015
Cantidad: 30
Forma de pago: 30 d�as
T�tulo: �Usar el cerebro�*/

/*12.6. Agregar un plan de regal�as a cada t�tulo que no lo tenga. El rango m�nimo ser�
cero y el m�ximo 5000. El porcentaje de regal�as establecer en 10.*/

/*12.7. Agregar un plan de regal�as a cada t�tulo. El rango m�nimo ser� el rango
m�ximo actual m�s uno, el rango m�ximo ser� el doble del rango m�ximo actual y la
regal�a ser� el m�ximo actual m�s dos puntos.*/

/*12.8. Subir en un 10% los precios de los t�tulos de la editorial Algodata Infosystems
12.9. A aquellos empleados que en su cargo est�n en el nivel m�nimo (rango inferior)
subirle a la al punto medio.*/

/*12.10. Cambiar el cargo de los �editores� a �director editorial� a aquellos editores que
est�n a por lo menos 15 puntos del nivel m�ximo.*/

/*12.11. Borrar los autores que no fueron contratados.*/

/*12.12. Borrar el t�tulo �Usar el cerebro�. Para poder completar esta operaci�n borrar
las filas relacionas den las distintas tablas mediante subconsulta.*/
