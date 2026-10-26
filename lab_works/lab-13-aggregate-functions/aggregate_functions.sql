-- Lab 13: Aggregate Functions

CREATE TABLE sales_lab13 (
    sale_id SERIAL PRIMARY KEY,
    department VARCHAR(50),
    employee_name VARCHAR(100),
    amount NUMERIC(10,2),
    sale_date DATE
);

INSERT INTO sales_lab13 (department, employee_name, amount, sale_date)
VALUES
    ('Electronics', 'Aibek', 1200.00, '2024-01-10'),
    ('Electronics', 'Meerim', 950.00, '2024-01-12'),
    ('Books', 'Bakyt', 300.00, '2024-02-05'),
    ('Books', 'Dana', 450.00, '2024-02-07'),
    ('Clothing', 'Azamat', 700.00, '2024-03-01'),
    ('Electronics', 'Aibek', 1500.00, '2024-03-15');

SELECT COUNT(*) AS total_sales FROM sales_lab13;

SELECT SUM(amount) AS total_revenue FROM sales_lab13;

SELECT AVG(amount) AS average_sale FROM sales_lab13;

SELECT MAX(amount) AS highest_sale, MIN(amount) AS lowest_sale
FROM sales_lab13;

SELECT department, COUNT(*) AS number_of_sales, SUM(amount) AS total_sales, AVG(amount) AS average_sale
FROM sales_lab13
GROUP BY department;

SELECT department, SUM(amount) AS total_sales
FROM sales_lab13
GROUP BY department
HAVING SUM(amount) > 1000;

SELECT department, STRING_AGG(employee_name, ', ' ORDER BY employee_name) AS employees
FROM sales_lab13
GROUP BY department;

SELECT department, ARRAY_AGG(amount ORDER BY amount) AS sale_amounts
FROM sales_lab13
GROUP BY department;

SELECT EXTRACT(YEAR FROM sale_date) AS year,
       EXTRACT(QUARTER FROM sale_date) AS quarter,
       COUNT(*) AS sales_count,
       SUM(amount) AS revenue
FROM sales_lab13
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(QUARTER FROM sale_date)
ORDER BY year, quarter;

DROP TABLE sales_lab13;
