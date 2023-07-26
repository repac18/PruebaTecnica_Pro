if not exists(select * from sys.sysdatabases where name='PruebaPromerica')
begin
	create database PruebaPromerica
end
go
use PruebaPromerica
go

Create table Usuarios(
	Id int identity not null constraint PK_Usuarios primary key,
	UserName varchar(50) not null,
	Password varchar (50) not null
)

insert into Usuarios(UserName,Password)values('Edward','Pac')
