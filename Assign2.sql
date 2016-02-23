/*
  Jocelynne Gonzales
  CSC 453 Section 802
  Assignment 1
  January 22, 2016
*/

-- 1
SELECT AVG(SALARY)
  FROM EMPLOYEE
  WHERE GENDER = 'F';

-- 2
SELECT FNAME--, DEPENDENTNAME, ESSN, SSN
FROM EMPLOYEE
INNER JOIN DEPENDENT
ON EMPLOYEE.SSN = DEPENDENT.ESSN
WHERE FNAME = DEPENDENTNAME;

-- 3
SELECT FNAME, LNAME FROM EMPLOYEE
WHERE SUPERSSN = (SELECT SSN FROM EMPLOYEE WHERE FNAME = 'Janine');

--4
SELECT PNAME, SUM(HOURS)
FROM PROJECT
INNER JOIN WORKSON
ON PROJECT.PNUMBER = WORKSON.PNO
GROUP BY PNAME
ORDER BY PNAME;

--5
SELECT SSN
FROM EMPLOYEE
WHERE  (EMPLOYEE.SSN) NOT IN 
(SELECT ESSN FROM PROJECT, WORKSON WHERE PROJECT.PNUMBER = WORKSON.PNO);

--6
SELECT DNO, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DNO
ORDER BY AVG(SALARY) DESC;


--7
SELECT FNAME, LNAME FROM EMPLOYEE
WHERE SSN IN (
SELECT ESSN
FROM WORKSON
WHERE ESSN IN (SELECT SSN FROM EMPLOYEE WHERE DNO = '2') AND HOURS > 15 
AND PNO = (SELECT PNUMBER FROM PROJECT
WHERE PNAME = 'ProductX'));

--8

SELECT DNAME, COUNT(DNO)
FROM DEPARTMENT, EMPLOYEE
WHERE
EMPLOYEE.DNO IN DEPARTMENT.DNUMBER
GROUP BY DNAME
HAVING COUNT(DNO) >= 3;



--9
SELECT SALARY FROM EMPLOYEE
WHERE DNO IN
(SELECT DNO FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE));