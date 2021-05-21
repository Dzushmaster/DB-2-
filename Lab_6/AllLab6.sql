use TMPKM_UNIVER;
go
--1
select p.PULPIT_NAME, pr.PROFESSION_NAME from PULPIT as p,PROFESSION as pr, FACULTY as f 
where p.FACULTY = f.FACULTY 
AND pr.PROFESSION_NAME IN(SELECT pr.PROFESSION_NAME from PROFESSION where pr.PROFESSION_NAME LIKE('%����������%') OR pr.PROFESSION_NAME LIKE('%����������%'));

go
--2
select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME from PULPIT join FACULTY
on PULPIT.FACULTY = FACULTY.FACULTY 
join PROFESSION on PROFESSION.FACULTY = PULPIT.FACULTY
where PROFESSION.PROFESSION_NAME in(select 
PROFESSION.PROFESSION_NAME from PROFESSION where PROFESSION.PROFESSION_NAME LIKE('%����������%') OR PROFESSION.PROFESSION_NAME LIKE('%����������%'));

go
--3
select PULPIT.PULPIT_NAME, PROFESSION.PROFESSION_NAME from PULPIT join FACULTY
ON PULPIT.FACULTY = FACULTY.FACULTY
JOIN PROFESSION 
ON PROFESSION.FACULTY  = FACULTY.FACULTY
where PROFESSION.PROFESSION_NAME LIKE('%����������%') OR PROFESSION.PROFESSION_NAME LIKE('%����������%');

go
--4
select * from AUDITORIUM join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE ORDER BY AUDITORIUM.AUDITORIUM_CAPACITY DESC)

go
--5
select FACULTY.FACULTY_NAME from FACULTY
where NOT EXISTS (select * from PULPIT  where PULPIT.FACULTY = FACULTY.FACULTY)

go
--6
select top 1
(select avg(PROGRESS.NOTE) from PROGRESS where PROGRESS.SUBJECT_ like '����%')[OAiP], 
(select avg(PROGRESS.NOTE) from PROGRESS where PROGRESS.SUBJECT_ like '��%')[Data bases], 
(select avg(PROGRESS.NOTE) from PROGRESS where PROGRESS.SUBJECT_ like '����%')[SUBD]
from PROGRESS;

go
--7
select * from PROGRESS 
where PROGRESS.NOTE >=ALL(select PROGRESS.NOTE from PROGRESS where PROGRESS.SUBJECT_ like '��%'); 

go
--8
select * from PROGRESS 
where PROGRESS.NOTE-1 >=ANY(select PROGRESS.NOTE from PROGRESS where PROGRESS.SUBJECT_ like '����%'); 

go
--10
select IDSTUDENT, IDGROUP, SECOND_NAME, FIRST_NAME, FATHER_NAME, BDAY from STUDENT as STUDENT1
where EXISTS (select STUDENT2.BDAY, STUDENT2.FATHER_NAME, STUDENT2.FIRST_NAME, STUDENT2.SECOND_NAME from STUDENT as STUDENT2 where (DAY(STUDENT1.BDAY) = DAY(STUDENT2.BDAY) AND MONTH(STUDENT1.BDAY) = MONTH(STUDENT2.BDAY) AND STUDENT1.IDSTUDENT <> STUDENT2.IDSTUDENT))