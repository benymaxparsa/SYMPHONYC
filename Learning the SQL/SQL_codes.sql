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

-- WHEN YOU INSERT AN INVALID VALUE

INSERT INTO "university".Enrolled(sid, cid)
	VALUES (917777, 134837);
	
UPDATE "university".students
	SET sid = '999999'
	WHERE sid = '10187440';

UPDATE "university".students
	SET sid = '95555555'
	WHERE sid = '9214952';

-- SORT

SELECT customer_name
	FROM "Bank".customer
	WHERE customer_city = 'Rafsanjan'
	ORDER BY customer_name DESC

-- REMOVE DUPLICATE

SELECT DISTINCT customer_city
	FROM "Bank".customer
	ORDER BY customer_city
	
SELECT ALL customer_city
	FROM "Bank".customer

-- SHOW ALL

SELECT *
	FROM "Bank".loan
	ORDER BY loan_number ASC, branch_name ASC, amount ASC;
	
-- math op, rename

SELECT amount*100 as "خخخخ", 'lol' as what_ever
	FROM "Bank".loan
	ORDER BY amount ASC;

-- where

SELECT loan_number
	FROM "Bank".loan
	WHERE branch_name = 'Azadi' AND amount > 25;

SELECT loan_number
	FROM "Bank".loan
	WHERE amount BETWEEN 40 AND 80;

SELECT account_number, balance
	FROM "Bank".account
	WHERE branch_name = 'Safa' and balance BETWEEN 54 and 100;


-- Strings

SELECT *
	FROM "Bank".customer
	WHERE customer_city LIKE '_afsan%';

SELECT *
	FROM "Bank".customer
	WHERE customer_city LIKE 'S%_ja%';

SELECT customer_name as "نام مشتری", customer_city||', '||customer_street as "آدرس"
	FROM "Bank".customer
	WHERE customer_city LIKE '%ja%';


-- the from clause

SELECT COUNT(*)
	FROM "Bank".borrower;

SELECT COUNT(*)
	FROM "Bank".loan;

SELECT *
	FROM "Bank".borrower, "Bank".loan;

SELECT customer_name, borrower.loan_number, amount
	FROM "Bank".borrower, "Bank".loan
	WHERE borrower.loan_number = loan.loan_number AND branch_name = 'Pirouzi';
	
-- UNIVERSITY EXAMPLE

SELECT title 
	FROM University.courses;
	
SELECT *
	FROM University.courses;
	
SELECT name
	FROM University.courses, University.lecturers
	where cid = '1413056' and lecturer = empid;
	
SELECT sid, mark
	FROM university.assessment
	WHERE mark BETWEEN 0 and 10;
	
SELECT sid
	FROM university.enrolled
	WHERE cid = '1413056' and grade in ('D', 'H');
	
	
SELECT students.sid, name
	FROM university.enrolled, university.students
	WHERE cid = '1413056' AND grade IN ('D', 'H') AND students.sid = enrolled.sid
	ORDER BY name;
	
-- Aggregate Functions

SELECT COUNT(*) 
	FROM university.enrolled;

SELECT COUNT(DISTINCT sid)
	FROM university.enrolled;
	
SELECT MAX(mark)
	FROM university.assessment
	WHERE cid = '1413056';

SELECT AVG(mark)
	FROM university.assessment
	WHERE cid = '1413056';

---  SET OPERATIONS 

(SELECT customer_name FROM "Bank".depositor)
	UNION
	(SELECT customer_name FROM "Bank".borrower);

(SELECT customer_name FROM "Bank".depositor)
	UNION ALL
	(SELECT customer_name FROM "Bank".borrower);
	

(SELECT customer_name FROM "Bank".depositor)
	INTERSECT
	(SELECT customer_name FROM "Bank".borrower);
	
	
(SELECT customer_name FROM "Bank".depositor)
	EXCEPT
	(SELECT customer_name FROM "Bank".borrower);
		

SELECT name FROM university.students
	UNION
	SELECT name FROM university.lecturers;
	
	
SELECT sid FROM university.students
	EXCEPT
	SELECT sid FROM university.enrolled;


SELECT sid FROM university.enrolled WHERE cid = '1413056'
	INTERSECT
	SELECT sid FROM university.enrolled WHERE cid = '1413059';


-- Adding the sailor schema

CREATE TABLE sailor.Boats(
	bid CHARACTER VARYING(50),
	bname CHARACTER VARYING(50),
	color CHARACTER VARYING(50),
	CONSTRAINT Boats_PK PRIMARY KEY (bid)
);

CREATE TABLE sailor.Sailors(
	sid CHARACTER VARYING(50),
	sname CHARACTER VARYING(50),
	rating INTEGER,
	age DOUBLE PRECISION,
	CONSTRAINT Sailors_PK PRIMARY KEY (sid)
);

