use TMPKM_UNIVER;

--1
exec sp_helpindex 'AUDITORIUM';
exec sp_helpindex 'AUDITORIUM_TYPE';
exec sp_helpindex 'FACULTY';
exec sp_helpindex 'GROUP_';
exec sp_helpindex 'PROFESSION';
exec sp_helpindex 'PROGRESS';
exec sp_helpindex 'PULPIT';
exec sp_helpindex 'STUDENT';
exec sp_helpindex 'SUBJECT_';
exec sp_helpindex 'TEACHER';
exec sp_helpindex 'TIMETABLE';
--go


create table #EXPLERE(ID int identity(1,1), RandNumb int)
SET nocount on;
DECLARE @i int = 0;
while @i<1000
begin
	insert #EXPLERE(RandNumb)
	values(floor(20000*RAND()));
	SET @i += 1;
end;
select * from #EXPLERE where RandNumb between 5000 and 10000 order by RandNumb;
checkpoint;
dbcc DROPCLEANBUFFERS;
create clustered index #EXPLERE on #EXPLERE(RandNumb asc)
select * from #EXPLERE where RandNumb between 5000 and 10000 order by RandNumb;


--2
-- ак-то вли€ет на работу только когда зафиксируем индексируемые значени€
go
use tempdb;
exec sp_helpindex '#TIMES'; 
create table #TIMES(TIMESKEY int,TIMESID int identity(1,1), TIMESSTRING varchar(10));
	set nocount on;
	declare @i int = 0;
	while @i<15000
	begin
		insert into #TIMES(TIMESKEY,TIMESSTRING)
		values(floor(30000*RAND()), replicate('c',10));
		SET @i +=1; 
	end;
select count(*) from #TIMES;
select * from #TIMES where #TIMES.TIMESKEY = 4800 and #TIMES.TIMESID>20;
checkpoint;
dbcc DROPCLEANBUFFERS;
create index ForTIMES on #TIMES(TIMESKEY, TIMESID);
select * from #TIMES where #TIMES.TIMESKEY = 4800 and #TIMES.TIMESID>20;


--3
create index #THIRDINDEX on #TIMES(TIMESKEY) include(TIMESID)
select #TIMES.TIMESID from #TIMES where #TIMES.TIMESKEY>1500

--4
go
create index #FOURTHINDEX on #TIMES(TIMESKEY) where(TIMESKEY <= 20000 and TIMESKEY>12800); 
select #TIMES.TIMESKEY from #TIMES where #TIMES.TIMESKEY between 12801 and 19999;
select #TIMES.TIMESKEY from #TIMES where #TIMES.TIMESKEY >17000
select #TIMES.TIMESKEY from #TIMES where #TIMES.TIMESKEY =12500
go


--5
create index #FOURTHINDEX on #TIMES(TIMESKEY) where(TIMESKEY <= 20000 and TIMESKEY>12800); 
select name[Index], avg_fragmentation_in_percent[Fragmentation(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#TIMES'),NULL,NULL,NULL)ss
JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;
alter index #FOURTHINDEX on #TIMES reorganize;
alter index #FOURTHINDEX on #TIMES rebuild with(online = off);

--6
drop index #FOURTHINDEX on #TIMES;
create INDEX #FOURTHINDEX on #TIMES(TIMESKEY) with(fillfactor = 65);
insert top(90) percent into #TIMES(TIMESKEY)
select #TIMES.TIMESKEY from #TIMES;

--DROP ALL TABLES
drop table #TIMES;
drop table #EXPLERE;
--DROP INDEX
drop index #FOURTHINDEX on #TIMES;
