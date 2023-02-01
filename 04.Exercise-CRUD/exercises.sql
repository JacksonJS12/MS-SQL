USE [SoftUni]
 GO

 -- Problem 03
 SELECT [Name] 
    FROM [Departments]

 -- Problem 04
 SELECT [FirstName],
        [LastName],
        [Salary]
    FROM [Employees]

 -- Problem 05
 SELECT [FirstName],
         [MiddleName],
         [LastName]
    FROM [Employees]

 -- Problem 06
 SELECT CONCAT([FirstName], '.', [LastName],'@','softuni.bg')
    AS [Full Email Address]
 FROM [Employees]  
 
 -- Problem 07
 SELECT DISTINCT [Salary]
            FROM  [Employees]

 -- Problem 09
 SELECT  [FirstName],
         [LastName],
         [JobTitle]
 FROM [Employees]
 WHERE [Salary] BETWEEN 20000 AND 30000
 