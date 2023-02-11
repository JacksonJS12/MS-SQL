GO

USE [SoftUni]

GO

-- Problem 01
 SELECT 
    TOP (5) [e].[EmployeeID],
            [e].[JobTitle],
            [e].[AddressID],
            [a].[AddressText]
   FROM [Employees]
     AS [e]
LEFT JOIN [Addresses]
     AS [a]
     ON [e].[AddressID] = [a].[AddressID]
ORDER BY[e].[AddressID] 


-- Problem 04
  SELECT 
  TOP(5) [EmployeeID], 
         [FirstName], 
         [Salary], 
         [d].[Name] 
      AS [DepartmentName]
	  FROM [Employees] 
      AS [e]
    JOIN [Departments] 
      AS [d]
		 ON [d].[DepartmentID] = [e].[DepartmentID]
   WHERE [e].[Salary] > 15000
ORDER BY [d].[DepartmentID] ASC

-- Problem 05
   SELECT 
  TOP (3) [e].[EmployeeID],
          [e].[FirstName]
     FROM [Employees]
       AS [e]
LEFT JOIN [EmployeesProjects]
       AS [ep]
       ON [e].[EmployeeID] = [ep].[EmployeeID]
    WHERE [ep].[ProjectID] IS NULL
 ORDER BY [e].[EmployeeID]


-- Problem 06
   SELECT [e].[FirstName], 
          [e].[LastName], 
          [e].[HireDate],
          [d].[Name] 
       AS [DeptName]
     FROM [Employees]
       AS [e]
     JOIN [Departments]
       AS [d] 
   	 ON [d].[DepartmentID] = [e].[DepartmentID]
    WHERE [e].[HireDate] > '1999-01-01'
   	AND [d].[Name] IN ('Sales', 'Finance')
 ORDER BY [e].[HireDate] ASC


 -- Problem 07
     SELECT 
     TOP (5) [e].[EmployeeID],
               [e].[FirstName],
               [p].[Name]
          AS [ProjectName]
          FROM [EmployeesProjects]
          AS [ep]
     INNER JOIN [Employees]
          AS [e]
          ON [ep].[EmployeeID] = [e].[EmployeeID]
     INNER JOIN [Projects]
          AS [p]
          ON [ep].[ProjectID] = [p].[ProjectID]
          WHERE [p].[StartDate] > '08-13-2002' AND [p].[EndDate] IS NULL
     ORDER BY [e].[EmployeeID]


-- Problem 09
SELECT [e].[EmployeeID], 
		 [e].[FirstName], 
		 [e].[ManagerID], 
	   	 [m].[FirstName] 
      AS [ManagerName]
    FROM [Employees] 
      AS [e]
    JOIN [Employees] AS [m]
      ON [m].[EmployeeID] = [e].[ManagerID]
   WHERE [m].[EmployeeID] IN (3, 7)
ORDER BY [e].[EmployeeID] ASC



GO

USE [Geography]

GO
-- Problem 12
    SELECT [mc].[CountryCode],
           [m].[MountainRange],
           [p].[PeakName],
           [p].[Elevation]
      FROM [MountainsCountries]
        AS [mc]
INNER JOIN [Countries]
        AS [c]
        ON [mc].[CountryCode] = [c].[CountryCode]
INNER JOIN [Mountains]
        AS [m]
        ON [mc].[MountainId] = [m].[Id]
INNER JOIN [Peaks]
        AS [p]
        ON [p].[MountainId] = [m].[Id]
     WHERE [c].[CountryName] = 'Bulgaria' AND 
           [p].[Elevation] > 2835
  ORDER BY [p].[Elevation] DESC


-- Problem 13
   SELECT [CountryCode],
          COUNT([MountainId])
       AS [MountainRanges]
     FROM [MountainsCountries]
    WHERE [CountryCode] IN (
                              SELECT [CountryCode]
                                FROM [Countries]
                               WHERE [CountryName] IN ('United States', 'Russia', 'Bulgaria')
                           )
 GROUP BY [CountryCode]


 -- Problem 15
    SELECT [ContinentCode],
           [CurrencyCode],
           [CurrencyUsage]
      FROM (
            SELECT *,
                   DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC)
                AS [CurrencyRank] 
               FROM (
                      SELECT [ContinentCode],
                             [CurrencyCode],
                             COUNT(*)
                          AS [CurrencyUsage]
                        FROM [Countries]
                    GROUP BY [ContinentCode], [CurrencyCode]
                     HAVING COUNT(*) > 1
                   )
                AS [CurrencyUsageSubquery]
           )
        AS [CurrencyRankingSubQuery]
     WHERE [CurrencyRank] = 1

     
-- Problem 17
   SELECT 
  TOP (5) [c].[CountryName],
          MAX([p].[Elevation])
       AS [HighestPeakElevation],
          MAX([r].[Length])
       AS [LongestRiverLeangth]
     FROM [Countries] 
       AS [c]
LEFT JOIN [CountriesRivers]
       AS [cr]
       ON [cr].[CountryCode] = [c].[CountryCode]
LEFT JOIN [Rivers]
       AS [r]
       ON [cr].[RiverId] = [r].[Id]    
LEFT JOIN [MountainsCountries]
       AS [mc]
       ON [mc].[CountryCode] = [c].[CountryCode]
LEFT JOIN [Mountains]
       AS [m]
       ON [mc].[MountainId] = [m].[Id]
LEFT JOIN [Peaks]
       AS [p]
       ON [p].[MountainId] = [m].[Id]
 GROUP BY [c].[CountryName] 
 ORDER BY [HighestPeakElevation] DESC,
          [LongestRiverLeangth] DESC,
          [CountryName]


-- Problem 18
   SELECT 
  TOP (5) [CountryName]
       AS [Country],
          CASE
             WHEN [PeakName] IS NULL THEN '(no highest peak)'
             ELSE [PeakName]
          END
       AS [Highest Peak Name],
          CASE
             WHEN [Elevation] IS NULL THEN 0
             ELSE [Elevation]
          END
       AS [Highest Peak Elevation],
          CASE
             WHEN [MountainRange] IS NULL THEN '(no mountain)'
             ELSE [MountainRange]
          END
       AS [Mountain]
     FROM (
            SELECT [c].[CountryName],
                      [p].[PeakName],
                      [p].[Elevation],
                      [m].[MountainRange],
                      DENSE_RANK() OVER(PARTITION BY [c].[CountryName] ORDER BY [p].[Elevation] DESC)
                   AS [PeakRank]
                 FROM [Countries]
                   AS [c]
            LEFT JOIN [MountainsCountries]
                   AS [mc]
                   ON [mc].[CountryCode] = [c].[CountryCode]
            LEFT JOIN [Mountains]
                   AS [m]
                   ON [mc].[MountainId] = [m].[Id]
            LEFT JOIN [Peaks]
                   AS [p]
                   ON [p].[MountainId] = [m].[Id]
          ) 
       AS [PeakRankingSubquery]
    WHERE [PeakRank] = 1
 ORDER BY [Country],
          [Highest Peak Name]

   