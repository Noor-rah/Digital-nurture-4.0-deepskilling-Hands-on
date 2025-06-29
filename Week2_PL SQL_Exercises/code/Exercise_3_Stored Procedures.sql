CREATE TABLE accounts (
  account_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  account_type VARCHAR2(20),
  balance NUMBER(10,2)
);

CREATE TABLE employees (
  employee_id NUMBER PRIMARY KEY,
  name VARCHAR2(50),
  department VARCHAR2(50),
  salary NUMBER(10,2)
);

-- Sample accounts
INSERT INTO accounts VALUES (1, 101, 'savings', 10000);
INSERT INTO accounts VALUES (2, 102, 'savings', 5000);
INSERT INTO accounts VALUES (3, 101, 'current', 3000);

-- Sample employees
INSERT INTO employees VALUES (201, 'Alice', 'HR', 60000);
INSERT INTO employees VALUES (202, 'Bob', 'HR', 55000);
INSERT INTO employees VALUES (203, 'Charlie', 'IT', 70000);

COMMIT;

--scenario 1

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
  UPDATE accounts
  SET balance = balance + (balance * 0.01)
  WHERE account_type = 'savings';

  COMMIT;
END;
/

--output

EXEC ProcessMonthlyInterest;

--scenario 2

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
  p_department IN VARCHAR2,
  p_bonus_percent IN NUMBER
) AS
BEGIN
  UPDATE employees
  SET salary = salary + (salary * p_bonus_percent / 100)
  WHERE department = p_department;

  COMMIT;
END;
/

--output

EXEC UpdateEmployeeBonus('HR', 10);

--scenario 3

CREATE OR REPLACE PROCEDURE TransferFunds (
  p_from_account IN NUMBER,
  p_to_account IN NUMBER,
  p_amount IN NUMBER
) AS
  v_balance NUMBER;
BEGIN
  SELECT balance INTO v_balance
  FROM accounts
  WHERE account_id = p_from_account;

  IF v_balance >= p_amount THEN
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;

    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;

    COMMIT;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Insufficient balance.');
  END IF;
END;
/

--output

EXEC TransferFunds(1, 3, 2000);
