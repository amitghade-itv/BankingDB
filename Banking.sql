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



insert	into customers 
values (105,'Karan','Mehta','karan@gmail.com','9876543214','2024-05-25','1996-12-30');

INSERT INTO Branches
VALUES
(1,'Nagpur Branch','Sitabuldi, Nagpur','0712-123456'),
(2,'Pune Branch','Shivaji Nagar, Pune','020-223344'),
(3,'Mumbai Branch','Andheri, Mumbai','022-334455');

INSERT INTO Accounts
(AccountID,AccountType,Balance,CustomerID,BranchID)
VALUES
(1001,'Savings',25000,101,1),
(1002,'Current',45000,102,2),
(1003,'Savings',18000,103,1),
(1004,'Current',72000,104,3),
(1005,'Savings',15000,105,2);

DELETE FROM Accounts
WHERE accountid = 201;


INSERT INTO Transactions
VALUES
(1,'2025-01-10',5000,'Deposit',1001),
(2,'2025-01-12',2000,'Withdrawal',1001),
(3,'2025-01-13',7000,'Deposit',1002),
(4,'2025-01-15',3000,'Withdrawal',1003),
(5,'2025-01-16',10000,'Deposit',1004);

INSERT INTO Transactions
VALUES
(6,'2025-01-10',3000,'Deposit',1006);

INSERT INTO Loans
(LoanID,LoanAmount,InterestRate,StartDate,EndDate,CustomerID)
VALUES
(501,500000,8.5,'2024-01-01','2029-01-01',101),
(502,250000,9.0,'2024-03-15','2028-03-15',103),
(503,700000,7.8,'2024-06-20','2031-06-20',104);


UPDATE accounts 
SET 
    balance = 30000
WHERE
    customerID = 101;
    
    
UPDATE accounts 
SET 
    balance = balance + 2000
WHERE
    customerID = 102;

UPDATE customers 
SET 
    email = 'rahulsharma@gmail.com',
    phone = '7372748274'
WHERE
     customerid = 101;
     
select * from customers;
select * from accounts;
select * from branches;
select * from loans;
select * from transactions;
SELECT 
    customerid, firstname, lastname, phone
FROM
    customers;
    
SELECT 
    *
FROM
    accounts
WHERE
    AccountType = 'Savings';

SELECT 
    *
FROM
    accounts
WHERE
    balance >= 30000;
    
    
SELECT 
    *
FROM
    accounts
WHERE
    AccountType <> 'Savings';
    
SELECT 
    *
FROM
    accounts
WHERE
    balance >= 15000 && AccountType = 'Savings';    -- use AND or && in syntax
    
SELECT 
    *
FROM
    accounts
WHERE
    balance >= 15000 OR AccountType = 'Savings'; -- use OR or || in syntax
    
select * from accounts where not accounttype ='Savings';

-- Find all customers registered after 1July2026.
select firstname,lastname,accountcreationdate
from customers
where AccountCreationDate > '2026-07-1';

-- Query multiple customers using IN operator (Use phone number)
select firstname,lastname,phone
from customers
where phone IN ('7372748274','9277476727','9876543214');

select firstname,lastname,phone
from customers
where Phone='7372748274' OR Phone='9277476727' OR Phone='9876543214';

-- BETWEEN operator
-- Find customers having balance between 10000 to 30000
SELECT customerid, accounttype,balance
from accounts
where balance between 10000 and 30000;
-- the values specified in range are included in the results.  
SELECT customerid, accounttype,balance
from accounts
where balance >= 10000 AND balance < 30000;

-- LIKE operator
-- Find all customers whose first name starts with letter "K" 
-- % matches any number of characters, even zero characters
select * from customers
where FirstName LIKE 'K%';
-- Find all customers whose last name ends with letter "a";
select * from customers
where LastName LIKE '%a';

-- "_" matches exactly one character.
-- Find all customers whose last name has exactly 3 characters;
select * from customers
where LastName LIKE '___';

