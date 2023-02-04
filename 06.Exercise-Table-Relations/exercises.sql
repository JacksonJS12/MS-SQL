CREATE DATABASE [EntityRelationsDemo2023]

GO

USE [EntityRelationsDemo2023]

GO

 -- Problem 01
CREATE TABLE [Passports](
	[PassportID] INT PRIMARY KEY IDENTITY(101,1),
	[PassportNumber] NVARCHAR(10) UNIQUE NOT NULL
)

CREATE TABLE [Persons](
	[PersonID] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(20) NOT NULL,
	[Salary] DECIMAL(7,2) NOT NULL,
	[PassportID] INT FOREIGN KEY REFERENCES [Passports]([PassportID]) UNIQUE
)

INSERT INTO [Passports]([PassportNumber])
	 VALUES
('N34FG21B'),
('K65LO4R7'), 
('ZE657QP2')

INSERT INTO [Persons]([FirstName], [Salary], [PassportID])
	 VALUES
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101)

 -- Problem 02
 CREATE TABLE Manufacturers
 (
 	ManufacturerID INT PRIMARY KEY IDENTITY,
 	[Name] NVARCHAR(10) NOT NULL,
 	EstablishedOn DATE
 )
 CREATE TABLE Models
 (
 	ModelID INT PRIMARY KEY IDENTITY(101, 1),
 	[Name] NVARCHAR(50) NOT NULL,
 	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
 )
 
 INSERT INTO Manufacturers([Name])
 	 VALUES
 ('BMW'),
 ('Tesla'),
 ('Lada')
 
 
 INSERT INTO Models([Name], ManufacturerID)
 	 VALUES
 ('X1', 1),
 ('i6', 1),
 ('ModelS', 2),
 ('ModelX', 2),
 ('Model3', 2),
 ('Nova', 3)

 --Problem 03
 
CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(80) NOT NULL
)

CREATE TABLE Exams
(
	ExamID INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(80) NOT NULL
)

CREATE TABLE StudentsExams
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES Exams(ExamID)
	PRIMARY KEY (StudentID, ExamID)
)

INSERT INTO Students ([Name]) VALUES
('Mila'),
('Tony'),
('Ron')

INSERT INTO Exams ([Name]) VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO StudentsExams(StudentID, ExamID) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103)

--Problem 04
CREATE TABLE [Teachers]
(
    [TeacherID] INT PRIMARY KEY IDENTITY(101,1),
    [Name] NVARCHAR(50) NOT NULL,
    [ManagerID] INT FOREIGN KEY REFERENCES[Teachers]([TeacherID])
)

INSERT INTO Students ([Name]) VALUES
('Mila'),
('Tony'),
('Ron')

INSERT INTO Exams ([Name]) VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO [Teachers]([Name], [ManagerID])
    VALUES
            ('John', NULL),
            ('Maya', 106),
            ('Silvia', 196),
            ('Ted', 105),
            ('Mark', 101),
            ('Greta', 101)

--Problem 06
CREATE DATABASE [UniversityDatabase2023]

GO

USE [UniversityDatabase2023]

GO

CREATE TABLE [Majors]
(
    [MajorID] INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(50) NOT NULL 
)        

CREATE TABLE [Subjects]
(
    [SubjectID] INT PRIMARY KEY IDENTITY,
    [SubjectName] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Students] 
(
    [StudentID] INT PRIMARY KEY IDENTITY,
    [StudentNumber] VARCHAR,
    [StudentName] NVARCHAR(50) NOT NULL,
    [MajorID] INT FOREIGN KEY REFERENCES[Majors]([MajorID]) NOT NULL 
)

CREATE TABLE [Agenda]
(
    [StudentID] INT FOREIGN KEY REFERENCES[Students]([StudentID]),
    [SubjectID] INT FOREIGN KEY REFERENCES[Subjects]([SubjectID]),
    PRIMARY KEY([StudentID], [SubjectID])
)

CREATE TABLE [Payments]
(
    [PaymentID] INT PRIMARY KEY IDENTITY,
    [PaymentDate] DATETIME2 NOT NULL,
    [PaymentAmount] DECIMAL(8, 2) NOT NULL,
    [StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]) NOT NULL
 )

ALTER TABLE [Students]
ADD UNIQUE ([StudentNumber])

INSERT INTO [Majors]
        VALUES  
                ('Pesho')

INSERT INTO [Students]([StudentName], [StudentNumber], [MajorID])
        VALUES  
                ('Tosho', '941220005', 1)

INSERT INTO [Agenda]
        VALUES  
                (1,1)
        
--Problem 09
GO 

USE [Geography]

GO

SELECT  [m].[MountainRange],
        [p].[PeakName],
        [p].[Elevation]
    FROM [Peaks]
        AS [p]
    LEFT JOIN [Mountains]
        AS [m]
        ON [p].[MountainId] = [m].[Id]
     WHERE [m].[MountainRange] = 'Rila'
    ORDER BY [p].[Elevation] DESC

