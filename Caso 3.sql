if not exists(select * from sys.sysdatabases where name='PruebaPromerica')
begin
	create database PruebaPromerica
end
go
use PruebaPromerica
go

--tablas
/*
los datos para prueba estan en la parte inferior del archivo
*/
Create table Proyecto(
	Proyecto int identity ,
	Nombre varchar(50) not null,
	constraint PK_Proyecto primary key (Proyecto),
	constraint  UQ_Proyecto_Nombre unique(Proyecto,Nombre)
)
go
Create table Tipo(
	Cod_Tipo int identity,
	Nombre varchar(50) not null,
	constraint PK_Tipo_Cod_Tipo primary key(Cod_Tipo),
	constraint UQ_Tipo_Cod_Tipo_Nombre unique(Cod_Tipo,Nombre)
)
go
Create table Tipo_Informacion(
	Cod_Tipo_Informacion int identity,
	Nombre varchar(50) not null,
	constraint PK_Tipo_Informacion_Cod_Tipo_Informacion primary key(Cod_Tipo_Informacion),
	constraint UQ_Tipo_Informacion_Cod_Tipo_Nombre unique(Cod_Tipo_Informacion,Nombre)
)
go
Create table Producto(
	Producto int identity,
	Descripcion varchar(200) not null,
	constraint PK_Producto primary key(Producto),
	constraint UQ_Producto_Descripcion unique(Producto,Descripcion)
)
go
create table Producto_Proyecto(
	Proyecto int constraint FK_Producto_Proyecto_Proyecto references Proyecto,
	Producto int constraint FK_Producto_Proyecto_Producto references Producto,
	constraint PK_Producto_Proyecto primary key(Proyecto,Producto)
)
go
create table Formato_Mensaje(
	Cod_Formato int,
	Cod_Tipo int NOT NULL constraint FK_Formato_Mensaje_Cod_Tipo references Tipo,
	Cod_Tipo_Informacion int NOT NULL constraint FK_Formato_Mensaje_Cod_Tipo_Informacion  references Tipo_Informacion,
	Nombre varchar(100) not null,
	Remitente varchar(50) not null,
	Asunto varchar(50) not null,
	constraint PK_Formato_Mensaje primary key(Cod_Formato)
)
go
Create table Mensaje (
	Cod_Mensaje int,
	Cod_Formato int constraint FK_Mensaje_Cod_Formato references Formato_Mensaje,
	Proyecto int ,
	Producto int ,
	Constraint FK_Mensaje_ProyectoProducto foreign key(Proyecto,Producto) references Producto_Proyecto
)

--consulta
--A) proyecto y producto con codigo proyecto 1
select proy.Nombre,prod.Descripcion from Proyecto proy
inner join Producto_Proyecto pp on proy.Proyecto=pp.Proyecto
inner join Producto prod on pp.Producto = prod.Producto
where proy.Proyecto=1

--B) distinto mensaje que hay, con proyecto y producto 
select proy.Nombre,prod.Descripcion,fmen.Nombre from Mensaje men
inner join Formato_Mensaje fmen on fmen.Cod_Formato= men.Cod_Formato
INNER JOIN Producto_Proyecto PP ON PP.Producto=men.Producto and pp.Proyecto=men.Proyecto
inner join Proyecto proy on proy.Proyecto=pp.Proyecto
inner join Producto prod on prod.Producto=pp.Producto

--c) distintos mensajes que hay
--tabla de proyecto con producto sin mensaje
	begin
		declare @tableSinMensaje table(Proyecto int not null,Producto int not null)
		
		--insercion de proyecto con mensaje faltantes
		insert into @tableSinMensaje(Proyecto,Producto)
			(select pp.Proyecto,pp.Producto from Producto_Proyecto pp
			inner join Proyecto p on pp.Proyecto=p.Proyecto 
			left join Mensaje m on m.Producto = pp.Producto AND M.Proyecto=P.Proyecto
			where m.Cod_Mensaje is null
			group by pp.Proyecto,pp.Producto)

	--todos los proyecto que ya se enviaro
	--consulta de proyecto donde no esta todos los productos con mensaje
		select distinct proy.Nombre,prod.Descripcion,fmen.Nombre from Mensaje men
		inner join Formato_Mensaje fmen on fmen.Cod_Formato= men.Cod_Formato
		INNER JOIN Producto_Proyecto PP ON PP.Producto=men.Producto and pp.Proyecto=men.Proyecto
		inner join Proyecto proy on proy.Proyecto=pp.Proyecto
		inner join Producto prod on prod.Producto=pp.Producto
		left join @tableSinMensaje tsm on tsm.Proyecto =pp.Proyecto
		where tsm.Producto is null
		group by proy.Nombre,prod.Descripcion,fmen.Nombre
		union all
		--los que tiene todo los producto con mensaje
		select proy.Nombre,'TODOS' Producto,fmen.Nombre from Mensaje men
		inner join Formato_Mensaje fmen on fmen.Cod_Formato= men.Cod_Formato
		INNER JOIN Producto_Proyecto PP ON PP.Producto=men.Producto and pp.Proyecto=men.Proyecto
		inner join Proyecto proy on proy.Proyecto=pp.Proyecto
		inner join Producto prod on prod.Producto=pp.Producto
		inner join @tableSinMensaje tsm on  tsm.Proyecto =pp.Proyecto
		group by proy.Nombre,fmen.Nombre

	end