-- ORDER BY clause
-- sort the accounts table according to customers balance.
select customerid,balance
from accounts
order by balance;
-- sort the branches table according to branchname.
select branchid,branchname
from branches
order by branchname;
-- sort the accounts table according to customers balance 
-- from highest to lowest balance amount.
select customerid,balance
from accounts
order by balance DESC;
-- Sort according to multiple columns
-- Sort accounts table according to the accounttype and balance
select accountid,accounttype,balance,customerid
from accounts
order by AccountType DESC,Balance DESC;
-- DISTINCT clause
-- Find distinct(unique) account types from accounts table
select distinct accounttype from accounts;
-- Find distinct(unique) transaction types and accountID 
-- from transactions table
select * from transactions;
select distinct transactiontype,accountid from transactions;
select * from customers;

select * from accounts;

select * from accounts
limit 2;

select * from customers
limit 3 offset 2;

select * from accounts
order by balance desc
limit 2;

select * from accounts
order by balance desc
limit 1 offset 2;

select * from accounts
order by balance desc
limit 2,1;  -- Here 2 specifies the rows to skip and 1 specifies the number of rows to return


INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AccountCreationDate, DateOfBirth)
VALUES
(106,'Priya','Patil','priya@gmail.com',NULL,'2025-03-15','1999-04-18'),
(107,'Amit','Verma','amit@gmail.com','9876500001','2025-07-10','1994-02-20'),
(108,'Sneha','Kulkarni','sneha@gmail.com',NULL,'2026-01-12','2001-09-05'),
(109,'Rohan','Deshmukh','rohan@gmail.com','9876500002','2024-09-08','1997-01-10'),
(110,'Pooja','Shah','pooja@gmail.com','9876500003','2025-12-01','1998-12-15');

select * from customers
where phone IS NULL;

select * from customers
where phone IS NOT NULL;

INSERT INTO Accounts
(AccountID,AccountType,Balance,CustomerID,BranchID)
VALUES
(1006,'Savings',12000,106,1),
(1007,'Current',85000,107,2),
(1008,'Savings',50000,108,3),
(1009,'Salary',27000,109,2),
(1010,'Savings',9500,110,1);

select * from accounts;

INSERT INTO Transactions
VALUES
(7,'2025-02-10',2500,'Deposit',1006),
(8,'2025-02-12',500,'Withdrawal',1006),
(9,'2025-02-15',15000,'Deposit',1007),
(10,'2025-02-20',3500,'Withdrawal',1008),
(11,'2025-03-01',5000,'Deposit',1009),
(12,'2025-03-05',4500,'Withdrawal',1010);

select * from transactions;

INSERT INTO Loans
VALUES
(504,300000,8.9,'2025-01-01','2030-01-01',106),
(505,900000,7.2,'2024-09-01','2034-09-01',108);

select * from loans;

SELECT 
    accountid,
    accounttype,
    balance,
    CASE
        WHEN balance >= 50000 THEN 'High Value Customer'
        ELSE 'Low Value Customer'
    END AS 'CustomerCategory'
FROM
    accounts;

-- Categorize the deposits in the transactions table as per conditions given
-- if above 10000(included) High amount
-- if 5000(included) to 10000 Medium amount
-- if upto 5000 Low Amount
-- For Transaction type Withdrawal "Not Applicable"

select * ,
case
    when TransactionType = "Deposit" AND amount >= 10000 then "High Amount"
    when TransactionType = "Deposit" AND amount >= 5000 then "Medium Amount"
    when TransactionType = "Deposit" AND amount < 5000 then "Low Amount"
    ELSE "Not Applicable"
    END AS "TransactionCategory"
    from transactions
    where TransactionDate > "2025-02-01";

select * from transactions;
select * from customers;

select customerid,upper(firstname),upper(lastname) from customers;
select customerid,lower(firstname),lower(lastname) from customers;

-- Select upper("india")
select * from branches;

select lastname , length(lastname) from customers;

select length("NAGPUR") AS "NoOfCharacters"; -- gives o/p in number of bytes
select length("नागपूर");-- gives o/p in number of bytes
select char_length("NAGPUR");-- gives o/p in number of characters
select char_length("नागपूर");-- gives o/p in number of characters

select concat("Hero"," ","Honda") as vehiclename;

select customerid,concat(firstname," ",lastname) as Fullname ,phone
from customers;

select substring("Hello World",1,4);




 

