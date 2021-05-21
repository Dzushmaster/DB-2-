use TMPKM_UNIVER;

--1
DECLARE subjects cursor for select SUBJECT_.SUBJECT_ from SUBJECT_ where PULPIT = 'ИСиТ';
DECLARE @subjects_name nchar(10), @allSubjects nvarchar(600) ='';
OPEN subjects;
FETCH subjects into @subjects_name;
print '----------------- Subject 1 -----------------' + char(13)
print 'Subjects at the department of ISiT: ';
while @@FETCH_STATUS = 0
begin
	set @allSubjects = RTRIM(@subjects_name) + ',' + @allSubjects;
	FETCH subjects into @subjects_name;
end;
print @allSubjects + char(13);
CLOSE subjects;
DEALLOCATE subjects;
go


--2
DECLARE @Names nvarchar(40) = '', @index int = 0;
DECLARE Students_names CURSOR LOCAL for select STUDENT.FATHER_NAME from STUDENT;
OPEN Students_names;
FETCH Students_names into @Names;
print '----------------- Subject 2 -----------------' + char(13)
while @@FETCH_STATUS = 0
begin
	SET @index +=1;
	print 'Student number ' + cast(@index as varchar(5)) + ': ' + @Names + char(13);
	FETCH Students_names into @Names;
end

go
DECLARE @Names nvarchar(40) = '', @index int = 0;
FETCH Students_names into @Names;
while @@FETCH_STATUS = 0
begin
	SET @index +=1;
	print 'Student number ' + cast(@index as varchar(5)) + ': ' + @Names + char(13);
	FETCH Students_names into @Names;
end
CLOSE Students_names;
GO
--global
print '----------------- GLOBAL -----------------' + char(13)
DECLARE @Names nvarchar(40) = '', @index int = 0;
DECLARE Students_names CURSOR GLOBAL for select STUDENT.FATHER_NAME from STUDENT;
OPEN Students_names;
FETCH Students_names into @Names;
while @@FETCH_STATUS = 0
begin
	SET @index +=1;
	print 'Student number ' + cast(@index as varchar(5)) + ': ' + @Names + char(13);
	FETCH Students_names into @Names;
end
go
DECLARE @Names nvarchar(40) = '', @index int = 0;
FETCH Students_names into @Names;

while @@FETCH_STATUS = 0
begin
	SET @index +=1;
	print 'Student number ' + cast(@index as varchar(5)) + ': ' + @Names + char(13);
	FETCH Students_names into @Names;
end
CLOSE Students_names;
DEALLOCATE Students_names;
go
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '200-2a';


--3
DECLARE @Auditorium_Type nvarchar(8), @Auditorium_number nvarchar(8), @Auditorium_capacity int;
DECLARE Auditoriums CURSOR LOCAL STATIC for select AUDITORIUM_TYPE, AUDITORIUM, AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК';
OPEN Auditoriums;
print '----------------- Subject 3 -----------------' + char(13)
SET nocount on;
print 'Numbers rows:' + cast(@@CURSOR_ROWS as varchar(5));
insert into AUDITORIUM(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_NAME)
	values('200-2a',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'ЛК'),'200-2a'),
	('100-2a',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'ЛК'),'100-2a'),
	('300-2a',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'ЛК'),'300-2a');
	delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '300-2a';
	update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 90 where AUDITORIUM.AUDITORIUM_CAPACITY <15;
	--delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '100-2a' or AUDITORIUM.AUDITORIUM = '200-2a';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'ЛК';
FETCH Auditoriums into @Auditorium_Type, @Auditorium_number, @Auditorium_capacity;
while @@FETCH_STATUS = 0
begin
	print @Auditorium_Type + ' ' + @Auditorium_number + ' ' + cast(@Auditorium_capacity as varchar(5)) + char(13); 
	FETCH Auditoriums into @Auditorium_Type, @Auditorium_number, @Auditorium_capacity;
end
CLOSE Auditoriums;
go


