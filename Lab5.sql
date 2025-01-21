--write a query to show all the database present in the sql server
SELECT * FROM sys.databases
USE master

--List all the tables in the company database created
SELECT name FROM sys.tables
--OR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

--List the names of all employees working on the computerization project
SELECT e.fname, e.minit, e.lname
FROM employee e
INNER JOIN works_on w ON e.ssn = w.essn
INNER JOIN project p ON w.pno = p.pnumber
WHERE p.pname = 'Computerization';

--Calculate the avg sal,max sal, and min sal as well as the total number of employees working the Computerization, Newbenefits, and ProjectX projects
SELECT AVG(e.salary) as AverageSalary,
       MAX(e.salary)as MaximumSalary,
       MIN(e.salary) as MinimumSalary,
       COUNT(e.ssn) as TotalEmployees
FROM employee e 
INNER JOIN works_on w ON e.ssn = w.essn
INNER JOIN project p ON w.pno = p.pnumber
WHERE p.pname IN ( 'Computerization', 'Newbenefits', 'Projectx')

--Retrieve the name and the address of all employees and the names of their immediate supervisors
SELECT 
    e.fname AS employee_fname,
    e.lname As employee_lname,
    e.address As employee_address,
    s.fname As supervisor_fname,
    s.lname As supervisor_lname
FROM employee e
LEFT JOIN employee s ON e.superssn = s.ssn

--Determine the average age of all employees
SELECT
    AVG(DATEDIFF(YEAR, bdate, GETDATE())) As average_age
FROM employee e;

--For each department, retrieve the department number, the department manager's name, the number of employees in the department, and their average salary.
SELECT
    d.dnumber AS department_number,
    CONCAT(m.fname, ' ', m.lname) As department_manager_name,
    COUNT(e.ssn) As number_of_employees,
    AVG(e.salary)As AverageSalary
FROM department d
    LEFT JOIN 
    employee m ON d.mgrssn = m.ssn
LEFT JOIN 
    employee e ON d.dnumber = e.dno
GROUP BY 
    d.dnumber, m.fname, m.lname;


--create a view table Comp_grp1 fname,lname,department name and age
SELECT 
    e.fname,
    e.lname,
    d.dname AS department_name,
    DATEDIFF(YEAR, e.bdate, GETDATE()) - 
        CASE 
            WHEN DATEADD(YEAR, DATEDIFF(YEAR, e.bdate, GETDATE()), e.bdate) > GETDATE() THEN 1 
            ELSE 0 
        END AS age
FROM 
    employee e
INNER JOIN 
    department d ON e.dno = d.dnumber;