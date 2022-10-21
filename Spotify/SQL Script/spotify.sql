/*
A few commands to explore the imported .csv file from Spotify

Skills used: Aggregate functions, Group By, Order By, CTE
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
