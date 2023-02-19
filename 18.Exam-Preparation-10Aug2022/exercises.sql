CREATE DATABASE [NationalTouristSitesOfBulgaria]

GO

USE [NationalTouristSitesOfBulgaria]

GO


-- Problem 01
CREATE TABLE [Categories](
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(50) NOT NULL
)

CREATE TABLE [Locations](
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(50) NOT NULL,
    [Municipality] VARCHAR(50),
    [Province] VARCHAR(50) 
)

CREATE TABLE [Sites](
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(100) NOT NULL,
    [LocationId] INT FOREIGN KEY REFERENCES [Locations]([Id]) NOT NULL,
    [CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]) NOT NULL,
    [Establishment] VARCHAR(15)
)

CREATE TABLE [Tourists](
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(50) NOT NULL,
    [Age] INT CHECK([Age] BETWEEN 0 AND 120) NOT NULL,
    [PhoneNumber] VARCHAR(20) NOT NULL,
    [Nationality] VARCHAR(30) NOT NULL,
    [Reward] VARCHAR(20) 
)

CREATE TABLE [SitesTourists](
    [TouristId] INT FOREIGN KEY REFERENCES [Tourists]([Id]) NOT NULL,
    [SiteId] INT FOREIGN KEY REFERENCES [Sites]([Id]) NOT NULL,
    PRIMARY KEY ([TouristId], [SiteId]) 
)

CREATE TABLE [BonusPrizes](
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(50) NOT NULL
)

CREATE TABLE [TouristsBonusPrizes](
    [TouristId] INT FOREIGN KEY REFERENCES [Tourists]([Id]) NOT NULL,
    [BonusPrizeId] INT FOREIGN KEY REFERENCES [BonusPrizes]([Id]) NOT NULL
    PRIMARY KEY ([TouristId], [BonusPrizeId])
)


-- Problme 02
INSERT INTO [Tourists]
            ([Name], [Age], [PhoneNumber], [Nationality], [Reward])
     VALUES
            ('Borislava Kazakova',	52,	'+359896354244',	'Bulgaria',	NULL),
            ('Peter Bosh',	48,	'+447911844141',	'UK',	NULL),
            ('Martin Smith',	29,	'+353863818592',	'Ireland',	'Bronze badge'),
            ('Svilen Dobrev',	49,	'+359986584786',	'Bulgaria',	'Silver badge'),
            ('Kremena Popova',	38,	'+359893298604',	'Bulgaria',	NULL)


INSERT INTO [Sites]
            ([Name], [LocationId], [CategoryId], [Establishment])
     VALUES ('Ustra fortress', 90,	7,	'X'),
            ('Karlanovo Pyramids',	65,	7,	NULL),
            ('The Tomb of Tsar Sevt',	63,	8,	'V BC'),
            ('Sinite Kamani Natural Park', 17,	1,	NULL),
            ('St. Petka of Bulgaria - Rupite',	92,	6,	'1994')


-- Problem 03
UPDATE [Sites]
   SET [Establishment] = '(not defined)'
 WHERE [Establishment] IS NULL


 SELECT *
   FROM [Sites]


-- Problem 04
DELETE 
  FROM [TouristsBonusPrizes]
 WHERE [BonusPrizeId] = (
                    SELECT [Id]
                      FROM [BonusPrizes]
                     WHERE [Name] = 'Sleeping bag'
                )


DELETE 
  FROM [BonusPrizes]
 WHERE [Name] = 'Sleeping bag'


-- Problem 05
  SELECT [Name],
         [Age],
         [PhoneNumber],
         [Nationality]
    FROM [Tourists]
ORDER BY [Nationality],
         [Age] DESC,
         [Name]


-- Problem 06
   SELECT [s].[Name],
          [l].[Name]
       AS [Location],
          [s].[Establishment],
          [c].[Name] 
     FROM [Sites]
       AS [s]
     JOIN [Categories]
       AS [c]
       ON [c].[Id] = [s].[CategoryId]
     JOIN [Locations]
       AS [l]
       ON [l].[Id] = [s].[LocationId]
 ORDER BY [c].[Name] DESC,
          [l].[Name],
          [s].[Name]


-- Problem 07
  SELECT [l].[Province],
         [l].[Municipality],
         [l].[Name],
         COUNT([s].[Name])
      AS [CountOfSites]
    FROM [Locations]
      AS [l]
    JOIN [Sites]
      AS [s]
      ON [s].[LocationId] = [l].[Id] 
   WHERE [Province] = 'Sofia'
GROUP BY [l].[Name],
         [l].[Province],
         [l].[Municipality]
ORDER BY [CountOfSites] DESC,
         [l].[Name]


-- Problem 08
SELECT DISTINCT [s].[Name]
             AS [Site],
                [l].[Name]
             AS [Location],
                [l].[Municipality],
                [l].[Province],
                [s].[Establishment]
           FROM [Sites]
             AS [s]
           JOIN [Locations]
             AS [l]
             ON [l].[Id] = [s].[LocationId]
          WHERE [l].[Name] NOT LIKE ('B%') AND 
                [l].[Name] NOT LIKE ('M%') AND
                [l].[Name] NOT LIKE ('D%') AND
                [s].[Establishment] LIKE ('%BC')
       ORDER BY [s].[Name]  


-- Problem 09
   SELECT [t].[Name],
          [t].[Age],
          [t].[PhoneNumber],
          [t].[Nationality],
          ISNULL([b].[Name], '(no bonus prize)')
       AS [Reward]
     FROM [Tourists]
       AS [t]
LEFT JOIN [TouristsBonusPrizes]
       AS [tb]
       ON [tb].[TouristId] = [t].[Id]
LEFT JOIN [BonusPrizes]
       AS [b]
       ON [tb].[BonusPrizeId] = [b].[Id]
 ORDER BY [t].[Name]
    
       