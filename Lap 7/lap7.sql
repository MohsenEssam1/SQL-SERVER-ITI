use ITI
go

/*1.Create a scalar function that takes date and returns Month name of that date*/

create function mon_name(@date date)
returns varchar(20)
    begin
	
           return datename (MONTH, @date)  
	end

select dbo.mon_name( GETDATE()) as month_name
select dbo.mon_name( '5/9/2001') as month_name

/*2.Create a multi-statements table-valued function that takes 2 integers and returns the values between them.*/

create function values2num (@num1 int ,@num2 int)
returns @t table
  (
   num int
  )
as
begin
   while @num1 <@num2
     begin
	     if @num1=@num2 - 1
		    break
	     set @num1 +=1
	     insert into @t values(@num1)
	 end
	 return
end

select * from values2num (4,9)

/*3.Create a tabled valued function that takes Student No and returns Department Name with Student full name.*/

create function stuno(@sid int)
returns table 
as 
return(
select st_fname+' '+st_lname as full_name, dept_id from student where st_id=@sid

)

select * from stuno(3)

/*4.	Create a scalar function that takes Student ID and returns a message to user 
a.	If first name and Last name are null then display 'First name & last name are null'
b.	If First name is null then display 'first name is null'
c.	If Last name is null then display 'last name is null'
d.	Else display 'First name & last name are not null'*/

create function stumessage(@sid int )
returns varchar(50)
begin
 DECLARE @message VARCHAR(50);

    SELECT @message =

     case
             when st_fname =null and St_Lname = null then 'First name & last name are null'
			when st_fname= null then 'First name is null'
			when st_lname= null then 'Last name is null'
			else 'First name & last name are not null'
	end 

from Student
where st_id=@sid
return @message
end



select dbo.stumessage(8)



/*5.Create a function that takes integer which represents manager ID and displays department name, Manager Name and hiring date */

create function manager(@MID int)
RETURNS TABLE
as
return
select ins_id ,dept_name , ins_name , manager_hiredate
from department d join Instructor i
on d.Dept_Manager=i.Ins_Id
where  i.Ins_Id=@mid

select * from manager(4)


/*6.	Create multi-statements table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name 
If string='full name' returns Full Name from student table 
Note: Use “ISNULL” function*/

create function getsname(@format varchar(20))
returns @t table 
          (
	         
		     sname varchar(20)
	      )
as
   begin
        if @format='first name'
                insert into @t
	            select ISNULL(st_fname,'NoName')from Student
        else if @format='last name'
                 insert into  @t
	             select ISNULL(St_Lname,'NoName') from Student
		else if @format='full name'
                 insert into  @t
	             select isnull (St_fname,'') +' '+ isnull(St_Lname,'') as full_name from Student
		return
   end 

select *  from getsname('full name')

/*7.Write a query that returns the Student No and Student first name without the last char*/

create function lastchar(@sid int)
returns table 
as 

return
(select  st_id ,name=left(st_fname , len(st_fname)-1) 
from student
where St_Id=@sid)

select * from lastchar(4)