---datos
GO
SET IDENTITY_INSERT [dbo].[Proyecto] ON 
GO
INSERT [dbo].[Proyecto] ([Proyecto], [Nombre]) VALUES (1, N'Primia')
GO
INSERT [dbo].[Proyecto] ([Proyecto], [Nombre]) VALUES (2, N'Konmia')
GO
INSERT [dbo].[Proyecto] ([Proyecto], [Nombre]) VALUES (3, N'Yujule')
GO
SET IDENTITY_INSERT [dbo].[Proyecto] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 
GO
INSERT [dbo].[Producto] ([Producto], [Descripcion]) VALUES (1, N'Primia Clasica')
GO
INSERT [dbo].[Producto] ([Producto], [Descripcion]) VALUES (2, N'Premia Oro')
GO
INSERT [dbo].[Producto] ([Producto], [Descripcion]) VALUES (3, N'Premia Platinum')
GO
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
INSERT [dbo].[Producto_Proyecto] ([Proyecto], [Producto]) VALUES (1, 1)
GO
INSERT [dbo].[Producto_Proyecto] ([Proyecto], [Producto]) VALUES (1, 2)
GO
INSERT [dbo].[Producto_Proyecto] ([Proyecto], [Producto]) VALUES (1, 3)
GO
INSERT [dbo].[Producto_Proyecto] ([Proyecto], [Producto]) VALUES (2, 2)
GO
INSERT [dbo].[Producto_Proyecto] ([Proyecto], [Producto]) VALUES (2, 3)
GO
SET IDENTITY_INSERT [dbo].[Tipo] ON 
GO
INSERT [dbo].[Tipo] ([Cod_Tipo], [Nombre]) VALUES (1, N'Mensaje Texto')
GO
INSERT [dbo].[Tipo] ([Cod_Tipo], [Nombre]) VALUES (2, N'Mail')
GO
INSERT [dbo].[Tipo] ([Cod_Tipo], [Nombre]) VALUES (3, N'Mensaje en el estado de cuenta')
GO
SET IDENTITY_INSERT [dbo].[Tipo] OFF
GO
SET IDENTITY_INSERT [dbo].[Tipo_Informacion] ON 
GO
INSERT [dbo].[Tipo_Informacion] ([Cod_Tipo_Informacion], [Nombre]) VALUES (1, N'Mensaje de Bienvenida')
GO
INSERT [dbo].[Tipo_Informacion] ([Cod_Tipo_Informacion], [Nombre]) VALUES (2, N'Mensaje de mora')
GO
INSERT [dbo].[Tipo_Informacion] ([Cod_Tipo_Informacion], [Nombre]) VALUES (3, N'Mensaje de promocion')
GO
SET IDENTITY_INSERT [dbo].[Tipo_Informacion] OFF
GO
INSERT [dbo].[Formato_Mensaje] ([Cod_Formato], [Cod_Tipo], [Cod_Tipo_Informacion], [Nombre], [Remitente], [Asunto]) VALUES (1, 1, 1, N'MENSAJE DE BIENVENIDA', N'BANCO PROMERICA', N'BIENVENIDA AL CLUB')
GO
INSERT [dbo].[Formato_Mensaje] ([Cod_Formato], [Cod_Tipo], [Cod_Tipo_Informacion], [Nombre], [Remitente], [Asunto]) VALUES (2, 1, 2, N'MORA', N'GERENCIA', N'PAGOS PENDIENTES')
GO
INSERT [dbo].[Formato_Mensaje] ([Cod_Formato], [Cod_Tipo], [Cod_Tipo_Informacion], [Nombre], [Remitente], [Asunto]) VALUES (3, 1, 3, N'PROMOCIONES', N'ADMINISTRACION', N'PROMOCIONES DEL MES')
GO
INSERT [dbo].[Mensaje] ([Cod_Mensaje], [Cod_Formato], [Proyecto], [Producto]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[Mensaje] ([Cod_Mensaje], [Cod_Formato], [Proyecto], [Producto]) VALUES (2, 2, 1, 1)
GO
INSERT [dbo].[Mensaje] ([Cod_Mensaje], [Cod_Formato], [Proyecto], [Producto]) VALUES (3, 1, 1, 2)
GO
INSERT [dbo].[Mensaje] ([Cod_Mensaje], [Cod_Formato], [Proyecto], [Producto]) VALUES (4, 1, 2, 2)
GO
INSERT [dbo].[Mensaje] ([Cod_Mensaje], [Cod_Formato], [Proyecto], [Producto]) VALUES (5, 2, 2, 3)
GO
INSERT [dbo].[Mensaje] ([Cod_Mensaje], [Cod_Formato], [Proyecto], [Producto]) VALUES (6, 1, 2, 3)
GO