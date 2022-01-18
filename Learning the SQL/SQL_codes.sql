-- creating a new table

CREATE TABLE Students (
	sid CHAR(20),
	name CHAR(20),
	login CHAR(10),
	age INTEGER,
	gpa REAL
);

-- destroying that table

DROP TABLE Students;

-- create the old table with extra details

CREATE TABLE Students (
	sid CHAR(20) PRIMARY KEY,
	name CHAR(20),
	login CHAR(10) UNIQUE,
	age INTEGER,
	gpa REAL,
	FOREIGN KEY (sid) REFERENCES Students (sid)
);

-- see whats inside of it

SELECT * FROM students;

-- learning how to use constraint

CREATE TABLE Students1 (
	sid INTEGER,
	name CHAR(20),
	CONSTRAINT Students_PK PRIMARY KEY (sid)
);

SELECT * FROM students1;

CREATE TABLE Courses (
	cid CHAR(8),
	title CHAR(20),
	credits INTEGER,
	CONSTRAINT Courses_PK PRIMARY KEY (cid)
);

SELECT * FROM Courses;

CREATE TABLE Enroll (
	sid INTEGER,
	cid CHAR(8),
	CONSTRAINT Enroll_FK1 FOREIGN KEY (sid) REFERENCES Students1 (sid),
	CONSTRAINT Enroll_FK2 FOREIGN KEY (cid) REFERENCES Courses (cid),
	CONSTRAINT Enroll_PK PRIMARY KEY (sid, cid)
);

SELECT * FROM Enroll;

-- Referential integrity in SQL

DROP TABLE IF EXISTS Enroll;
CREATE TABLE Enroll (
	sid INTEGER,
	cid CHAR(8),
	CONSTRAINT Enroll_FK1 FOREIGN KEY (sid) REFERENCES Students1 (sid)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	CONSTRAINT Enroll_FK2 FOREIGN KEY (cid) REFERENCES Courses (cid)
		ON DELETE SET NULL
		ON UPDATE SET DEFAULT,
	CONSTRAINT Enroll_PK PRIMARY KEY (sid, cid)
);
SELECT * FROM Enroll;

DROP TABLE Students1;

-- UPDATE A TABLE

ALTER TABLE Students1
	ADD COLUMN age INTEGER;
	
SELECT * FROM students1;

-- INSERT A NEW DATA INTO A TABLE

INSERT INTO Students1 (sid, name) VALUES (97779081, 'Parsa KamaliPour')

UPDATE Students1
	SET age = 22
	WHERE sid = 97779081
	
DELETE FROM Students1
	WHERE sid = 97779081
	

-- SELECT

SELECT (sid, age) FROM Students1
	WHERE sid > 100
	ORDER BY age DESC

-- BANK EXAMPLE

CREATE TABLE "Bank".Branch(
	branch_name VARCHAR(50),
	branch_city VARCHAR(50),
	assets VARCHAR(50),
	CONSTRAINT Branch_PK PRIMARY KEY (branch_name)
);

ALTER TABLE "Bank".Branch
ALTER COLUMN assets TYPE INTEGER
USING assets::integer;

CREATE TABLE "Bank".Account(
	account_number INTEGER,
	branch_name VARCHAR(50),
	balance DECIMAL,
	CONSTRAINT Account_PK PRIMARY KEY (account_number),
	CONSTRAINT Account_FK FOREIGN KEY (branch_name) REFERENCES "Bank".Branch (branch_name)
)

CREATE TABLE "Bank".Loan(
	loan_number INTEGER,
	branch_name VARCHAR(50),
	amount DECIMAL,
	CONSTRAINT Loan_PK PRIMARY KEY (loan_number),
	CONSTRAINT Loan_FK FOREIGN KEY (branch_name) REFERENCES "Bank".Branch (branch_name)
);

CREATE TABLE "Bank".Customer(
	customer_name VARCHAR(50),
	customer_street VARCHAR(50),
	customer_city VARCHAR(50),
	CONSTRAINT Customer_PK PRIMARY KEY (customer_name)
);

