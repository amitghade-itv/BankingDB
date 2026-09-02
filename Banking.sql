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

select 
customerid, 
concat(substring(firstname,1,1),".",lastname) as FullName,
phone
from customers;

-- Trim() function
select  length("  Hello World  ");
select  length(trim("  Hello World  "));
select length(trim(substring("Hello World",6)));

-- replace function
select replace("Mat mat Mat","M","C");


 select * from accounts;
 
-- Avg() function
select avg(Balance) from accounts
where accounttype = "Savings";

--  round() function
select round(avg(Balance),2) from accounts
where accounttype = "Savings";
-- Ceil() or Ceiling() function
select ceiling(avg(Balance)) from accounts
where accounttype = "Savings";

-- floor() function
select floor(avg(Balance)) from accounts
where accounttype = "Savings";

select * from transactions;

select avg(amount) as AverageDeposit from transactions where
transactiontype = "Deposit";

-- Absolute() function......It removes the sign
select abs(-3656);
select abs(-1.34);
select abs(6.464);

-- MOD value 
select  (7/3);
select mod(7,3); 

-- Power()
select power(2,3);
select power(1.5,3);

-- SQRT()
select sqrt(123);
select sqrt(144);

select * from customers;

-- Date functions
-- NOW() function
select NOW();
-- curdate() function 
 select curdate();
 -- curtime() function 
 select curtime();
 
 -- YEAR() MONTH() DAY()
select DateOfBirth,year(Dateofbirth) as Year,
month(Dateofbirth) as Month,
day(Dateofbirth) as Date
from customers;

-- Datediff () function...Returns number of days between two dates.
select concat(firstname," ",lastname) as fullname,dateofbirth,
floor(datediff(curdate(),dateofbirth)/365) as age from customers;

-- Date_add function
 select concat(firstname," ",lastname) as fullname,
 accountcreationdate,
 date_add(accountcreationdate, interval 1 year) as KYCRenewal
 from customers;
 -- date_sub function  
SELECT 
DATE_SUB(CURDATE(), INTERVAL 7 DAY);

-- count() function
select * from customers;
select count(*) as TotalCustomers from customers;
select count(phone) as TotalCustomers from customers;

-- sum() function
select * from accounts;
select sum(balance) as totalBalance from accounts;
select sum(balance) as SavingsBalance from accounts
where accounttype = "savings";
select sum(balance) as CurrentBalance from accounts
where accounttype = "current";

-- avg() function
select * from transactions;
select avg(amount) as totalAmountTransacted from transactions;
select avg(amount) as AvgAmountDeposited  from transactions
where transactiontype = "Deposit";
select avg(amount) as AvgAmountWithdrawn from transactions
where transactiontype = "Withdrawal";

-- max() and min() function
-- find maximum balance available in savings account
select max(balance) from accounts
where AccountType = "savings"; 
-- find minimum balance available in savings account
select min(balance) from accounts
where AccountType = "savings"; 

EXPLAIN SELECT COUNT(*) FROM customers;

-- GROUP BY 
select * from transactions;
select transactiontype, sum(amount) from transactions
group by (transactiontype);

select * from accounts;
select accounttype,
       count(*) as TotalAccounts,
       sum(balance) as totalBalance,
       avg(balance) as avgBalance
from accounts
group by accounttype;

-- Find total accounts for branch and accounttype;
select * from accounts;

select branchid,accounttype, count(*) as NoOfAccounts
from accounts
group by branchid,accounttype
order by branchid;

-- Having 
select branchid,accounttype, count(*) as NoOfAccounts
from accounts
group by branchid,accounttype
having noofaccounts >= 2 and AccountType = "savings";

select * from customers;
-- Find number of customers for according to year from customers table
SELECT 
    YEAR(accountcreationdate) AS years, COUNT(*) AS noOfAccounts
FROM
    customers
GROUP BY years
order by years desc;

select * from customers;
select * from accounts;
select * from loans;
select * from branches;
select * from transactions;

