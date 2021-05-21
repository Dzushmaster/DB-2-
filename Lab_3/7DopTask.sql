use K_MyBase;
go
create table STUDENT
					(
						Student_number int identity(1000,1) primary key not null,
						SecondName nvarchar(20) not null,
						FirstName nvarchar(20) not null,
						FatherName nvarchar(20) not null,
						Date_Of_Birth date check(Date_Of_Birth < GetDate()) not null,
						Gender nchar(1) default 'ì' check(Gender in('ì','æ')),
						Receipt_date date check(Receipt_date <= GetDate()) not null
					)
go
insert into STUDENT (SecondName, FirstName, FatherName, Date_Of_Birth, Gender, Receipt_date)
		values
		('Woths','Natalie','Smit','2002-05-29','æ','2021-01-01'),
		('Gren','Ann','Oliver','2000-03-21','æ','2018-02-21'),
		('Black','Viktor','Oliver','1990-05-30','ì','2020-05-20'),
		('Relins','Smit','Oliver','1988-10-15','ì','2006-03-26'),
		('White','Valter','Oliver','1997-06-29','ì','2018-05-27'),
		('Klaus','Santa','Oliver','2000-03-09','ì','2021-02-05'),
		('Lipton','Tea','Oliver','1995-09-22','æ','2009-09-20')

select * from STUDENT;
select * from STUDENT where (Gender = 'æ' and ( (YEAR(Receipt_date) - YEAR(Date_Of_Birth)) >= 17 and (RIGHT(Date_Of_Birth,5)>RIGHT(Receipt_date,5))))
select * from STUDENT where (Gender = 'æ' and ( (YEAR(Receipt_date) - YEAR(Date_Of_Birth)) = 18))