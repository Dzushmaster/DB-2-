use K_MyBase
select * from Товары
select * from Сотрудники
select * from Отделы

select Товары.Название, Товары.Описание from Товары 
select count(*) from Товары

select * from Отделы
where Отделы.Количество_сотрудников>1

select distinct top(5) * from Сотрудники order by Предельная_норма_расхода desc -- desc == сортировка по убыванию

update Товары set Продано = 20 where Продано=10
select * from Товары

select * from Товары where Товары.Название like 'С%' or  Товары.Стоимость between 320 and 1000