--4
print '----------------- Subject 4 -----------------' + char(13)
DECLARE @RowNumber int = 0, @SecondName nvarchar(20) = '';
DECLARE Scrolls CURSOR LOCAL DYNAMIC SCROLL 
for select row_number() over(order by STUDENT.SECOND_NAME) S, STUDENT.SECOND_NAME
from dbo.STUDENT
OPEN Scrolls;
FETCH FIRST from Scrolls into @RowNumber, @SecondName;
print 'First row: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);

FETCH NEXT from Scrolls into @RowNumber, @SecondName;
print 'Next row: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);

FETCH PRIOR from Scrolls into @RowNumber, @SecondName;
print 'Prior row: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);

FETCH LAST from Scrolls into @RowNumber, @SecondName;
print 'Last row: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);

FETCH ABSOLUTE 2 from Scrolls into  @RowNumber, @SecondName;
print 'The second row: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);

FETCH  ABSOLUTE -4 from Scrolls into @RowNumber, @SecondName;
print 'The fourth row from end: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);

FETCH RELATIVE 2 from Scrolls into  @RowNumber, @SecondName;
print 'The second row after current: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);

FETCH  RELATIVE -2 from Scrolls into @RowNumber, @SecondName;
print 'The second row before current: ' + cast(@RowNumber as nvarchar(8)) + ' ' + @SecondName + char(13);
CLOSE Scrolls;
go


--5
print '----------------- Subject 5 -----------------' + char(13)
select * from AUDITORIUM;
DECLARE @Auditorium_Type nvarchar(8), @Auditorium_number nvarchar(8), @Auditorium_capacity int;
DECLARE Auditoriums CURSOR LOCAL DYNAMIC for select AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM;
OPEN Auditoriums;
FETCH Auditoriums into @Auditorium_Type, @Auditorium_number, @Auditorium_capacity;
while @@FETCH_STATUS = 0
begin
	if @Auditorium_capacity<15
		UPDATE AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 90 where CURRENT OF Auditoriums;
	if @Auditorium_number = '100-2a' or @Auditorium_number = '200-2a'
	DELETE AUDITORIUM where CURRENT OF Auditoriums;
	FETCH Auditoriums into @Auditorium_Type, @Auditorium_number, @Auditorium_capacity;
end
select * from AUDITORIUM;
CLOSE Auditoriums;


--6
print '----------------- Subject 6 -----------------' + char(13)
use TMPKM_UNIVER;
insert into PROGRESS (PROGRESS.SUBJECT_, PROGRESS.IDSTUDENT, PROGRESS.PDATE, PROGRESS.NOTE)
	values ((select SUBJECT_ from SUBJECT_ where SUBJECT_ = 'ОАиП'),(select STUDENT.IDSTUDENT from STUDENT where STUDENT.IDSTUDENT = 1000),'2014-01-12',3),
		   ((select SUBJECT_ from SUBJECT_ where SUBJECT_ = 'БД'),(select STUDENT.IDSTUDENT from STUDENT where STUDENT.IDSTUDENT = 1005),'2014-01-15',3)
select PROGRESS.NOTE, STUDENT.IDSTUDENT from 
PROGRESS JOIN STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN GROUP_ on GROUP_.IDGROUP = STUDENT.IDGROUP;

DECLARE @Progress_Note int = 0, @ID_Student int = 0;
DECLARE Students CURSOR LOCAL DYNAMIC for select PROGRESS.NOTE, STUDENT.IDSTUDENT from
PROGRESS join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT 
join GROUP_ on GROUP_.IDGROUP = STUDENT.IDGROUP;
OPEN Students;
FETCH Students into @Progress_Note, @ID_Student;
while @@FETCH_STATUS = 0
begin
	if @Progress_Note < 4
		delete PROGRESS where CURRENT OF Students;
	FETCH Students into @Progress_Note, @ID_Student;
end
CLOSE Students;
select PROGRESS.NOTE, STUDENT.IDSTUDENT from 
PROGRESS JOIN STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN GROUP_ on GROUP_.IDGROUP = STUDENT.IDGROUP;

