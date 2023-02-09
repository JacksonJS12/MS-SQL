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