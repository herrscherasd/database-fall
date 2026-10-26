-- Lab 11: Basic Data Operations

CREATE TABLE students_lab11 (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE
);

-- 1. Insert one record
INSERT INTO students_lab11 (first_name, last_name, birth_date)
VALUES ('Aibek', 'Sharshenov', '2002-05-12');

-- 2. Insert multiple records
INSERT INTO students_lab11 (first_name, last_name, birth_date)
VALUES
    ('Ainura', 'Toktomamatova', '2001-09-23'),
    ('Bakyt', 'Mamatov', '2003-01-15'),
    ('Gulzat', 'Sultanova', '2002-07-30');

SELECT * FROM students_lab11;

-- 3. Update one record
UPDATE students_lab11
SET birth_date = '2002-05-15'
WHERE first_name = 'Aibek' AND last_name = 'Sharshenov';

-- 4. Bulk update
UPDATE students_lab11
SET last_name = 'Bekov'
WHERE last_name IN ('Mamatov', 'Sharshenov');

SELECT * FROM students_lab11;

-- 5. Delete one record
DELETE FROM students_lab11
WHERE first_name = 'Gulzat' AND last_name = 'Sultanova';

-- 6. Bulk delete
DELETE FROM students_lab11
WHERE birth_date < '2002-01-01';

SELECT * FROM students_lab11;

DROP TABLE students_lab11;
