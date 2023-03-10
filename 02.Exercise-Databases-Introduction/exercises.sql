CREATE DATABASE Minions
USE Minions

CREATE TABLE Minions 
(
	Id INT PRIMARY KEY,
	[Name] NVARCHAR(50),
	Age TINYINT
)

CREATE TABLE Towns 
(
	Id INT PRIMARY KEY,
	[Name] NVARCHAR(85)
)

ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

INSERT INTO Towns (Id, Name) VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions (Id, Name, Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

DELETE FROM Minions


DROP TABLE Minions
DROP TABLE Towns

-- Problem 13
CREATE DATABASE Movies

USE Movies

--•	Directors (Id, DirectorName, Notes)
CREATE TABLE Directors
(
	Id INT PRIMARY KEY,
	DirectorName NVARCHAR(80) NOT NULL,
	Notes NVARCHAR(MAX)
)
--•	Genres (Id, GenreName, Notes)
CREATE TABLE Genres
(
	Id INT PRIMARY KEY,
	GenreName VARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)
--•	Categories (Id, CategoryName, Notes)
CREATE TABLE Categories
(
	Id INT PRIMARY KEY,
	CategoryName VARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)
--•	Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
CREATE TABLE Movies
(
	Id INT PRIMARY KEY,
	Title VARCHAR(250) NOT NULL,
	DirectorId INT NOT NULL,
	CopyrightYear SMALLINT NOT NULL,
	[Length] TIME NOT NULL,
	GenreId INT NOT NULL,
	CategoryId INT NOT NULL,
	Rating TINYINT NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Directors (Id, DirectorName) VALUES
(1, 'Guy Ritchie'),
(2, 'Tarantino'),
(3, 'Peter Jackson'),
(4, 'Ben Aflec'),
(5, 'Martin Scorsese')

INSERT INTO Genres (Id, GenreName, Notes) VALUES
(1, 'Thriller', 'some note'),
(2, 'Mystery', null),
(3, 'Action', null),
(4, 'Romance', 'other note'),
(5, 'Fantasy', null)

INSERT INTO Categories (Id, CategoryName, Notes) VALUES
(1, 'Musicals', null),
(2, 'Comedy', 'note'),
(3, 'Sci-Fi', 'another note'),
(4, 'Horror', 'note'),
(5, 'Young Adult', null)

INSERT INTO Movies (Id, Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes) VALUES
(1, 'Harry Potter', 1, 2005, '1:45', 1, 2, 8, 'some note'),
(2, 'Lord of the Rings', 3, 2000, '1:45', 1, 2, 8, 'some note'),
(3, 'Argo', 4, 2006, '1:45', 1, 2, 8, 'some note'),
(4, 'Mission Impossible', 2, 2012, '1:45', 1, 2, 8, 'some note'),
(5, 'Wild Wild West', 5, 2000, '1:45', 1, 2, 8, 'some note')

-- Problem 14

CREATE DATABASE CarRental

USE CarRental

--•	Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName VARCHAR(50) NOT NULL,
	DailyRate DECIMAL (15,2) NOT NULL,
	WeeklyRate DECIMAL (15,2) NOT NULL,
	MonthlyRate DECIMAL (15,2) NOT NULL,
	WeekendRate DECIMAL (15,2) NOT NULL
)
--•	Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
CREATE TABLE Cars
(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber NVARCHAR(20) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	Model NVARCHAR(20) NOT NULL,
	CarYear SMALLINT NOT NULL,
	CategoryId INT NOT NULL,
	Doors TINYINT NOT NULL,
	Picture VARBINARY(MAX),
	Condition VARCHAR(50) NOT NULL,
	Available BIT NOT NULL
)
--•	Employees (Id, FirstName, LastName, Title, Notes)
CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(10) NOT NULL,
	Notes VARCHAR(MAX)
)
--•	Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY,
	DriverLicenceNumber NVARCHAR(20) NOT NULL,
	FullName NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(MAX) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	ZIPCode NVARCHAR(15) NOT NULL,
	Notes NVARCHAR(MAX)
)
--•	RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes
CREATE TABLE RentalOrders
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT NOT NULL,
	CustomerId INT NOT NULL,
	CarId INT NOT NULL,
	TankLevel DECIMAL(2,2) NOT NULL,
	KilometrageStart DECIMAL(15,2) NOT NULL,
	KilometrageEnd DECIMAL(15,2) NOT NULL,
	TotalKilometrage DECIMAL(15,2) NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	TotalDays INT NOT NULL,
	RateApplied DECIMAL(5,2) NOT NULL,
	TaxRate TINYINT NOT NULL,
	OrderStatus NVARCHAR(15) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
      VALUES
('practical', 59.99, 255.28, 1000.55, 122.25),
('comfortable',65.89, 299.87, 1200.66, 165.33),
('economical', 45.77, 199.54, 999.99, 135.39)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Condition, Available)
      VALUES
('EH0212BP', 'Opel', 'Astra', 1992, 1, 4, 'new', 1),
('EH02da2BP', 'Oasdel', 'Astasda', 2005, 2, 4, 'new', 1),
('EHasd212BP', 'Opasdl', 'Astasdasa', 2022, 3, 2, 'new', 0)


INSERT INTO Employees(FirstName, LastName, Title)
	VALUES
('Petar', 'Ivanov', 'CEO'),
('Stoyan', 'Georgiev', 'CFO'),
('Ivan', 'Petrov', 'CTO')

INSERT INTO Customers(DriverLicenceNumber, FullName, [Address], City, ZIPCode)
	VALUES
('JIGLAKFJFJHGDHASF', 'Petar Georgiev', 'George Street', 'Sydney', '528000BT'),
('JIdasdFJFJHGDHASF', 'Milen Georgiev', 'Nedelyq', 'Sofia', '5246540BT'),
('JIGLAKFJFgfdgfDHASF', 'Petar Stoyanov','Bunar Hisar 8' , 'VT', '5280655BT')

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus)
	VALUES
(1, 3, 2, 0,  1.10, 1.10, 1.10, '1988-09-27', '1988-10-27', 1, 1.10, 1, 'Complete'),
(2, 3, 3, 0, 1.10, 1.10, 1.10, '2022-05-27', '2022-10-15', 1, 1.10, 1, 'Alive'),
(3, 1, 1, 0, 1.10, 1.10, 1.10, '1989-12-27', '1990-11-05', 1, 1.10, 1, 'Complete')


SELECT * FROM [Categories]
SELECT * FROM [Cars]
SELECT * FROM [Employees]
SELECT * FROM [Customers]
SELECT * FROM [RentalOrders]

 