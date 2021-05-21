use TMPKM_UNIVER;

drop table TR_AUDIT;
--1
create table TR_AUDIT(
	ID int identity(1,1),
	STMT varchar(20)
		check (STMT in ('INS','DEL','UPD')),
	TRNAME varchar(50),
	CC varchar(200)
);
go
drop trigger TR_TEACHER_INS;
go
create trigger TR_TEACHER_INS
				on TEACHER after insert
as declare @teacher nchar(10), @secName nvarchar(35)
, @firstName nvarchar(35), @fathName nvarchar(35),
@gend  nchar(1), @pulp nchar(20), @all varchar(200); 
	print 'Операция вставки';
	set @teacher   = (select [TEACHER] from INSERTED);
	set @secName   = (select [SECOND_NAME] from INSERTED);
	set @firstName = (select [FIRST_NAME] from INSERTED);
	set @fathName  = (select [FATHER_NAME] from INSERTED);
	set @gend      = (select [GENDER] from INSERTED);
	set @pulp      = (select [PULPIT] from INSERTED);
	set @all	   = @teacher + ' ' + @secName + ' ' + 
	@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
	@pulp + ' ';
	insert into TR_AUDIT(STMT, TRNAME, CC)
		values('INS', 'TR_TEACHER', @all);
	return;
go
insert into TEACHER
	values('БНВ', 'Шиман', 'Дмитрий' ,'Васильевич', 'м', 'ИСиТ');
select * from TR_AUDIT;
delete from TEACHER where TEACHER.TEACHER = 'БНВ';
select * from TR_AUDIT where TR_AUDIT.STMT = 'INS';

--================================================================================================
--2
drop trigger TR_TEACHER_DEL;
go
create TRIGGER TR_TEACHER_DEL on TEACHER after DELETE
as declare @teacher nchar(10), @secName nvarchar(35)
, @firstName nvarchar(35), @fathName nvarchar(35),
@gend  nchar(1), @pulp nchar(20), @all varchar(200); 
	print 'Операция удаления';
	set @teacher   = (select [TEACHER] from		DELETED);
	set @secName   = (select [SECOND_NAME] from DELETED);
	set @firstName = (select [FIRST_NAME] from	DELETED);
	set @fathName  = (select [FATHER_NAME] from DELETED);
	set @gend      = (select [GENDER] from		DELETED);
	set @pulp      = (select [PULPIT] from		DELETED);
	set @all	   = @teacher + ' ' + @secName + ' ' + 
	@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
	@pulp + ' ';
	insert into TR_AUDIT(STMT, TRNAME, CC)
		values('DEL', 'TR_TEACHER_DEL', @all);
return;
go
insert into TEACHER
	values('БНВ', 'Шиман', 'Дмитрий' ,'Васильевич', 'м', 'ИСиТ');
delete from TEACHER where TEACHER.TEACHER = 'БНВ';
select * from TR_AUDIT where TR_AUDIT.STMT = 'DEL';
select * from TR_AUDIT;

 
--================================================================================================
--3
drop trigger TR_TEACHER_UPD;
go
create TRIGGER TR_TEACHER_UPD on TEACHER after UPDATE
as declare @teacher nchar(10), @secName nvarchar(35)
, @firstName nvarchar(35), @fathName nvarchar(35),
@gend  nchar(1), @pulp nchar(20), @all varchar(200); 
	print 'Операция изменения';

	set @teacher   = (select [TEACHER] from		INSERTED);
	set @secName   = (select [SECOND_NAME] from INSERTED);
	set @firstName = (select [FIRST_NAME] from	INSERTED);
	set @fathName  = (select [FATHER_NAME] from INSERTED);
	set @gend      = (select [GENDER] from		INSERTED);
	set @pulp      = (select [PULPIT] from		INSERTED);
	set @all	   = @teacher + ' ' + @secName + ' ' + 
	@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
	@pulp + ' ';
	print '----------------------------' +char(13) + @all + char(13);
	insert into TR_AUDIT(STMT, TRNAME, CC)
		values('UPD', 'TR_TEACHER_UPD', @all);
	set @teacher   = (select [TEACHER] from		DELETED);
	set @secName   = (select [SECOND_NAME] from DELETED);
	set @firstName = (select [FIRST_NAME] from	DELETED);
	set @fathName  = (select [FATHER_NAME] from DELETED);
	set @gend      = (select [GENDER] from		DELETED);
	set @pulp      = (select [PULPIT] from		DELETED);
	set @all	   = @teacher + ' ' + @secName + ' ' + 
	@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
	@pulp + ' ';
	print '----------------------------' +char(13) + @all + char(13);
	insert into TR_AUDIT(STMT, TRNAME, CC)
		values('UPD', 'TR_TEACHER_UPD', @all);
return;
go
insert into TEACHER
	values('БНВ', 'Шиман', 'Дмитрий' ,'Васильевич', 'м', 'ИСиТ');
