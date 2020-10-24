-- when running sqlite3 in terminal, .header on, .mode column

-- Drop table (order by dropping the foreign key tables first)
DROP TABLE question_likes;
DROP TABLE replies;
DROP TABLE question_follows;
DROP TABLE questions;
DROP TABLE users;

-- Sqlite3 to respect the foreign key constraints in CREATE statements
PRAGMA foreign_keys = ON;

-- USERS

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL, 
    lname VARCHAR(255) NOT NULL
);

INSERT INTO
    users (fname, lname)
VALUES 
    ("Harrison", "Lau"), ("Raden", "Asri"), ("James", "Bond");

-- QUESTIONS 

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id) 
);

INSERT INTO
    questions (title, body, author_id)
VALUES
    ("First Q", "QQQ", (SELECT id FROM users WHERE fname = "Harrison" AND lname = "Lau"));

INSERT INTO
    questions (title, body, author_id)
VALUES
    ("Second Q", "QQQQQ", (SELECT id FROM users WHERE fname = "James" AND lname = "Bond"));


-- QUESTION FOLLOWS 

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
    question_follows(user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "Harrison" AND lname = "Lau"), 
    (SELECT id FROM questions WHERE title = "First Q")),

    ((SELECT id FROM users WHERE fname = "Raden" AND lname = "Asri"),
    (SELECT id FROM questions WHERE title = "Second Q"));

-- QUESTION REPLIES 

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL, 
    parent_reply_id INTEGER, 
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE title = "Second Q"),NULL,
    (SELECT id FROM users WHERE fname = "Raden" AND lname = "Asri"),
    "First");

INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE title = "Second Q"),
    (SELECT id FROM replies WHERE body = "First"),
    (SELECT id FROM users WHERE fname = "Harrison" AND lname = "Lau"),
    "Second");


-- QUESTION LIKES 

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    question_likes (user_id, question_id)
VALUES 
    ((SELECT id FROM users WHERE fname = "Harrison" AND lname = "Lau"),
    (SELECT id FROM questions WHERE title = "Second Q"));