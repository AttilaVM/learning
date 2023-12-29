DROP TABLE bank_accounts;

CREATE TABLE bank_accounts (
    user_name VARCHAR(200),
    balance INT CHECK (balance > 0)
);

INSERT INTO
    bank_accounts
VALUES (
       'Bob',
        1000
);

INSERT INTO
    bank_accounts
VALUES (
       'Alice',
        7000
);

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;


UPDATE
    bank_accounts
SET
    balance = balance - 5000
WHERE
    user_name = 'Bob';

UPDATE
    bank_accounts
SET
    balance = balance + 5000
WHERE
    user_name = 'Alice';

COMMIT;


SELECT
    user_name,
    balance
FROM
    bank_accounts;
