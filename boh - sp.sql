use [back of house]
--

create procedure spEngrillar(
			@upc bigint,
			@contenedor int,
			@estante char(1)
)
as
begin
insert into grilla(upc, contenedor, estante) values(@upc, @contenedor,@estante)
end
--

create procedure spAltaProvedor(
			@cuit varchar(50),
			@razonSocial varchar(50),
			@mail varchar(50),
			@telefono varchar(50),
			@direccion varchar(50)
)
as
begin
insert into proveedores(cuit, razonSocial, mail, telefono, direccion) values(@cuit, @razonSocial, @mail, @telefono, @direccion)
end
--

create procedure spAltaVendedor(
			@legajo bigint,
			@nombre varchar(50),
			@apellido varchar(50),
			@dni varchar(50),
			@mail varchar(50),
			@telefono varchar(50),
			@fechaNacimiento date,
			@idTurno tinyint
)
as
begin
insert into vendedores(legajo, nombre, apellido, dni, mail, telefono, fechaNacimiento, idTurno) values(@legajo, @nombre, @apellido, @dni, @mail, @telefono, @fechaNacimiento, @idTurno)
end
--

create procedure spVendedorXturno(
@turno varchar(2)
)
as
begin
select
		vendedores.legajo,
		vendedores.nombre +' '+vendedores.apellido as 'apenom'
from vendedores
inner join turnos on vendedores.idTurno=turnos.id
where turnos.turno=@turno
end
--









