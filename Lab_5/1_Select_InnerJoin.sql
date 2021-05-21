use TMPKM_UNIVER;
go
--select * from AUDITORIUM;
--select * from AUDITORIUM_TYPE;
-- Subject 1
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM INNER JOIN AUDITORIUM_TYPE 
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
--Without INNER JOIN and with pseudonyms

-- Subject 3(second part on the second file)
select A1.AUDITORIUM, A2.AUDITORIUM_TYPE  from AUDITORIUM  A1, AUDITORIUM_TYPE as A2 
where A1.AUDITORIUM_TYPE = A2.AUDITORIUM_TYPE;