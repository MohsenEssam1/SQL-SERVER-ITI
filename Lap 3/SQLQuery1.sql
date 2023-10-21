use company_sd
go

/*1.	Display the Department id, name and id and the name of its manager.*/

select dnum , fname + ' ' + lname as manager_name , ssn
from Departments join Employee
on SSN = MGRSSN


/*2.	Display the name of the departments and the name of the projects under its control.*/

select d.dname , p.pname
from Departments d join Project p
on d.Dnum=p.Dnum
order by d.Dname


/*3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.*/

select d.* , e.fname +' ' +e.lname as emp_name
from Dependent d join Employee e
on d.ESSN = e.SSN


/*4.	Display the Id, name and location of the projects in Cairo or Alex city.*/

select pnumber  , pname , plocation 
from Project
where city in ('cairo' , 'alex')


/*5.	Display the Projects full data of the projects with a name starts with "a" letter.*/

select *
from Project
where pname like ('a%')


/*6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly*/

select *
from Employee
where Dno = 30 and Salary between 1000 and 2000


/*7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.*/

select e.fname +' ' +e.lname as emp_name 
from Employee e join Departments d
on e.Dno= d.Dnum
join works_for w
on e.SSN=w.ESSn
join Project p
on p.Pnumber=w.Pno
where d.Dnum=10
and w.Hours >= 10
and p.Pname='AL Rabwah'



/*8.	Find the names of the employees who directly supervised with Kamel Mohamed.*/

select e.fname +' ' +e.lname as emp_name 
from Employee e, Employee s
where s.SSN=e.Superssn
and s.Fname ='Kamel'
and s.Lname='Mohamed'



/*9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.*/
select e.* , p.pname
from Employee e join Works_for w
on e.SSN= w.ESSn
join Project p
on p.Pnumber=w.Pno
order by p.pname


/*10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.*/
select p.pname , d.dnum , e.lname ,e.address , e.bdate
from Project p join Departments d
on p.Dnum=d.Dnum
join Employee e
on e.SSN= d.MGRSSN
where p.City = 'cairo'



/*11.	Display All Data of the mangers*/

select e.*
from Employee e join Departments d
on e.SSN=d.MGRSSN

/*12.	Display All Employees data and the data of their dependents even if they have no dependents*/

select e.* , d.*
from Employee e left join Dependent d
on e.SSN= d.ESSN

/*1.  Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.*/
insert into Employee (fname,lname,Dno,SSN,Superssn,salary,bdate,sex)values('mohsen','essam',30,102672,112233,3000,7/23/2001,'m')


/*2.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.*/

insert into Employee (fname , lname ,dno,ssn)values('omar','ali',30,102660)

/*3.	Upgrade your salary by 20 % of its last value.*/

update Employee
set Salary = Salary +.2*Salary
where fname='mohsen'