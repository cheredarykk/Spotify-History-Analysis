CREATE TABLE spotify (
    Date DATETIME,
    EndTime DATETIME,
    ArtistName TEXT,
    TrackName TEXT,
    MsPlayed DOUBLE,
    Language VARCHAR(3)
);
-- Inserted values from txt:
-- INSERT INTO spotify VALUES (copied from txt)



-- Rename other than 'en' and 'uk' values to 'Other' in language column 
-- But first I need to modify lenghth of 'language' varchar
-- + I will modify 'en' to 'En' and 'uk' to 'Uk' for better visuals 

ALTER TABLE spotify 
MODIFY language varchar(6);

UPDATE spotify
SET
language = 'Other'
WHERE language != 'en' AND language != 'uk'; 


-- Converted ms into min and h

ALTER TABLE spotify
ADD COLUMN minutes float,
ADD COLUMN hours float;

UPDATE spotify 
SET minutes = MsPlayed/60000;

UPDATE spotify 
SET hours = MsPlayed/3600000;

ALTER TABLE spotify 
MODIFY  minutes DECIMAL(8,2);
ALTER TABLE spotify 
MODIFY  hours DECIMAL(8,2);
select * from spotify;

-- Calculated Sum of Days and Hours Listened 

SELECT SUM(hours)
FROM spotify;
    
SELECT CAST(SUM(hours)/24 AS DECIMAL(10,2))
FROM spotify;
    
    
-- Top Language choices in music selection 

SELECT language, COUNT(Language) as count
FROM spotify
GROUP BY Language
ORDER BY COUNT(Language) DESC;


-- Most Listened Songs 

SELECT TrackName, sum(hours)
FROM spotify
GROUP BY TrackName
ORDER BY sum(hours) DESC;


-- Most Listened Ukrainian Songs 

SELECT TrackName, sum(hours)
FROM spotify
WHERE language = 'uk'
GROUP BY TrackName
ORDER BY sum(hours) DESC;

-- Most Listened Artists

SELECT ArtistName, sum(hours)
FROM spotify
GROUP BY ArtistName
ORDER BY sum(hours) DESC;


-- Most Listened Ukrainian Artists

SELECT ArtistName, sum(hours), language
FROM spotify
WHERE language = 'uk'
GROUP BY ArtistName
ORDER BY sum(hours) DESC;


-- Music listened each month in hours

SELECT
  MONTHNAME(date),
  YEAR(date),
  sum(hours) 
FROM spotify
GROUP BY 1,2;



-- Music Listening Behavior by Time

SELECT
CONVERT(HOUR(EndTime), signed),
  sum(hours) 
FROM spotify
GROUP BY 1 
ORDER BY 1;

SELECT
CONVERT(HOUR(EndTime), signed),
  sum(hours) 
FROM spotify
GROUP BY 1 
ORDER BY 2;


-- How many artists I listened 
 
SELECT  COUNT(DISTINCT(ArtistName)) as NumberOfArtists
FROM spotify;


-- How many days out of the year I listened to music

SELECT COUNT(DISTINCT(Date))
FROM Spotify;

SELECT 365-COUNT(DISTINCT(Date))
FROM Spotify;