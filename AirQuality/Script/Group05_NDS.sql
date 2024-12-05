CREATE DATABASE Group05_NDS;

USE Group05_NDS;
GO

CREATE TABLE DataSource (
    SourceID INT IDENTITY(1,1) PRIMARY KEY,
    SourceName NVARCHAR(100) NOT NULL,                   
    CreatedDate DATETIME DEFAULT GETDATE(), 
    UpdatedDate DATETIME                   
);

INSERT INTO DataSource(SourceName) VALUES ('State_AQI_Stage');
INSERT INTO DataSource(SourceName) VALUES ('USCounties_Stage');

CREATE TABLE State (
    StateSK INT IDENTITY(1,1) PRIMARY KEY,
	StateID VARCHAR(10),
    StateName VARCHAR(100) NOT NULL,
    StateCode VARCHAR(10) NOT NULL,
	SourceID INT,
	CreatedDate DATETIME DEFAULT GETDATE(),
	UpdatedDate DATETIME,
	FOREIGN KEY (SourceID) REFERENCES DataSource(SourceID)
);

CREATE TABLE County (
    CountyID INT IDENTITY(1,1) PRIMARY KEY,
    CountyName VARCHAR(100) NOT NULL,
    CountyCode VARCHAR(10) NOT NULL,
    StateSK INT,
    CountyFIPS VARCHAR(10),
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6),
    Population INT,
	SourceID INT,
	CreatedDate DATETIME DEFAULT GETDATE(),
	UpdatedDate DATETIME,
	FOREIGN KEY (SourceID) REFERENCES DataSource(SourceID),
    FOREIGN KEY (StateSK) REFERENCES State(StateSK)
);

CREATE TABLE AQI_Category (
    AQICategoryID INT IDENTITY(1,1) PRIMARY KEY,
    AQICategory VARCHAR(50) NOT NULL,
	SourceID INT,
	CreatedDate DATETIME DEFAULT GETDATE(),
	UpdatedDate DATETIME,
	FOREIGN KEY (SourceID) REFERENCES DataSource(SourceID)
);

CREATE TABLE Air_Quality (
    AirQualityID INT IDENTITY(1,1) PRIMARY KEY,
    CountyID INT,
    AQI INT,
	Date DATETIME,
    DefiningParameter VARCHAR(100),
    DefiningSite VARCHAR(100),
    NumberOfSitesReporting INT,
	AQICategoryID INT,
	SourceID INT,
	CreatedDate DATETIME DEFAULT GETDATE(),
	UpdatedDate DATETIME,
	FOREIGN KEY (SourceID) REFERENCES DataSource(SourceID),
    FOREIGN KEY (CountyID) REFERENCES County(CountyID),
	FOREIGN KEY (AQICategoryID) REFERENCES AQI_Category(AQICategoryID)
);

SELECT * FROM Air_Quality;
SELECT * FROM State;
SELECT * FROM AQI_Category;
SELECT * FROM County;