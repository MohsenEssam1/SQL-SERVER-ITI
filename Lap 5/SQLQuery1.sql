use ITI
go

/*1.	Retrieve number of students who have a value in their age. */

select count( *) 
from Student 
where St_Age is not null

/*2.	Get all instructors Names without repetition*/

select distinct ins_name
from Instructor

/*3.	Display student with the following Format (use isNull function)*/

select St_Id , isnull(St_Fname,'')+' '+isnull(St_Lname,'') as st_fullname,  isnull(dept_name,'') dep_name
from Student s join Department d
on s.Dept_Id=d.Dept_Id

/*4.	Display instructor Name and Department Name 
Note: display all the instructors if they are attached to a department or not*/

select ins_name , isnull(dept_name,'no department')
from Instructor i left join Department d
on i.Dept_Id=d.Dept_Id

/*5.	Display student full name and the name of the course he is taking
For only courses which have a grade */

select st_fname +' '+ st_lname as st_fullname , crs_name
from Student s join Stud_Course sc
on s.St_Id=sc.St_Id
join Course c
on c.Crs_Id=sc.Crs_Id
where sc.Grade is not null

/*6.	Display number of courses for each topic name*/

select top_name , count(crs_id) as number_of_courses  
from Course c join Topic t
on c.Top_Id=t.Top_Id
group by Top_Name

/*7.	Display max and min salary for instructors*/

select MAX(salary) as max_salary , min(salary) as min_salary
from Instructor

/*8.	Display instructors who have salaries less than the average salary of all instructors.*/

select *
from Instructor
where salary < all (select avg(Salary) from Instructor)

/*9.	Display the Department name that contains the instructor who receives the minimum salary.*/

select Dept_Name
from Department d join Instructor i
on d.Dept_Id=i.Dept_Id
where i.Salary = (select min (Salary) from Instructor)
 
/*10.	 Select max two salaries in instructor table. */

select Salary
from(
select *,  ROW_NUMBER() over (order by salary desc) rn
from Instructor ) as new
where rn <= 2

/*11.Select instructor name and his salary but if there is no salary display instructor bonus. “use one of coalesce Function*/

select ins_name , coalesce(salary , 200)
from Instructor

/*12.	Select Average Salary for instructors */

select AVG(salary) as avg_salary
from Instructor

/*13.	Select Student first name and the data of his supervisor */

select s.st_fname , su.*
from Student s  join Student su
on s.St_super=su.St_Id

/*14.	Write a query to select the highest two salaries in Each Department for instructors who have salaries
. “using one of Ranking Functions”*/

select * from(
select * , DENSE_RANK() over (partition by dept_id order by salary desc) dr
from Instructor) new
where dr <= 2 and  Dept_Id is not null  and Salary is not null

/*15.	 Write a query to select a random  student from each department.
“using one of Ranking Functions”*/

select * from(
select * , ROW_NUMBER()over (partition by dept_id order by newid()) as rn
from Student where Dept_Id is not null) new

where rn =1



