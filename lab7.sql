--write SQL queries to list the names of all employees who are older than the average age of all employees
SELECT e.fname, e.lname 
FROM employee e
WHERE DATEDIFF(YEAR, e.bdate, GETDATE()) > (
    SELECT
    AVG(DATEDIFF(YEAR, ee.bdate, GETDATE())) As average_age
FROM employee ee
)

--List the names of all employees whose salaries are less than the average salaries of those whose first name second character is 'a'
SELECT  e.fname,e.lname 
FROM    employee e
WHERE e.salary < (
    	SELECT AVG(e.salary)
    	FROM employee e
    	WHERE e.fname LIKE '_a%'
);

--Using the IN or NOT IN operator, list the names of employees working on ProductX, Computerization, or NewBenefits
SELECT  e.fname, e.lname
FROM    employee e 
JOIN works_on wo ON e.ssn = wo.essn
JOIN project p ON wo.pno = p.pnumber
WHERE p.pname IN ('ProductX', 'Computerization', 'Newbenefits')


--Find the average salaries for all the employyes who have a lower salary than Sam S. Snedden
SELECT AVG(e.salary) as AverageSalary
FROM    employee e
WHERE e.salary < (
    	SELECT e.salary
    	FROM employee e
    	WHERE e.fname = 'Sam' AND e.minit = 'S' AND e.lname = 'Snedden'
);

--List the names, supervisor's names, and the department names of all employees whose salaries are lower than the average salaries of Software department workers
SELECT  e.fname AS employee_fname,
       e.lname AS employee_lname,
       s.fname AS supervisor_fname,
       s.lname AS supervisor_lname,
       d.dname AS department_name
FROM employee e
LEFT JOIN employee s ON e.superssn = s.ssn
JOIN department d ON e.dno = d.dnumber
WHERE e.salary < (
    	SELECT AVG(ee.salary)
    	FROM employee ee
    	JOIN department dd ON ee.dno = dd.dnumber
    	WHERE dd.dname = 'Software'
);