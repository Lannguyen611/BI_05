CREATE DATABASE Group05_DDS;

USE Group05_DDS;
GO

DROP TABLE Fact_AirQuality;
DROP TABLE Dim_County;
DROP TABLE Dim_State;
DROP TABLE Dim_AQI_Category;
DROP TABLE Dim_Date;


CREATE TABLE Dim_Date (
    DateID INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Quarter INT,
    Year INT 
);

CREATE TABLE Dim_State (
    StateSK INT IDENTITY(1,1) PRIMARY KEY,
	StateID VARCHAR(10),
    StateName VARCHAR(100) NOT NULL,
    StateCode VARCHAR(10) NOT NULL,
	Status VARCHAR(255)
);

CREATE TABLE Dim_County (
    CountyID INT IDENTITY(1,1) PRIMARY KEY,
    CountyName VARCHAR(100) NOT NULL,
    CountyCode VARCHAR(10) NOT NULL,
    StateSK INT,
    CountyFIPS VARCHAR(10),
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6),
    Population INT,
	Status VARCHAR(255),
	FOREIGN KEY (StateSK) REFERENCES Dim_State(StateSK)
);

CREATE TABLE Dim_AQI_Category (
    AQICategoryID INT IDENTITY(1,1) PRIMARY KEY,
    AQICategory VARCHAR(50) NOT NULL,
);

CREATE TABLE Fact_AirQuality(
	AirQualityID INT IDENTITY(1,1) PRIMARY KEY,
    CountyID INT,
	AQICategoryID INT,
    AQI INT,
	DateID INT,
    DefiningParameter VARCHAR(100),
    DefiningSite VARCHAR(100),
    NumberOfSitesReporting INT,
	FOREIGN KEY (CountyID) REFERENCES Dim_County(CountyID),
	FOREIGN KEY (AQICategoryID) REFERENCES Dim_AQI_Category(AQICategoryID),
	FOREIGN KEY (DateID) REFERENCES Dim_Date(DateID)
);


SELECT * FROM Dim_State;
SELECT * FROM Dim_County;
SELECT * FROM Dim_AQI_Category;
SELECT * FROM Fact_AirQuality;
SELECT * FROM Dim_Date;