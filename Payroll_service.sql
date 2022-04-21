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

--UC3- Inserting Values in Table
INSERT INTO Employee_payroll(Emp_Name,SALARY,StartDate) VALUES 
('REMANT',25000,'2022-04-18'),
('AMAN',30000,'2022-03-10'),
('SHUBHAM',40000,'2022-04-08'),
('KUMUD',35000,'2022-02-15'),
('GEETA',45000,'2022-01-06');

--UC4-Retrieving all data from table
Select * from Employee_payroll;

--UC 5 Retrieve Data for particular employee as well as who joined in a particular datarange
select * from Employee_payroll where Emp_Name='SHUBHAM';
select *From Employee_Payroll where startdate between CAST('2022-04-1' as date) and getdate();