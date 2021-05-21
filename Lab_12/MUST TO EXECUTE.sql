--execute while executing the second part of 4 exercise
--for 4 exercise

use TMPKM_UNIVER;
update AUDITORIUM set AUDITORIUM_CAPACITY = 90 where AUDITORIUM.AUDITORIUM_CAPACITY =25
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM.AUDITORIUM_CAPACITY>=90
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit
--uncomment after using
rollback

--execute while executing the third part of 4 exercise
--for 4 exercise
use TMPKM_UNIVER;
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM ='115-2';
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
insert into AUDITORIUM
	values('115-2', (select distinct '��' from AUDITORIUM_TYPE), 90, '115-2');
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit
--
rollback

--for 5 exercise you can wait all time, while first trans don't end
use TMPKM_UNIVER;
begin transaction
select @@SPID, * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE='��'
insert into AUDITORIUM values ('105-a',(select distinct '��' from AUDITORIUM), 90,'105-a');
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 25 where AUDITORIUM.AUDITORIUM_CAPACITY>=90 and AUDITORIUM.AUDITORIUM_TYPE = '��';
select @@SPID, * from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE='��'
commit;
--
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 90 where AUDITORIUM.AUDITORIUM_CAPACITY=25 and AUDITORIUM.AUDITORIUM_TYPE = '��';

--for 5 exercise ��� ����������������� ������
use TMPKM_UNIVER;
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM.AUDITORIUM_CAPACITY>=90
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit;
--
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 90 where AUDITORIUM.AUDITORIUM_CAPACITY=25 and AUDITORIUM.AUDITORIUM_TYPE = '��';

--for 5 for phantom reading
use TMPKM_UNIVER;
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
insert into AUDITORIUM
	values('115-2', (select distinct '��' from AUDITORIUM_TYPE), 90, '115-2');
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit
--
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '115-2'


-- for 6
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '115-2';
set tran isolation level read committed 
begin tran
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
insert into AUDITORIUM
	values('115-2', (select distinct '��' from AUDITORIUM_TYPE), 90, '115-2');
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';

rollback

-- for 6 ��������������� �����e

use TMPKM_UNIVER;
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM.AUDITORIUM_CAPACITY>=90
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit;
--
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 90 where AUDITORIUM.AUDITORIUM_CAPACITY=25 and AUDITORIUM.AUDITORIUM_TYPE = '��';

-- for 6 phantom reading
use TMPKM_UNIVER;
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
insert into AUDITORIUM
	values('115-2', (select distinct '��' from AUDITORIUM_TYPE), 90, '115-2');
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit
--
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '115-2'


-- for 7
set tran isolation level read committed
begin tran
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
insert into AUDITORIUM
	values('115-2', (select distinct '��' from AUDITORIUM_TYPE), 90, '115-2');
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';

rollback

-- for 7 ��������������� �����e
use TMPKM_UNIVER;
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM.AUDITORIUM_CAPACITY>=90
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit;
--
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = 90 where AUDITORIUM.AUDITORIUM_CAPACITY=25 and AUDITORIUM.AUDITORIUM_TYPE = '��';

-- for 7 phantom reading
use TMPKM_UNIVER;
begin tran 
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
insert into AUDITORIUM
	values('115-2', (select distinct '��' from AUDITORIUM_TYPE), 90, '115-2');
select* from AUDITORIUM where AUDITORIUM.AUDITORIUM_TYPE = '��';
commit
--
delete from AUDITORIUM where AUDITORIUM.AUDITORIUM = '115-2'
