insert into Estaciones(ANSICode, Nombre) 
values('abcd1234','estawea')

insert into Estaciones(ANSICode, Nombre) 
values('abcd1235','estacion2')

select * from Estaciones
---------------------------------------------------
insert into Sensores(Tipo, Activo, Alta, ANSICode)
values('a',2,GETDATE(),'abcd1234')

insert into Sensores(Tipo, Activo, Alta, ANSICode)
values('a',2,GETDATE()+1,'abcd1234')

insert into Sensores(Tipo, Activo, Alta, ANSICode)
values('a',2,null,'abcd1235')

select * from Sensores