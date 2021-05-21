use master 
go 
create database TMPKM_UNIVER
on primary
( 
	name = N'FACULTY_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\FACULTY.mdf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 1Mb
),
(
	name = N'FACULTY_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\FACULTY.ndf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 10%
),
( 
	name = N'AUDITORIUM_TYPE_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\AUDITORIUM_TYPE.mdf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 1Mb
),
(
	name = N'AUDITORIUM_TYPE_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\AUDITORIUM_TYPE.ndf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 10%
),
( 
	name = N'PROFESSION_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\PROFESSION.mdf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 1Mb
),
(
	name = N'PROFESSION_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\PROFESSION.ndf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 10%
),

filegroup G1
(
	name = N'PULPIT_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\PULPIT.mdf',
	size = 10Mb, maxsize = 15Mb, filegrowth = 1Mb
),
(
	name = N'PULPIT_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\PULPIT.ndf',
	size = 2Mb, maxsize = 5Mb, filegrowth = 1Mb
),
(
	name = N'SUBJECT_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\SUBJECT.mdf',
	size = 10Mb, maxsize = 15Mb, filegrowth = 1Mb
),
(
	name = N'SUBJECT_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\SUBJECT.ndf',
	size = 2Mb, maxsize = 5Mb, filegrowth = 1Mb
),
(
	name = N'GROUPS_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\GROUPS.mdf',
	size = 10Mb, maxsize = 15Mb, filegrowth = 1Mb
),
(
	name = N'GROUPS_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\GROUPS.ndf',
	size = 2Mb, maxsize = 5Mb, filegrowth = 1Mb
),
(
	name = N'TEACHER_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\TEACHER.mdf',
	size = 10Mb, maxsize = 15Mb, filegrowth = 1Mb
),
(
	name = N'TEACHER_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\TEACHER.ndf',
	size = 2Mb, maxsize = 5Mb, filegrowth = 1Mb
),
filegroup G2
(
	name = N'AUDITORIUM_mdf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\AUDITORIUM.mdf',
	size = 5Mb, maxsize = 10Mb, filegrowth = 1Mb
),
(
	name = N'AUDITORIUM_ndf', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\AUDITORIUM.ndf',
	size = 2Mb, maxsize = 5Mb, filegrowth = 1Mb
)
log on
(
	name = N'Logger', filename = N'D:\Labs\Data_Bases\Lab_4\Files\Univers_files\Logger.ldf',
	size = 5Mb, maxsize = UNLIMITED, filegrowth = 1Mb
)