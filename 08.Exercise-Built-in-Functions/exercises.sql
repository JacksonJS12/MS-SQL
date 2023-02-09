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
SELECT  [CountryName]
    AS  [Country Name],
        [ISOCode]
    AS  [ISO Code]
   FROM [Countries]
  WHERE LOWER([CountryName]) LIKE '%a%a%a'
ORDER BY [ISO Code]

---- Method B
SELECT  [CountryName]
    AS  [Country Name],
        [ISOCode]
    AS  [ISO Code]
   FROM [Countries]
  WHERE LEN([CountryName]) - LEN(REPLACE(LOWER([CountryName]), 'a', '')) >= 3
ORDER BY [ISO Code] 


-- Problem 13
SELECT [p].[PeakName],
       [r].[RiverName],
       LOWER(CONCAT(SUBSTRING([p].[PeakName], 1, LEN([p].[PeakName]) - 1), [r].[RiverName]))
    AS [Mix] 
  FROM [Peaks]
    AS [p],
       [Rivers]
    AS [r]
 WHERE RIGHT(LOWER([p].[PeakName]), 1) = LEFT(LOWER([r].[RiverName]), 1)
 ORDER BY [Mix]


 GO

 USE [Diablo]

 GO

 -- Problem 15
 SELECT [Username],
        SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email]) - CHARINDEX('@', [Email]))
    AS  [Email Provider]
   FROM [Users] 
ORDER BY[Email Provider],
        [Username]

    
-- Problem 17
  SELECT [Name]
      AS [Game],
         CASE
            WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
            ELSE  'Evening'
         END
      AS [Part of the Day],
         CASE
            WHEN [Duration] <= 3 THEN 'Extra Short'
            WHEN [Duration] >= 4 AND [Duration] <= 6 THEN 'Short'
            WHEN [Duration] > 6 THEN 'Long'
            ELSE 'Extra Long'
         END
      AS [Duration]
    FROM [Games]
      AS [g]
ORDER BY [Game],
         [Duration],
         [Part of the Day] 