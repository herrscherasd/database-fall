-- Lab 10: Viewing Database and Table Structure

CREATE TABLE departments_lab10 (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE students_lab10 (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) UNIQUE,
    department_id INTEGER REFERENCES departments_lab10(department_id)
);

-- View all tables in the current database
\dt

-- Describe exact table structures
\d departments_lab10
\d students_lab10

-- View table and column metadata through information_schema
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'students_lab10'
ORDER BY ordinal_position;

DROP TABLE students_lab10;
DROP TABLE departments_lab10;
