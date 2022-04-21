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

--UC6- Add gender to Employee Payroll table and update the rows to retrive the correct gender
Alter Table Employee_payroll add Gender Varchar(1);
Update Employee_payroll set Gender='M' where Emp_Id In (1,2,3);
Update Employee_payroll set Gender='F' where Emp_Id In (4,5);

-- find sum, average, min, max and number of male and female employees
select sum(Salary) as Sum_Of_Salary_of_FemaleEmp from Employee_payroll where Gender = 'F' Group by Gender;
select sum(Salary) as Sum_Of_Salary_of_MaleEmp from Employee_payroll where Gender = 'M' Group by Gender;
select Avg(Salary) as Avg_Salary_of_FemaleEmp from employee_payroll where Gender = 'F' Group by Gender;
select Avg(Salary) as Avg_Salary_of_MaleEmp from employee_payroll where Gender = 'M' Group by Gender;
select Max(Salary) as Max_Salary_of_FemaleEmp from employee_payroll where Gender = 'F' Group by Gender;
select Max(Salary) as Max_Salary_of_MaleEmp from employee_payroll where Gender = 'M' Group by Gender;
select Min(Salary) as Min_Salary_of_FemaleEmp from employee_payroll where Gender = 'F' Group by Gender;
select Min(Salary) as Min_Salary_of_MaleEmp from employee_payroll where Gender = 'M' Group by Gender;
select count(Salary) as No_of_FemaleEmp from employee_payroll where Gender = 'F' Group by Gender;
select count(Salary) as No_of_MaleEmp from employee_payroll where Gender = 'M' Group by Gender;