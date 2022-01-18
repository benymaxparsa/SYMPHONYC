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