use TMPKM_UNIVER;
--1
set nocount on;
if exists (select * from sys.objects where OBJECT_ID = object_id(N'dbo.newTable'))
	drop table dbo.newTable;
DECLARE @count int, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS ON; --‚ÍÎ˛˜ÂÌËÂ ÂÊËÏ‡ ÌÂˇ‚ÌÓÈ Ú‡ÌÁ‡ÍˆËË
create table newTable(numb int);
insert into newTable(numb)
	values(4),(5),(7);
	SET @count = (select count(*) from newTable);
	print 'Count of elements in the table is ' + cast(@count as varchar(3)) + char(8);
	select * from newTable;
	if(@flag = 'c')
	commit;
	else
	rollback;
SET IMPLICIT_TRANSACTIONS OFF;
if exists(select * from sys.objects where OBJECT_ID = object_id(N'dbo.newTable'))
	print 'The table created' + char(8);
else
	print 'The table was not create' + char(8);


--===========================================================================================================================================================================
--2
set nocount on;
insert into AUDITORIUM(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY, AUDITORIUM.AUDITORIUM_NAME)
	values('400-2a', (select distinct 'À ' from AUDITORIUM_TYPE), 90, '400-2a');
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '313-3' or AUDITORIUM.AUDITORIUM = '409-2';
BEGIN TRY
	BEGIN TRAN
	delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '400-2a';
	insert into AUDITORIUM
		values('313-3', (select distinct 'À ' from AUDITORIUM_TYPE), 90, '313-3'),
			  ('409-2', (select distinct 'À ' from AUDITORIUM_TYPE), 90, '409-2');
	commit tran;
END TRY
BEGIN CATCH
	print 'Error: ' + case
	when error_message() = 2627 and patindex('%PK_AUDITORIUM%', error_message())>0 then 'duplicate value' + char(8)
	else
	'undefined error' + char(8)
	end;
	if @@TRANCOUNT>0
	rollback tran;
END CATCH;
select * from AUDITORIUM;



--===========================================================================================================================================================================
--3
set nocount on;
insert into AUDITORIUM(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY, AUDITORIUM.AUDITORIUM_NAME)
	values('400-2a', (select distinct 'À ' from AUDITORIUM_TYPE), 90, '400-2a');
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '313-3' or AUDITORIUM.AUDITORIUM = '409-2';
DECLARE @point nvarchar(30);
BEGIN TRY
	BEGIN TRAN
	delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '400-2a';
	SET @point = 'point1';
	SAVE TRAN @point;  
	insert into AUDITORIUM
		values('313-3', (select distinct 'À ' from AUDITORIUM_TYPE), 90, '313-3');
			SET @point = 'point2';
			SAVE TRAN @point;  
	insert into AUDITORIUM
		values('409-2', (select distinct 'À ' from AUDITORIUM_TYPE), 90, '409-2');
			SET @point = 'point3';
			SAVE TRAN @point;
	commit tran;
	print 'All checkpoints passed' + char(8);
END TRY
BEGIN CATCH
	print 'Error: ' + case
	when error_message() = 2627 and patindex('%PK_AUDITORIUM%', error_message())>0 then 'duplicate value' + char(8)
	else
	'undefined error' + char(8)
	end;
	if @@TRANCOUNT>0
	BEGIN
	print 'checkpoint: ' + @point + char(8);
	rollback tran;
	commit tran;
	END
END CATCH;
select * from AUDITORIUM;


--===========================================================================================================================================================================
--4
use TMPKM_UNIVER;
set transaction isolation level READ UNCOMMITTED
begin transaction
select @@SPID, 'insert AUDITORIUM' 'Result',* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
select @@SPID, 'update AUDITORIUM' 'Result', AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit;
begin transaction
select @@SPID, * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE='À '
insert into AUDITORIUM values ('105-a',(select distinct 'À ' from AUDITORIUM), 90,'105-a');
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 25 where AUDITORIUM.AUDITORIUM_CAPACITY>=90 and AUDITORIUM.AUDITORIUM_TYPE = 'À ';
select @@SPID, * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE='À '
rollback;
--ÌÂÔÓ‚ÚÓˇ˛˘ÂÂÒˇ ˜ÚÂÌËÂ
use TMPKM_UNIVER;
set transaction isolation level READ UNCOMMITTED
begin tran 
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
go
waitfor delay '00:00:10';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit
--phantom reading
use TMPKM_UNIVER;
set transaction isolation level READ UNCOMMITTED
begin tran 
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
go
waitfor delay '00:00:10';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit


--===========================================================================================================================================================================
--5
use TMPKM_UNIVER;
set transaction isolation level READ COMMITTED
begin transaction
waitfor delay '00:00:05';
select @@SPID, 'insert AUDITORIUM' 'Result',* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
waitfor delay '00:00:05';
select @@SPID, 'update AUDITORIUM' 'Result', AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit;

use TMPKM_UNIVER;
set tran isolation level READ COMMITTED
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
go
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit

--phantom reading
use TMPKM_UNIVER;
set transaction isolation level READ COMMITTED
begin tran 
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
go
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit


--===========================================================================================================================================================================
--6
set tran isolation level REPEATABLE READ
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit


--ÌÂÔÓ‚ÚÓˇ˛˘ÂÂÒˇ ˜ÚÂÌËÂ
set tran isolation level REPEATABLE READ
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit


-- phantom reading
set tran isolation level REPEATABLE READ
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit


--===========================================================================================================================================================================
--7
set tran isolation level SERIALIZABLE
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit

--ÌÂÔÓ‚ÚÓˇ˛˘ÂÂÒˇ ˜ÚÂÌËÂ
set tran isolation level SERIALIZABLE
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit

--phantom reading
set tran isolation level SERIALIZABLE
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
waitfor delay '00:00:05';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit


--===========================================================================================================================================================================
--8
begin tran
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
begin tran
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM.AUDITORIUM_CAPACITY>=90
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
insert into AUDITORIUM
	values('115-2', (select distinct 'À ' from AUDITORIUM_TYPE), 90, '115-2');
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
commit
commit
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '115-2'
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 90 where AUDITORIUM.AUDITORIUM_CAPACITY=25 and AUDITORIUM.AUDITORIUM_TYPE = 'À ';
select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = 'À ';


--===========================================================================================================================================================================
--9
use K_MyBase;
begin tran 
select* from Products;
update Products set Products.Cost = 999 where Products.Cost <25;
select* from Products;
rollback;
update Products set Products.Cost = 40 where Products.Cost = 25;
