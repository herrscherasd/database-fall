-- Lab 09: Database Design Basics

-- Library management system designed from entities and relationships

CREATE TABLE authors_lab9 (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE books_lab9 (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year INTEGER CHECK (published_year > 0)
);

CREATE TABLE book_authors_lab9 (
    book_id INTEGER REFERENCES books_lab9(book_id) ON DELETE CASCADE,
    author_id INTEGER REFERENCES authors_lab9(author_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, author_id)
);

CREATE TABLE members_lab9 (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL
);

CREATE TABLE loans_lab9 (
    loan_id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES books_lab9(book_id),
    member_id INTEGER NOT NULL REFERENCES members_lab9(member_id),
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    CHECK (due_date >= loan_date)
);

INSERT INTO authors_lab9 (first_name, last_name)
VALUES ('Chyngyz', 'Aitmatov'), ('George', 'Orwell');

INSERT INTO books_lab9 (title, isbn, published_year)
VALUES
    ('The Day Lasts More Than a Hundred Years', '978-1-111-11111-1', 1980),
    ('Animal Farm', '978-1-111-11111-2', 1945);

INSERT INTO book_authors_lab9 (book_id, author_id)
VALUES (1, 1), (2, 2);

INSERT INTO members_lab9 (first_name, last_name, email)
VALUES
    ('Aizada', 'Mamatkulov', 'aizada@example.com'),
    ('Aibek', 'Sharshenov', 'aibek@example.com');

INSERT INTO loans_lab9 (book_id, member_id, due_date)
VALUES (1, 1, CURRENT_DATE + INTERVAL '14 days');

SELECT b.title, a.first_name, a.last_name
FROM books_lab9 b
JOIN book_authors_lab9 ba ON b.book_id = ba.book_id
JOIN authors_lab9 a ON ba.author_id = a.author_id;

SELECT m.first_name, m.last_name, b.title, l.loan_date, l.due_date
FROM loans_lab9 l
JOIN members_lab9 m ON l.member_id = m.member_id
JOIN books_lab9 b ON l.book_id = b.book_id;

DROP TABLE loans_lab9;
DROP TABLE book_authors_lab9;
DROP TABLE members_lab9;
DROP TABLE books_lab9;
DROP TABLE authors_lab9;
