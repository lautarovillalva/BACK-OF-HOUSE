create database [back of house]
use [back of house]
--
create table canales(
id tinyint not null primary key identity(1,1),
canal varchar(50) not null unique
)
--
create table mediosDePago(
id tinyint not null primary key identity(1,1),
mpago varchar(50) not null unique
)
--
create table pos(
pos bigint not null primary key
)
--
create table turnos(
id tinyint not null primary key identity(1,1),
turno varchar(50) not null unique
)
--
create table colores(
id int not null primary key identity(1,1),
color varchar(50) not null unique
)
--
create table talles(
id tinyint not null primary key identity(1,1),
talle varchar(50) not null unique
)
--
create table generos(
id tinyint not null primary key identity(1,1),
genero varchar(50) not null unique
)
--
create table proveedores(
cuit varchar(50) not null primary key,
razonSocial varchar(50) not null,
mail varchar(50) not null,
telefono varchar(50) not null,
direccion varchar(50) not null
)
--
create table vendedores(
legajo bigint not null primary key identity(1000,10),
nombre varchar(50) not null,
apellido varchar(50) not null,
dni varchar(50) not null,
mail varchar(50) not null,
telefono varchar(50) not null,
fechaNacimiento date not null,
idTurno tinyint not null foreign key references turnos(id)
)
alter table vendedores
add unique(dni) 
--
create table ventas(
id bigint not null primary key identity(1,1),
idCanal tinyint not null foreign key references canales(id),
idMedioPago tinyint not null foreign key references mediosDePago(id),
fecha date not null,
pos bigint not null foreign key references pos(pos),
legajoVendedor bigint not null foreign key references vendedores(legajo)
)
--
create table productos(
upc bigint not null primary key identity(1000,10),
descripcion varchar(50) not null,
idColor int not null foreign key references colores(id),
idTalle tinyint not null foreign key references talles(id),
stock int not null check(stock>=0),
stockMin int not null check(stockMin>=0),
precio money not null check(precio>0),
idGenero tinyint not null foreign key references generos(id)
)
--
create table grilla(
upc bigint not null foreign key references productos(upc),
contenedor int not null check(contenedor>0),
estante char(1) not null
)
--
create table pedidos(
id bigint not null primary key identity(1,1),
cuitProveedor varchar(50) not null foreign key references proveedores(cuit),
fechaInicio date not null,
fechaEntrega date null,
entregado bit null
)
--
create table productosXpedidos(
upc bigint not null foreign key references productos(upc),
idPedido bigint not null foreign key references pedidos(id),
cantidad int not null check(cantidad>0)
)
--
create table productosXventa(
upc bigint not null foreign key references productos(upc),
idVenta bigint not null foreign key references ventas(id),
precioUnitario money not null
)
use [back of house]
alter table productosXventa
add  cantidad int not null check(cantidad>0)