-- Joins
-- INNER JOIN
 -- Find all customers having loans with their names, 
 -- interest rate and loan amount.
 select c.customerid,c.firstname,c.lastname,l.loanamount,l.interestrate
 from customers c
 inner join loans l
 on c.CustomerID = l.CustomerID;
 
-- Find the branch names for all the accountid's
-- Include account id, accounttype and branchname,branchaddress.
select a.accountid,a.accounttype,b.branchname,b.branchaddress
from accounts a
join branches b
on a.BranchID = b.BranchID
where accounttype = "Savings";

select * from transactions;

-- Find all the customers(name, phone, accounttype,balance) 
-- where account type is savings
 
INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AccountCreationDate, DateOfBirth)
VALUES
(111, 'Vikram', 'Joshi', 'vikram@gmail.com', '9876500011', '2026-02-10', '1993-05-12'),
(112, 'Anjali', 'Deshpande', 'anjali@gmail.com', NULL, '2026-03-15', '1998-08-25'),
(113, 'Suresh', 'Pawar', 'suresh@gmail.com', '9876500013', '2024-11-20', '1991-10-05');

-- LEFT join 
select c.firstname,c.lastname,c.phone,a.accounttype,a.balance
from customers c
left join accounts a
on c.CustomerID = a.CustomerID;

select c.firstname,c.lastname,c.phone,a.accounttype,a.balance
from accounts a
left join customers c
on a.CustomerID = c.CustomerID ;

-- RIGHT join 
INSERT INTO Branches
VALUES
(4, 'Nashik Branch', 'College Road, Nashik', '0253-456789');

INSERT INTO Branches
VALUES
(5, 'Amravati Branch', 'DG Road, Amravati', '0302-55868335');

INSERT INTO Accounts
(AccountID, AccountType, Balance, CustomerID, BranchID)
VALUES
(1011, 'Savings', 22000, 111, 4),
(1012, 'Current', 35000, 112, 2);

INSERT INTO Transactions
VALUES
(13, '2025-03-10', 8000, 'Deposit', 1001),
(14, '2025-03-15', 1500, 'Withdrawal', 1002),
(15, '2025-03-20', 12000, 'Deposit', 1002),
(16, '2025-04-05', 4000, 'Withdrawal', 1004),
(17, '2025-04-10', 7000, 'Deposit', 1007),
(18, '2025-04-15', 2500, 'Withdrawal', 1007),
(19, '2025-05-01', 6000, 'Deposit', 1008),
(20, '2025-05-10', 2000, 'Withdrawal', 1009);

INSERT INTO Transactions
VALUES
(21, '2024-06-15', 5000, 'Deposit', 1003),
(22, '2024-12-20', 3500, 'Withdrawal', 1004),
(23, '2025-07-10', 9000, 'Deposit', 1005),
(24, '2026-01-15', 11000, 'Deposit', 1007),
(25, '2026-02-20', 3000, 'Withdrawal', 1008);

INSERT INTO Accounts
(AccountID, AccountType, Balance, CustomerID, BranchID)
VALUES
(1013, 'Current', 18000, 101, 1),
(1014, 'Current', 25000, 103, 1);

select * from accounts;

select c.CustomerID,a.accountid,concat_ws(" ",c.firstname,c.lastname) as fullName, a.accounttype, a.balance
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
order by c.CustomerID;

-- Find the number of accounts held by each customer.
select c.CustomerID,c.firstname,c.lastname,count(a.accountid) as totalAccounts
from customers c
left join accounts a
on c.CustomerID = a.CustomerID
group by c.customerid;

-- Find the number of customers for each account type.
select a.accounttype, count(a.customerid) as totalCustomers
from accounts a 
left join customers c
on a.CustomerID = c.CustomerID
group by a.accounttype;

-- Find customers who have more than one account.
select c.customerid, 
concat(c.firstname," ",c.lastname) as fullname,count(a.accountid) as totalAccounts
from customers c
inner join accounts a
on a.customerid = c.CustomerID
group by c.CustomerID having totalAccounts > 1;

 -- Find customers who have never performed a transaction.
