-- Lab 12: Querying Data

CREATE TABLE employees_lab12 (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    email VARCHAR(120)
);

INSERT INTO employees_lab12 (name, department, salary, email)
VALUES
    ('Aibek', 'Sales', 65000, 'aibek@gmail.com'),
    ('Meerim', 'Engineering', 95000, 'meerim@company.com'),
    ('Bakyt', 'Engineering', 78000, 'bakyt@gmail.com'),
    ('Dana', 'HR', 52000, 'dana@company.com'),
    ('Azamat', 'Sales', 72000, 'azamat@company.com');

SELECT * FROM employees_lab12;

SELECT name, department FROM employees_lab12;

SELECT name, salary, salary * 0.10 AS potential_bonus
FROM employees_lab12;

SELECT name, salary
FROM employees_lab12
WHERE department = 'Sales';

SELECT name
FROM employees_lab12
WHERE salary > 75000 AND department = 'Engineering';

SELECT name, salary
FROM employees_lab12
WHERE salary BETWEEN 60000 AND 80000;

SELECT name
FROM employees_lab12
WHERE name LIKE 'A%';

SELECT email
FROM employees_lab12
WHERE email ILIKE '%@gmail.com';

SELECT name
FROM employees_lab12
WHERE name ~ '^[AB]';

SELECT name, department
FROM employees_lab12
WHERE department IN ('Sales', 'HR');

SELECT name, salary,
    CASE
        WHEN salary > 90000 THEN 'Senior'
        WHEN salary BETWEEN 60000 AND 90000 THEN 'Mid-Level'
        ELSE 'Junior'
    END AS employee_level
FROM employees_lab12;

WITH department_averages AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees_lab12
    GROUP BY department
)
SELECT e.name, e.salary, e.department, da.avg_salary
FROM employees_lab12 e
JOIN department_averages da ON e.department = da.department
WHERE e.salary > da.avg_salary;

DROP TABLE employees_lab12;
