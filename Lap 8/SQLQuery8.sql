use iti
go

/*Create a view that displays student full name, course name if the student has a grade more than 50*/

create view s1
as 
select (st_fname + ' '+st_lname)as full_name , crs_name
from Student s join Stud_Course sc on s.St_Id=sc.St_Id
join Course c on c.Crs_Id=sc.Crs_Id
where sc.Grade>50

/*2.Create an Encrypted view that displays manager names and the topics they teach. */

create view mgr
with encryption
as
select ins_name , top_name 
from Instructor i join Department d on i.Ins_Id=d.Dept_Manager
join Ins_Course inc on i.Ins_Id=inc.Ins_Id
join Course c on inc.Crs_Id=c.Crs_Id
join Topic t on c.Top_Id=t.Top_Id

/*3.Create a view that will display Instructor Name, 
Department Name for the ‘SD’ or ‘Java’ Department 
“use Schema binding” and describe what is the meaning of Schema Binding*/

create view sd_java
with schemabinding
as
select ins_name , Dept_Name
from dbo.Instructor i join dbo.Department d on i.Dept_Id=d.Dept_Id
where Dept_Name in ('SD' , 'Java')

/*SCHEMABINDING binds the view to the schema of the underlying
tables, restricting any changes in the base table that would
impact the view definition. */

/*Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
Note: Prevent the users to run the following query 
Update V1 set st_address=’tanta’
Where st_address=’alex’;*/

create view v11
as 
select * from Student
where St_Address in ('alex','cairo')
with check option

/*5.Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen?*/

create nonclustered index hd
on department(Manager_hiredate)

/*6.Create index that allow u to enter unique ages in student table. What will happen?*/

create unique index age
on student(st_age)

/*7.Create temporary table [Session based] on Company DB to save employee name and his today task.*/
use Company_SD
go

CREATE TABLE EmployeeTasks (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    TodayTask VARCHAR(255)
);

-- Insert sample data (replace with actual data)
INSERT INTO EmployeeTasks (EmployeeID, EmployeeName, TodayTask)
VALUES
    (1, 'John Doe', 'Complete project report'),
    (2, 'Jane Smith', 'Attend team meeting');

/*8.Create a view that will display the project name and the number of employees work on it. “Use Company DB”*/

create view p1
as
select p.pname , count(e.ssn) as count_of_emp
from Project p join Works_for w  on p.Pnumber=w.Pno
join Employee e on w.ESSn=e.SSN
group by p.Pname 

/*9.Using Merge statement between the following two tables [User ID, Transaction Amount]*/

merge into last_transactions as l
using dialy_transactions as d
on l.id=d.id
when matched then
update set  l.amount=d.amount
when not matched by target then 
insert into (l.id,l.amount)values(d.id,d.amount)
when not matched by source then
delete 


/*Part 2*/

/*1)Create view named   “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'.*/

 create view v_clerk
as
select ssn,Pnumber,[MGRStart Date]
from Employee e inner join Departments d
on  e.SSN=d.MGRSSN
inner join Project p
on d.Dnum=p.Dnum and job='clerk'

 select *from v_clerk

		 --
--2)	 Create view named  “v_without_budget” that will display all the projects data 
--       without budget
create view v_without_budget
as
select p.City,p.Dnum,p.Plocation,p.Pname,p.Pnumber from Project p

select * from v_without_budget	

--3)	Create view named  “v_count “ that will display the project name and the # of jobs in it
create view v_count 
as
select pname,count(job) as numofjobs
from Project p,Departments d
where d.Dnum=p.Dnum
group by Pname

select *from v_count

--4)	 Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’
---------use the previously created view  “v_clerk”
create view v_project_p2
as
select count(SSN)
from v_clerk where Pname='p2'

select*from v_project_p2

--5)	modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2 
alter view v_without_budget
as
select p.City,p.Dnum,p.Plocation,p.Pname,p.Pnumber from Project p
where Pname in ('p1','p2')

select * from v_without_budget	

--6)	Delete the views  “v_ clerk” and “v_count”
drop view v_count
drop view v_clerk

--7)	Create view that will display the emp# and emp lastname who works on dept# is ‘d2’
alter view dep2
as
select Lname, count(ssn) as numbers from
Employee e,Departments d
where d.Dnum=e.Dno and d.Dname='dp2'
group by Lname

select lname from dep2

--8)	Display the employee  lastname that contains letter “J”
--------Use the previous view created in Q#7
select lname from dep2 where lname like '%j%'

--9)	Create view named “v_dept” that will display the department# and department name
alter view v_dept(dname,dnum)
as
select dname,dnum
from Departments

select * from v_dept

--10)	using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’

insert into v_dept(dname,dnum)
values('development','p4')

--11)	Create view name “v_2006_check” that will display employee#, 
--the project #where he works and the date of joining the project which must be from
-- the first of January and the last of December 2006.this view will be used to insert data so
-- make sure that the coming
-- new data must match the condition
alter view v_2006_check(empno,projectn,edate)
as
select empno,projectno,enter_date
from works_on where enter_date between '1-1-2006'and'12-31-2006'
with check option


select * from v_2006_check


