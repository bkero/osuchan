DROP TABLE badwords CASCADE;
DROP TABLE boardcategory CASCADE;
DROP TABLE board CASCADE;
DROP TABLE thread CASCADE;
DROP TABLE post CASCADE;
DROP TABLE file CASCADE;

CREATE TABLE badwords (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    replacement VARCHAR(20)
);

CREATE TABLE boardcategory (
    id SERIAL PRIMARY KEY,
    title VARCHAR(20)
);

CREATE TABLE board (
    name VARCHAR(20),
    abbreviation CHAR(1) PRIMARY KEY,
    category INTEGER REFERENCES boardcategory(id)
);

CREATE TABLE thread (
    id SERIAL PRIMARY KEY,
    subject VARCHAR(20),
    author VARCHAR(20),
    board CHAR(1) REFERENCES board(abbreviation)
);

CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    author VARCHAR (20) NOT NULL,
    threadid INTEGER REFERENCES thread(id),
    timestamp TIMESTAMP,
    comment VARCHAR(160),
    email VARCHAR(30)
);

CREATE TABLE file (
    id SERIAL PRIMARY KEY,
    postid INTEGER REFERENCES post(id),
    filename VARCHAR (20) NOT NULL
);

INSERT INTO boardcategory VALUES (DEFAULT, 'general');
INSERT INTO board (name, abbreviation, category) VALUES ('school', 's', 1);
INSERT INTO thread VALUES (DEFAULT, 'New subject', 'Anonymous', 's');
INSERT INTO post VALUES (DEFAULT, 'Anonymous', 1, NOW(), 'My Fancy Comment!!!\n\n\nStuff goes here?', 'anon@nonymo.us');
