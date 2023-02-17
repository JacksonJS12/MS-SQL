CREATE DATABASE [Airport]

GO

USE [Airport]

GO

-- Problem 01
CREATE TABLE [Passengers] (
    [Id] INT PRIMARY KEY IDENTITY,
    [FullName] VARCHAR(100) UNIQUE NOT NULL,
    [Email] VARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE [Pilots](
    [Id] INT PRIMARY KEY IDENTITY,
    [FirstName] VARCHAR(30) UNIQUE NOT NULL,
    [LastName] VARCHAR(30) UNIQUE NOT NULL,
    [Age] TINYINT NOT NULL CHECK(Age >= 21 AND Age <= 62),
    [Rating] FLOAT CHECK(Rating >= 0.0 AND Rating <= 10.0)
)

CREATE TABLE [AircraftTypes](
    [Id] INT PRIMARY KEY IDENTITY,
    [TypeName] VARCHAR(30) UNIQUE NOT NULL
)

CREATE TABLE [Aircraft](
    [Id] INT PRIMARY KEY IDENTITY,
    [Manufacturer] VARCHAR(25) NOT NULL,
    [Model] VARCHAR(30) NOT NULL,
    [Year] INT NOT NULL,
    [FlightHours] INT,
    [Condition] CHAR NOT NULL,
    [TypeId] INT FOREIGN KEY REFERENCES[AircraftTypes]([Id]) NOT NULL
)

CREATE TABLE [PilotsAircraft] (
    [AircraftId] INT FOREIGN KEY REFERENCES [Aircraft]([Id]),
    [PilotId] INT FOREIGN KEY REFERENCES [Pilots]([Id]),
    PRIMARY KEY ([AircraftId], [PilotId])
)

CREATE TABLE [Airports](
    [Id] INT PRIMARY KEY IDENTITY,
    [AirportName] VARCHAR(70) NOT NULL,
    [Country] VARCHAR(100) NOT NULL
)

CREATE TABLE [FlightDestinations](
    [Id] INT PRIMARY KEY IDENTITY,
    [AirportId] INT FOREIGN KEY REFERENCES [Airports]([Id]) NOT NULL,
    [Start] DateTime NOT NULL,
    [AircraftId] INT FOREIGN KEY REFERENCES [Aircraft]([Id]) NOT NULL,
    [PassengerId] INT FOREIGN KEY REFERENCES [Passengers]([Id]) NOT NULL,
    [TicketPrice] DECIMAL(18, 2) DEFAULT(15) NOT NULL
)


-- Problem 02
INSERT INTO [Passengers] 
            ([FullName], [Email])
SELECT 
       CONCAT([FirstName], ' ', [LastName]), 
       CONCAT([FirstName], [LastName], '@gmail.com')
  FROM [Pilots]
 WHERE [Id] BETWEEN 5 AND 15

-- Problem 03
UPDATE [Aircraft] SET [Condition] = 'A'
 WHERE ([Condition] = 'C' OR [Condition] = 'B') AND
       ([FlightHours] IS NULL OR [FlightHours] <= 100) AND
       [Year] >= 2013

-- Problem 04
DELETE FROM [Passengers]
    WHERE LEN([FullName]) <= 10 

-- Problem 05
  SELECT [Manufacturer],
         [Model],
         [FlightHours],
         [Condition]
    FROM [Aircraft]
ORDER BY [FlightHours] DESC

    -- Problem 06
 SELECT [p].[FirstName],
        [p].[LastName],
        [a].[Manufacturer],
        [a].[Model],
        [a].[FlightHours]
   FROM [Pilots]
     AS [p]
   JOIN [PilotsAircraft]
     AS [pa]
     ON [p].[Id] = [pa].[PilotId]
   JOIN [Aircraft]
     AS [a]
     ON [a].[Id] = [pa].[AircraftId]
  WHERE ([a].[FlightHours] IS NOT NULL AND [a].[FlightHours] < 304)
ORDER BY [a].[FlightHours] DESC,
         [p].[FirstName]


-- Probelem 07
SELECT 
TOP (20) [fd].[Id]
      AS [DestinationId],
         [fd].[Start],
         [p].[FullName],
         [a].[AirportName],
         [fd].[TicketPrice]
    FROM [FlightDestinations]
      AS [fd]
    JOIN [Passengers]
      AS [p]
      ON [fd].[PassengerId] = [p].[Id]
    JOIN [Airports]
      AS [a]
      ON [fd].[AirportId] = [a].[Id]
   WHERE (DAY([Start]) % 2 = 0)
ORDER BY [fd].[TicketPrice] DESC,
         [a].[AirportName] 


-- Problem 08
   SELECT [a].[Id]
       AS [AircraftId],
          [a].[Manufacturer],
          [a].[FlightHours],
          COUNT([fd].[Id])
       AS [FlightDestinationsCount],
          ROUND(AVG([fd].[TicketPrice]), 2)
       AS [AvgPrice]
     FROM [Aircraft]
       AS [a]
     JOIN [FlightDestinations]
       AS [fd]
       ON [a].[Id] = [fd].[AircraftId]
 GROUP BY [a].[Id],
          [a].[Manufacturer],
          [a].[FlightHours]
   HAVING COUNT([fd].[Id]) >= 2
 ORDER BY 4 DESC,
          1


-- Problem 09
   SELECT [p].[FullName],
          COUNT([a].[Id])
       AS [CountOfAircraft],
          SUM([fd].[TicketPrice])
       AS [TotalPayed]
     FROM [Passengers]
       AS [p]
     JOIN [FlightDestinations]
       AS [fd]
       ON [p].[Id] = [fd].[PassengerId]
     JOIN [Aircraft]
       AS [a]
       ON [fd].[AircraftId] = [a].[Id]
    WHERE SUBSTRING([p].[FullName], 2, 1) = 'a'
 GROUP BY [p].[Id],
          [p].[FullName]
   HAVING COUNT([a].[Id]) > 1
 ORDER BY [p].[FullName]


-- Problem 10
  SELECT [ap].[AirportName],
         [fd].[Start]
      AS [DayTime],
         [fd].[TicketPrice],
         [p].[FullName],
         [a].[Manufacturer],
         [a].[Model]
    FROM [FlightDestinations]
      AS [fd]
    JOIN [Passengers]
      AS [p]
      ON [fd].[PassengerId] = [p].[Id]
    JOIN [Aircraft]
      AS [a]
      ON [fd].[AircraftId] = [a].[Id]
    JOIN [Airports]
      AS [ap]
      ON [fd].[AirportId] = [ap].[Id]
   WHERE (DATEPART(HOUR, [fd].[Start]) BETWEEN 6 AND 20) AND
         [fd].[TicketPrice] > 2500 
ORDER BY [a].[Model]
 
GO
-- Problem 11
CREATE FUNCTION [udf_FlightDestinationsByEmail](@email VARCHAR(50))
 RETURNS INT AS 
          BEGIN
                DECLARE @destinationCount INT;
                    SET @destinationCount = (
                                                SELECT COUNT([fd].[Id])
                                                  FROM [Passengers]
                                                    AS [p]
                                                  JOIN [FlightDestinations]
                                                    AS [fd]
                                                    ON [fd].[PassengerId] = [p].[Id]
                                                 WHERE [p].[Email] = @email
                                              GROUP BY [p].[Id]
                                            )
                     IF @destinationCount IS NULL
                    SET @destinationCount = 0
                 RETURN @destinationCount
            END

GO

SELECT [dbo].[udf_FlightDestinationsByEmail] ('PierretteDunmuir@gmail.com')

GO

-- Problem 12
CREATE OR ALTER PROCEDURE [usp_SearchByAirportName](@airportName VARCHAR(70))
              AS 
           BEGIN
                SELECT [a].[AirportName],
                       [p].[FullName],
                       CASE  
                             WHEN [fd].[TicketPrice] <= 400 THEN 'Low'
                             WHEN [fd].[TicketPrice] BETWEEN 401 AND 1500 THEN 'Medium'
                             ELSE 'High'
                        END
                    AS [LevelOfTicketPrice],
                       [ac].[Manufacturer],
                       [ac].[Condition],
                       [t].[TypeName]
                  FROM [Airports] 
                    AS [a]
                  JOIN [FlightDestinations]
                    AS [fd]
                    ON [a].[Id] = [fd].[AirportId]
                  JOIN [Passengers]
                    AS [p]
                    ON [p].[Id] = [fd].[PassengerId]
                  JOIN [Aircraft] 
                    AS [ac]
                    ON [ac].[Id] = [fd].[AircraftId]
                  JOIN [AircraftTypes]
                    AS [t]
                    ON [ac].[TypeId] = [t].[Id]
                 WHERE [a].[AirportName] = @airportName
              ORDER BY [ac].[Manufacturer],
                       [p].[FullName]
             END

GO

EXEC usp_SearchByAirportName 'Sir Seretse Khama International Airport'