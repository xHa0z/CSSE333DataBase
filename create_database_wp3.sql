create database wp3
on
	primary (name = Wp3Data,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.TITAN\MSSQL\DATA\wp3.mdf ',
	SIZE = 10 MB,
	MAXSIZE = 25 MB,	
	FILEGROWTH = 20%
	)
LOG on
	(name = Wp3Log,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.TITAN\MSSQL\DATA\wp3.ldf ',
	SIZE = 3MB,
	MAXSIZE = 10MB,
	FILEGROWTH = 1 MB


	)
Collate SQL_latin1_General_Cp1_CI_AS









