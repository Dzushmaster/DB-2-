use TMPKM_UNIVER

insert into FACULTY (FACULTY, FACULTY_NAME)
	values
	('ТТЛП', 'Технологии и техника лесной промышленности'),
	('ТОВ','Технологии органических веществ'),
	('ХТиТ','Химические технологии и техника'),
	('ИЭФ','Инженерно-экономический'),
	('ЛХ','Лесохозяйственный'),
	('ИДиП','Издательское дело и полиграфия'),
	('ИТ','Информацинных технологий')
insert into PROFESSION (PROFESSION, FACULTY, PROFESSION_NAME, QUALIFICATION)
	values 
	('1-36 06 01',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП'),'Полиграфическое оборудование и системы обработки информации','инженер-электромеханик'),
	('1-36 07 01',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ХТиТ'),'Машины и аппараты химических производств и предприятий строительных материалов','инженер-программист-системотехник'),
	('1-40 01 02',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИТ')  ,'Информационные системы и технологии','инженер-программист-системотехник'),
	('1-46 01 01',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП'),'Лесоинженерное дело','инженер-технолог'),
	('1-47 01 01',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП'),'Издательско дело','редактор-технолог'),
	('1-48 01 02',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТОВ') ,'Химическая технология органических веществ, материалов и изделий','инженер-химик-технолог'),
	('1-48 01 05',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТОВ') ,'Химическая технология переработки древесины','инженер-химик-технолог'),
	('1-54 01 03',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТОВ') ,'Физико-химические методы и приборы контроля качества продукции','инженер по сертификации'),
	('1-75 01 01',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ') ,'Лесное хозяйство','инженер лесного хозяйства'),
	('1-75 02 01',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ') ,'Садово-парковое строительство','инженер садово-паркового строительства'),
	('1-89 02 02',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ') ,'Туризм и природопользование','специалист в сфере туризма')

insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY)
	values
	('РИТ','Редакционно-издательских технологий',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП')),
	('СБУАиА','Статистики, бухгалтерского учета, анализа и аудита',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИЭФ')),
	('ТДП','Технологий деревообрабатывающих производств',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП')),
	('ТиДИД','Технологии и дизайна изделий из древесины',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП')),
	('ТиП','Туризма и природопользования',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ')),
	('ТЛ','Транспорта леса',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП')),
	('ИСиТ','Информационные системы и технологии',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИТ')),
	('ЛВ','Лесоводство',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ')),
	('ПОиСОИ','Полиграфическое оборудование и системы обработки информации',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП')),
	('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ХТиТ')),
	('ТНХСиППМ','Технологии нефтехимического синтеза и переработки полимерных материалов',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТОВ')),
	('ХПД','Химической переработки древесины',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТОВ')),
	('ОВ','Органических веществ',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТОВ')),
	('МиЭП','Менеджмента, технологий бизнеса и устойчивого развития',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИЭФ')),
	('ХТЭПиМЭЕ','Химии, технологии электрохимических производст и материалов электронной техники',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ХТиТ')),
	('ЭТиМ','Экономической теории и маркетинга',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИЭФ'))

insert into TEACHER (TEACHER, SECOND_NAME, FIRST_NAME, FATHER_NAME, GENDER, PULPIT)
	values
	('НСКВ','Носков','Михаил','Трофимович',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ТДП')),
	('ПРКП','Прокопенко','Николай','Иванович',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ТНХСиППМ')),
	('МРЗВ','Морозова','Елена','Степановна',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('РВКС','Ровкас','Андрей','Петрович',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ОВ')),
	('РЖКВ','Рыжиков','Леонид','Николаевич',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ЛВ')),
	('РМНВ','Романов','Дмитрий','Михайлович',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('СМЛВ','Смелов','Владимир','Владиславович',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('КРЛВ','Крылов','Павел','Павлович',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('ЧРН', 'Чернова','Анна','Викторовна',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ХПД')),
	('МХВ', 'Мохов','Михаил','Сергеевич',NULL ,(select PULPIT.PULPIT from PULPIT where PULPIT = 'ПОиСОИ'))

insert into SUBJECT_ (SUBJECT_, SUBJECT_NAME, PULPIT)
	values
	('БД','Базы данных',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('ОАиП','Основы алгоритмизации и программирования',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('ПЗ','Представление знаний в компьютерных системах',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('ПИС','Проектирование информационных систем',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('ПСП','Программирование сетевых приложений',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('ПЭХ','Прикладная электрохимия',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ХТЭПиМЭЕ')),
	('СУБД','Системы управления базами данных',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ИСиТ')),
	('ТиОЛ','Технология и оборудование лесозагатовок',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ТиП')),
	('ТРИ','Технология резиновых изделий',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ТНХСиППМ')),
	('ЭП','Экономика природопользования',(select PULPIT.PULPIT from PULPIT where PULPIT = 'МиЭП')),
	('ЭТ','Экономическая теория',(select PULPIT.PULPIT from PULPIT where PULPIT = 'ЭТиМ'))

insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
	values
	('ЛБ-Х','Химическая лаборатория'),
	('ЛБ-К','Компьютерный класс'),
	('ЛБ-СК','Спец. компьютерный класс'),
	('ЛК','Лекционная'),
	('ЛК-К','Лекционная с уст.проектором');

insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
	values
	('301-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК'),'15','301-1'),--
	('304-4',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛБ-К'),'90','304-4'),
	('313-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК-К'),'60','313-1'),
	('314-4',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК'),'90','314-4'),
	('320-4',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК'),'90','320-4'),
	('324-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК-К'),'50','324-1'),
	('413-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛБ-К'),'15','413-1'),
	('423-1',(select AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛБ-К'),'90','423-1')


insert into GROUP_ (IDGROUP, FACULTY, PROFESSION, YEAR_FIRST)
	values
	('22',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ'),  (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-75 02 01'),'2011'),
	('23',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ'),  (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-89 02 02'),'2012'),
	('24',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ЛХ'),  (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-89 02 02'),'2011'),
	('25',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП'),(select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-46 01 01'),'2013'),
	('26',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП'),(select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-46 01 01'),'2012'),
	('27',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ТТЛП'),(select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-46 01 01'),'2012'),
	('28',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2013'),
	('29',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2012'),
	('30',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2010'),
	('31',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2013'),
	('32',(select FACULTY.FACULTY from FACULTY where FACULTY = 'ИДиП'), (select PROFESSION.PROFESSION from PROFESSION where PROFESSION ='1-47 01 01'),'2012')

insert into STUDENT (IDGROUP, SECOND_NAME, FIRST_NAME, FATHER_NAME, BDAY)
	values
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '22'),'Пугач', 'Михаил', 'Трофимович',    '1996-02-01'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '23'),'Авдеев','Николай','Николаевич',    '1996-07-19'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '24'),'Белова','Елена ', 'Степановна',    '1996-05-22'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '25'),'Вилков','Андрей', 'Петрович',      '1996-12-08'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '26'),'Грушин','Леонид', 'Николаевич',    '1995-11-11'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '27'),'Дунаев','Дмитрий','Михайлович',    '1996-08-24'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '28'),'Клуни', 'Иван',   'Владиславович', '1996-09-15'),
	((select GROUP_.IDGROUP from GROUP_ where IDGROUP = '29'),'Крылов','Олег',   'Павлович',      '1996-10-16')

insert into PROGRESS (SUBJECT_, IDSTUDENT, PDATE, NOTE)
	values
	('ОАиП',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1000'),'12/01/2014','4'),
	('ОАиП',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1001'),'19/01/2014','5'),
	('ОАиП',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1003'),'08/01/2014','9'),
	('БД',  (select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1004'),'11/01/2014','8'),
	('БД',  (select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1005'),'15/01/2014','4'),
	('СУБД',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1006'),'16/01/2014','7'),
	('СУБД',(select STUDENT.IDSTUDENT from STUDENT where IDSTUDENT = '1007'),'27/01/2014','6')


