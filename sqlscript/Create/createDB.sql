create database wpwpwp
on
primary (name = WpwpwpData,
  FILENAME = 'C:\Program Files\ProgramMicrosoft SQL Server\MSSQL11.TITAN\MSSQL\DATA\wpwpwp.mdf ',
  SIZE = 10   MB,
  MAXSIZE = 25 MB,
  FILEGROWTH = 20%
)
LOG on
(name = WpwpwpLog,
  FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.TITAN\MSSQL\MSSQLDATA\wpwpwp.ldf ',
  SIZE = 3MB,
  MAXSIZE = 10MB,
  FILEGROWTH = 1 MB
 )
Collate SQL_latin1_General_Cp1_CI_AS









