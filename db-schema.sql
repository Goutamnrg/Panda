CREATE DATABASE PANDA
GO

CREATE SCHEMA PANDA
GO

CREATE TABLE Students (
	StudentId int,
	FirstName varchar (100),
	LastName varchar (80),
	Address1 varchar (50),
	City varchar (50),
	State1_province varchar (50),
	Country varchar (80),
	Phone_Number varchar (60),
	Email_Address varchar (70),
	Graduation_Year Decimal (1000),
	);
	
CREATE TABLE EMPLOYEES (
	EmployeeID int,
	FirstName varchar (100),
	Address1 varchar (50),
	City varchar (50),
	State1_Province varchar (50),
	PostalCode varchar (20),
	CountryCode varchar (70),
	PhoneNumber DECIMAL (60),
	EmailAddress varchar (100),
	Salary DECIMAL (50,0),
	);

CREATE TABLE StudentTransation (
	TransactionId int,
	StudentId varchar (1000),
	PostDate DATE,
	Amount DECIMAL (10,2),
	Description1 varchar (40),
	);

CREATE TABLE GRADES (
	StudentId int,
	CourseId DECIMAL (999),
	Year1 DATE,
	Semester varchar (50),
	Grades DECIMAL (999),
	);

CREATE TABLE COURSES (
	CourseId int,
	DepartmentId varchar (50),
	Name1 varchar (50),
	Units varchar (50),
	Cost DECIMAL (50),
	);

CREATE TABLE ENROLLMENT (
	CourseId int,
	Section varchar (50),
	StudentID DECIMAL (10,02),
	);

CREATE TABLE DEPARTMENTS (
	LastName int,
	DepartmentId DECIMAL,
	Description1 varchar (50),
	);

CREATE TABLE SECTION (
	CourseID int,
	Section varchar (50),
	Days1 DATE,
	StartDate DATE,
	Length1 TIME,
	ProfessorID DECIMAL (10),
	Capacity DECIMAL (10),
	);

ALTER TABLE Panda.Students_Courses
	ADD CONSTRAINT FKStudentId
	FOREIGN KEY (StudentId) REFERENCES Panda.Students(StudentID);
	GO

ALTER TABLE Panda.Students_Courses
	ADD CONSTRAINT FKCourseId
	FOREIGN KEY (CourseId) REFERENCES Panda.Courses(CourseId);
	GO

