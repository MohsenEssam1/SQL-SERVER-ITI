use AdventureWorks2012
go

/*1.	Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema)
to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’*/

SELECT SalesOrderID, ShipDate 
from Sales.SalesOrderHeader
where ShipDate between '7/28/2002' and '7/29/2014 ' 

/*2.	Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)*/

select ProductID , Name
from Production.Product
where StandardCost <110

/*3.	Display ProductID, Name if its weight is unknown*/

select ProductID , Name
from Production.Product
where weight is  null 

/*4.	 Display all Products with a Silver, Black, or Red Color*/

select *
from Production.Product
where Color in ('Silver','Black','Red')

/*5.	 Display any Product with a Name starting with the letter B*/

select *
from Production.Product
where Name like 'b%'

/*6.	Run the following Query
then write a query that displays any Product description with underscore value in its description.*/

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select *
from Production.ProductDescription
where Description like'%[_]%'

/*7.	Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table 
for the period between  '7/1/2001' and '7/31/2014'*/

select sum(TotalDue) sum_of_TotalDue ,OrderDate
from Sales.SalesOrderHeader 
where ShipDate between '7/1/2001' and '7/31/2014'
group by OrderDate

/*8.	 Display the Employees HireDate (note no repeated values are allowed)*/

select distinct (hiredate)
from HumanResources.Employee

/*9.	 Calculate the average of the unique ListPrices in the Product table*/

select avg( distinct ListPrice) as unique_avg
from Production.Product

/*10.	Display the Product Name and its ListPrice within the values of 100 and 120
the list should has the following format "The [product name] is only! [List price]" 
(the list will be sorted according to its ListPrice value)*/

select 'the '+ name +' is only! ' +convert(varchar(50),ListPrice) as product_price
from Production.Product
where ListPrice between 100 and 120
order by ListPrice

/*11.   a) Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table
in a newly created table named [store_Archive]
Note: Check your database to see the new table and how many rows in it?*/


select rowguid ,Name, SalesPersonID, Demographics into store_Archive
from Sales.Store

select *
from store_Archive


/*b)	Try the previous query but without transferring the data? */

select rowguid ,Name, SalesPersonID, Demographics into store_Archive2
from Sales.Store
where 1=2

/*12.	Using union statement, retrieve the today’s date in different styles*/


select format(GETDATE(),'mm/dd/yyyy') 
union
select format(GETDATE(),'dd/mm/yyyy') 
union
select format(GETDATE(),'mmmm/dddd/yyyy') 
union
select format(GETDATE(),'dddd mmmm yyyy') 
union
select format(GETDATE(),'mm/dd/yyyy') 
union
select format(GETDATE(),'dddd') 
union
select format(GETDATE(),'mmmm') 
union
select format(GETDATE(),'hh:mm:ss') 
union
select format(GETDATE(),'hh tt') 
union
select format(GETDATE(),'mm/dd/yyyy') 
union
select format(eomonth(GETDATE()),'mm/dd/yyyy')
union
select convert (varchar(10),GETDATE(),102) 
union
select convert (varchar(10),GETDATE(),103) 
union
select convert (varchar(10),GETDATE(),104)
union
select convert (varchar(10),GETDATE(),105) 


select @@VERSION
select @@SERVERNAME


