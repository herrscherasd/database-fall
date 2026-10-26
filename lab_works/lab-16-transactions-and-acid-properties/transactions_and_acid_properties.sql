-- Lab 16: Transactions and ACID Properties

CREATE TABLE accounts_lab16 (
    account_id SERIAL PRIMARY KEY,
    account_holder VARCHAR(100),
    balance NUMERIC(10,2) CHECK (balance >= 0)
);

INSERT INTO accounts_lab16 (account_holder, balance)
VALUES ('Aibek', 1000.00), ('Meerim', 500.00);

SELECT * FROM accounts_lab16;

-- 1. Successful transaction
BEGIN;
UPDATE accounts_lab16 SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts_lab16 SET balance = balance + 100 WHERE account_id = 2;
COMMIT;

SELECT * FROM accounts_lab16;

-- 2. Rollback transaction
BEGIN;
UPDATE accounts_lab16 SET balance = balance - 300 WHERE account_id = 1;
UPDATE accounts_lab16 SET balance = balance + 300 WHERE account_id = 2;
ROLLBACK;

SELECT * FROM accounts_lab16;

-- 3. Savepoint
BEGIN;
UPDATE accounts_lab16 SET balance = balance - 50 WHERE account_id = 1;
SAVEPOINT after_first_update;
UPDATE accounts_lab16 SET balance = balance - 2000 WHERE account_id = 1;
ROLLBACK TO SAVEPOINT after_first_update;
UPDATE accounts_lab16 SET balance = balance + 50 WHERE account_id = 2;
COMMIT;

SELECT * FROM accounts_lab16;

-- 4. Isolation level example
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM accounts_lab16 WHERE balance > 500;
COMMIT;

DROP TABLE accounts_lab16;
