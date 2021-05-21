use KAMINSKYUNIVER
go

CREATE table [dbo].RESULTS(
		ID int primary key identity(1,1),
		STUDENT_NAME nvarchar(50),
		MATH int,
		CHEMISTRY int,
		IT int,
		check (MATH>0 and CHEMISTRY>0 and IT>0), 
		AVER_VALUE as (MATH + CHEMISTRY + IT)/3
)

insert into RESULTS(STUDENT_NAME,MATH,CHEMISTRY,IT)
			values ('Artem', 5,7,10),
			('Nikita', 8,6,10),
			('Anna', 8,7,8),
			('Kirill', 5,5,5),
			('Alesya', 8,9,9)