UPDATE TEACHER set TEACHER.TEACHER = 'БНА' where TEACHER.TEACHER = 'БНВ';
UPDATE TEACHER set TEACHER.FATHER_NAME = 'Анатольевич' where TEACHER.TEACHER = 'БНА'; 
--select * from TR_AUDIT where TR_AUDIT.STMT = 'UPD';
--select * from TR_AUDIT;
delete from TEACHER where TEACHER.TEACHER = 'БНА';


--================================================================================================
--4
drop trigger TR_TEACHER;
go
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE
as declare @teacher nchar(10), @secName nvarchar(35)
, @firstName nvarchar(35), @fathName nvarchar(35),
@gend  nchar(1), @pulp nchar(20), @all varchar(200); 
	declare @ins int = (select count(*) from INSERTED);
	declare @del int = (select count(*) from DELETED);
	if(@ins >0 and @del =0)
	begin
		print 'Событие INSERT: ';
		set @teacher   = (select [TEACHER] from INSERTED);
		set @secName   = (select [SECOND_NAME] from INSERTED);
		set @firstName = (select [FIRST_NAME] from INSERTED);
		set @fathName  = (select [FATHER_NAME] from INSERTED);
		set @gend      = (select [GENDER] from INSERTED);
		set @pulp      = (select [PULPIT] from INSERTED);
		set @all	   = @teacher + ' ' + @secName + ' ' + 
		@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
		@pulp + ' ';
		insert into TR_AUDIT(STMT, TRNAME, CC)
		values('INS', 'TR_TEACHER', @all);
	end;
		if(@ins = 0 and @del > 0)
	begin
		print 'Событие DELETE: ';
		set @teacher   = (select [TEACHER] from INSERTED);
		set @secName   = (select [SECOND_NAME] from INSERTED);
		set @firstName = (select [FIRST_NAME] from INSERTED);
		set @fathName  = (select [FATHER_NAME] from INSERTED);
		set @gend      = (select [GENDER] from INSERTED);
		set @pulp      = (select [PULPIT] from INSERTED);
		set @all	   = @teacher + ' ' + @secName + ' ' + 
		@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
		@pulp + ' ';
		insert into TR_AUDIT(STMT, TRNAME, CC)
		values('DEL', 'TR_TEACHER', @all);
	end;
		if(@ins > 0 and @del > 0)
	begin
		print 'Событие UPDATE: ';
		set @teacher   = (select [TEACHER] from INSERTED);
		set @secName   = (select [SECOND_NAME] from INSERTED);
		set @firstName = (select [FIRST_NAME] from INSERTED);
		set @fathName  = (select [FATHER_NAME] from INSERTED);
		set @gend      = (select [GENDER] from INSERTED);
		set @pulp      = (select [PULPIT] from INSERTED);
		set @all	   = @teacher + ' ' + @secName + ' ' + 
		@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
		@pulp + ' ';
		insert into TR_AUDIT(STMT, TRNAME, CC)
		values('UPD', 'TR_TEACHER', @all);
	end;
return;
go
select * from TR_AUDIT;


--================================================================================================
--5
go
insert into TEACHER
	values('ШДВ', 'Шиман', 'Дмитрий' ,'Васильевич', 'м', 'ИСиТ');
select * from TR_AUDIT;
go


--================================================================================================
--6

go
drop trigger TR_TEACHER_DEL1;
drop trigger TR_TEACHER_DEL2;
drop trigger TR_TEACHER_DEL3;
go
create TRIGGER TR_TEACHER_DEL1 on TEACHER after delete
as declare @teacher nchar(10), @secName nvarchar(35)
, @firstName nvarchar(35), @fathName nvarchar(35),
@gend  nchar(1), @pulp nchar(20), @all varchar(200); 
	print 'Операция удаления';
	set @teacher   = (select [TEACHER] from		DELETED);
	set @secName   = (select [SECOND_NAME] from DELETED);
	set @firstName = (select [FIRST_NAME] from	DELETED);
	set @fathName  = (select [FATHER_NAME] from DELETED);
	set @gend      = (select [GENDER] from		DELETED);
	set @pulp      = (select [PULPIT] from		DELETED);
	set @all	   = @teacher + ' ' + @secName + ' ' + 
	@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
	@pulp + ' ';
	insert into TR_AUDIT(STMT, TRNAME, CC)
		values('DEL', 'TR_TEACHER_DEL1', @all);
return;

