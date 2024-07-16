--Write SQL queries to list the names of all employees who work on projects ProductX,Computerization and Newbenefits and get paid more than their supervisors
SELECT DISTINCT
CONCAT (e. fname,' '
,e.lname) AS employee_name,
e. salary AS employee_salary,
s. salary AS supervisor_salary
FROM
employee e, employee s, project, department
WHERE
project. pname IN ('ProductX', 'Computerization', 'Newbenefits') AND e.salary > s. salary AND
project.dnum = department. dnumber AND
e.ssn = s.ssn;


--List the names, supervisor's names, and ghe department names of all employees whose salaries are lower than the average salaries of Software department workers
SELECT  e.fname AS employee_fname,
       e.minit AS employee_minit,
       e.lname AS employee_lname,
       s.fname AS supervisor_fname,
       s.minit AS supervisor_minit,
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


-- List all the names of employees who have worked on more projects than the average project count and the projects they work on
WITH project_count AS (
    SELECT essn, COUNT(pno) AS num_projects
    FROM works_on
    GROUP BY essn
),
average_project_count AS (
    SELECT AVG(num_projects) AS avg_projects
    FROM project_count
)
SELECT e.fname, e.lname, p.pname
FROM project_count pc
JOIN average_project_count apc ON pc.num_projects > apc.avg_projects
JOIN employee e ON pc.essn = e.ssn
JOIN works_on w ON e.ssn = w.essn
JOIN project p ON w.pno = p.pnumber;


--USing IN or NOTIN operator, list the names of employees working on Middleware, Computerization, Newbenefits or OperatingSystems
SELECT  e.fname, e.minit, e.lname
FROM    employee e 
JOIN works_on wo ON e.ssn = wo.essn
JOIN project p ON wo.pno = p.pnumber
WHERE p.pname IN ('Middleware') AND p.pname IN ('Computerization') AND p.pname IN ('Newbenefits') OR p.pname IN ('OperatingSystems')

--List all the department, the employee names of the highest paid employees of those departments
WITH department_max_salary AS (
    SELECT dno, MAX(salary) AS max_salary
    FROM employee
    GROUP BY dno
)
SELECT d.dname, e.fname, e.lname, e.salary
FROM department d
JOIN employee e ON d.dnumber = e.dno
JOIN department_max_salary dms ON e.dno = dms.dno AND e.salary = dms.max_salary;
