use TMPKM_UNIVER;

--1
GO
create view [�������������] as 
select TEACHER.TEACHER[TeachersId],
TEACHER.SECOND_NAME[Teachers_secondName],
TEACHER.FIRST_NAME[Teachers_FirstName],
TEACHER.FATHER_NAME[Teachers_FatherName],
TEACHER.GENDER[Teachers_Gender],
TEACHER.PULPIT[Teachers_Pulpit] from TEACHER;
GO
select * from �������������;

--2
GO
create view [����������_������] as
select FACULTY.FACULTY_NAME[Faculty_name],
COUNT(PULPIT.PULPIT)[Cathedras_quantity]
from FACULTY join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
group by PULPIT.FACULTY, FACULTY.FACULTY_NAME
GO
select * from [����������_������]
go
--3
create view [���������] as
select AUDITORIUM.AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_NAME[������������ ���������],
AUDITORIUM.AUDITORIUM_TYPE[���_���������]
from AUDITORIUM;
go
insert into [���������](���,���_���������,[������������ ���������]) 
values('305-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = '��'),'305-1');
select * from [���������]
delete from [���������] where ���������.��� = '305-1';
go
--4
create view [����������_���������] as
select AUDITORIUM.AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_NAME[������������ ���������],
AUDITORIUM.AUDITORIUM_TYPE[���_���������]
from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE='��' with check option;
go
insert into [����������_���������](���,���_���������,[������������ ���������])
values('408-2',(select DISTINCT AUDITORIUM.AUDITORIUM_TYPE from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��'),'408-2')
	--('409-2',(select DISTINCT AUDITORIUM.AUDITORIUM_TYPE from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��-�'),'409-2');
select * from [����������_���������]

--5
go
create view ���������� as
select TOP 150 SUBJECT_.SUBJECT_, SUBJECT_.SUBJECT_NAME, SUBJECT_.PULPIT
from SUBJECT_ ORDER BY SUBJECT_.SUBJECT_NAME;
go
SELECT * FROM [����������]

--6
go
alter view [����������_������] WITH SCHEMABINDING
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
pivot( COUNT(T1.SUBJECT_) FOR T1.WEEKDAY_ IN ( [�����������],
[�������],
[�����],
[�������],
[�������],
[�������],
[�����������] )) as T2