go
create TRIGGER TR_TEACHER_DEL2 on TEACHER after delete
as declare @teacher nchar(10), @secName nvarchar(35)
, @firstName nvarchar(35), @fathName nvarchar(35),
@gend  nchar(1), @pulp nchar(20), @all varchar(200); 
	print 'Операция удаления';
	set @teacher   = (select [TEACHER] from		DELETED);
	set @secName   = (select [SECOND_NAME] from DELETED);
	set @firstName = (select [FIRST_NAME] from	DELETED);
	set @fathName  = (select [FATHER_NAME] from DELETED);
	set @gend      = (select [GENDER] from		DELETED);
	set @pulp      = (select [PULPIT] from		DELETED);
	set @all	   = @teacher + ' ' + @secName + ' ' + 
	@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
	@pulp + ' ';
	insert into TR_AUDIT(STMT, TRNAME, CC)
		values('DEL', 'TR_TEACHER_DEL2', @all);
return;

go
create TRIGGER TR_TEACHER_DEL3 on TEACHER after delete
as declare @teacher nchar(10), @secName nvarchar(35)
, @firstName nvarchar(35), @fathName nvarchar(35),
@gend  nchar(1), @pulp nchar(20), @all varchar(200); 
	print 'Операция удаления';
	set @teacher   = (select [TEACHER] from		DELETED);
	set @secName   = (select [SECOND_NAME] from DELETED);
	set @firstName = (select [FIRST_NAME] from	DELETED);
	set @fathName  = (select [FATHER_NAME] from DELETED);
	set @gend      = (select [GENDER] from		DELETED);
	set @pulp      = (select [PULPIT] from		DELETED);
	set @all	   = @teacher + ' ' + @secName + ' ' + 
	@firstName + ' ' + @fathName + ' ' + @gend + ' ' + 
	@pulp + ' ';
	insert into TR_AUDIT(STMT, TRNAME, CC)
		values('DEL', 'TR_TEACHER_DEL3', @all);
return;
go
select t.name, e.type_desc
	from sys.triggers t join sys.trigger_events e
		on t.object_id = e.object_id	
			where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE';
--================================================================================================
--7
go
use AllUsers
go
create trigger TOV_RAN on Users after insert
as declare @c int = (select count(*) from Users);
	if(@c >200)
	begin
		raiserror('Количество пользователей не должно превышать 200', 10, 1)
		rollback;
	end;
return;
go
declare @count int = 0;
while @count <= 201
insert into Users 
	values('User', 'UsLog', 'Ps','User');
go
select count(*) from Users;

--================================================================================================
--8


drop trigger INSTEAD_DEL_FAC;
go
use TMPKM_UNIVER;
go
create trigger INSTEAD_DEL_FAC on FACULTY instead of delete
as raiserror(N'Удаление запрещено',10,1);
return
go
delete FACULTY where FACULTY.FACULTY = 'ИТ';
select * from FACULTY;
go
--================================================================================================
--9
use AllUsers;
drop trigger DDL_TRIG_UNIVER;
go
create trigger DDL_TRIG_UNIVER on database for DDL_DATABASE_LEVEL_EVENTS 
as
	declare @t varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','varchar(50)');
	declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(50)');
	declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(50)');
	print 'Тип события: ' + @t;
	print 'Имя объекта: ' + @t1;
	print 'Тип объетка: ' + @t2;
	raiserror(N'Операции с таблицами запрещены',16,1);
	rollback;
return;
go
create table Tb(id int);
go


--================================================================================================
--10


--================================================================================================
--11


use TMPKM_UNIVER;
go
drop table WEATHER;
drop trigger TRIG_INST_TEMP ;
create table WEATHER([Город]varchar(30), [Начальная_дата] date, [Конечная_дата] date, [Температура] float);
go
create trigger TRIG_INST_TEMP on WEATHER after insert
as
	declare weather cursor local for 
	select * from WEATHER;
	declare @tbTown varchar(30) = '', @tbBeginDate datetime = CURRENT_TIMESTAMP, @tbEndDate datetime = CURRENT_TIMESTAMP, @tbTemperature float = 0.0;
	open weather;
	fetch weather into @tbTown, @tbBeginDate, @tbEndDate, @tbTemperature;
	while @@FETCH_STATUS = 0
	begin
		declare @count int = (select count(*) from WEATHER where
		@tbTown = WEATHER.Город and (WEATHER.Температура = @tbTemperature and
		WEATHER.Начальная_дата between @tbBeginDate and @tbEndDate or 
		WEATHER.Конечная_дата between @tbBeginDate and @tbEndDate));
		if(@count > 1)
		begin
			raiserror('Ошибка в введенных данных',15,1);
			rollback;
		end;
		fetch weather into @tbTown, @tbBeginDate, @tbEndDate, @tbTemperature;
	end;
return;
go
insert into WEATHER
	values ('Bobruisk','01-01-2017 00:00','01-01-2017 23:59',-15.0),
	('Minsk', '01-01-2017 00:00','01-01-2017 23:59',-15.0),
	--('Bobruisk','01-01-2017 00:00','01-01-2017 23:59',-15.0),
	('Vitebsk','01-01-2017 00:00','01-01-2017 23:59',-12.0);

select * from WEATHER;