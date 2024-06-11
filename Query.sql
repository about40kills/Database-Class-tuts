--Retrieve the birth date and address of employee(s) whose name is 'John B. Smith'
SELECT fname, lname, Bdate, Address
	FROM	employee
	WHERE	 Minit = 'B';

--Retrieve the name and address of employees who work for the "Research Department"
SELECT dnumber
	FROM department
	WHERE dname = 'research';
SELECT		fname, lname, address
	FROM	employee, department
	WHERE	dname = 'research' AND dnumber = dno
SELECT	fname, lname, address
	FROM	employee, department
	WHERE	dname = 'research' AND dnumber = dno OR dname = 'hardware' AND dnumber = dno OR dname = 'software' AND dnumber = dno;

---For every project located in 'Strafford', list the project number, the controlling department number, and the department manager's 
--		name, address and date of birth
SELECT pnumber, pname, dname, dnum, fname, minit, lname, address, bdate
	FROM	project, department, employee
	WHERE	plocation = 'Stafford' AND dnum = dnumber AND mgrssn = ssn;
SELECT pname, dname, fname, minit, lname
	FROM	project, department, employee
	WHERE	(plocation = 'Houston' AND dnum = dnumber OR plocation = 'Atlanta' AND dnum = dnumber OR plocation = 'Dallas' AND dnum = dnumber) AND (mgrssn = ssn);
SELECT *
	FROM	employee, project, department, works_on
	WHERE	(dnumber = dnum) AND (essn = ssn) AND (pnumber = pno);
--For every department located in Stafford, Houston, Sugarland, and Atlanta,find the average, max and min salary of all employees
SELECT AVG(salary)