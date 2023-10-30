use [SD32-Company]
go

--Department

create rule r1 as @x in ('ny','ds','kw')

create default d1 as 'ny'

sp_addtype loc , 'nchar(2)'

sp_bindrule r1 , loc

sp_bindefault d1 , loc

create table Department
(
deptno int identity(1,1) ,
deptname varchar(50) ,
location loc 

constraint c1 primary key(deptno)
)

insert into Department values('Research','NY'),('Accounting','DS'),('Markiting','KW')

---- Employee
create rule r2 as @y<6000

sp_bindrule r2 ,'Employee.salary'

create table Employee 
(
EmpNo int ,
Fname varchar(50) not null ,
Lname varchar(50) not null ,
DeptNo	int ,
Salary  int

constraint c2 primary key (EmpNo) ,
constraint c3 foreign key (DeptNo) references Department(deptno) ,
constraint c4 unique (salary) 


)



insert into Employee values (25348,'Mathew','Smith',3,2500),(10102,'Ann','Jones',3,3000),(18316,'John','Barrimore',1,2400)
,(29346,'James','James'	,2,2800),(9031,'Lisa','Bertoni',2,4000),(2581,'Elisa','Hansel',2,3600),(28559,'Sybl','Moser',1,2900)

---- Project

create table Project
(
projectno int primary key identity(1,1),
projectname varchar(50) not null ,
budget int 

)

insert into Project values('Apollo',120000),('Gemini',95000),('Mercury',185600)

-----Works_on (visually)

----
/*1-Add  TelephoneNumber column to the employee table[programmatically]*/

alter table employee  add  TelephoneNumber int 

/*2-drop this column[programmatically]*/

alter table employee drop column TelephoneNumber

/*2.	Create the following schema and transfer the following tables to it 
a.	Company Schema 
i.	Department table (Programmatically)
ii.	Project table (visually)*/

create schema company

alter schema company transfer Department

/*b.	Human Resource Schema
i.	  Employee table (Programmatically)*/


create schema hr

alter schema hr transfer Employee

/*3.	 Write query to display the constraints for the Employee table.*/

select * 
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME= 'Employee'

/*4.	Create Synonym for table Employee as Emp */

CREATE SYNONYM emp
for hr.employee

/*5.	Increase the budget of the project where the manager number is 10102 by 10%.*/

update company.Project set budget =budget*1.1
from company.Project p join works_on w
on p.projectno = w.projectno
where empno=10102

/*6.	Change the name of the department for which the employee named James works.The new department name is Sales.*/

update company.department
set deptname='sales'
from company.department d join hr.employee e
on d.deptno=e.deptno
where fname = 'James'

/*7.	Change the enter date for the projects for those employees 
who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.*/

update works_on 
set date = '12/12/2007'
from works_on w join hr.employee e
on w.empno = e.empno
join company.department d
on e.deptno=d.deptno
where Projectno= 1 and d.deptname='sales'

/*8.	Delete the information in the works_on table for all employees who work for the department located in KW.*/

delete from works_on
where empno in (select empno from hr.employee e join company.Department d on e.deptno=d.deptno where location in ('kw'))