-- show databases;
-- CREATE DATABASE BankingDB;
-- USE bankingdb;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    AccountCreationDate DATE
);

desc customers;

select * from customers;


CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
    
);

desc accounts;


CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);
CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);

CREATE TABLE AccountBranches ( 
		AssignmentDate DATE
);

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);
 desc loans;
 
ALTER TABLE Customers 
ADD DateOfBirth DATE;

desc customers;
 
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

ALTER TABLE Accounts
ADD CONSTRAINT chk_MinBalance
CHECK (Balance >= 1000);

Drop table accountbranches;

ALTER TABLE Accounts
ADD CustomerID INT;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER table accounts
add constraint 
primary key(AccountID );

desc accounts;

ALTER TABLE Customers
MODIFY FirstName VARCHAR(50) NOT NULL;

desc customers;

ALTER TABLE Customers
ADD CONSTRAINT uq_Email UNIQUE (Email);

ALTER table branches
add constraint 
primary key(BranchID);

ALTER TABLE Accounts
ADD BranchID INT;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Branch_Customers
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);



desc accounts;

SELECT
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'bankingdb'
  AND TABLE_NAME = 'transactions';

SHOW CREATE TABLE Accounts;


-- Transactions Connect with Accounts
ALTER TABLE Transactions
ADD CONSTRAINT PK_Transactions
PRIMARY KEY (TransactionID);

ALTER TABLE Transactions
ADD AccountID INT;

ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

-- Loans Connect with Customers
ALTER TABLE Loans
ADD CONSTRAINT PK_Loans
PRIMARY KEY (LoanID);

-- Add CustomerID column
ALTER TABLE Loans
ADD CustomerID INT;

-- Add Foreign Key Constraint
ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(101,'Rahul','Sharma','rahul@gmail.com','9876543210','1998-04-15');


INSERT INTO Customers
VALUES
(102,'Ketan','Tiwari','ketan@gmail.com','8838938284','2026-08-05','2000-06-22');

INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES
(201,101,'Savings',25000);

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone,AccountCreationDate, DateOfBirth)
VALUES
(103,'Neha','Singh','neha@gmail.com','9277476727','2026-08-03','1992-07-03'),
(104,'Mukul','Jha','mukul@gmail.com','7929267534','2025-02-01','1995-11-06');

UPDATE customers 
SET 
    AccountCreationDate = '2025-06-29'
WHERE
    CustomerID = 101;	

select * from customers;
select * from accounts;

