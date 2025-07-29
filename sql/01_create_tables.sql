CREATE TABLE DimDate (
  DateKey INT PRIMARY KEY,
  [Date] DATE,
  Year INT, Month INT, Day INT, Week INT, DayOfWeek INT
);

CREATE TABLE DimCountry (
	CountryKey INT IDENTITY PRIMARY KEY, 
	CountryName NVARCHAR(100)
);

CREATE TABLE DimTrack (
  TrackKey INT IDENTITY PRIMARY KEY,
  SpotifyID NVARCHAR(50), Name NVARCHAR(300), AlbumName NVARCHAR(300),
  AlbumReleaseDate DATE, DurationMs INT, IsExplicit BIT
);

CREATE TABLE DimArtist (
	ArtistKey INT IDENTITY PRIMARY KEY, 
	ArtistName NVARCHAR(300)
);

CREATE TABLE FactSpotify (
  FactID INT IDENTITY PRIMARY KEY,
  DateKey INT, 
  CountryKey INT, 
  TrackKey INT, 
  ArtistKey INT,
  DailyRank INT, 
  DailyMovement INT, 
  WeeklyMovement INT,
  Popularity INT, 
  Danceability DECIMAL(4,2), 
  Energy DECIMAL(4,2),
  Loudness DECIMAL(6,2), 
  Speechiness DECIMAL(4,2), 
  Acousticness DECIMAL(4,2),
  Instrumentalness DECIMAL(4,2), 
  Liveness DECIMAL(4,2),
  Valence DECIMAL(4,2), 
  Tempo DECIMAL(6,2), 
  MusicalKey INT, 
  Mode INT,
  TimeSignature INT,
  IsExplicit BIT
  FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
  FOREIGN KEY (CountryKey) REFERENCES DimCountry(CountryKey),
  FOREIGN KEY (TrackKey) REFERENCES DimTrack(TrackKey),
  FOREIGN KEY (ArtistKey) REFERENCES DimArtist(ArtistKey)
);

