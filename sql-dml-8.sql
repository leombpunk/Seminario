--8. Juntas
/*8.1. Informar las ventas a 60 días. Mostrar el id de título, el título y el total de ventas
(cantidad por precio). Renombrar a la columna calculada.*/
select t.titulo_id, t.titulo, (v.cantidad*t.precio) as 'total de ventas'
from titulos as t inner join ventas as v 
on t.titulo_id = v.titulo_id
where v.forma_pago = '60 días'

/*8.2. Informar los autores que hayan escrito varios géneros de libros. Mostrar nombre y
cantidad de géneros ordenados por esta última columna empezando por el mayor.*/
select a.autor_nombre, count(distinct t.genero) as 'cantidad de generos'
from titulos as t inner join titulo_autor as ta
on t.titulo_id = ta.titulo_id
inner join autores as a on a.autor_id = ta.autor_id
group by a.autor_nombre
having count(distinct t.genero) > 1
order by count(t.genero) desc

/*8.3. Informar para que editorial ha trabajado cada autor. Mostrar Apellido y nombre del
autor y nombre de la editorial. Ordenar por Apellido y nombre del autor y nombre de
la editorial.*/
select a.autor_apellido, a.autor_nombre, e.editorial_nombre
from autores as a inner join titulo_autor as ta
on a.autor_id = ta.autor_id
inner join titulos as ti on ti.titulo_id = ta.titulo_id
inner join editoriales as e on e.editorial_id = ti.editorial_id

/*8.4. Informar las ventas por título. Mostrar título, fecha de orden y cantidad, si no tienen
venta al menos mostrar una fila que indique la cantidad en 0. Ordenar por título y
mayor cantidad vendida primero.*/
select titulo
from titulos --resulta 18 filas/titulos

select t.titulo, sum(isnull(v.cantidad,0)) as cantidad, fecha_orden
from titulos as t left outer join ventas as v on t.titulo_id = v.titulo_id
group by t.titulo, fecha_orden
order by sum(isnull(v.cantidad,0)) desc, t.titulo

/*8.5. Informar los autores que no tienen títulos. Mostrar nombre y apellido*/
select a.autor_nombre, a.autor_apellido
from autores as a --son 23 autores

select a.autor_nombre, a.autor_apellido
from autores as a inner join titulo_autor as ta on a.autor_id = ta.autor_id
group by autor_nombre, a.autor_apellido --19 autores tienen titulos, entonces 4 no escribieron nada

select a.autor_nombre, a.autor_apellido
from autores as a left outer join titulo_autor as ta on a.autor_id = ta.autor_id --con full tambien funciona
where ta.titulo_id is null

/*8.6. Informar todos los cargos y los empleados que le corresponden de la editorial 'New
Moon Books', si algún cargo está vacante informar como 'Vacante' en apellido.
Mostrar descripción del cargo, apellido y nombre. Ordenar por descripción del cargo,
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

/*8.7. Informar cuantos títulos escribió cada autor inclusive aquellos que no lo hayan hecho
aún. Mostrar nombre y apellido del autor y cantidad. Ordenar por cantidad mayor
primero, apellido y nombre.*/
select a.autor_apellido,a.autor_nombre, count(titulo_id) as cantidad
from autores as a left outer join titulo_autor as ta on a.autor_id = ta.autor_id
group by autor_apellido, a.autor_nombre

/*8.8. ¿Informar cuantos títulos “Is Anger the Enemy?” vendió cada almacén. Si un almacén
no tuvo ventas del mismo informar con un cero. Mostrar código de almacén y
cantidad.*/
select * from almacenes -- son 6 alamcenes

select al.almacen_id, sum(isnull(v.cantidad,0)) as cantidad
from titulos as ti inner join ventas as v on ti.titulo_id = v.titulo_id and ti.titulo = 'Is Anger the Enemy?'
right outer join almacenes as al on al.almacen_id = v.almacen_id
group by al.almacen_id

/*8.9. Informar los totales de ventas (pesos) al contado entre abril y septiembre del 2014
por cada almacén. Mostrar nombre de almacén, y total de venta. Si un almacén no
tiene ventas mostrar en cero.*/
--son 6 almacenes
select distinct(forma_pago)
from ventas-- formas de pago

select a.almacen_nombre, sum(isnull((ti.precio*v.cantidad),0)) as cantidad
from ventas as v inner join titulos as ti on v.titulo_id = ti.titulo_id
right outer join almacenes as a on a.almacen_id = v.almacen_id 
and v.forma_pago = 'Al contado' and ((MONTH(v.fecha_orden) >= 4 and MONTH(v.fecha_orden) <= 9) 
and YEAR(v.fecha_orden) = 2014)
group by almacen_nombre

/*8.10. Informar el monto de regalías a pagar por cada autor, inclusive aquellos que no
tengan ventas, de las ventas del año 2013 de la editorial ‘Binnet & Hardley’. Mostrar
apellido y nombre del autor y monto a pagar. Tener en cuenta que hay que operar la
regalía del título y sobre esta la regalía del autor respecto a ese libro.*/
select a.autor_nombre, a.autor_apellido
from autores as a --son 23 autores

select a.autor_apellido, a.autor_nombre, sum(isnull((t.precio*v.cantidad),0)) as monto_regalia
from ventas as v inner join titulos as t on v.titulo_id = t.titulo_id 
	and YEAR(v.fecha_orden) = 2013 --ventas |r| titulos
inner join editoriales as ed on ed.editorial_id = t.editorial_id 
	and ed.editorial_nombre = 'Binnet & Hardley' --editoriales |r| titulos
inner join titulo_autor as ta on ta.titulo_id = t.titulo_id --titulos |r| titulo_autor
right outer join autores as a on a.autor_id = ta.autor_id --autores |r| titulo_autor
group by autor_apellido, autor_nombre