select c.customerid,
concat(c.firstname," ",c.lastname) as fullname, count(t.AccountID) as NoOfTransactions
from customers c
inner join accounts a
on c.CustomerID = a.CustomerID
left join transactions t
on t.accountID = a.AccountID
group by c.CustomerID
having NoOfTransactions = 0;

-- Display all Savings account customers along with their branch name.

-- Display all branches and their account count.include only
-- those branches that have more than 2 accounts.
select b.branchid,b.branchname,count(a.accountid) as totalAccounts
from branches b
left join accounts a
on b.BranchID = a.BranchID
group by b.branchid
having totalAccounts > 2;

-- FULL OUTER JOIN
select * from customers c
left join accounts a
on c.CustomerID = a.CustomerID
UNION
select * from customers c
right join accounts a
on c.CustomerID = a.CustomerID;

-- CROSS JOIN
select * from customers c
cross join accounts a;

-- SELF join
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    ManagerID INT,
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoiningDate DATE,
    BranchID INT,
    FOREIGN KEY (ManagerID)
    REFERENCES Employees(EmployeeID),
    FOREIGN KEY (BranchID)
    REFERENCES Branches(BranchID)
);

desc employees;
select * from branches;
INSERT INTO Employees
    (EmployeeID, EmployeeName, ManagerID, Department, Salary, JoiningDate, BranchID)
VALUES
    (1, 'Rajesh Sharma', NULL, 'Management', 120000.00, '2018-04-15', 1),
    (2, 'Priya Patel', 1, 'Human Resources', 75000.00, '2019-06-10', 2),
    (3, 'Amit Kumar', 1, 'Finance', 82000.00, '2020-01-20', 3),
    (4, 'Sneha Verma', 1, 'IT', 95000.00, '2019-09-05', 4),
    (5, 'Rahul Singh', 1, 'Sales', 78000.00, '2021-03-12', 5),

    (6, 'Neha Joshi', 2, 'Human Resources', 55000.00, '2021-07-19', 1),
    (7, 'Vikas Gupta', 2, 'Human Resources', 52000.00, '2022-02-14', 2),
    (8, 'Pooja Mehta', 3, 'Finance', 60000.00, '2021-11-08', 3),
    (9, 'Suresh Yadav', 3, 'Finance', 58000.00, '2022-05-16', 4),
    (10, 'Anjali Deshmukh', 4, 'IT', 72000.00, '2020-08-24', 5),

    (11, 'Rohan Kulkarni', 4, 'IT', 68000.00, '2021-10-11', 1),
    (12, 'Kavita Rao', 4, 'IT', 65000.00, '2022-01-17', 2),
    (13, 'Arjun Malhotra', 5, 'Sales', 57000.00, '2022-06-20', 3),
    (14, 'Meena Shah', 5, 'Sales', 59000.00, '2021-12-06', 4),
    (15, 'Deepak Thakur', 5, 'Sales', 54000.00, '2023-01-09', 5),

    (16, 'Nitin Pawar', 6, 'Human Resources', 42000.00, '2023-04-18', 1),
    (17, 'Swati Mishra', 7, 'Human Resources', 40000.00, '2023-07-03', 2),
    (18, 'Manish Jain', 8, 'Finance', 45000.00, '2023-02-27', 3),
    (19, 'Komal Sinha', 9, 'Finance', 43000.00, '2023-08-14', 4),
    (20, 'Akash Bansal', 10, 'IT', 50000.00, '2023-05-22', 5);

select * from employees;

select e.employeeid,e.employeename as employeeName,m.employeename as managerName
from employees e
left join employees m
on e.ManagerID = m.EmployeeID;

-- include branch name also
select e.employeeid,e.employeename as employeeName,m.employeename as managerName,
b.branchname
from employees e
left join employees m
on e.ManagerID = m.EmployeeID
join branches b
on e.BranchID = b.BranchID;

-- Find all the employees who reports to Sneha Verma
select e.employeeID,e.employeename,e.department, m.EmployeeName as managerName
from employees e
join employees m
on e.ManagerID = m.EmployeeID
where m.employeename = "Sneha Verma";

