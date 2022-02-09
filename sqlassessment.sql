CREATE TABLE Salesman
    (     
SalesmanId int  ,
SalesmanName VARCHAR(50),
Experience int
    )

insert into Salesman(SalesmanId,SalesmanName,Experience)
values('1','a','10'),
      ('2','b','12'),
	  ('3','c','11'),
	  ('4','d','7'),
	  ('5','e','10'),
	  ('6','f','8'),
      ('7','g','6'),
	  ('8','h','5'),
	  ('9','i','10'),
	  ('10','j','7');


CREATE TABLE Orders
    (     
OrderId int,
Amount int,
ProductName VARCHAR(50),
OrderDate DATE ,
CustomerId int
    )

insert into Orders(OrderId,Amount,ProductName,OrderDate,CustomerId)
values('1001','8000','mobile','2022-01-2','1'),
      ('1002','40000','laptop','2022-01-5','2'),
	  ('1003','4000','printer','2022-01-7','3'),
	  ('1004','11000','monitor','2022-01-11','4'),
	  ('1005','15000','tv','2022-01-15','5'),
	  ('1006','100','watch','2022-01-17','4'),
      ('1007','250','speaker','2022-01-21','2'),
	  ('1008','500','pendrive','2022-02-4','5'),
	  ('1009','3000','harddisk','2022-02-5','3'),
	  ('1010','400','memory card','2022-02-7','1');

CREATE TABLE Deliveries
(
Id int, 
OrderId int, 
Commission int,
DeliveredDate DATE,
SalesmanId int
)
insert into Deliveries(id,OrderId,Commission,DeliveredDate,SalesmanId)
values('1','1001','200','2022-01-05','1'),
      ('2','1008','400','2022-01-29','2'),
	  ('3','1004','300','2022-01-25','3'),
	  ('4','1003','100','2022-01-12','4'),
	  ('5','1007','200','2022-01-20','5'),
	  ('6','1005','350','2022-02-05','4'),
      ('7','1006','260','2022-01-29','2'),
	  ('8','1002','150','2022-01-25','5'),
	  ('9','1009','200','2022-01-12','3'),
	  ('10','1010','350','2022-02-06','1');
CREATE TABLE Customer
(
CustomerId int,
CustomerName VARCHAR(50),
City VARCHAR(50),
ContactNumber VARCHAR(10)
)



insert into Customer(CustomerId,CustomerName,City,ContactNumber)
values('1','kumar','madurai','9202020202'),
      ('2','mani','trichy','9542586312'),
	  ('3','rahul','chennai','9726851423'),
	  ('4','ram','bangalore','9402147362'),
	  ('5','vijay','mumbai','9845612371'),
	  ('6','siva','coimbatore','8824715637'),
      ('7','mithun','karur','8047123647'),
	  ('8','kiran','vilupuram','8704487410'),
	  ('9','naveen','kodaikanal','8222546575'),
	  ('10','hari','chennai','8401571141');

/* 1. Display the orderNo followed by orderDate and the Amount for each order which will be delivered by the salesman who is holding the ID 4. */

select Orders.OrderId,Orders.OrderDate,Orders.Amount from Orders inner join Deliveries on Orders.OrderId=Deliveries.OrderId where SalesmanId='4';


/* 2. Display OrderNo,SalesmanName,CustomerName,City using Joins. */

select  Orders.OrderId,Salesman.SalesmanName,Customer.CustomerName,Customer.City from 
Orders inner join Customer on Orders.CustomerId=Customer.CustomerId 
inner join Deliveries on Orders.OrderId=Deliveries.OrderId 
inner join Salesman on Deliveries.SalesmanId=Salesman.SalesmanId


/* 3. Display the order details from orders table from orderDate(01-01-2022 to CurrentDate) */

select * from Orders where OrderDate between '2022-01-01' and GETDATE();

/* 4. Display the count of orders where Amount is more than 100.  */

select count(OrderId) as 'ordercount' from Orders where Amount >= 100

/* 5. Display SalesmanName,Experience who have highest exeprience. */

select SalesmanName, Experience from Salesman where Experience = ( select max(Experience) from Salesman )

/* 6. Display CustomerName,OrderDate,Amount who have purchases highest amount  */

select Customer.CustomerName,Orders.OrderDate,Orders.Amount from 
Orders inner join Customer on Customer.CustomerId = Orders.CustomerId where Amount=( select max(Amount) from Orders )

/* 7. Display SalesmanName,Commission who completed maximum number of order in one day and Display the total amount of commission.(using DeliveredDate) */

select Salesman.SalesmanName,sum(Deliveries.Commission) as 'Total' from 
Deliveries inner join Salesman on Deliveries.SalesmanId=Salesman.SalesmanId where Deliveries.DeliveredDate='2022-01-25' 
group by Salesman.SalesmanName

/* 8. Display CustomerName,City,OrderId,OrderDate who have order last  */

select Customer.CustomerName,Customer.City,Orders.OrderId,Orders.OrderDate from Orders inner join Customer on Orders.CustomerId=Customer.CustomerId where OrderDate=(select max(OrderDate) from Orders)

/* 9. Display SalesmanName,TotalAmount,Number of orders any one of salesman  */

select Salesman.SalesmanName,sum(Orders.Amount) as 'total',count(Orders.OrderId) as numberoforder
from Orders
inner join Customer on Orders.CustomerId=Customer.CustomerId
inner join Deliveries on Orders.OrderId=Deliveries.OrderId
inner join Salesman on Deliveries.SalesmanId=Salesman.SalesmanId
where Salesman.SalesmanId = 5  group by Salesman.SalesmanName

/* 10. Display CustomerName and City where customeName starts with letter 's'.  */

select CustomerName,City from Customer where CustomerName like 's%'