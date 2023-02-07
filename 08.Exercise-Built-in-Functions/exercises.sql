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
---- Method A 
SELECT  [FirstName],
        [LastName]
  FROM  [Employees]
 WHERE CHARINDEX('engineer', [JobTitle]) = 0 

---- Method B
SELECT  [FirstName],
        [LastName]
  FROM  [Employees]
 WHERE [JobTitle] NOT LIKE 'engineer'


-- Problem 05
SELECT [Name]
  FROM [Towns]
 WHERE LEN([Name]) IN (5,6)
 ORDER BY [Name] 


-- Problem 06
---- Method A
SELECT *
  FROM [Towns]
   WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name]

---- Method B
SELECT * 
  FROM [Towns]
 WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name]


-- Problem 10
SELECT   [EmployeeID],
         [FirstName],
         [LastName],
         [Salary],
         DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
      AS [Rank]
    FROM [Employees] 
   WHERE [Salary] BETWEEN 10000 AND 50000
ORDER BY [Salary] DESC



-- Problem 11
SELECT *
   FROM (
                   SELECT   [EmployeeID],
                     [FirstName],
                     [LastName],
                     [Salary],
                     DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
                  AS [Rank]
                FROM [Employees] 
               WHERE [Salary] BETWEEN 10000 AND 50000
   ) AS [RankingSubquery]
WHERE [Rank] = 2
ORDER BY [Salary] DESC


GO

USE [Geography]

GO

-- Probelem 12
---- Method A
SELECT  [ConutryName]
    AS  [Country Name],
        [ISOCode]
    AS  [ISO Code]
   FROM [Countries]
  WHERE LOWER([CountryName]) LIKE '%a%a%a'
ORDER BY [ISO Code]

---- Method B
SELECT  [ConutryName]
    AS  [Country Name],
        [ISOCode]
    AS  [ISO Code]
   FROM [Countries]
  WHERE LEN([CountryName]) - LEN(REPLACE(LOWER([CountryName], 'a', ''))) >= 3
ORDER BY [ISO Code]