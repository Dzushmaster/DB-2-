use TMPKM_UNIVER;
--1
drop procedure PSUBJECT
go
create PROCEDURE PSUBJECT
as
begin
	declare @count int = (select count(*) from SUBJECT_);
	select SUBJECT_.SUBJECT_, SUBJECT_.SUBJECT_NAME, SUBJECT_.PULPIT from SUBJECT_;
	return @count;
end;
go
declare @count1 int = 0;
EXEC @count1 = PSUBJECT;
print 'Count of PSUBJECT: ' + cast(@count1 as varchar(3));
go
--2
declare @count2 int =0;
declare @c int = 0;
exec @count2 = PSUBJECT 'ИСиТ', @c;
print 'Count of PSUBEJCT @count2 = ' + cast(@count2 as varchar(3)) + 
	'@c = ' + cast(@c as varchar(3));
--3
go
drop table #SUBJECT;
create table #SUBJECT(SUBJECT_ nchar(10) not null, SUBJECT_NAME nvarchar(100) not null, PULPIT nchar(20) not null);
	insert #SUBJECT exec PSUBJECT @p = 'ИСиТ';
	insert #SUBJECT exec PSUBJECT @p = 'ТиП';
select * from #SUBJECT
use TMPKM_UNIVER;
go
--4
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY = 82;
drop PROCEDURE PAUDITORIUM_INSERT;
go
create PROCEDURE PAUDITORIUM_INSERT @a char(20), @n varchar(50), @t char(10), @c int = 0 
as declare @checkProc int = 1;
begin
	begin try
		insert into AUDITORIUM
			values (@a,@n,@c,@t);
		return @checkProc;
	end try
	begin catch
		print 'Error number: ' + cast(error_number() as varchar(6));
		print 'Message: ' + error_message();
		print 'Level: ' + cast(error_severity() as varchar(6));
		print 'Metka: ' + cast(error_state() as varchar(8));
		if ERROR_PROCEDURE() is not null
		print 'Name of procedure: ' + error_procedure();
		return -1;
	end catch
end;
go
declare @number int;
declare @LK varchar(10) = (select distinct 'ЛК' from AUDITORIUM);
exec @number = PAUDITORIUM_INSERT '220-3', @LK, '220-3', 82;
select * from AUDITORIUM;
print 'Return code: ' + cast(@number as varchar(5));

--5
use TMPKM_UNIVER
drop procedure SUBJECT_REPORT;
go
create PROCEDURE SUBJECT_REPORT @p char(10)
as
begin
	declare @count int = 0;
	begin try
		declare @pulpName char(10) = '', @allPulpits nvarchar(150) = '';
		declare ZkTov cursor local for
			select SUBJECT_.SUBJECT_ from SUBJECT_ where SUBJECT_.PULPIT = @p;
		if not exists(select SUBJECT_.SUBJECT_ from SUBJECT_ where SUBJECT_.PULPIT= @p)
			raiserror('error',11,1);
		else
			open ZkTov;
			fetch ZkTov into @pulpName;
			print 'Ordered items';
			while @@FETCH_STATUS = 0
			begin
				set @allPulpits = RTRIM(@pulpName) + ', ' + @allPulpits;
				set @count = @count + 1;
				fetch ZkTov into @pulpName;
			end;
			print @allPulpits;
			close ZkTov;
			return @count;
		end try
		begin catch
			print 'Error in the parameters '
			if ERROR_PROCEDURE() is not null 
				print 'Name of the procedure: ' + error_procedure();
			return @count;
		end catch
		return @count;
end;
go
	declare @newCount int = 0;
	exec @newCount = SUBJECT_REPORT 'ИСиТ';
	print 'New count: ' + cast(@newCount as varchar(3))
	