-- SUBQUERIES
-- Find all customers having balance more than the average balance
-- in the savings account.

select * from accounts;
select avg(balance) from accounts
where accounttype="savings";

select c.firstname,a.balance from customers c
join accounts a
on c.CustomerID = a.CustomerID
where a.accounttype = "Savings";

select c.CustomerID,c.firstname,avg(a.balance) as avgBalance from customers c
join accounts a
on c.CustomerID = a.CustomerID
where a.accounttype = "Savings"
group by c.FirstName,c.customerid
having avgBalance > 22357;

-- SCALAR subquery
select accountid,customerid
from accounts
where balance > (
     select avg(balance) from accounts
     where accounttype = "Savings"
)   && accounttype = "Savings";

select accountid,customerid
from accounts
where balance > (
     select avg(balance) from accounts
);
select a.accountid,c.customerid, c.firstname
from accounts a
join customers c
on a.CustomerID = c.CustomerID
where a.balance > (
     select avg(balance) from accounts
     where accounttype = "Savings"
)   && accounttype = "Savings";

-- Find the account(s) having the highest balance. 

select accountid,customerid,balance
from accounts
where balance = (
select max(balance) from accounts
);
-- Find customers whose year of birth is earlier than the average year of birth 
-- of all customers.
select * from customers; 
select floor(avg(year(dateofbirth))) from customers;

select firstname,lastname,dateofbirth, year(DateOfBirth) as yearofBirth
from customers
where year(DateOfBirth) < (
		select floor(avg(year(dateofbirth))) from customers
);

SELECT branchid, AVG(balance) AS avgBalance
FROM accounts
GROUP BY branchid
HAVING AVG(balance) = (
    SELECT MAX(avgBalance)
    FROM (
        SELECT AVG(balance) AS avgBalance
        FROM accounts
        GROUP BY branchid
    ) AS t
);

-- Multi row subquery
-- Find all customers who have taken at least one loan
select * from customers;
select * from loans;
select customerID, firstname, phone
from customers where
customerID in (select customerID from loans);

-- select customerID from loans;

-- Find all customers who have at least one Savings account
select * from accounts;

select customerId,firstname,phone
from customers
where customerid in (
      select customerID from accounts where
      accounttype = "Savings"
);

-- Find all customers who have an account in BranchID = 1. 
select * from customers;
select * from accounts;

select customerid,firstname from
customers where customerid in(
select customerid from accounts where
BranchID = 1
);
select customerid from accounts where
BranchID = 1;

-- Find all accounts whose balance is greater than 
-- any account in BranchID = 1

select accountid, balance from accounts
where balance > ANY (
		select balance from accounts
        where BranchID = 1);
        
 -- Find all accounts whose balance is greater than 
-- all accounts in BranchID = 1       
select accountid, balance from accounts
where balance > ALL (
		select balance from accounts
        where BranchID = 1);

-- Find the branch with the highest average account balance
select branchid, avg(balance) as avgBalance from
accounts group by branchid
order by avgBalance DESC
limit 1;

-- Find accounts whose balance is greater than 
-- the average balance of their respective branch
select * from accounts;

select avg(balance) from accounts
where accounttype = "Savings";

select a.accountid,a.balance,a.BranchID 
from accounts a
where a.balance > (
     select avg(a1.balance) from accounts a1 
     where a1.BranchID = a.BranchID
);

-- Find employees whose salary is greater than
-- the average salary of their respective department. 
select * from employees;

select e.employeename,e.department,e.salary from employees e
where e.salary > (
select avg(e1.salary) from employees e1
where e1.Department = e.Department
);
-- Find customers who have more than one account
select * from customers;
select * from accounts;

select c.firstname,c.lastname
from customers c where (
select count(*) from accounts a
where c.CustomerID = a.CustomerID
) > 1;

-- Find the average account balance for each account type 
-- using a derived table. 
SELECT * FROM accounts;

