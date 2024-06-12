 SELECT AVG(salary), MAX(salary), MIN(salary), COUNT(*)
FROM dept_locations, employee
WHERE Dlocation = 'Stafford' or Dlocation = 'Houston' or Dlocation = 'sugarland' or Dlocation = 'Atlanta'

SELECT fname, lname, address, superssn
FROM employee
WHERE superssn is NULL

SELECT pnumber,s.fname, s.lname, count(e.ssn)
FROM employee as s, employee as e, project,department
WHERE dnum = dnumber and s.ssn = mgrssn and e.dno = dnumber
Group by pnumber, s.fname, s.lname