CREATE TABLE "Bank".Depositor(
	customer_name VARCHAR(50),
	account_number INTEGER,
	CONSTRAINT Depositor_PK PRIMARY KEY (customer_name, account_number),
	CONSTRAINT Depositor_FK1 FOREIGN KEY (customer_name) REFERENCES "Bank".Customer (customer_name),
	CONSTRAINT Depositor_FK2 FOREIGN KEY (account_number) REFERENCES "Bank".Account (account_number)
);

CREATE TABLE "Bank".Borrower(
	customer_name VARCHAR(50),
	loan_number INTEGER,
	CONSTRAINT Borrower_PK PRIMARY KEY (customer_name, loan_number),
	CONSTRAINT Borrower_FK1 FOREIGN KEY (customer_name) REFERENCES "Bank".Customer (customer_name),
	CONSTRAINT Borrower_FK2 FOREIGN KEY (loan_number) REFERENCES "Bank".Loan (loan_number)
);

-- EXAMINE SELECT BETTER 

SELECT customer_name from "Bank".customer 
	where customer_city = 'Shiraz';
	
SELECT customer_name
	FROM "Bank".customer
	where customer_city = 'Shiraz'
	ORDER BY customer_name DESC;


SELECT (customer_name, customer_street)
	FROM "Bank".customer
	where customer_city = 'Shiraz'
	ORDER BY customer_name ASC, customer_street DESC;

-- ADD THE UNIVERSITY SCHEMA

CREATE TABLE "university".Lecturers(
	empid CHARACTER VARYING(50),
	name CHARACTER VARYING(50),
	room CHARACTER VARYING(50),
	CONSTRAINT Lecturers_PK PRIMARY KEY (empid)
);

CREATE TABLE "university".Students(
	sid CHARACTER VARYING(50),
	name CHARACTER VARYING(50),
	phone CHARACTER VARYING(50),
	address CHARACTER VARYING(50),
	email CHARACTER VARYING(50),
	birthdate DATE,
	country CHARACTER VARYING(50),
	CONSTRAINT Students_PK PRIMARY KEY (sid)
);

ALTER TABLE "university".Students
	ALTER COLUMN country TYPE CHARACTER VARYING(100);
	
CREATE TABLE "university".Courses(
	cid CHARACTER VARYING(50),
	title CHARACTER VARYING(50),
	credit INTEGER,
	lecturer CHARACTER VARYING(50),
	CONSTRAINT Courses_PK PRIMARY KEY (cid),
	CONSTRAINT Courses_FK FOREIGN KEY (lecturer) REFERENCES "university".Lecturers (empid)
);

CREATE TABLE "university".Enrolled(
	sid CHARACTER VARYING(50),
	cid CHARACTER VARYING(50),
	grade CHAR,
	CONSTRAINT Enrolled_PK PRIMARY KEY (cid, sid),
	CONSTRAINT Enrolled_FK1 FOREIGN KEY (sid) REFERENCES "university".Students (sid),
	CONSTRAINT Enrolled_FK2 FOREIGN KEY (cid) REFERENCES "university".Courses (cid)
);

DROP TABLE IF EXISTS "university".Assessment;

CREATE TABLE "university".Assessment(
	sid CHARACTER VARYING(50),
	cid CHARACTER VARYING(50),
	empid CHARACTER VARYING(50),
	mark DOUBLE PRECISION,
	CONSTRAINT Assessment_PK PRIMARY KEY (cid, sid),
	CONSTRAINT Assessment_FK1 FOREIGN KEY (sid) REFERENCES "university".Students (sid),
	CONSTRAINT Assessment_FK2 FOREIGN KEY (cid) REFERENCES "university".Courses (cid),
	CONSTRAINT Assessment_FK3 FOREIGN KEY (empid) REFERENCES "university".Lecturers (empid)
);

