USE [TMPKM_UNIVER]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 4/21/2021 9:47:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null, @c int output 
as
begin
	declare @count int = (select count(*) from SUBJECT_);
	print '@Fromcount = ' + cast(@c as nchar(3));
	select SUBJECT_.SUBJECT_, SUBJECT_.SUBJECT_NAME, SUBJECT_.PULPIT from SUBJECT_;
	print 'parameters: @p = ' + @p + ', @c= ' + cast(@c as varchar(3));
	select * from SUBJECT_ where SUBJECT_.PULPIT = @p;
	set @c = @@ROWCOUNT;
	print '@Fromcount = ' + cast(@c as nchar(3));
	return @count;
end;
GO
--ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null
--as
--begin
--	declare @count int = (select count(*) from SUBJECT_);
--	select * from SUBJECT_ where SUBJECT_.PULPIT = @p;
--end;
--go

