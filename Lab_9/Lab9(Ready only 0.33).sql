use TMPKM_UNIVER;
go

--1
DECLARE @Cchar char(6) = 'BELSTU',
		@Vvarchar varchar(10) = 'Statement',
		@DdateTime datetime,
		@Ttime time,
		@Iint int,
		@Ssmallint smallint,
		@TItinyint tinyint,
		@Nnumeric numeric(12,5);
SET @Iint = 123154;
SET	@Ssmallint = 12;
SELECT @TItinyint = 4;
SET @DdateTime = (select STUDENT.BDAY from STUDENT where year(STUDENT.BDAY)<1996)
SET @Ttime = '12:05';
select @DdateTime Ddatetime
select @Ttime Ttime;
select @Nnumeric [Maybe Null];
select @TItinyint [Tinyint];
print '----------------- Subject 1 -----------------' + char(13)
print char(13) + 'Char '+  @Cchar + char(13) + 'Varchar ' + @Vvarchar +char(13) +  'Int ' + cast(@Iint as nvarchar(10)) + char(13) + 'SmallInt ' + cast(@Ssmallint as nvarchar(10)); 
print  '--'+ cast(@Nnumeric as varchar(5)) + '--';--Не выводится
--SET @DdateTime = (select STUDENT.BDAY from STUDENT);
--select @DdateTime newDateTime
GO

