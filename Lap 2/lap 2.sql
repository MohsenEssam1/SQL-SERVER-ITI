/*1.	Display all the employees Data.  */

select *
from emp;

-----
/*2.Display the employee First name, last name, Salary and Department number.*/

select fname , lname , salary , dno
from emp;

-----
/*3.Display all the projects names, locations and the department which is responsible about it.*/

select *
from project;

-----
/*4.If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary .Display each employee full name and his annual commission in an ANNUAL COMM column (alias).*/

select (fname+ ' '+lname)as full_name , (salary *12 * .1 ) as ANNUAL_COMM
from emp

----
/*5.Display the employees Id, name who earns more than 100 LE monthly.*/

select ssn ,(fname+ ' '+lname)as full_name 
from emp
where salary >100 ;

----
/*6.Display the employees Id, name who earns more than 10000 LE annually.*/

select ssn ,(fname+ ' '+lname)as full_name 
from emp
where salary*12 >1000 ; 

----
/*7.Display the names and salaries of the female employees */

select(fname+ ' '+lname)as full_name , salary
from emp
where sex='f'; 

----
/*8.Display each department id, name which managed by a manager with id equals 968574.*/

select dnum , dname 
from dep
where mgrssn=968574;

----
/*9.Dispaly the ids, names and locations of  the pojects which controled with department 10.*/

select pnum , pname , plocation
from project
where dno=10;