CREATE TABLE sailor.Reservations(
	sid CHARACTER VARYING(50),
	bid CHARACTER VARYING(50),
	day DATE,
	CONSTRAINT Reservations_PK PRIMARY KEY (sid, bid, day),
	CONSTRAINT Reservations_FK1 FOREIGN KEY (sid) REFERENCES sailor.Sailors(sid),
	CONSTRAINT Reservations_FK2 FOREIGN KEY (bid) REFERENCES sailor.Boats(bid)
);

--- SET OPERATIONS: Part 2

SELECT DISTINCT R.sid, S.sname
	FROM sailor.Sailors S, sailor.Boats B, sailor.Reservations R
	WHERE S.sid = R.sid AND B.bid = R.bid AND B.color IN ('red', 'green');
	

SELECT R.sid
	FROM sailor.Boats B, sailor.Reservations R
	WHERE B.bid = R.bid AND B.color IN ('red', 'green');

SELECT R.sid
	FROM sailor.Boats B, sailor.Reservations R
	WHERE B.bid = R.bid AND B.color = 'red'
	UNION
	SELECT R.sid
		FROM sailor.Boats B, sailor.Reservations R
		WHERE B.bid = R.bid AND B.color = 'green'
		
		
SELECT R1.sid
	FROM sailor.Boats B1, sailor.Reservations R1, sailor.Boats B2, sailor.Reservations R2
	WHERE B1.bid = R1.bid AND B2.bid = R2.bid
	AND (B1.color = 'red' AND B2.color = 'green');	
	

SELECT R.sid
	FROM sailor.Boats B, sailor.Reservations R
	WHERE B.bid = R.bid AND B.color = 'red'
	INTERSECT
	SELECT R.sid
		FROM sailor.Boats B, sailor.Reservations R
		WHERE B.bid = R.bid AND B.color = 'green';

-------------------------------EMPLOYEE DATABASE----------------------------

DROP TABLE IF EXISTS employee.Employee;
CREATE TABLE employee.Employee(
	Fname CHARACTER VARYING(50),
	Minit CHAR,
	Lname CHARACTER VARYING(50),
	SSN CHARACTER VARYING(50),
	Bdate DATE,
	Address CHARACTER VARYING(100),
	Sex CHAR,
	Salary BIGINT,
	SupperSSN CHARACTER VARYING(50),
	DNO INTEGER,
	CONSTRAINT Employee_PK PRIMARY KEY (SSN),
	CONSTRAINT Employee_FK1 FOREIGN KEY (SupperSSN) REFERENCES employee.Employee (SSN),
	CONSTRAINT Employee_FK2 FOREIGN KEY (DNO) REFERENCES employee.Department (Dnumber)
);

DROP TABLE IF EXISTS employee.Project;
CREATE TABLE employee.Project(
	Pname CHARACTER VARYING(50),
	Pnumber INTEGER,
	Plocation CHARACTER VARYING(50),
	Dnum INTEGER,
	CONSTRAINT Project_PK PRIMARY KEY (Pnumber),
	CONSTRAINT Employee_FK FOREIGN KEY (Dnum) REFERENCES employee.Department (Dnumber)
	);

DROP TABLE IF EXISTS employee.Works_on;
CREATE TABLE employee.Works_on(
	ESSN CHARACTER VARYING(50),
	PNO INTEGER,
	hours DOUBLE PRECISION,
	CONSTRAINT Works_on_PK PRIMARY KEY (ESSN, PNO),
	CONSTRAINT Works_on_FK1 FOREIGN KEY (ESSN) REFERENCES employee.Employee (SSN),
	CONSTRAINT Works_on_FK2 FOREIGN KEY (PNO) REFERENCES employee.Project (Pnumber)
	);

DROP TABLE IF EXISTS employee.Department;
CREATE TABLE employee.Department(
	Dname CHARACTER VARYING(50),
	Dnumber INTEGER,
	MgrSSN CHARACTER VARYING,
	MgrStartDate DATE,
	CONSTRAINT Department_PK PRIMARY KEY (Dnumber)
	);
	
DROP TABLE IF EXISTS employee.Dep_location;
CREATE TABLE employee.Dep_location(
	Dnumber INTEGER,
	Dlocation CHARACTER VARYING(50),
	CONSTRAINT Dep_location_PK PRIMARY KEY (Dnumber),
	CONSTRAINT Dep_location_FK FOREIGN KEY (Dnumber) REFERENCES employee.Department (Dnumber)
	);
	
DROP TABLE IF EXISTS employee.Dependent;
CREATE TABLE employee.Dependent(
	ESSN CHARACTER VARYING(50),
	dependent_name CHARACTER VARYING(50),
	Sex CHAR,
	Bdate DATE,
	Relationship CHARACTER VARYING(50),
	CONSTRAINT Dependent_PK PRIMARY KEY (ESSN),
	CONSTRAINT Dependent_FK FOREIGN KEY (ESSN) REFERENCES employee.Employee (SSN)
);

----------------------------------- JOIN ----------------------------------


SELECT name, cid, grade
	FROM university.students S, university.enrolled E
	WHERE S.sid = E.sid;




