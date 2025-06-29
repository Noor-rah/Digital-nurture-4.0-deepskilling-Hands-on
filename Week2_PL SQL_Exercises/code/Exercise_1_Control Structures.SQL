CREATE TABLE customer (customer_id NUMBER PRIMARY KEY,name VARCHAR2(20),age NUMBER,balance NUMBER(10,2),IsVIP VARCHAR2(5));

CREATE TABLE loan (loan_id NUMBER PRIMARY KEY,customer_id NUMBER,interest_rate NUMBER(5,2),due_date DATE,FOREIGN KEY (customer_id) REFERENCES customer(customer_id));

INSERT INTO customer (customer_id, name, age, balance, IsVIP) VALUES (1, 'John Doe', 65, 12000, 'FALSE');
INSERT INTO customer (customer_id, name, age, balance, IsVIP) VALUES (2, 'Jane Smith', 45, 9000, 'FALSE');
INSERT INTO customer (customer_id, name, age, balance, IsVIP) VALUES (3, 'Alice Johnson', 70, 11000, 'FALSE');
INSERT INTO customer (customer_id, name, age, balance, IsVIP) VALUES (4, 'Bob Brown', 58, 10500, 'FALSE');
INSERT INTO customer (customer_id, name, age, balance, IsVIP) VALUES (5, 'Clara White', 30, 5000, 'FALSE');


INSERT INTO loan (loan_id, customer_id, interest_rate, due_date) VALUES (101, 1, 8.5, SYSDATE + 10);
INSERT INTO loan (loan_id, customer_id, interest_rate, due_date) VALUES (102, 2, 7.0, SYSDATE + 40);
INSERT INTO loan (loan_id, customer_id, interest_rate, due_date) VALUES (103, 3, 9.0, SYSDATE + 20);
INSERT INTO loan (loan_id, customer_id, interest_rate, due_date) VALUES (104, 4, 8.0, SYSDATE + 5);
INSERT INTO loan (loan_id, customer_id, interest_rate, due_date) VALUES (105, 5, 6.5, SYSDATE + 50);

select * from customer;
select * from loan;


--scenario 1
DECLARE
  CURSOR cust_cursor IS
    SELECT customer_id, interest_rate
    FROM loan
    WHERE customer_id IN (
      SELECT customer_id FROM customer WHERE age > 60
    );

BEGIN
  FOR rec IN cust_cursor LOOP
    UPDATE loan
    SET interest_rate = interest_rate - 1
    WHERE customer_id = rec.customer_id;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('1% interest rate discount applied to customers above 60 years.');
END;
/


--output

select * from customer;
select * from loan;


--scenario 2
DECLARE
  CURSOR cust_cursor IS
    SELECT customer_id, balance
    FROM customer
    WHERE balance > 10000;

BEGIN
  FOR rec IN cust_cursor LOOP
    UPDATE customer
    SET IsVIP = 'TRUE'
    WHERE customer_id = rec.customer_id;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('VIP status assigned to customers with balance over $10,000.');
END;
/

--output
select * from customer;
select * from loan;


--scenario 3
DECLARE
  CURSOR due_loans IS
    SELECT l.loan_id, l.customer_id, l.due_date, c.name
    FROM loan l
    JOIN customer c ON l.customer_id = c.customer_id
    WHERE l.due_date <= SYSDATE + 30;

BEGIN
  FOR rec IN due_loans LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || rec.name || ', your loan (ID: ' || rec.loan_id || ') is due on ' || TO_CHAR(rec.due_date, 'DD-MON-YYYY'));
  END LOOP;
END;
/

select * from customer;
select * from loan;