--6
go
drop PROCEDURE PAUDITORIUM_INSERTX;
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '210-3';
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = 'ЛЕК'
go
create PROCEDURE PAUDITORIUM_INSERTX @a char(20), @n varchar(50), @t char(10), @tn varchar(50) ,@c int = 0 
as declare @rc int = 1;
begin
	begin try
		set transaction isolation level SERIALIZABLE ;
		begin tran
			insert into AUDITORIUM_TYPE
			values (@n, @tn);
			exec @rc = PAUDITORIUM_INSERT @a,@n, @t,@c;
		commit tran
		return @rc;
	end try
	begin catch
		print 'Error number: ' + cast(error_number() as varchar(6));
		print 'Message: ' + error_message();
		print 'Level: ' + cast(error_severity() as varchar(6));
		print 'Metka: ' + cast(error_state() as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Name of procedure: ' + error_procedure();
		if @@TRANCOUNT > 0 
			rollback tran;
		return -1;

	end catch
end

go
declare @number int = 0;
declare @LK varchar(10) = 'ЛЕК';
exec @number =  PAUDITORIUM_INSERTX '210-3', @LK, '210-3', 'Лекарная', 82;
print 'Operation result = ' + cast(@number as varchar(4));
select * from AUDITORIUM_TYPE;
select * from AUDITORIUM;
--7
--8

go
use TMPKM_UNIVER
GO
--@f - faculty, @p - pulpit

create procedure PRINT_REPORT  @f char(10) = null, @p char(10) = null
as declare @count int = 0
begin
	begin try
		if(@f is not null AND @p is null)
		begin
			DECLARE Faculties CURSOR GLOBAL STATIC for
			select FACULTY.FACULTY, PULPIT.PULPIT, COUNT(TEACHER.TEACHER),  ISNULL (SUBJECT_.SUBJECT_, 'Нет')  FROM 
			FACULTY JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
			JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
			left JOIN SUBJECT_ ON SUBJECT_.PULPIT = PULPIT.PULPIT
			where FACULTY.FACULTY = @f
			GROUP BY SUBJECT_.SUBJECT_, PULPIT.PULPIT , FACULTY.FACULTY;
		end
		if(@f is not null AND @p is not null)
		begin
			DECLARE Faculties CURSOR GLOBAL STATIC for
			select FACULTY.FACULTY, PULPIT.PULPIT, COUNT(TEACHER.TEACHER),  ISNULL (SUBJECT_.SUBJECT_, 'Нет')  FROM 
			FACULTY JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
			JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
			left JOIN SUBJECT_ ON SUBJECT_.PULPIT = PULPIT.PULPIT
			where FACULTY.FACULTY = @f AND PULPIT.PULPIT = @p
			GROUP BY SUBJECT_.SUBJECT_, PULPIT.PULPIT , FACULTY.FACULTY;
		end
		if(@f is null AND @p is not null)
		begin
			DECLARE Faculties CURSOR GLOBAL STATIC for
			select PULPIT.FACULTY, PULPIT.PULPIT, COUNT(TEACHER.TEACHER),  ISNULL (SUBJECT_.SUBJECT_, 'Нет')  FROM 
			FACULTY JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
			JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
			left JOIN SUBJECT_ ON SUBJECT_.PULPIT = PULPIT.PULPIT
			where PULPIT.PULPIT= @p
			GROUP BY SUBJECT_.SUBJECT_, PULPIT.PULPIT , PULPIT.FACULTY;
		end
		declare @checkNumb int =0;

		select @checkNumb = count(*) FROM 
		FACULTY JOIN PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
		JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
		left JOIN SUBJECT_ ON SUBJECT_.PULPIT = PULPIT.PULPIT
		where PULPIT.PULPIT= @p
		GROUP BY SUBJECT_.SUBJECT_, PULPIT.PULPIT , FACULTY.FACULTY
		--if(@checkNumb<=0)
			--throw 5100, 'Ошибка в параметрах',1;
		open Faculties;

		DECLARE @Faculty nvarchar(10) = '', @Pulpit nvarchar(15) = '', @CountTeacher int, @Subject nvarchar(10) = '';
		FETCH Faculties into @Faculty, @Pulpit, @CountTeacher, @Subject;
		DECLARE @PriorFaculty nvarchar(10) = '', @PriorPulpit nvarchar(15) = '', @PriorCountTeacher int = -2, @PriorSubject nvarchar(10) = '';
		WHILE @@FETCH_STATUS = 0
		begin
			if(@Faculty != @PriorFaculty) 
				print 'Факультет: ' + @Faculty + char(13);
			if(@Pulpit != @PriorPulpit) 
			begin
				print space(5) + 'Кафедра:' + @Pulpit + char(13);
				set @count +=1;
			end
			if(@CountTeacher != @PriorCountTeacher)
			begin
				print space(7) + 'Количество преводавателей: ' + cast(@CountTeacher as varchar(10)) + char(13) + space(7);
				print space(7) + 'Дисциплины: ';
			end
			print replace(@Subject ,char(13), '') + ',';
			SET @PriorFaculty = @Faculty; SET @PriorPulpit = @Pulpit; SET @PriorCountTeacher = @CountTeacher; SET @PriorSubject = @Subject;
			FETCH Faculties into @Faculty, @Pulpit, @CountTeacher, @Subject;
		end
		close Faculties;
		deallocate Faculties;
	end try
	begin catch
		print('Ошибка в параметрах');
		return -5;
	end catch
	return @count;
end;
go
declare @count int =0;	
exec @count = PRINT_REPORT 'ИТ'
print 'Количество выведенных кафедр ' + cast(@count as varchar(5));
drop procedure PRINT_REPORT;