--2
DECLARE @SumCapacityAud int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM),
		@CountAud int = (select count(*) from AUDITORIUM),
		@AvarageCapacity float(4) = (select avg(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM);
DECLARE @CountLessAvg int = (select count(*) from AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY < @AvarageCapacity);
DECLARE @Percents float(4) = cast(@CountLessAvg as float(4))/cast(@CountAud as float(4))*100;
		print '----------------- Subject 2 -----------------' + char(13)
if(@SumCapacityAud>200)
	print 'Count of auditorium  ' + cast(@CountAud as varchar(10)) + char(13)
	 + 'Avarage capacity of auditoriums ' + cast(@AvarageCapacity as varchar(10)) + char(13)
	 + 'Count of auditoriums less avarage ' + cast(@CountLessAvg as varchar(10)) + char(13)
	 + 'Percent of this auditoriums ' + cast(@Percents as varchar(10)) + '%' + char(13);
else
	print 'All capacity of auditoriums ' + cast(@SumCapacityAud as varchar(10)) + char(13);

--3

	print '----------------- Subject 3 -----------------' + char(13)
	print  '--Number of lines processed: ' + cast(@@ROWCOUNT as varchar(7)) + char(13)
		 + '--Version of SQL server: ' + @@VERSION + char(13)
		 + '--System process identifier assigned by the server: ' + cast(@@SPID as varchar(10)) + char(13)
		 + '--Last error code: ' + cast(@@ERROR as varchar(7)) + char(13)
		 + '--Server name: ' + @@SERVERNAME + char(13)
		 + '--Nesting level of the result set: ' + cast(@@TRANCOUNT as varchar(4)) + char(13)
		 + '--Checked: ' + cast(@@FETCH_STATUS as varchar(4)) +char(13)
		 + '--Nesting level of the current procedure: ' + cast(@@NESTLEVEL as varchar(5)) +char(13)

--4
	print '----------------- Subject 4 -----------------' + char(13)

DECLARE @t int = 4,
		@x int = 2,
		@z float(4) = 0,
		@oper int = 2;
if(@t>@x)
begin
	SET @z = power(sin(@t),2);
	SET @oper = 0;
end
else if(@t<@x)
begin
	SET @z = (4*(@t+@x));
	SET @oper = 1;
end
else
	SET @z = 1 - exp(@x-2);
print 'Operation number: ' + cast(@oper as varchar(10)) + ', result is ' + cast(@z as varchar(10)) + char(13);
GO

print 'NAMES' + char(13);
DECLARE FullNames_Cursor CURSOR LOCAL FOR 
select STUDENT.FIRST_NAME, STUDENT.SECOND_NAME, STUDENT.FATHER_NAME from STUDENT;
DECLARE @ResultNames varchar(100) = '',
		@Name varchar(20),
		@SecondName varchar(20),
		@FatherName varchar(20);
OPEN FullNames_Cursor;
FETCH FullNames_Cursor into @Name, @SecondName, @FatherName
while @@FETCH_STATUS = 0
begin
	SET @ResultNames += substring(@Name, 1, 1) + substring(@SecondName, 1, 1) + substring(@FatherName, 1, 1) + char(13);
	FETCH FullNames_Cursor into @Name, @SecondName, @FatherName;
end
CLOSE FullNames_Cursor;
print @ResultNames;
GO

DECLARE @CurrentDate Date = Getdate(),
		@BirthdayStud Date,
		@IsMonth bit = 0;
DECLARE DefineAge CURSOR LOCAL FOR
select STUDENT.BDAY from STUDENT;
OPEN DefineAge;
FETCH DefineAge into @BirthdayStud;
while @@FETCH_STATUS = 0
begin
	if(Month(@BirthdayStud) = Month(DateAdd(month, 1, @CurrentDate)))
	begin
		print 'Years: '+ cast(DateDiff(year,@BirthdayStud, @CurrentDate) as varchar(7)) + char(13);
		SET @IsMonth = 1;
	end
	FETCH DefineAge into @BirthdayStud;
end
if(@IsMonth = 0)
	print 'There is noone student with birthday after month' + char(13);
CLOSE DefineAge
GO

select TIMETABLE.IDGROUP, TIMETABLE.WEEKDAY_ from TIMETABLE where TIMETABLE.SUBJECT_ = 'СУБД';
GO

--5
	print '----------------- Subject 5 -----------------' + char(13)

DECLARE @Mark smallint = 0;
DECLARE Marks CURSOR local for
select PROGRESS.NOTE from PROGRESS;
OPEN Marks;
FETCH Marks into @Mark;
while @@FETCH_STATUS = 0
BEGIN
	if(@Mark between 1 and 4)
		print 'Mark: ' + cast(@Mark as varchar(2)) + ' Retake';
	else if(@Mark between 5 and 7)
		print 'Mark: ' + cast(@Mark as varchar(2)) + ' Very good';
	else if(@Mark in(8,9))
		print 'Mark: ' + cast(@Mark as varchar(2)) + ' Spectacular';
	else
		print 'Mark: ' + cast(@Mark as varchar(2)) + ' Imposible';
	FETCH Marks into @Mark;
END


GO
--6
	print '----------------- Subject 6 -----------------' + char(13)

select CASE 
		when P.NOTE between 1 and 4 then 'Retake'
		when P.NOTE between 5 and 7 then 'Very good'
		when P.NOTE in(8,9) then 'Spectacular'
		when P.NOTE = 10 then 'Imposible'
		end Notes, count(*)[Count]
		from PROGRESS as P
		group by case
		when P.NOTE between 1 and 4 then 'Retake'
		when P.NOTE between 5 and 7 then 'Very good'
		when P.NOTE in(8,9) then 'Spectacular'
		when P.NOTE = 10 then 'Imposible'
		end
GO
--7
	
	create table #TIMES(ID int, RandNumb int, string varchar(30));
	SET nocount on;		--не выводить инфу о вводе строк
	DECLARE @i int = 0;
	while(@i<10)
	BEGIN
		insert #TIMES(ID, RandNumb,string)
			values(@i, floor(30000*rand()), replicate('2',@i))
		SET @i +=1; 
	END
	GO
	select * from #TIMES;
--8
	GO
	DECLARE @x int =1
	print @x + 1
	print @x + 2
	return
	print @x + 3
	go

--9
	begin TRY
		select 1/0;
	end TRY
	begin CATCH
		print ERROR_NUMBER()
		print ERROR_MESSAGE()
		print ERROR_LINE()
		print ERROR_PROCEDURE()
		print ERROR_SEVERITY()
		print ERROR_STATE()
	end CATCH