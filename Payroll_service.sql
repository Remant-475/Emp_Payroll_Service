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

-- UC 7-find sum, average, min, max and number of male and female employees
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

--UC8 -Add column department,PhoneNumber and Address
Alter table Employee_payroll
add PhoneNumber BigInt,Department varchar(200) not null default 'Sales',Address varchar(200) default 'Not Provided';

Update Employee_payroll 
set PhoneNumber='8271630771',Department='Marketing',Address='Dhanbad,Jharkhand'
where Emp_Name='REMANT';

Update Employee_payroll 
set PhoneNumber='9798777067',Address='Patna,Bihar'
where Emp_Name ='AMAN';

Update Employee_payroll 
set PhoneNumber='7903488510 ',Department='Lead',Address='KoLkata,WB'
where Emp_Name ='SHUBHAM';

Update Employee_payroll 
set PhoneNumber='7903488210',Address='Dugrapur,WB'
where Emp_Name ='KUMUD';

Update Employee_payroll 
set PhoneNumber='9835390376',Department='Lead',Address='Bokaro,Jharkhnad'
where Emp_Name ='Geeta';

--UC 9-  Add BasicPay, Deduction,Taxable pay, Income Pay and Netpay
EXEC sp_RENAME 'Employee_payroll.Basic_Pay' , 'BasicPay', 'COLUMN'
Alter table Employee_payroll
add Deduction float,TaxablePay float, IncomeTax float,NetPay float;
Update Employee_payroll 
set Deduction=1000
where Gender='F';
Update Employee_payroll 
set Deduction=2000
where Gender='M';
update Employee_payroll
set NetPay=(BasicPay - Deduction)
update Employee_payroll
set TaxablePay=0,IncomeTax=0
select * from Employee_payroll;

--UC10- Two departments for same employee
Insert into Employee_payroll(Emp_Name,BasicPay,StartDate,Gender,PhoneNumber,Department,Address) values ('GEETA',450000,'2022-01-06','F',9835390376,'Management','Bokaro,Jharkhand');
select * from Employee_payroll;
update Employee_payroll
set BasicPay=45000 where Emp_Name='Geeta';

-- UC 11: Implement the ER Diagram into Payroll Service DB 
--Create Table for Company
Create Table Company
(CompanyID int identity(1,1) primary key,
CompanyName varchar(100))
--Insert Values in Company
Insert into Company values ('Infosys'),('Wipro')
Select * from Company
drop table Company

--Create Employee Table
create table Employee
(EmployeeID int identity(1,1) primary key,
EmployeeName varchar(200),
EmployeePhoneNumber bigInt,
EmployeeAddress varchar(200),
StartDate date,
Gender char
)
--Insert Values in Employee
insert into Employee values
('Kavita Yadav',9234123750,'Dhanbad,Jharkhand','2012-03-28','F'),
('Sweta Triphati',9842905550,'Azamgarh,UP','2017-04-22','F'),
('Nilesh',8789555067,'Gaya,Bihar','2015-08-22','M'),
('Ajit Kumar',7250487755,'Patna,Bihar','2012-08-29','M')

Select * from Employee

--Create Payroll Table
create table PayrollCalculate
(BasicPay float,
Deductions float,
TaxablePay float,
IncomeTax float,
NetPay float,
EmployeeIdentity int,
Foreign key (EmployeeIdentity) references Employee(EmployeeID)
)
--Insert Values in Payroll Table
insert into PayrollCalculate(BasicPay,Deductions,IncomeTax,EmployeeIdentity) values 
(4000000,1000000,20000,1),
(4500000,200000,4000,2),
(6000000,10000,5000,3),
(9000000,399994,6784,4);

--Update Derived attribute values 
update PayrollCalculate
set TaxablePay=BasicPay-Deductions

update PayrollCalculate
set NetPay=TaxablePay-IncomeTax

select * from PayrollCalculate
drop table PayrollCalculate

--Create Department Table
create table Department
(
DepartmentId int identity(1,1) primary key,
DepartName varchar(100)
)
--Insert Values in Department Table
insert into Department values
('Marketing'),
('Sales'),
('Lead')

select * from Department

--Create table EmployeeDepartment
create table EmployeeDepartment
(
DepartmentIdentity int,
EmployeeIdentity int,
Foreign key (EmployeeIdentity) references Employee(EmployeeID),
Foreign key (DepartmentIdentity) references Department(DepartmentID)
)

--Insert Values in EmployeeDepartment
insert into EmployeeDepartment values
(3,1),
(2,2),
(1,3),
(3,4)
select * from EmployeeDepartment
drop table EmployeeDepartment

SELECT EmployeeID,EmployeeName,EmployeeAddress,EmployeePhoneNumber,StartDate,Gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,DepartName
FROM Employee
LEFT JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID
LEFT JOIN EmployeeDepartment on Employee.EmployeeID=EmployeeDepartment.EmployeeIdentity
LEFT JOIN Department on Department.DepartmentId=EmployeeDepartment.DepartmentIdentity

--UC 5: Retrieve Data for particular employee as well as who joined in a particular datarange
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanyIdentity and StartDate BETWEEN Cast('2012-11-12' as Date) and GetDate()
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID
--Retrieve query based on Name
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanyIdentity and Employee.EmployeeName='Ajit Kumar'
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID

--UC 7: -find sum, average, min, max and number of male and female employees

select Sum(BasicPay) as "TotalSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Avg(BasicPay) as "AverageSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Min(BasicPay) as "MinimumSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Max(BasicPay)  as "MaximumSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;

select Count(BasicPay) as "CountSalary",Gender 
from Employee
INNER JOIN PayrollCalculate on PayrollCalculate.EmployeeIdentity=Employee.EmployeeID group by Gender;


