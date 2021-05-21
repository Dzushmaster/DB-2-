use TMPKM_UNIVER

insert into FACULTY (FACULTY, FACULTY_NAME)
	values
	('����', '���������� � ������� ������ ��������������'),
	('���','���������� ������������ �������'),
	('����','���������� ���������� � �������'),
	('���','���������-�������������'),
	('��','�����������������'),
	('����','������������ ���� � ����������'),
	('��','������������� ����������')
insert into PROFESSION (PROFESSION, FACULTY, PROFESSION_NAME, QUALIFICATION)
	values 
	('1-36 06 01',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'),'��������������� ������������ � ������� ��������� ����������','�������-��������������'),
	('1-36 07 01',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'),'������ � �������� ���������� ����������� � ����������� ������������ ����������','�������-�����������-�������������'),
	('1-40 01 02',(select FACULTY.FACULTY from FACULTY where FACULTY = '��')  ,'�������������� ������� � ����������','�������-�����������-�������������'),
	('1-46 01 01',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'),'�������������� ����','�������-��������'),
	('1-47 01 01',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'),'����������� ����','��������-��������'),
	('1-48 01 02',(select FACULTY.FACULTY from FACULTY where FACULTY = '���') ,'���������� ���������� ������������ �������, ���������� � �������','�������-�����-��������'),
	('1-48 01 05',(select FACULTY.FACULTY from FACULTY where FACULTY = '���') ,'���������� ���������� ����������� ���������','�������-�����-��������'),
	('1-54 01 03',(select FACULTY.FACULTY from FACULTY where FACULTY = '���') ,'������-���������� ������ � ������� �������� �������� ���������','������� �� ������������'),
	('1-75 01 01',(select FACULTY.FACULTY from FACULTY where FACULTY = '��') ,'������ ���������','������� ������� ���������'),
	('1-75 02 01',(select FACULTY.FACULTY from FACULTY where FACULTY = '��') ,'������-�������� �������������','������� ������-��������� �������������'),
	('1-89 02 02',(select FACULTY.FACULTY from FACULTY where FACULTY = '��') ,'������ � ������������������','���������� � ����� �������')

insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY)
	values
	('���','�����������-������������ ����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '����')),
	('������','����������, �������������� �����, ������� � ������',(select FACULTY.FACULTY from FACULTY where FACULTY = '���')),
	('���','���������� �������������������� �����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '����')),
	('�����','���������� � ������� ������� �� ���������',(select FACULTY.FACULTY from FACULTY where FACULTY = '����')),
	('���','������� � ������������������',(select FACULTY.FACULTY from FACULTY where FACULTY = '��')),
	('��','���������� ����',(select FACULTY.FACULTY from FACULTY where FACULTY = '����')),
	('����','�������������� ������� � ����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '��')),
	('��','�����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '��')),
	('������','��������������� ������������ � ������� ��������� ����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '����')),
	('�������','���������� �������������� ������� � ����� ���������� ����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '����')),
	('��������','���������� ���������������� ������� � ����������� ���������� ����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '���')),
	('���','���������� ����������� ���������',(select FACULTY.FACULTY from FACULTY where FACULTY = '���')),
	('��','������������ �������',(select FACULTY.FACULTY from FACULTY where FACULTY = '���')),
	('����','�����������, ���������� ������� � ����������� ��������',(select FACULTY.FACULTY from FACULTY where FACULTY = '���')),
	('��������','�����, ���������� ����������������� ���������� � ���������� ����������� �������',(select FACULTY.FACULTY from FACULTY where FACULTY = '����')),
	('����','������������� ������ � ����������',(select FACULTY.FACULTY from FACULTY where FACULTY = '���'))

insert into TEACHER (TEACHER, SECOND_NAME, FIRST_NAME, FATHER_NAME, GENDER, PULPIT)
	values
	('����','������','������','����������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '���')),
	('����','����������','�������','��������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '��������')),
	('����','��������','�����','����������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('����','������','������','��������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '��')),
	('����','�������','������','����������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '��')),
	('����','�������','�������','����������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('����','������','��������','�������������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('����','������','�����','��������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('���', '�������','����','����������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '���')),
	('���', '�����','������','���������',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = '������'))

insert into SUBJECT_ (SUBJECT_, SUBJECT_NAME, PULPIT)
	values
	('��','���� ������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('����','������ �������������� � ����������������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('��','������������� ������ � ������������ ��������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('���','�������������� �������������� ������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('���','���������������� ������� ����������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('���','���������� ������������',(select PULPIT.PULPIT from PULPIT where PULPIT = '��������')),
	('����','������� ���������� ������ ������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('����','���������� � ������������ �������������',(select PULPIT.PULPIT from PULPIT where PULPIT = '���')),
	('���','���������� ��������� �������',(select PULPIT.PULPIT from PULPIT where PULPIT = '��������')),
	('��','��������� ������������������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����')),
	('��','������������� ������',(select PULPIT.PULPIT from PULPIT where PULPIT = '����'))

insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
	values
	('��-�','���������� �����������'),
	('��-�','������������ �����'),
	('��-��','����. ������������ �����'),
	('��','����������'),
	('��-�','���������� � ���.����������');

insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
	values
	('301-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��'),'15','301-1'),--
	('304-4',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��-�'),'90','304-4'),
	('313-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��-�'),'60','313-1'),
	('314-4',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��'),'90','314-4'),
	('320-4',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��'),'90','320-4'),
	('324-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��-�'),'50','324-1'),
	('413-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��-�'),'15','413-1'),
	('423-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��-�'),'90','423-1')


insert into GROUP_ (IDGROUP, FACULTY, PROFESSION, YEAR_FIRST)
	values
	('22',(select FACULTY.FACULTY from FACULTY where FACULTY = '��'),  (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-75 02 01'),'2011'),
	('23',(select FACULTY.FACULTY from FACULTY where FACULTY = '��'),  (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-89 02 02'),'2012'),
	('24',(select FACULTY.FACULTY from FACULTY where FACULTY = '��'),  (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-89 02 02'),'2011'),
	('25',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'),(select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-46 01 01'),'2013'),
	('26',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'),(select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-46 01 01'),'2012'),
	('27',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'),(select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-46 01 01'),'2012'),
	('28',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2013'),
	('29',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2012'),
	('30',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2010'),
	('31',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2013'),
	('32',(select FACULTY.FACULTY from FACULTY where FACULTY = '����'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2012')

insert into STUDENT (IDGROUP, SECOND_NAME, FIRST_NAME, FATHER_NAME, BDAY)
	values
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '22'),'�����', '������', '����������',    '1996-02-01'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '23'),'������','�������','����������',    '1996-07-19'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '24'),'������','����� ', '����������',    '1996-05-22'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '25'),'������','������', '��������',      '1996-12-08'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '26'),'������','������', '����������',    '1995-11-11'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '27'),'������','�������','����������',    '1996-08-24'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '28'),'�����', '����',   '�������������', '1996-09-15'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '29'),'������','����',   '��������',      '1996-10-16')

insert into PROGRESS (SUBJECT_, IDSTUDENT, PDATE, NOTE)
	values
	('����',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1000'),'12/01/2014','4'),
	('����',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1001'),'19/01/2014','5'),
	('����',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1003'),'08/01/2014','9'),
	('��',  (select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1004'),'11/01/2014','8'),
	('��',  (select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1005'),'15/01/2014','4'),
	('����',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1006'),'16/01/2014','7'),
	('����',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1007'),'27/01/2014','6')


