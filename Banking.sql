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







