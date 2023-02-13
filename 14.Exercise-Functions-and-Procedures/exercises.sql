USE [SoftUni]

GO


-- Problem 01
CREATE PROCEDURE [usp_GetEmployeesSalaryAbove35000] 
              AS
           BEGIN
                  SELECT [FirstName],
                         [LastName]
                    FROM [Employees]
                   WHERE [Salary] > 35000
             END

EXEC [dbo].[usp_GetEmployeesSalaryAbove35000]

GO


-- Problem 02
CREATE PROCEDURE [usp_GetEmployeesSalaryAboveNumber] @minSalary DECIMAL(18,4)
              AS
           BEGIN
                      SELECT [FirstName],
                             [LastName]
                        FROM [Employees]
                       WHERE [Salary] >= @minSalary
             END

EXEC [dbo].[usp_GetEmployeesSalaryAboveNumber] 48100

GO


-- Problem 04
CREATE PROCEDURE [usp_GetEmployeesFromTown] @townName VARCHAR(50)
              AS 
           BEGIN
                     SELECT [e].[FirstName],
                            [e].[LastName]
                       FROM [Employees]
                         AS [e]
                 INNER JOIN [Addresses]
                         AS [a]
                         ON [e].[AddressID] = [a].[AddressID]
                 INNER JOIN [Towns]
                         AS [t]
                         ON [a].[TownID] = [t].[TownID]
                      WHERE [t].[Name] = @townName
             END

EXEC [dbo].[usp_GetEmployeesFromTown] Sofia

GO


-- Problem 06
CREATE PROCEDURE [usp_EmployeesBySalaryLevel] @salaryLevel VARCHAR(8)
              AS 
           BEGIN
                     SELECT [FirstName],
                            [LastName]
                       FROM [Employees]
                      WHERE [dbo].[ufn_GetSalaryLevel]([Salary]) = @salaryLevel
             END

EXEC [dbo].[usp_EmployeesBySalaryLevel] 'High'

GO

-- Problem 07
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50)) 
RETURNS BIT
       AS
    BEGIN
                     DECLARE @wordIndex INT = 1;
                     WHILE (@wordIndex <= LEN(@word))
                     BEGIN
                            DECLARE @currentCharacter CHAR = SUBSTRING(@word, @wordIndex, 1);

                            IF CHARINDEX(@currentCharacter, @setOfLetters) = 0
                            BEGIN
                            RETURN 0;
                            END

                     SET @wordIndex += 1; 
             END

             RETURN 1;
       END

GO

SELECT [dbo].[ufn_IsWordComprised]('oistmiahf', 'Sofia')

GO


-- Problem 08
CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment @departmentId INT
              AS
           BEGIN
                     DECLARE @employeesToDelete TABLE ([Id] INT);

                     INSERT INTO @employeesToDelete
                                 SELECT [EmployeeID] 
                                   FROM [Employees]
                                  WHERE [DepartmentID] = @departmentId

                     DELETE
                       FROM [EmployeesProjects]
                      WHERE [EmployeeID]  IN (   
                                              SELECT *
                                                FROM @employeesToDelete
                                             )

                     ALTER TABLE [Departments]
                    ALTER COLUMN [ManagerID] INT

                    UPDATE [Departments]
                       SET [ManagerID] = NULL
                     WHERE [ManagerID] IN (
                                                 SELECT *
                                                   FROM @employeesToDelete
                                          )

                     UPDATE [Employees]
                        SET [ManagerID] = NULL
                      WHERE [ManagerID] IN (
                                                 SELECT *
                                                   FROM @employeesToDelete
                                           )  

                     DELETE 
                       FROM [Employees]
                      WHERE [DepartmentID] = @departmentId

                      DELETE 
                       FROM [Departments]
                      WHERE [DepartmentID] = @departmentId

                     SELECT COUNT(*)
                       FROM [Employees]
                      WHERE [DepartmentID] = @departmentId
             END

EXEC [dbo].[usp_DeleteEmployeesFromDepartment] 7

GO

USE [Diablo]

GO
-- Problem 13
CREATE FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(50))
RETURNS TABLE
           AS 
       RETURN
              (
                     SELECT SUM([Cash])
                         AS [SumCash]
                       FROM (
                                SELECT [g].[Name],
                                       [ug].[Cash],
                                       ROW_NUMBER() OVER(ORDER BY [ug].[Cash] DESC)
                                    AS [RowNumber]
                                  FROM [UsersGames]
                                    AS [ug]
                            INNER JOIN [Games]
                                    AS [g]
                                    ON [ug].[GameId] = [g].[Id]
                                 WHERE [g].[Name] = @gameName
                            ) 
                         AS [RankingSubQuery]
                      WHERE [RowNumber] % 2 <> 0
              )

GO

SELECT * FROM [dbo].[ufn_CashInUsersGames]('Love in a mist')