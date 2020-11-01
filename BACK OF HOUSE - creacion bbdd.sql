create database[BACK OF HOUSE]


create table vendedores(
	id tinyint not null primary key identity(100,1),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	dni int not null,
	mail varchar(50),
	fechaNac date not null
)
create table pos(
	pos tinyint not null primary key identity(100,3),
	caja tinyint not null unique
)
create table colores(
	ID tinyint not null primary key identity(100,100),
	color varchar(30) not null unique
)
create table talles(
	ID tinyint not null primary key identity(1,1),
	talle varchar(30) not null unique
)
create table generos(
	ID tinyint not null primary key identity(1,1),
	genero varchar(30) not null unique
)
create table contenedores(
	rack int not null identity(1,1),
	bin char not null unique,
	primary key (rack, bin)
)
create table proveedores(
	cuit int not null primary key,
	rSocial varchar(50) unique,
	mail varchar(50) not null,
	telefono varchar(20) not null
)
create table productos(
	UPC varchar(10) not null,
	descripcion varchar(50) not null,
	style varchar(5) not null,
	idColor tinyint not null foreign key references colores(ID),
	idTalle tinyint not null foreign key references talles(ID),
	idGenero tinyint not null foreign key references generos(ID),
	stock int not null check(stock>0),
	stockMin int not null check(stockMin>0),
	precio money not null check(precio>0),
)
alter table productos
add constraint PK_productos primary key (UPC, style, idcolor)
create table canales(
	ID tinyint not null primary key identity(1,1),
	canal varchar(30) not null unique,
)
create table pagos(
	ID tinyint not null primary key identity(1,1),
	pago varchar(30) not null unique
)
create table ventas(
	ID tinyint not null primary key identity(1,1),
	idCanal tinyint not null foreign key references canales(ID),
	idPago tinyint not null foreign key references pagos(ID),
	fecha date not null,
	montoTotal money not null,
	pos tinyint not null foreign key references pos(pos),
)
create table productos_x_venta(
	idVenta tinyint not null foreign key references ventas(ID),
	UPCproducto varchar(10) not null foreign key references productos(UPC),
	cantidad tinyint not null check (cantidad>0)
)
create table pedidos(
	ID int not null primary key identity(1,1),
	cuitProveedor int not null foreign key references proveedores(cuit),
	UPCproducto varchar(10) not null foreign key references productos(UPC),
	cantidad tinyint not null check (cantidad>0),
	fechaInicio date not null,
	fechaEntrega date not null,
	entregado bit null
)