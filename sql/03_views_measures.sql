CREATE VIEW vw_FactSpotify AS
SELECT f.*, d.Date, c.CountryName, t.Name AS TrackName,
       a.ArtistName
FROM FactSpotify f
JOIN DimDate d ON f.DateKey = d.DateKey
JOIN DimCountry c ON f.CountryKey = c.CountryKey
JOIN DimTrack t ON f.TrackKey = t.TrackKey
JOIN DimArtist a ON f.ArtistKey = a.ArtistKey;