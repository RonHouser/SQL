/*The goal of this project was to demonstrate my ability to create tables and import data.
In this example I sourced Spotify data from Kaggle.
I created a table to insert the Spotify data into.
I chose a few questions to demonstrate analytics on the data using SQL.
I inserted the Spotify Data .csv into the table.
I explored the data using the SQL below:*/ 

CREATE TABLE BIT_DB.Spotifydata (
    id integer PRIMARY KEY,
    artist_name varchar NOT NULL,
    track_name varchar NOT NULL,
    track_id varchar NOT NULL,
    popularity integer NOT NULL,
    danceability decimal(4,3) NOT NULL,
    energy decimal(4,3) NOT NULL,
    key integer NOT NULL,
    loudness decimal(5,3) NOT NULL,
    mode integer NOT NULL,
    speechiness decimal(5,4) NOT NULL,
    acousticness decimal(6,5) NOT NULL,
    instrumentalness text NOT NULL,
    liveness decimal(5,4) NOT NULL,
    valence decimal(4,3) NOT NULL,
    tempo decimal(6,3) NOT NULL,
    duration_ms integer NOT NULL,
    time_signature integer NOT NULL);
    
/*What is the avg popularity, danceability, and energy by artist and track*/
SELECT AVG(popularity), AVG(danceability),  AVG(energy), artist_name, track_name
    FROM BIT_DB.Spotifydata
    GROUP BY track_name;

/*Who are the top 10 most popular artist?*/
SELECT artist_name, popularity
    FROM BIT_DB.Spotifydata
    ORDER BY popularity desc
    LIMIT 10;


/*The next example uses a CTE to accomplish the task.
Label every artist with an average popularity of 90 or above as a “Top Star”.*/  

WITH pop_avg AS
  
(    SELECT s.artist_name, AVG(s.popularity) AS AVG_Popularity
        FROM SpotifyData AS s 
        GROUP BY s.artist_name    )           
                            
SELECT  artist_name, AVG_Popularity, 'Top Star' AS tag
    FROM pop_avg
    WHERE AVG_Popularity >= 90;
