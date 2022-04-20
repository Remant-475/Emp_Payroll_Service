--UC1-Create Database-Payroll_Service
Create database Payroll_Service;
select * from sys.databases;
use Payroll_Service;

--UC2-Create Table Employee_payroll
Create table Employee_payroll(
Emp_Id int identity(1,1) not null primary key,
Emp_Name varchar(50),
Salary Bigint,
StartDate Date);
