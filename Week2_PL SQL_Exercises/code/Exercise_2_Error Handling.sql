-- Customers Table
CREATE TABLE customers (
  customer_id NUMBER PRIMARY KEY,
  name VARCHAR2(50),
  balance NUMBER(10,2)
);

-- Employees Table
CREATE TABLE employees (
  employee_id NUMBER PRIMARY KEY,
  name VARCHAR2(50),
  salary NUMBER(10,2)
);



-- Sample customers
INSERT INTO customers (customer_id, name, balance) VALUES (1, 'Alice', 5000);
INSERT INTO customers (customer_id, name, balance) VALUES (2, 'Bob', 3000);

-- Sample employees
INSERT INTO employees (employee_id, name, salary) VALUES (1001, 'John', 60000);
INSERT INTO employees (employee_id, name, salary) VALUES (1002, 'Jane', 55000);

COMMIT;

--scenario 1

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
  p_from_id IN NUMBER,
  p_to_id IN NUMBER,
  p_amount IN NUMBER
) AS
  v_from_balance NUMBER;
BEGIN
  -- Check balance
  SELECT balance INTO v_from_balance FROM customers WHERE customer_id = p_from_id;

  IF v_from_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in source account.');
  END IF;

  -- Deduct from source
  UPDATE customers SET balance = balance - p_amount WHERE customer_id = p_from_id;

  -- Add to destination
  UPDATE customers SET balance = balance + p_amount WHERE customer_id = p_to_id;

  COMMIT;

  DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--scenario 2
CREATE OR REPLACE PROCEDURE UpdateSalary (
  p_emp_id IN NUMBER,
  p_percent IN NUMBER
) AS
BEGIN
  UPDATE employees
  SET salary = salary + (salary * p_percent / 100)
  WHERE employee_id = p_emp_id;

  IF SQL%ROWCOUNT = 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Employee ID not found.');
  END IF;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--scenario 3
CREATE OR REPLACE PROCEDURE AddNewCustomer (
  p_id IN NUMBER,
  p_name IN VARCHAR2,
  p_balance IN NUMBER
) AS
BEGIN
  INSERT INTO customers (customer_id, name, balance)
  VALUES (p_id, p_name, p_balance);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Customer added successfully.');

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    INSERT INTO error_logs (error_message)
    VALUES ('Duplicate customer ID: ' || p_id);
    DBMS_OUTPUT.PUT_LINE('Error: Customer ID already exists.');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


-- Test transfer (valid)
EXEC SafeTransferFunds(1, 2, 1000);

-- Test transfer (insufficient funds)
EXEC SafeTransferFunds(2, 1, 999999);

-- Test salary update (valid)
EXEC UpdateSalary(1001, 10);

-- Test salary update (invalid ID)
EXEC UpdateSalary(9999, 10);

-- Test customer insert (valid)
EXEC AddNewCustomer(3, 'Charlie', 7000);

-- Test customer insert (duplicate ID)
EXEC AddNewCustomer(1, 'Duplicate', 1000);



