USE [КаминскийПРОДАЖИ]
select * from ТОВАРЫ
join ЗАКАЗЫ on ТОВАРЫ.Наименование = ЗАКАЗЫ.Наименование_товара
where ЗАКАЗЫ.Дата_поставки > '20.05.2021'