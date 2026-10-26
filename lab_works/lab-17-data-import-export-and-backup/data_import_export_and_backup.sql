-- Lab 17: Data Import/Export and Backup

CREATE TABLE products_lab17 (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10,2)
);

INSERT INTO products_lab17 (product_name, category, price)
VALUES
    ('Laptop', 'Electronics', 900.00),
    ('Mouse', 'Electronics', 25.00),
    ('Notebook', 'Stationery', 3.50);

SELECT * FROM products_lab17;

-- Export table data to CSV
\copy products_lab17 TO 'products_lab17.csv' WITH CSV HEADER

-- Import table data from CSV
CREATE TABLE products_import_lab17 (
    product_id INTEGER,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);

\copy products_import_lab17 FROM 'products_lab17.csv' WITH CSV HEADER

SELECT * FROM products_import_lab17;

-- Export query results
\copy (SELECT product_name, price FROM products_lab17 WHERE category = 'Electronics') TO 'electronics_lab17.csv' WITH CSV HEADER

-- run_labs.py also backs up this database and checks a separate restored copy.
-- Keep the tables for that check when keep_tables is true.
\if :{?keep_tables}
\else
\set keep_tables false
\endif

\if :keep_tables
\else
DROP TABLE products_import_lab17;
DROP TABLE products_lab17;
\endif
