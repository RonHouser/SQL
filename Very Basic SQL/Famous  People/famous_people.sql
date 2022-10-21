/* Create table about the people and what they do here */

CREATE TABLE Famous_People (id INTEGER PRIMARY KEY AUTOINCREMENT,
first_name TEXT,
last_name TEXT,
birthdate TEXT,
occupation integer);

INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Leonardo", "Dicaprio", "11-11-1974", 1);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Willie", "Nelson", "04-29-1933", 2);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Misty", "Copeland", "09-10-1982", 3);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Doutzen", "Kroes", "01-23-1985", 4);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Jack", "Nicholson", "04-22-1937", 1);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Christoph", "Waltz", "10-04-1956", 1);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Bob", "Fosse", "04-27-1911", 3);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Thom", "Yorke", "10-07-1968", 2);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Kate", "Moss", "01-16-1974", 4);
INSERT INTO Famous_People (first_name, last_Name, birthdate, occupation)
VALUES ("Cary", "Grant", "01-18-1904", 5);


CREATE TABLE Profession (id INTEGER PRIMARY KEY,
title TEXT);

INSERT INTO Profession VALUES (1, "Actor");
INSERT INTO Profession VALUES (2, "Musician");
INSERT INTO Profession VALUES (3, "Dancer");
INSERT INTO Profession VALUES (4, "Model");
INSERT INTO Profession VALUES (5, "Actor");

/*What is the occupation of each famous person?*/

SELECT f.first_name, f.last_name, p.title 
    FROM famous_people as f
    JOIN profession as p
    ON p.id = f.occupation;
