INSERT INTO DimDate SELECT DISTINCT
  CONVERT(INT, FORMAT(snapshot_date,'yyyyMMdd')),
  snapshot_date, YEAR(snapshot_date), MONTH(snapshot_date),
  DAY(snapshot_date), DATEPART(week,snapshot_date),
  DATEPART(weekday,snapshot_date)
FROM universal_top_spotify_songs;

INSERT INTO DimCountry (CountryName)
  SELECT DISTINCT country FROM universal_top_spotify_songs;

INSERT INTO DimTrack (SpotifyID, Name, AlbumName, AlbumReleaseDate, DurationMs, IsExplicit)
SELECT DISTINCT
  s.spotify_id, s.name, s.album_name,
  CAST(s.album_release_date AS DATE),
  s.duration_ms, s.is_explicit
FROM universal_top_spotify_songs s
WHERE NOT EXISTS (
  SELECT 1 FROM DimTrack dt WHERE dt.SpotifyID = s.spotify_id
);

INSERT INTO DimArtist (ArtistName)
SELECT DISTINCT s.artists
FROM universal_top_spotify_songs s
WHERE NOT EXISTS (
  SELECT 1 FROM DimArtist da WHERE da.ArtistName = s.artists
);

INSERT INTO FactSpotify (
  DateKey,
  CountryKey,
  TrackKey,
  ArtistKey,
  DailyRank,
  DailyMovement,
  WeeklyMovement,
  Popularity,
  Danceability,
  Energy,
  Loudness,
  Speechiness,
  Acousticness,
  Instrumentalness,
  Liveness,
  Valence,
  Tempo,
  MusicalKey,
  Mode,
  TimeSignature,
  IsExplicit
)
SELECT 
  d.DateKey, c.CountryKey, t.TrackKey, a.ArtistKey,
  s.daily_rank, s.daily_movement, s.weekly_movement,
  s.popularity, s.danceability, s.energy, s.loudness,
  s.speechiness, s.acousticness, s.instrumentalness,
  s.liveness, s.valence, s.tempo, s.[key], s.mode,
  s.time_signature, s.is_explicit
FROM universal_top_spotify_songs s
JOIN DimDate d ON CONVERT(INT, FORMAT(s.snapshot_date,'yyyyMMdd')) = d.DateKey
JOIN DimCountry c ON s.country = c.CountryName
JOIN DimTrack t ON s.spotify_id = t.SpotifyID
JOIN DimArtist a ON s.artists = a.ArtistName;