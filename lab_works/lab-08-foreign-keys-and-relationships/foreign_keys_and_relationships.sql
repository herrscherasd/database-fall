-- Lab 08: Foreign Keys and Relationships

-- 1. Inline foreign key
CREATE TABLE departments_lab8 (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE students_lab8 (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department_id INTEGER REFERENCES departments_lab8(department_id)
);

-- 2. Table-level foreign key
CREATE TABLE courses_lab8 (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INTEGER,
    FOREIGN KEY (department_id) REFERENCES departments_lab8(department_id)
);

-- 3. Add a named foreign key to an existing table
CREATE TABLE enrollments_lab8 (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE DEFAULT CURRENT_DATE
);

ALTER TABLE enrollments_lab8
ADD CONSTRAINT fk_enrollments_student
FOREIGN KEY (student_id) REFERENCES students_lab8(student_id);

ALTER TABLE enrollments_lab8
ADD CONSTRAINT fk_enrollments_course
FOREIGN KEY (course_id) REFERENCES courses_lab8(course_id);

-- 4. Insert valid parent and child records
INSERT INTO departments_lab8 (department_name)
VALUES ('Software Engineering'), ('Business Administration');

INSERT INTO students_lab8 (student_name, department_id)
VALUES ('Aibek', 1), ('Meerim', 1), ('Dana', 2);

INSERT INTO courses_lab8 (course_name, department_id)
VALUES ('Databases', 1), ('Management', 2);

INSERT INTO enrollments_lab8 (student_id, course_id)
VALUES (1, 1), (2, 1), (3, 2);

SELECT * FROM enrollments_lab8;

-- 5. Referential integrity test
INSERT INTO enrollments_lab8 (student_id, course_id)
VALUES (99, 1);

-- 6. ON DELETE CASCADE
CREATE TABLE clubs_lab8 (
    club_id SERIAL PRIMARY KEY,
    club_name VARCHAR(100) NOT NULL
);

CREATE TABLE club_members_lab8 (
    member_id SERIAL PRIMARY KEY,
    club_id INTEGER REFERENCES clubs_lab8(club_id) ON DELETE CASCADE,
    student_name VARCHAR(100) NOT NULL
);

INSERT INTO clubs_lab8 (club_name) VALUES ('Programming Club');
INSERT INTO club_members_lab8 (club_id, student_name)
VALUES (1, 'Aibek'), (1, 'Meerim');

DELETE FROM clubs_lab8 WHERE club_id = 1;
SELECT * FROM club_members_lab8;

-- 7. One-to-one relationship
CREATE TABLE student_profiles_lab8 (
    profile_id SERIAL PRIMARY KEY,
    student_id INTEGER UNIQUE REFERENCES students_lab8(student_id),
    phone VARCHAR(30),
    address VARCHAR(150)
);

-- 8. Many-to-many relationship through a junction table
SELECT s.student_name, c.course_name
FROM enrollments_lab8 e
JOIN students_lab8 s ON e.student_id = s.student_id
JOIN courses_lab8 c ON e.course_id = c.course_id;

DROP TABLE student_profiles_lab8;
DROP TABLE club_members_lab8;
DROP TABLE clubs_lab8;
DROP TABLE enrollments_lab8;
DROP TABLE courses_lab8;
DROP TABLE students_lab8;
DROP TABLE departments_lab8;