SELECT AccountBalance.accounttype, AccountBalance.avgBalance
FROM (
  select accounttype,avg(balance) as avgBalance from accounts
  group by AccountType ) AccountBalance;


-- Display only those account types whose average balance is 
-- greater than ₹30,000
SELECT AccountBalance.accounttype, AccountBalance.avgBalance
FROM (
  select accounttype,avg(balance) as avgBalance from accounts
  group by AccountType ) AccountBalance
  where AccountBalance.avgBalance > 30000;
-- Find the top 3 customers based on their total account balance

select CustomerBalance.firstname,CustomerBalance.customerid,CustomerBalance.TotalBalance
FROM  (select c.FirstName,c.customerid,sum(a.balance) as TotalBalance
       from accounts a
       join customers c
       on a.CustomerID = c.CustomerID
        group by customerid) AS CustomerBalance
order by CustomerBalance.TotalBalance DESC
LIMIT 3;

-- Subquery inside select clause
 
-- Display each customer along with the number of accounts they have
select c.customerid,
     (
     select count(*) from accounts a
     where c.CustomerID = a.CustomerID
     ) as totalAccounts from customers c
     order by totalAccounts desc;


-- Subqueries inside UPDATE clause

-- Increase the balance of accounts belonging to customers 
-- who have taken a loan by 5% 
select * from accounts;
select * from loans;

UPDATE accounts SET balance = balance + balance*0.05
WHERE customerid IN (
   select customerid from loans
    );
    
select * from transactions;

-- subquery inside DELETE clause

-- Delete all transactions below amount of 1000 where transaction type is withdrawal.
delete from transactions
where accountid in (
select AccountID from (select accountid from transactions
where amount < 2500 and TransactionType = "Withdrawal") as temp
) and TransactionType = "Withdrawal";


select * from accounts;


-- subqueries in INSERT clause

-- Create a HighValueAccounts table and insert all accounts whose 
-- balance is greater than the average account balance. 
CREATE TABLE HighValueAccounts (
    AccountID INT,
    CustomerID INT,
    BranchID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES branches(BranchID)
);

desc highvalueaccounts;

select * from highvalueaccounts;

insert into highvalueaccounts (accountid,customerid,branchid
,accounttype,balance) 
select accountid,customerid,branchid
,accounttype,balance from accounts
where balance > (
select avg(balance) from accounts
);

-- Create a HighBalanceCustomers table and insert customers whose total account
-- balance is greater than ₹50,000. 

create table HighBalanceCustomers(
customerID INT ,
TotalBalance DECIMAL(10,2)
);

select * from highbalancecustomers;

insert into highbalancecustomers (customerid,totalbalance)
select customerid, totalbalance from
	(select customerid, sum(balance) as totalBalance
	from accounts
	group by customerid) as custBalance
where totalbalance > 50000;

-- SQL VIEWS
create or replace view PremiumAccounts AS
select a.accountid,a.accounttype,a.balance,a.customerid,t.transactiondate,
t.amount,t.transactiontype
from accounts a
join transactions t
on a.AccountID = t.AccountID
where balance > 50000;

select * from premiumaccounts
where accounttype = "Savings";

select * from premiumaccounts;
select * from transactions;

select distinct(customerid), accountid,balance
from premiumaccounts
order by balance DESC
limit 2;

-- WINDOWS FUNCITONS
select * from accounts;

select avg(balance) from accounts; 

select accountid,accounttype,balance,
avg(balance) over() as TotalAvgBalance from accounts; 

select accountid,accounttype,balance,
avg(balance) over(partition by accounttype ) as TotalAvgBalance from accounts; 

select accountid,accounttype,balance,
avg(balance) over(partition by accounttype order by balance DESC) as TotalAvgBalance from accounts; 

select accountid,accounttype,balance,
ROW_NUMBER() over() as RowNo,
avg(balance) over() as TotalAvgBalanace
from accounts; 

select accountid,accounttype,balance,
RANK() over(order by balance DESC) as Ranks,
dense_rank() over(order by balance DESC) as DenseRank
from accounts; 



