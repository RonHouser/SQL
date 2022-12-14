-- Example query (PostgreSQL) from "https://bit.io/CharlotteChaze/BreakIntoTech"

SELECT
people.show_id,
people.director,
titles.title,
titles.type
    FROM "CharlotteChaze/BreakIntoTech"."netflix_people" people
    LEFT JOIN "CharlotteChaze/BreakIntoTech"."netflix_titles_info" titles 
    ON people.show_id = titles.show_id
    LIMIT 5;

--  How many movie titles are there in the database? (movies only, not tv shows)
SELECT count(*) title, type
    FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info" titles
    GROUP BY Type;
--  Answer: 6131

--  When was the most recent batch of tv shows and/or movies added to the database?
SELECT date_added, title, type
    FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info" titles;
--  Answer:"2021-09-25"

--  List all the movies and tv shows in alphabetical order.
SELECT title
    FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info" titles
    ORDER BY title asc;
--  Answer: Run script

--  Who was the Director for the movie Bright Star?
SELECT people.director, titles.title
    FROM "CharlotteChaze/BreakIntoTech"."netflix_people" people
    LEFT JOIN "CharlotteChaze/BreakIntoTech"."netflix_titles_info" titles
    ON people.show_id=titles.show_id
    WHERE title LIKE '%Bright Star%';
--  Answer: Jane Campion

--  What is the oldest movie in the database and what year was it made?
SELECT title, min(release_year) 
    FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
    WHERE type='Movie'
    GROUP BY title, release_year
    ORDER BY release_year asc
    LIMIT 1;
--  Answer: "The Battle of Midway", 1942
