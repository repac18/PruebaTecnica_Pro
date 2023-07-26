if not exists(select * from sys.sysdatabases where name='PruebaPromerica')
begin
	create database PruebaPromerica
end
go
use PruebaPromerica
go
--tabla para manipular
Create table DatosManipular(
	Id int identity,
	Nombre varchar(50) null
)
go
---insertar datos aleatorios
begin
	declare @contador int= 0;

	declare @nombres table (Id int,Nombre varchar(50),Apellido varchar(50));
	insert @nombres (Id,Nombre,Apellido)
		values(1,'Joaquin','Nieto'),
			(2,'Pablo','Alvarez'),
			(3,'María ','Delgado'),
			(4,'Roberto','Moreno'),
			(5,'Daniel','Pastor'),
			(6,'Hector','Suarez'),
			(7,'Jose','Soledad'),
			(8,'Yolanda','Morales'),
			(9,'Felix','Castillo')

 
	while @contador <78
	begin
		declare @rondNombre int =(select floor(rand()*(9-1)+1));
		declare @rondApellido int =(select floor(rand()*(9-1)+1));

		insert DatosManipular(Nombre)
		values(concat((select nom.Nombre from @nombres nom where nom.Id=@rondNombre), ' ',
		(select nom.Apellido from @nombres nom where nom.Id=@rondApellido)
		) );
		set @contador=@contador+1
	end

end

