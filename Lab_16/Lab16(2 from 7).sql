use TMPKM_UNIVER;
go

--1
--===========================================================================
select * from TEACHER where TEACHER.PULPIT = '����' for xml raw('�������'),
root('������_��������'), elements;


--2
--===========================================================================
go
select AUD.AUDITORIUM_NAME[������������_���������], AUD.AUDITORIUM_TYPE[���_����_���������],
AUD.AUDITORIUM_CAPACITY[�����������]
from AUDITORIUM AUD join AUDITORIUM_TYPE AUT on AUD.AUDITORIUM_TYPE = AUT.AUDITORIUM_TYPE 
where AUD.AUDITORIUM_TYPE = '��' for xml AUTO, 
root('������_���������'),elements;
go

--3
--===========================================================================
go
declare @h int = 0,
@x varchar(2000) = '<?xml version="1.0" encoding="windows-1251"?>
					<SUBJECTS>
					<SUBJECT SUBJECT_ = "���" SUBJECT_NAME = "��������-��������������� ����������������" PULPIT = "����" />
					<SUBJECT SUBJECT_ = "���" SUBJECT_NAME = "������ �������������� ����������" PULPIT = "����"/>
					<SUBJECT SUBJECT_ = "��" SUBJECT_NAME = "����� ����������������" PULPIT = "����"/>
					</SUBJECTS>';
exec sp_xml_preparedocument @h output, @x; --���������� ���������
select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)
with ([SUBJECT_] nchar(10), [SUBJECT_NAME] nvarchar(100), [PULPIT] nchar(20))
exec sp_xml_removedocument @h;
go
--4
--===========================================================================
go
use TMPKM_UNIVER;
alter table STUDENT ALTER column INFO xml;
go
delete STUDENT where STUDENT.SECOND_NAME = '���';
insert into STUDENT(IDGROUP, SECOND_NAME, FIRST_NAME, FATHER_NAME, BDAY, INFO) values
(22, '���','������','����������', '1996-04-01', 
   '<student>
	<pasport ����� = "MP" ����� = "1234567" ���� = "01.05.2010"/>
	<�������>13215416</�������>
		<�����>
			<������>��</������>
			<�����>�����</�����>
			<�����>�������</�����>
			<���>17</���>
			<��������>7</��������>
		</�����>
	</student>');

update STUDENT set INFO = 
	'<student>
	<pasport ����� = "MP" ����� = "1234567" ���� = "01.05.2010"/>
	<�������>13215416</�������>
		<�����>
			<������>��</������>
			<�����>�����</�����>
			<�����>�������</�����>
			<���>29</���>
			<��������>48</��������>
		</�����>
	</student>'
where STUDENT.INFO.value('(/student/�����/���)[1]', 'int') = 17;
select SECOND_NAME, FIRST_NAME, FATHER_NAME, 
	INFO.value('(student/pasport/@�����)[1]', 'char(2)') '����� ��������',
	INFO.value('(student/pasport/@�����)[1]', 'varchar(10)') '����� ��������'
from STUDENT where STUDENT.SECOND_NAME = '���';
go
--5
--===========================================================================
use TMPKM_UNIVER;
go
drop xml schema collection Student
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xs:element name="�������">  
		<xs:complexType>
			<xs:sequence>
				<xs:element name="�������" maxOccurs="1" minOccurs="1">
					<xs:complexType>
						<xs:attribute name="�����" type="xs:string" use="required" />
						<xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
						<xs:attribute name="����"  use="required" >  
							<xs:simpleType> 
								<xs:restriction base ="xs:string">
									<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType> 
				</xs:element>
				<xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
				<xs:element name="�����">
					<xs:complexType>
						<xs:sequence>
							<xs:element name="������" type="xs:string" />
							<xs:element name="�����" type="xs:string" />
							<xs:element name="�����" type="xs:string" />
							<xs:element name="���" type="xs:string" />
							<xs:element name="��������" type="xs:string" />
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>';
alter table STUDENT drop constraint [DF__STUDENT__INFO__5441852A];
alter table STUDENT alter column INFO xml(Student);
delete STUDENT where STUDENT.FIRST_NAME = 'test';
insert STUDENT(IDGROUP, FIRST_NAME, BDAY, INFO) values
	(22,'test','01.01.2000',
		'<�������>
			<������� �����="�B" �����="6799765" ����="25.10.2011"/>
			<�������>2434353</�������>
			<�����>
				<������>��������</������>
				<�����>�����</�����>
				<�����>�����������</�����>
				<���>19</���>
				<��������>416</��������>
			</�����>
		</�������>');
select * from STUDENT;
--6
--===========================================================================

--7
--===========================================================================
select rtrim(FACULTY.FACULTY) as '@���',
	(select COUNT(*) from PULPIT 
		where PULPIT.FACULTY = FACULTY.FACULTY) as '����������_������',
	(select rtrim(PULPIT.PULPIT) as '@���',
		(select rtrim(TEACHER.TEACHER) as '�������������/@���',
			TEACHER.FIRST_NAME as '�������������'
		from TEACHER where TEACHER.PULPIT = PULPIT.PULPIT
		for xml path(''),type, root('�������������'))
	from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY 
		for xml path('�������'), type, root('�������')) 
from FACULTY
for xml path('���������'), type, root('�����������')
