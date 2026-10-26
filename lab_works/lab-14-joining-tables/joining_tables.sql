-- Lab 14: Joining Tables

CREATE TABLE departments_lab14 (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees_lab14 (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INTEGER REFERENCES departments_lab14(department_id)
);

CREATE TABLE projects_lab14 (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    employee_id INTEGER REFERENCES employees_lab14(employee_id)
);

INSERT INTO departments_lab14 (department_name)
VALUES ('Engineering'), ('Sales'), ('HR');

INSERT INTO employees_lab14 (employee_name, department_id)
VALUES ('Aibek', 1), ('Meerim', 1), ('Bakyt', 2), ('Dana', NULL);

INSERT INTO projects_lab14 (project_name, employee_id)
VALUES ('Database App', 1), ('CRM Setup', 3), ('Internal Portal', NULL);

-- INNER JOIN
SELECT e.employee_name, d.department_name
FROM employees_lab14 e
INNER JOIN departments_lab14 d ON e.department_id = d.department_id;

-- LEFT JOIN
SELECT e.employee_name, d.department_name
FROM employees_lab14 e
LEFT JOIN departments_lab14 d ON e.department_id = d.department_id;

-- RIGHT JOIN
SELECT e.employee_name, d.department_name
FROM employees_lab14 e
RIGHT JOIN departments_lab14 d ON e.department_id = d.department_id;

-- FULL OUTER JOIN
SELECT e.employee_name, p.project_name
FROM employees_lab14 e
FULL OUTER JOIN projects_lab14 p ON e.employee_id = p.employee_id;

-- CROSS JOIN
SELECT e.employee_name, d.department_name
FROM employees_lab14 e
CROSS JOIN departments_lab14 d
ORDER BY e.employee_name, d.department_name;

-- SELF JOIN
CREATE TABLE staff_lab14 (
    staff_id SERIAL PRIMARY KEY,
    staff_name VARCHAR(100),
    manager_id INTEGER REFERENCES staff_lab14(staff_id)
);

INSERT INTO staff_lab14 (staff_name, manager_id)
VALUES ('Director', NULL), ('Manager', 1), ('Developer', 2);

SELECT s.staff_name AS employee, m.staff_name AS manager
FROM staff_lab14 s
LEFT JOIN staff_lab14 m ON s.manager_id = m.staff_id;

DROP TABLE staff_lab14;
DROP TABLE projects_lab14;
DROP TABLE employees_lab14;
DROP TABLE departments_lab14;
