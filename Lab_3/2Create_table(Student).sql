USE KAMINSKYUNIVER
GO

CREATE TABLE [dbo].[STUDENT](
	[Student_number] [bigint] NOT NULL primary key, 
	[Student_surname] [nvarchar](25) default 'Ivanov' ,
	[Group_number] [smallint] NOT NULL,
	check (Group_number>0)	--�� ��������� �������� � ��������� ���� ��������, �� ��������������� �������
	--constraint PK_STUDENT primary key (Student_number) 
)ON[PRIMARY]
--drop table STUDENT;
