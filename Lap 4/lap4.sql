use Company_SD
go


/*1.	Display (Using Union Function)
a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
b.	 And the male dependence that depends on Male Employee.*/


select Dependent_name , d.Sex 
from Dependent d join Employee e
on d.ESSN=e.SSN
where  e.Sex='f' and d.Sex='f'

union 

select Dependent_name , d.Sex 
from Dependent d join Employee e
on d.ESSN=e.SSN
where  e.Sex='m' and d.Sex='m'



/*2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.*/

select  sum(hours) as sum_hours ,pname 
from Project p join Works_for w
on p.Pnumber=w.Pno
group by Pname


/*3.	Display the data of the department which has the smallest employee ID over all employees' ID.*/

select d.*
from Departments d join Employee e
on d.Dnum=e.Dno
where e.SSN =(select min(SSN) from Employee)

/*4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.*/


select dname,max(salary) as max_salary , min(salary) as min_salary , avg(salary) as avg_salary
from Employee e join Departments d
on e.Dno=d.Dnum
group by dname


/*5.	List the last name of all managers who have no dependents.*/

select lname
from Employee e  join Departments d
on e.SSN=d.MGRSSN
where d.MGRSSN not in (select essn from Dependent)


/*6.	For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.*/

select dnum , dname ,count(e.SSN) as emp_number
from Departments d join Employee e
on d.Dnum=e.Dno
group by dnum , dname 
having AVG(e.Salary)<all(select AVG(salary) from Employee)

/*7.	Retrieve a list of employees and the projects they are working on ordered by department and within each department, ordered alphabetically by last name, first name.*/

select e.Fname ,e.Lname , Pname 
from Employee e join Departments d
on e.Dno=d.Dnum
join Project p on p.Dnum=d.Dnum
order by  d.Dnum ,2,1


/*8.	Try to get the max 2 salaries using subquery*/

select top 2 salary from Employee order by Salary desc

----
select max(salary)
from Employee

union all

select MAX(salary)
from Employee
where Salary not in (select max(Salary) from Employee)


/*9.	Get the full name of employees that is similar to any dependent name*/

select fname + ' ' +lname as full_name
from Employee
where fname + ' '+lname in (select Dependent_name from Dependent )

/*10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% */

update Employee set Salary = salary *1.3
where SSN in (select essn from Works_for join Project on Pno =Pnumber where Pname='Al Rabwah')

/*11.	Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.*/

select ssn , fname + ' ' +Lname as full_name
from Employee
where exists (select 1 from Dependent where ESSN=SSN)

/*1. In the department table insert new department called "DEPT IT" , with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'*/
insert into Departments values('IT',100,112233,11/1/2006)

/*2.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 
a.	First try to update her record in the department table
b.	Update your record to be department 20 manager.
c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)*/


update Departments set MGRSSN=968574 where Dnum=100

update Departments set MGRSSN=102672 where Dnum=20

update Employee set Superssn=102672 where SSN=102660



/*3.Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).
*/

update Departments set MGRSSN=102672 where MGRSSN=223344

update Employee set Superssn=102672 where Superssn=223344

delete from Dependent where ESSN=223344

delete from Works_for  where ESSN=223344

delete from Employee where ssn=223344


