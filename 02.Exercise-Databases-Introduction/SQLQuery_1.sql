CREATE DATABASE Minions

USE [Minions]

CREATE TABLE [Minions](
    Id      INT,
    [Name]  VARCHAR(100),
    Age     INT
)

CREATE TABLE [Towns]( 
    Id INT PRIMARY KEY IDENTITY, 
    [Name] VARCHAR(100)
)

ALTER TABLE [Minions]
    ADD [TownId] INT FOREIGN KEY REFERENCES Towns(Id)
    
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

ALTER TABLE Minions
ALTER COLUMN Id INT NOT NULL;

ALTER TABLE Minions
ADD CONSTRAINT PK_Id  PRIMARY KEY (Id);

INSERT INTO Minions
    (Id, [Name], Age, TownId)
VALUES
(1, 'Kevin',22, 1)
(2, 'Bob',3, 3)
(3, 'Steward', NULL, 2)
