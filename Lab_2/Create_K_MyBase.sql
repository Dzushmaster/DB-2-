create database K_MyBase;
go
use K_MyBase;
go
create table Department(
						Department nvarchar(30) primary key not null,
						Number_of_Employes int
						)
go
insert into Department(Department,Number_of_Employes)
		values
		('Sales',150),
		('Shopping',50),
		('Lies',203),
		('Hours',1),
		('PR',20),
		('Security',30);
go
create table Products(
					  Order_number int	primary key not null,
					  Product_name nvarchar(50),
					  Specification nvarchar(50),
					  Cost int check (Cost>0),
					  Amount int check (Amount>0)
					  );
go
insert into Products (Order_number, Product_name, Specification, Cost, Amount)
		values
		(19881512, 'Chair', 'For sitting',29 , 20),
		(19881519, 'Pen', 'Why r u buying it?', 9, 45),
		(19881520, 'Pencil', 'It wooden too', 6, 38),
		(19881545, 'Table', 'It wooden', 75, 40),
		(19881515, 'Water', 'You can drink it', 4, 82),
		(19881580, 'Clocks', 'Cheap clocks', 2, 100)

create table Purchases(
					   Department nvarchar(30) foreign key references Department(Department) not null,
					   Id_Employee int Identity(1000,1),
					   Limit_rate int,
					   Order_number int check(Order_number>0),
					   Amount_spent int check(Amount_spent > 0),
					   )
go
insert into Purchases(Department, Limit_rate, Order_number, Amount_spent)
		values
		 ((select distinct 'Sales'    from Department),     1090, (select distinct 19881512 from Products), 580 ), 
		 ((select distinct 'PR'	     from Department),	   800 ,  (select distinct 19881519 from Products), 405 ),	   
		 ((select distinct 'Lies'     from Department),	   400 ,  (select distinct 19881520 from Products), 228 ),	   
		 ((select distinct 'Shopping' from Department),     3500, (select distinct 19881545 from Products), 3000), 	   
		 ((select distinct 'Security' from Department),	   400 ,  (select distinct 19881515 from Products), 328 ),	   
		 ((select distinct 'Hours'    from Department),     320 , (select distinct 19881580 from Products), 200 );
go
