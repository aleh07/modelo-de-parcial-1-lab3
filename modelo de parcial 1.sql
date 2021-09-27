/*1) Listado con Apellido y nombres de los clientes que hayan gastado más de $60000 en
el año 2020 en concepto de servicios.*/

select cli.Apellido , cli.Nombre  from Clientes as cli  inner join Servicios as serv on serv.IDCliente= cli.ID 
where year(serv.Fecha) =2020
group by cli.Apellido ,cli.Nombre having sum(serv.Importe) >60000  

/*2) Listado con ID, Apellido y nombres sin repeticiones de los técnicos que hayan
cobrado un servicio menos de $2600 y dicho servicio haya demorado más que el
promedio general de duración de servicios.*/
  select distinct  t.ID , t.Apellido, t.Nombre  from Tecnicos as t inner join Servicios as serv on 
  serv.IDTecnico= t.ID
  where serv.Importe < 2600 and serv.Duracion > 
  (select AVG(serv.Duracion) from Servicios as serv)

  /*3) Listado con Apellido y nombres de los técnicos, total recaudado en concepto de
servicios abonados en efectivo y total recaudado en concepto de servicios abonados
con tarjeta.*/select distinct t.Apellido , t.Nombre,(select SUM(serv.Importe  )from servicios as serv where serv.FormaPago='E' and serv.IDTecnico= t.ID)as 'recaudacion con efectivo',(select SUM (s.importe) from Servicios as s where s.FormaPago='T' and s.IDTecnico= t.ID) as 'recaudacion con tarjeta'from Tecnicos as t 
/*4) Listar la cantidad de tipos de servicio que registre más clientes de tipo particular que
clientes de tipo empresa.*/

select ts.descripcion from TiposServicio as ts
where 
(select COUNT (s.idcliente) from Servicios as s inner join Clientes as c on c.ID= s.IDCliente where s.IDTipo=ts.ID and c.Tipo='p')
> 
(select COUNT (s.idcliente) from Servicios as s inner join Clientes as c on c.ID= s.IDCliente where s.IDTipo=ts.ID and c.Tipo='e')

/*5) Agregar las tablas y/o restricciones que considere necesario para permitir registrar
que un cliente pueda valorar el trabajo realizado en un servicio por parte de un
técnico. Debe poder registrar un puntaje entre 1 y 10 y un texto de hasta 500
caracteres con observaciones.*/
go
create table CalidadServicio(
id bigint not null primary key identity(1,1),
idservicio int  not null foreign key references servicios(id),
puntaje int not null check( puntaje >0 and puntaje <11),
descripcion varchar(500) not null
)

From TiposServicio TS

Inner Join Servicios S ON S.IDTipo = TS.ID

Where (Select Count(*) From Servicios 

Inner join Clientes C ON C.ID = IDCliente

Where IDTipo = TS.ID and C.Tipo Like 'P') > (Select Count(*) From Servicios 

Inner join Clientes C ON C.ID = IDCliente

Where IDTipo = TS.ID and C.Tipo Like 'E')

select * from TiposServicio