use TMPKM_UNIVER;
go

--1
--===========================================================================
select * from TEACHER where TEACHER.PULPIT = 'ИСиТ' for xml raw('Учителя'),
root('Список_учителей'), elements;


--2
--===========================================================================
go
select AUD.AUDITORIUM_NAME[Наименование_аудитории], AUD.AUDITORIUM_TYPE[Имя_типа_аудитории],
AUD.AUDITORIUM_CAPACITY[Вместимость]
from AUDITORIUM AUD join AUDITORIUM_TYPE AUT on AUD.AUDITORIUM_TYPE = AUT.AUDITORIUM_TYPE 
where AUD.AUDITORIUM_TYPE = 'лк' for xml AUTO, 
root('Список_аудиторий'),elements;
go

--3
--===========================================================================
go
declare @h int = 0,
@x varchar(2000) = '<?xml version="1.0" encoding="windows-1251"?>
					<SUBJECTS>
					<SUBJECT SUBJECT_ = "ООП" SUBJECT_NAME = "Объектно-ориентированное программирование" PULPIT = "ИСиТ" />
					<SUBJECT SUBJECT_ = "ОИТ" SUBJECT_NAME = "Основы информационных технологий" PULPIT = "ИСиТ"/>
					<SUBJECT SUBJECT_ = "ЯП" SUBJECT_NAME = "Языки программирования" PULPIT = "ИСиТ"/>
					</SUBJECTS>';
exec sp_xml_preparedocument @h output, @x; --подготовка документа
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
delete STUDENT where STUDENT.SECOND_NAME = 'Лук';
insert into STUDENT(IDGROUP, SECOND_NAME, FIRST_NAME, FATHER_NAME, BDAY, INFO) values
(22, 'Лук','Михаил','Трофимович', '1996-04-01', 
   '<student>
	<pasport серия = "MP" номер = "1234567" дата = "01.05.2010"/>
	<телефон>13215416</телефон>
		<адрес>
			<страна>РБ</страна>
			<город>Минск</город>
			<улица>Пушкина</улица>
			<дом>17</дом>
			<квартира>7</квартира>
		</адрес>
	</student>');

update STUDENT set INFO = 
	'<student>
	<pasport серия = "MP" номер = "1234567" дата = "01.05.2010"/>
	<телефон>13215416</телефон>
		<адрес>
			<страна>РБ</страна>
			<город>Минск</город>
			<улица>Пушкина</улица>
			<дом>29</дом>
			<квартира>48</квартира>
		</адрес>
	</student>'
where STUDENT.INFO.value('(/student/адрес/дом)[1]', 'int') = 17;
select SECOND_NAME, FIRST_NAME, FATHER_NAME, 
	INFO.value('(student/pasport/@серия)[1]', 'char(2)') 'Серия паспорта',
	INFO.value('(student/pasport/@номер)[1]', 'varchar(10)') 'Номер паспорта'
from STUDENT where STUDENT.SECOND_NAME = 'Лук';
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
	<xs:element name="студент">  
		<xs:complexType>
			<xs:sequence>
				<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
					<xs:complexType>
						<xs:attribute name="серия" type="xs:string" use="required" />
						<xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
						<xs:attribute name="дата"  use="required" >  
							<xs:simpleType> 
								<xs:restriction base ="xs:string">
									<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType> 
				</xs:element>
				<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
				<xs:element name="адрес">
					<xs:complexType>
						<xs:sequence>
							<xs:element name="страна" type="xs:string" />
							<xs:element name="город" type="xs:string" />
							<xs:element name="улица" type="xs:string" />
							<xs:element name="дом" type="xs:string" />
							<xs:element name="квартира" type="xs:string" />
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
		'<студент>
			<паспорт серия="НB" номер="6799765" дата="25.10.2011"/>
			<телефон>2434353</телефон>
			<адрес>
				<страна>Беларусь</страна>
				<город>Минск</город>
				<улица>Белорусская</улица>
				<дом>19</дом>
				<квартира>416</квартира>
			</адрес>
		</студент>');
select * from STUDENT;
--6
--===========================================================================

--7
--===========================================================================
select rtrim(FACULTY.FACULTY) as '@код',
	(select COUNT(*) from PULPIT 
		where PULPIT.FACULTY = FACULTY.FACULTY) as 'количество_кафедр',
	(select rtrim(PULPIT.PULPIT) as '@код',
		(select rtrim(TEACHER.TEACHER) as 'преподаватель/@код',
			TEACHER.FIRST_NAME as 'преподаватель'
		from TEACHER where TEACHER.PULPIT = PULPIT.PULPIT
		for xml path(''),type, root('преподаватели'))
	from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY 
		for xml path('кафедра'), type, root('кафедры')) 
from FACULTY
for xml path('факультет'), type, root('университет')
