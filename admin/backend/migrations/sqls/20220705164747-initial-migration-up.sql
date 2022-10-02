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
  start_date TEXT NOT NULL,
  end_date TEXT NOT NULL,
  claimed_date TEXT,
  status VARCHAR(30) NOT NULL,
  branch VARCHAR(100) NOT NULL,

  customer_id INT NOT NULL,
  CONSTRAINT fk_customer
    FOREIGN KEY(customer_id)
      REFERENCES customers(id),

  PRIMARY KEY(customer_id, code),

  /* Voucher Issuance Properties */
  issuer_id INT NOT NULL,
  CONSTRAINT fk_admin_issuer
    FOREIGN KEY(issuer_id)
      REFERENCES admins(id),
  issue_receipt_id VARCHAR(30),
  issue_receipt_price DOUBLE PRECISION,

  /* Voucher Claiming Properties */
  claimer_id INT,
  CONSTRAINT fk_admin_claimer
    FOREIGN KEY(claimer_id)
      REFERENCES admins(id),
  claim_receipt_id VARCHAR(30),
  claim_receipt_price DOUBLE PRECISION
);

CREATE INDEX start_date_idx ON vouchers(start_date);
CREATE INDEX end_date_idx ON vouchers(end_date);
CREATE INDEX status_idx ON vouchers(status);
CREATE INDEX branch_idx ON vouchers(branch);
CREATE INDEX customer_id_fkey ON vouchers(customer_id);
CREATE INDEX issuer_id_fkey ON vouchers(issuer_id);
CREATE INDEX issue_receipt_id_idx ON vouchers(issue_receipt_id);
CREATE INDEX claimer_id_fkey ON vouchers(claimer_id);
CREATE INDEX claim_receipt_id_idx ON vouchers(claim_receipt_id);

/* TODO: Remove seed data before production */
INSERT INTO customers (name, email, phone)
  VALUES ('Jerry', 'jerry@example.com', '08981111222'),
  ('George', 'george@example.com', '11112222333');

INSERT INTO admins (username, hash_password, branch, role)
  VALUES ('MakassarAdmin', '12345678', 'Makassar', 'Admin');

INSERT INTO vouchers(code, start_date, end_date, status, branch, customer_id, issuer_id,
  issue_receipt_id, issue_receipt_price)
  VALUES (1, '12-07-2022', '12-08-2022', 'Active', 'Makassar', 1, 1, 'RECEIPTA', 100000);

INSERT INTO vouchers(code, start_date, end_date, claimed_date, status, branch, customer_id, issuer_id,
  issue_receipt_id, issue_receipt_price, claimer_id, claim_receipt_id, claim_receipt_price)
  VALUES (2, '11-07-2022', '11-08-2022', '12-07-2022', 'Used', 'Makassar', 1, 1, 'RECEIPTB', 100000,
    1, 'RECEIPTC', 100000),
  (3, '11-06-2022', '11-07-2022', NULL, 'Expired', 'Makassar', 1, 1, 'RECEIPTD', 100000,
    1, 'RECEIPTE', 100000);
