/*
The goal of this project was to demonstrate my ability to create tables and import data.
In this example I sourced Spotify data from Kaggle.
I created a table to insert the Spotify data into.
I chose a few questions to demonstrate analytics on the data using SQL.
I inserted the Spotify Data .csv into the table.
I explored the data using the SQL below:
*/ 

--What is the avg popularity, danceability, and energy by artist and track
SELECT AVG(popularity), AVG(danceability),  AVG(energy), artist_name, track_name
    FROM BIT_DB.Spotifydata
    GROUP BY track_name;

--Who are the top 10 most popular artist?
SELECT artist_name, popularity
    FROM BIT_DB.Spotifydata
    ORDER BY popularity desc
    LIMIT 10;



--Label every artist with an average popularity of 90 or above as a “Top Star”. 

WITH pop_avg AS
  
(    SELECT s.artist_name, AVG(s.popularity) AS AVG_Popularity
        FROM SpotifyData AS s 
        GROUP BY s.artist_name    )           
                            
SELECT  artist_name, AVG_Popularity, 'Top Star' AS tag
    FROM pop_avg
    WHERE AVG_Popularity >= 90;
