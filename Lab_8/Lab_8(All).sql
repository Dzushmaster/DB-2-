use TMPKM_UNIVER;

--1
GO
create view [Преподаватель] as 
select TEACHER.TEACHER[TeachersId],
TEACHER.SECOND_NAME[Teachers_secondName],
TEACHER.FIRST_NAME[Teachers_FirstName],
TEACHER.FATHER_NAME[Teachers_FatherName],
TEACHER.GENDER[Teachers_Gender],
TEACHER.PULPIT[Teachers_Pulpit] from TEACHER;
GO
select * from Преподаватель;

--2
GO
create view [Количество_кафедр] as
select FACULTY.FACULTY_NAME[Faculty_name],
COUNT(PULPIT.PULPIT)[Cathedras_quantity]
from FACULTY join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
group by PULPIT.FACULTY, FACULTY.FACULTY_NAME
GO
select * from [Количество_кафедр]
go
--3
create view [Аудитории] as
select AUDITORIUM.AUDITORIUM[Код],
AUDITORIUM.AUDITORIUM_NAME[Наименование аудитории],
AUDITORIUM.AUDITORIUM_TYPE[Тип_аудитории]
from AUDITORIUM;
go
insert into [Аудитории](Код,Тип_аудитории,[Наименование аудитории]) 
values('305-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'ЛК'),'305-1');
select * from [Аудитории]
delete from [Аудитории] where Аудитории.Код = '305-1';
go
--4
create view [Лекционные_аудитории] as
select AUDITORIUM.AUDITORIUM[Код],
AUDITORIUM.AUDITORIUM_NAME[Наименование аудитории],
AUDITORIUM.AUDITORIUM_TYPE[Тип_аудитории]
from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE='ЛК' with check option;
go
insert into [Лекционные_аудитории](Код,Тип_аудитории,[Наименование аудитории])
values('408-2',(select DISTINCT AUDITORIUM.AUDITORIUM_TYPE from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК'),'408-2')
	--('409-2',(select DISTINCT AUDITORIUM.AUDITORIUM_TYPE from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК-Б'),'409-2');
select * from [Лекционные_аудитории]

--5
go
create view Дисциплины as
select TOP 150 SUBJECT_.SUBJECT_, SUBJECT_.SUBJECT_NAME, SUBJECT_.PULPIT
from SUBJECT_ ORDER BY SUBJECT_.SUBJECT_NAME;
go
SELECT * FROM [Дисциплины]

--6
go
alter view [Количество_кафедр] WITH SCHEMABINDING
as select F.FACULTY_NAME[Faculty_name],
count(P.PULPIT)[Cathedras_quantity]
from dbo.FACULTY F JOIN dbo.PULPIT P on F.FACULTY = P.FACULTY
group by P.FACULTY, F.FACULTY_NAME
go

--7
use K_MyBase;
go
create view [K_View1]
as select count(Department.Department)[Count departments],
Department.Number_of_Employes
from Department
group by Department.Number_of_Employes
go
select * from [K_View1];
go

alter view [K_View1] WITH SCHEMABINDING
as select count(Department.Department)[Count departments],
Department.Number_of_Employes
from dbo.Department
group by Department.Number_of_Employes
go
--8
use TMPKM_UNIVER;
go
select * from (select T.IDGROUP, 
T.SUBJECT_,
T.WEEKDAY_
from TIMETABLE T) as T1
pivot( COUNT(T1.SUBJECT_) FOR T1.WEEKDAY_ IN ( [Понедельник],
[Вторник],
[Среда],
[Четверг],
[Пятница],
[Суббота],
[Воскресенье] )) as T2
