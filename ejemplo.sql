create database ejemplo
use ejemplo
--
create table areas(
id smallint not null primary key identity(1000,1),
nombre varchar(50) not null,
presupuesto money not null check(presupuesto>0),
mail varchar(100) not null
)

create table empleados(
legajo bigint not null primary key identity(1,1),
apellido varchar(100) not null,
nombre varchar(100) not null,
mail varchar(100) not null unique,
telefono varchar(20) null,
fechaNac date not null,
sueldo money not null check (sueldo>0),
idArea smallint not null foreign key references areas(id)
)