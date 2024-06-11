CREATE TABLE employee (
	fname	VARCHAR(15) NOT NULL,
	minit	VARCHAR(1),
	lname	VARCHAR(15) NOT NULL,
	ssn		CHAR(9) PRIMARY KEY,
	bdate	DATE,
	address VARCHAR(50),
	sex		CHAR,
	salary	DECIMAL(10,2),
	superssn CHAR(9),
	dno		INT,
	FOREIGN KEY(superssn) REFERENCES employee(ssn),
);


CREATE TABLE department (
	dname	VARCHAR(25) NOT NULL,
	dnumber INT PRIMARY KEY,
	mgrssn	CHAR(9) NOT NULL,
	mgrstartdate DATE,
	UNIQUE (dname),
	FOREIGN KEY(mgrssn) REFERENCES employee(ssn),
);


ALTER TABLE employee ADD
FOREIGN KEY(dno) REFERENCES department(dnumber);

CREATE TABLE dept_locations (
	dnumber		INT NOT NULL,
	dlocation	CHAR(15) NOT NULL,
	CONSTRAINT PK_dept_location
	PRIMARY KEY(dnumber,dlocation),
	FOREIGN KEY(dnumber) REFERENCES department(dnumber)
);

CREATE TABLE project (
	pname		VARCHAR(50) UNIQUE NOT NULL,
	pnumber		INT PRIMARY KEY NOT NULL,
	plocation	VARCHAR(50) NOT NULL,
	dnum		INT NOT NULL,
	FOREIGN KEY(dnum) REFERENCES department(dnumber),
);

CREATE TABLE works_on (
	essn	CHAR(9) NOT NULL,
	pno		INT NOT NULL,
	hours	INT,
	CONSTRAINT PK_works_on
	PRIMARY KEY(essn, pno),
	FOREIGN KEY(essn) REFERENCES employee(ssn),
	FOREIGN KEY(pno) REFERENCES project(pnumber)
);

CREATE TABLE dependent (
	essn	CHAR(9) NOT NULL,
	dependent_name  VARCHAR(50) NOT NULL,
	sex		CHAR(1),
	bdate	DATE,
	relationship  CHAR(9),
	CONSTRAINT PK_dependent
	PRIMARY KEY(essn, dependent_name),
	FOREIGN KEY(essn) REFERENCES employee(ssn)
);