USE [Gringotts]

GO

-- Problem 03
   SELECT [DepositGroup],
          MAX([MagicWandSize])
       AS [LongestMagicWand]
     FROM [WizzardDeposits]
 GROUP BY [DepositGroup]

 
-- Problem 04
   SELECT 
  TOP (2) [DepositGroup]
     FROM [WizzardDeposits]
 GROUP BY [DepositGroup]
 ORDER BY AVG([MagicWandSize])


-- Problem 05
   SELECT [DepositGroup],
          SUM([DepositAmount])
       AS [TotalSum]
     FROM [WizzardDeposits]
 GROUP BY [DepositGroup]


 -- Problem 07
    SELECT [DepositGroup],
            SUM([DepositAmount])
        AS [TotalSum]
      FROM [WizzardDeposits]
     WHERE [MagicWandCreator] = 'Ollivander family'
  GROUP BY [DepositGroup]
    HAVING SUM([DepositAmount]) < 150000
  ORDER BY [TotalSum] DESC


-- Problem 09
   SELECT [AgeGroup],
          COUNT(*)
       AS [WizardCount]
     FROM (
             SELECT 
                    CASE
                         WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
                         WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
                         WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
                         WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
                         WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
                         WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
                         ELSE '[61+]'
                    END
                  AS [AgeGroup] 
                FROM [WizzardDeposits]
          )
       AS [AgeGroupSubquery]
 GROUP BY [AgeGroup]

 -- Problem 11 
    SELECT [DepositGroup],
           [IsDepositExpired],
           AVG([DepositInterest])
      FROM [WizzardDeposits]
     WHERE [DepositStartDate] > '01/01/1985'
  GROUP BY [DepositGroup], [IsDepositExpired]
  ORDER BY [DepositGroup] DESC,
           [IsDepositExpired]


-- Problem 12
SELECT SUM([Difference]) 
    AS [SumDiffrence]
   FROM(
         SELECT [FirstName]
             AS [Host Wizard],
                [DepositAmount]
             AS [Host Wizard Deposit],
                LEAD([FirstName]) OVER(ORDER BY [Id])
             AS [Guest Wizard],
                LEAD([DepositAmount]) OVER(ORDER BY [Id])
             AS [Guest Wizard Deposit],
                [DepositAmount] - LEAD([DepositAmount]) OVER(ORDER BY [Id])
             AS [Difference]
           FROM [WizzardDeposits] 
       ) AS [DifferenceSubQuery]


GO

USE [SoftUni]

GO


-- Problem 15
SELECT *
  INTO [EmplyeesWithSalaryOver30000]
  FROM [Employees]
 WHERE [Salary] > 30000

DELETE 
  FROM [EmplyeesWithSalaryOver30000]
 WHERE [ManagerID] = 42

UPDATE [EmplyeesWithSalaryOver30000]
   SET [Salary] += 5000
 WHERE [DepartmentID] = 1

   SELECT [DepartmentID],
		  AVG([Salary])
       AS [AverageSalary]
     FROM [EmplyeesWithSalaryOver30000]
 GROUP BY [DepartmentID]

-- Problem 18
 SELECT 
 DISTINCT [DepartmentID],
          AVG([Salary])
       AS [AverageSalary]
     FROM (
           SELECT [DepartmentID],
                  [Salary],
                  DENSE_RANK() OVER(PARTITION BY [DepartmentID] ORDER BY [Salary] DESC)
               AS [SalaryRank]
             FROM [Employees]
          ) 
       AS [SalaryRankingSuquery]
    WHERE [SalaryRank] = 3
        
   
-- Problem 19
   SELECT 
 TOP (10) [e].[FirstName],
          [e].[LastName],
          [e].[DepartmentID],
          [e].[Salary]
     FROM [Employees]
       AS [e]
    WHERE [e].[Salary] > (
                         SELECT  AVG([Salary])
                              AS [AverageSalary]
                            FROM [Employees]
                              AS [eSub]
                           WHERE [eSub].[DepartmentID] = [e].[DepartmentID]
                        GROUP BY [DepartmentID] 
                     )
 ORDER BY [e].[DepartmentID]