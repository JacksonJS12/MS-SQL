USE [SoftUni]

GO

-- Problem 01 
---- Method A
SELECT  [FirstName],
        [LastName]
   FROM [Employees]
 WHERE LEFT([FirstName], 2) = 'Sa'

---- Method B
SELECT  [FirstName],
        [LastName]
   FROM [Employees]
 WHERE [FirstName] LIKE 'Sa%'

-- Problem 02
---- Method A
SELECT  [FirstName],
        [LastName]
   FROM [Employees]
 WHERE CHARINDEX([LastName], 'ei') > 0

---- Method B
SELECT  [FirstName],
        [LastName]
   FROM [Employees]
 WHERE [LastName] LIKE '%ei%'

-- Problem 03
SELECT *
    FROM [Employees]
 WHERE [DepartmentID] IN (3,10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005

-- Problem 04 
SELECT  [FirstName],
        [LastName],
        [JobTitle]
  FROM  [Employees]
 WHERE CHARINDEX('engineer', [JobTitle]) = 0 