select PROGRESS.NOTE, STUDENT.IDSTUDENT from 
PROGRESS JOIN STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN GROUP_ on GROUP_.IDGROUP = STUDENT.IDGROUP;
--
go
--
select PROGRESS.NOTE, STUDENT.IDSTUDENT from 
PROGRESS JOIN STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN GROUP_ on GROUP_.IDGROUP = STUDENT.IDGROUP;

DECLARE @Progress_Note int = 0, @ID_Student int = 0;
DECLARE Students CURSOR LOCAL DYNAMIC for select PROGRESS.NOTE, STUDENT.IDSTUDENT from
PROGRESS join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT 
join GROUP_ on GROUP_.IDGROUP = STUDENT.IDGROUP;
OPEN Students;
FETCH Students into @Progress_Note, @ID_Student;
while @@FETCH_STATUS = 0
begin
	if @ID_Student = 1001
		update PROGRESS SET PROGRESS.NOTE +=1 where CURRENT OF Students;
	FETCH Students into @Progress_Note, @ID_Student;
end
CLOSE Students;
select PROGRESS.NOTE, STUDENT.IDSTUDENT from 
PROGRESS JOIN STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN GROUP_ on GROUP_.IDGROUP = STUDENT.IDGROUP;


--7
go
USE K_MyBase;
DECLARE products cursor for select Products.Product_name, cast(Products.Cost as varchar(3)) from Products where Products.Cost >20;
DECLARE @products_name nchar(10), @Products nvarchar(600) ='', @product_cost int, @allCosts nvarchar(600) = '';
OPEN products;
FETCH products into @products_name, @product_cost;
print '----------------- Subject 7 -----------------' + char(13)
print 'Subjects at the department of ISiT: ';
while @@FETCH_STATUS = 0
begin
	set @Products = RTRIM(@products_name) + ',' + @Products;
	set @allCosts = RTRIM(@product_cost) + ',' + @allCosts;
	FETCH products into @products_name, @product_cost;
end;
print @Products + char(13) + @allCosts +char(13);
CLOSE products;
DEALLOCATE products;
go

print '----------------- Subject 8 -----------------' + char(13)
use TMPKM_UNIVER;
--8
GO
use TMPKM_UNIVER;
DECLARE @Faculty nvarchar(10) = '', @Pulpit nvarchar(15) = '', @CountTeacher int, @Subject nvarchar(10) = '';
DECLARE Faculties CURSOR LOCAL STATIC for
select FACULTY.FACULTY, PULPIT.PULPIT, COUNT(TEACHER.TEACHER),  ISNULL (SUBJECT_.SUBJECT_, 'Нет')  FROM 
FACULTY JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
left JOIN SUBJECT_ ON SUBJECT_.PULPIT = PULPIT.PULPIT
GROUP BY SUBJECT_.SUBJECT_, PULPIT.PULPIT , FACULTY.FACULTY;
OPEN Faculties;
FETCH Faculties into @Faculty, @Pulpit, @CountTeacher, @Subject;
DECLARE @PriorFaculty nvarchar(10) = '', @PriorPulpit nvarchar(15) = '', @PriorCountTeacher int = -2, @PriorSubject nvarchar(10) = '';
WHILE @@FETCH_STATUS = 0
begin
	if(@Faculty != @PriorFaculty) 
		print 'Факультет: ' + @Faculty + char(13);
	if(@Pulpit != @PriorPulpit) 
		print space(5) + 'Кафедра:' + @Pulpit + char(13);
	if(@CountTeacher != @PriorCountTeacher)
	begin
		print space(7) + 'Количество преводавателей: ' + cast(@CountTeacher as varchar(10)) + char(13) + space(7);
		print space(7) + 'Дисциплины: ';
	end
	print replace(@Subject ,char(13), '') + ',';
	SET @PriorFaculty = @Faculty; SET @PriorPulpit = @Pulpit; SET @PriorCountTeacher = @CountTeacher; SET @PriorSubject = @Subject;
	FETCH Faculties into @Faculty, @Pulpit, @CountTeacher, @Subject;
end
CLOSE Faculties;

