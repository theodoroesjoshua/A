CREATE TABLE customers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(30) NOT NULL UNIQUE
);

CREATE INDEX name_idx ON customers(name);

CREATE TABLE admins (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  username VARCHAR(50) NOT NULL UNIQUE,
  hash_password TEXT NOT NULL,
  branch VARCHAR(100) NOT NULL,
  role VARCHAR(50) NOT NULL
);

CREATE TYPE RECEIPT_TYPE AS ENUM ('Issue', 'Claim');

CREATE TABLE receipts (
  id VARCHAR(30) PRIMARY KEY,
  price NUMERIC(15, 5) NOT NULL,
  type RECEIPT_TYPE NOT NULL,

  admin_id INT NOT NULL,
  CONSTRAINT fk_admin
    FOREIGN KEY(admin_id)
      REFERENCES admins(id)
);

CREATE TABLE vouchers (
  code INT NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  claimed_date TIMESTAMPTZ,
  status VARCHAR(30) NOT NULL,
  branch VARCHAR(100) NOT NULL,

  customer_id INT NOT NULL,
  CONSTRAINT fk_customer
    FOREIGN KEY(customer_id)
      REFERENCES customers(id),

  PRIMARY KEY(customer_id, code),

  issue_receipt_id VARCHAR(30) NOT NULL,
  CONSTRAINT fk_issue_receipt
    FOREIGN KEY(issue_receipt_id)
      REFERENCES receipts(id),

  claim_receipt_id VARCHAR(30),
  CONSTRAINT fk_claim_receipt
    FOREIGN KEY(claim_receipt_id)
      REFERENCES receipts(id)
);

CREATE INDEX start_date_idx ON vouchers(start_date);
CREATE INDEX end_date_idx ON vouchers(end_date);
CREATE INDEX status_idx ON vouchers(status);
CREATE INDEX branch_idx ON vouchers(branch);
CREATE INDEX customer_id_fkey ON vouchers(customer_id);
CREATE INDEX issue_receipt_id_fkey ON vouchers(issue_receipt_id);
CREATE INDEX claim_receipt_id_fkey ON vouchers(claim_receipt_id);

/* TODO: Remove seed data before production */
INSERT INTO customers (name, email, phone)
  VALUES ('Jerry', 'jerry@example.com', '08981111222'),
  ('George', 'george@example.com', '11112222333');

INSERT INTO admins (username, hash_password, branch, role)
  VALUES ('MakassarAdmin', '12345678', 'Makassar', 'Admin');

INSERT INTO receipts(id, price, type, admin_id)
  VALUES ('RECEIPTA', 100000.00, 'Issue', 1),
  ('RECEIPTB', 100000.00, 'Claim', 1),
  ('RECEIPTC', 50000.00, 'Issue', 1);

INSERT INTO vouchers(code, start_date, end_date, status, branch, customer_id, issue_receipt_id)
  VALUES (1, '12-09-202 10:23:54+07', '12-10-2022 10:23:54+07', 'Active', 'Makassar', 1, 'RECEIPTA'),
  (2, '11-06-2022 10:23:54+07', '11-07-2022 10:23:54+07', 'Expired', 'Makassar', 1, 'RECEIPTC');

INSERT INTO vouchers(code, start_date, end_date, claimed_date, status, branch, customer_id,
  issue_receipt_id, claim_receipt_id)
  VALUES (3, '11-09-2022 10:23:54+07', '11-10-2022 10:23:54+07', '12-07-2022 10:23:54+07', 'Used', 'Makassar', 1, 'RECEIPTA', 'RECEIPTB');
