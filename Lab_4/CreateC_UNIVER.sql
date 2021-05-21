create database TMPKM_UNIVER;
GO
use TMPKM_UNIVER;
go
create table FACULTY(
						FACULTY nchar(10) NOT NULL primary key,
						FACULTY_NAME nvarchar(50) default '???');
GO
create table PROFESSION(
						PROFESSION nchar(20) NOT NULL primary key,
						FACULTY nchar(10) NOT NULL foreign key references FACULTY(FACULTY),
						PROFESSION_NAME nvarchar(100) NOT NULL,
						QUALIFICATION nvarchar(50) NOT NULL
						);
GO
create table PULPIT(
						PULPIT nchar(20) NOT NULL primary key,
						PULPIT_NAME nvarchar(100) NULL,
						FACULTY nchar(10) NOT NULL foreign key references FACULTY(FACULTY)
						);
GO
create table TEACHER(	
						TEACHER nchar(10) NOT NULL primary key,
						SECOND_NAME nvarchar(35) NULL ,
						FIRST_NAME nvarchar(35) NULL,
						FATHER_NAME nvarchar(35) NULL,
						GENDER nchar(1) check (GENDER in ('ì','æ')),
						PULPIT nchar(20) NOT NULL foreign key references PULPIT(PULPIT)
						);
GO
create table SUBJECT_(
						SUBJECT_ nchar(10) NOT NULL primary key,
						SUBJECT_NAME nvarchar(100) NULL UNIQUE,
						PULPIT nchar(20) NOT NULL foreign key references PULPIT(PULPIT)
						);
GO
create table AUDITORIUM_TYPE(
						AUDITORIUM_TYPE nchar(10) NOT NULL primary key,
						AUDITORIUM_TYPENAME nvarchar(30) NULL
						);
GO
create table AUDITORIUM(
						AUDITORIUM nchar(20) NOT NULL primary key,
						AUDITORIUM_TYPE nchar(10) NOT NULL foreign key references AUDITORIUM_TYPE(AUDITORIUM_TYPE),
						AUDITORIUM_CAPACITY int default 1 check (AUDITORIUM_CAPACITY between 1 and 300),
						AUDITORIUM_NAME nvarchar(50) NULL
						);
GO
create table GROUP_(
					IDGROUP int NOT NULL primary key,
					FACULTY nchar(10) NOT NULL foreign key references FACULTY(FACULTY),
					PROFESSION nchar(20) NOT NULL foreign key references PROFESSION(PROFESSION),
					YEAR_FIRST smallint check(YEAR_FIRST< (CONVERT(smallint,YEAR(GETDATE()) )+2) ),
					COURSE as (YEAR(GETDATE()) - YEAR_FIRST) 
					);
GO
create table STUDENT(
					 IDSTUDENT int identity(1000,1) primary key,
					 IDGROUP int NOT NULL foreign key references GROUP_(IDGROUP),
					 SECOND_NAME nvarchar(100),
					 FIRST_NAME nvarchar(100),
					 FATHER_NAME nvarchar(100),
					 BDAY date,
					 STAMP timestamp,
					 INFO xml default NULL,
					 FOTO varbinary(max) default NULL
					 );
GO
create table PROGRESS(
					 SUBJECT_ nchar(10) foreign key references SUBJECT_(SUBJECT_),
					 IDSTUDENT int foreign key references STUDENT(IDSTUDENT),
					 PDATE date,
					 NOTE int check(NOTE between 1 and 10)
					  );