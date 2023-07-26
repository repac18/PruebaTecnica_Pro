if not exists(select * from sys.sysdatabases where name='PruebaPromerica')
begin
	create database PruebaPromerica
end
go
use PruebaPromerica
go
/*
a) articulo => codigo,nombre,tipo,subtipo
b) existencia por sucursal
c) promociones => rango fecha vigencia,costo de punto y precio articulo
d) caje => IdArticulo, cantidad canjeada,precio articulo,promocion y observaciones
*/


Create table C_Tipo(
	Tipo int identity,
	Nombre varchar(50) not null,
	constraint PK_C_Tipo primary key(Tipo)
)
go
Create table C_SubTipo(
	SubTipo int,
	Nombre varchar(50) not null,
	constraint PK_C_SubTipo primary key(SubTipo)
)
go
Create table C_Articulo(
	Codigo int identity,
	nombre varchar(200) not null,
	Tipo int not null constraint FK_C_Articulo_Tipo references C_Tipo,
	SubTipo int not null constraint FK_C_Articulo_SubTipo references C_SubTipo
	constraint PK_C_Articulo primary key
)
go
Create table C_Sucursal(
	Codigo int identity,
	Nombre varchar(200) not null,
	constraint PK_C_Sucursal primary key(Codigo)
)
create table C_Sucursal_Existencia(
	Sucursal int not null constraint FK_C_Sucursal_Existencia_Sucursal references C_Sucursal,
	Articulo int not null constraint FK_C_Sucursal_Existencia_Articulo references C_Articulo,
	Cantidad int not null,
	constraint UQ_C_Sucursal_Existencia_Sucursal_Articulo unique(Sucursal,Articulo)
)
go
Create table C_Promocion(
	Cod_Promocion int identity,
	Nombre varchar(200) not null,
	Fecha_Inicio datetime not null,
	Fecha_Fin datetime not null,
	Activo bit not null,
	constraint PK_C_Promocion primary key (Cod_Promocion)
)
go
Create table C_Canje (
	Cod_Canje int identity constraint PK_C_Canje primary key,
	Articulo int not null constraint FK_C_Canje_Articulo references C_Articulo,
	Cantidad int not null,
	Precio decimal(10,2) not null,
	Promocion int not null constraint FK_C_Canje references C_Promocion,
	Observaciones varchar(500)
)
go
Create table C_Promocion_Articulo(
	Cod_Promocion_Articulo int identity,
	Cod_Promocion int not null Constraint FK_C_Promocion_Articulo_Promocion references C_Promocion,
	Cod_Canje int not null constraint FK_C_Promocion_Articulo_Cod_Canje references C_Canje, 
	Articulo  int not null constraint FK_C_Promocion_Articulo_Articulo references C_Articulo,
	Puntos int not null,
	Precio decimal(10,2) not null,
	constraint PK_Cod_Promocion_Articulo primary key(Cod_Promocion_Articulo)
)
go