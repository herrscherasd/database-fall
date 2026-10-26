-- Lab 15: Advanced Querying

CREATE TABLE employees_lab15 (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE
);

INSERT INTO employees_lab15 (employee_name, department, salary, hire_date)
VALUES
    ('Aibek', 'Engineering', 95000, '2021-01-15'),
    ('Meerim', 'Engineering', 88000, '2022-04-10'),
    ('Bakyt', 'Sales', 72000, '2020-03-20'),
    ('Dana', 'Sales', 68000, '2023-02-01'),
    ('Azamat', 'HR', 55000, '2022-11-05');

-- Subquery
SELECT employee_name, salary
FROM employees_lab15
WHERE salary > (SELECT AVG(salary) FROM employees_lab15);

-- CTE
WITH department_salary AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees_lab15
    GROUP BY department
)
SELECT e.employee_name, e.department, e.salary, ds.avg_salary
FROM employees_lab15 e
JOIN department_salary ds ON e.department = ds.department
WHERE e.salary >= ds.avg_salary;

-- Window functions
SELECT employee_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank,
       AVG(salary) OVER (PARTITION BY department) AS department_average
FROM employees_lab15;

-- FILTER
SELECT department,
       COUNT(*) AS total_employees,
       COUNT(*) FILTER (WHERE salary >= 80000) AS high_salary_employees
FROM employees_lab15
GROUP BY department;

-- Custom sorting with CASE
SELECT employee_name, department, salary
FROM employees_lab15
ORDER BY
    CASE department
        WHEN 'Engineering' THEN 1
        WHEN 'Sales' THEN 2
        WHEN 'HR' THEN 3
        ELSE 4
    END,
    salary DESC;

-- Query plan
EXPLAIN
SELECT employee_name
FROM employees_lab15
WHERE department = 'Engineering';

CREATE INDEX idx_employees_lab15_department
ON employees_lab15(department);

DROP TABLE employees_lab15;
