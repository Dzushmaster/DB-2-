use master 
go 
create database K_UNIVER

on primary
( 
	name = N'K_UNIVER_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\K_UNIVER.mdf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 1Mb
),
(
	name = N'K_UNIVER_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\K_UNIVER.ndf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 10%
),
filegroup G1
(
	name = N'K_UNIVER11_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\K_UNIVER11.ndf',
	size = 10Mb, maxsize = 15Mb, filegrowth = 1Mb
),
(
	name = N'K_UNIVER12_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\K_UNIVER12.ndf',
	size = 2Mb, maxsize = 5Mb, filegrowth = 1Mb
),
filegroup G2
(
	name = N'K_UNIVER21_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\K_UNIVER21.ndf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 1Mb
),
(
	name = N'K_UNIVER22_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\K_UNIVER22.ndf',
	size = 2Mb, maxsize = 5Mb, filegrowth = 1Mb
)
log on
(
	name = N'K_UNIVER_log', filename = N'D:\Labs\Data_Bases\Lab_4\Files\K_UNIVER_log.ldf',
	size = 5Mb, maxsize = UNLIMITED, filegrowth = 1Mb
)
use K_UNIVER;
CREATE TABLE acr_myTable(
    Id bigint NOT NULL,
    label nvarchar(max) NOT NULL,
)on G1;