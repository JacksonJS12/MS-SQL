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
INNER JOIN [Employees]
        AS [m]
        ON [e].[EmployeeID] = [m].[EmployeeID]
     WHERE [e].[ManagerID] IN (3, 7)
  ORDER BY [m].[EmployeeID]



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

