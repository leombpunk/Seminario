use editorial
go
--10. Subconsultas
/*10.1. Informar los títulos que no hayan tenido ventas entre el año 2011 y 2013
exceptuando los que se hayan publicado posteriormente. Mostrar título, y nombre de
editorial. Resolver este problema dos veces usando In y Exists*/
select titulo from titulos --18 titulos

select distinct t.titulo 
from titulos as t 
inner join ventas as v on v.titulo_id = t.titulo_id --2 titulos no tiene ventas sin evaluar el rango en años

--In
select t.titulo, e.editorial_nombre
from titulos as t
inner join editoriales as e on e.editorial_id = t.editorial_id
where t.titulo_id not in(
	select distinct v.titulo_id
	from ventas as v
	where year(v.fecha_orden) between 2011 and 2013)--13 de 18 titulos se vendieron en este rango de años
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

/*10.2. Informar las editoriales que no hayan contratados empleados en el año 2010
excepto que sean Director editorial, Diseñador o Editor. Mostrar nombre de editorial.
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
		and c.cargo_descripcion in('Director editorial','Diseñador','Editor')
	where year(e.fecha_contratacion) = 2010)

/*10.3. Informar los autores que han hecho algún título juntos. Mostrar los nombres y
apellidos de a pares, ósea en una misma fila apellido y nombre de un autor seguido de
apellido y nombre del otro autor. Ordenar por apellido y nombre de un autor seguido
de apellido y nombre del otro autor.*/

/*10.4. Informar aquellos títulos que hayan tenido alguna venta mejor que las ventas
del título “Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean”. Mostrar
título y género. Ordenar por título.*/

/*10.5. Informar los almacenes que hayan vendido más del doble que cualquier otro
almacén. Mostrar Nombre de almacén y cantidad. Ordenar por mayor venta primero.*/

/*10.6. Informar el almacén o los almacenes que haya vendido más que todos los
otros. Mostrar Nombre de almacén y cantidad.*/

/*10.7. Informar el o los títulos que se vendieron más que cualquier otro con forma de
pago a 60 días.*/

/*10.8. Informar cuantos títulos tiene cada autor. Mostrar código de autor, nombre,
apellido y cantidad de libros.*/

/*10.9. Informar el nivel de cargo más alto alcanzado por algún empleado de cada
editor. Mostrar Nombre del editor y nivel de cargo. Ordenar por nivel de cargo
máximo empezando por el mayor.*/

/*10.10. Mostrar los tres primeros géneros más vendidos. Mostrar género y total de
ventas ordenado por mayor total de venta.*/

/*10.11. Informar los autores que hayan escrito varios géneros de títulos. Mostrar
nombre y cantidad de géneros ordenados por esta última columna empezando por el
mayor.*/

/*10.12. Informar cuantos títulos escribió cada autor inclusive aquellos que no lo hayan
hecho aún. Mostrar nombre y apellido del autor y cantidad. Ordenar por cantidad
mayor primero, apellido y nombre.*/

/*10.13. Informar el monto de regalías a pagar por cada autor, inclusive aquellos que no
tengan ventas, de las ventas del año 2013 de la editorial ‘Binnet & Hardley’. Mostrar
apellido y nombre del autor y monto a pagar. Tener en cuenta que hay que operar la
regalía del título y sobre esta la regalía del autor respecto a ese libro.*/
