use master
go
alter database TMPKM_UNIVER
add file
	(
	name = N'FACULTY', filename = 'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\FACULTY.mdf',
	size = 10Mb, maxsize = 30Mb, filegrowth = 1Mb
	),
	(
	name = N'FACULTY', filename = 'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\FACULTY.ndf',
	size = 10Mb, maxsize = 30Mb, filegrowth = 10%
	),
	(
	name = N'AUDITORIUM_TYPE', filename = 'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\AUDITORIUM_TYPE.mdf',
	size = 10Mb, maxsize = 30Mb, filegrowth = 1Mb
	),
		(
	name = N'AUDITORIUM_TYPE', filename = 'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\AUDITORIUM_TYPE.ndf',
	size = 10Mb, maxsize = 30Mb, filegrowth = 10%
	),
	(
	name = N'PROFESSION', filename = 'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\PROFESSION.mdf',
	size = 10Mb, maxsize = 30Mb, filegrowth = 1Mb
	),
	(
	name = N'PROFESSION', filename = 'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\PROFESSION.ndf',
	size = 10Mb, maxsize = 30Mb, filegrowth = 10%
	)to FILEGROUP [PRIMARY]
	