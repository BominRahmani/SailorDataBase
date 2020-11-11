-- File: companyDML-a-solution
-- SQL/DML HOMEWORK (on the COMPANY database)
/*
--
IMPORTANT SPECIFICATIONS
--
(A)
-- Download the script file company.sql and use it to create your COMPANY database.
-- Dowlnoad the file companyDBinstance.pdf; it is provided for your convenience when checking the results of your queries.
(B)
Implement the queries below by ***editing this file*** to include
your name and your SQL code in the indicated places.   
--
(C)
IMPORTANT:
-- Don't use views
-- Don't use inline queries in the FROM clause - see our class notes.
--
(D)
After you have written the SQL code in the appropriate places:
-- Run this file (from the command line in sqlplus).
-- Upload the spooled file (companyDML-b.txt) to BB.*/
-- Don't remove the SET ECHO command below.
--
SPOOL companyDML-a.txt
SET ECHO ON
-- ---------------------------------------------------------------
-- 
-- Name: <Bomin Rahmani>
--
-- ------------------------------------------------------------
-- NULL AND SUBSTRINGS -------------------------------
--



/*(10A)
*/
Select emp.ssn, emp.lname
From employee emp
-- no supervisor or last name with 2 a's
Where emp.super_ssn IS NULL OR emp.lname LIKE "%a%a%"
--sort by ssn
ORDER BY emp.ssn;

/*(11A)
For every employee who works more than 30 hours on any project: Find the ssn, lname, project number, project name, and numer of hours. Sort the results by ssn.
*/
Select  emp.ssn, emp.lname, pro.number, pro.name, wo.hours
From employee emp, project pro, works_on wo
--works more than 30 hours on any project, Find the ssn, lname, project number, project name, and numer of hours.
Where emp.ssn = wo.essn AND wo.hours > 30 AND wo.pno = pro.pnumber
--Sort the results by ssn.
ORDER BY emp.ssn;

/*(12A)
Write a query that consists of one block only.
*/
Select  emp.lname, emp.dno, pro.pnumber, pro.dnum
From employee emp, project pro, works_on wo
--For every employee who works on a project that is not controlled by the department he works for:
--Find the employee's lname, the department he works for, the project number that he works on, 
--and the number of the department that controls that project. Sort the results by lname.
WHERE emp.ssn = wo_essn AND wo.pno = pro.pnum AND emp.dno != pro.dnum
ORDER BY emp.lname

/*(13A)
For every employee who works for more than 20 hours on any project
--that is located in the same location as his department:
--Find the ssn, lname, project number, project location, department number, and department location.
*/
SELECT DISTINCT emp.ssn, emp.lname, wo.pno, pro.plocation, emp.dno, loc.dlocation
FROM employee emp, project pro, works_on wo, dept_locations loc
WHERE emp.ssn = wo.essn AND emp.dno = loc.dnum
AND wo.pno = pro.pnum AND pro.plocation = loc.dlocation
AND wo.hours > 20
--Sort the results by lname
ORDER by emp.lname;

/*(14A)
Write a query that consists of one block only.
For every employee whose salary is less than 70% of his immediate supervisor's salary: Find his ssn, lname, salary; and his supervisor's ssn, lname, and salary. Sort the results by ssn.  
*/
SELECT emp.ssn, emp.lname, emp.salary, sup.ssn, sup.lname, sup.salary
FROM   employee E, employee sup
WHERE  emp.super_ssn = sup.ssn AND (sup.salary * .7) > emp.salary
ORDER BY emp.ssn;

/*(15A)
For projects located in Houston: Find pairs of last names such that the two employees in the pair work on the same project. Remove duplicates. Sort the result by the lname in the left column in the result. 
*/
SELECT emp1.lname, emp2.lname
FROM   employee emp1, employee emp2, works_on wo1, works_on wo2, project pro
WHERE  wo1.pno = wo2.pno AND wo1.pno = pro.pnumber AND
       p.plocation = 'Houston' AND emp1.ssn > emp2.ssn
--left hand column sort
ORDER BY emp1.lname;

/*(16A) Hint: A NULL in the hours column should be considered as zero hours.
Find the ssn, lname, and the total number of hours worked on projects for every employee whose total is less than 40 hours. Sort the result by lname
*/ 
SELECT emp.ssn, emp.lname
FROM   employee emp, works_on wo
WHERE  emp.ssn = wo.essn
GROUP BY emp.ssn, emp.lname
HAVING SUM(wo.hours) < 40 OR SUM(wo.hours) IS NULL
ORDER BY emp.lname;
/*(17A)
For every project that has more than 2 employees working on it: Find the project number, project name, number of employees working on it, and the total number of hours worked by all employees on that project. Sort the results by project number.
*/ 
SELECT pro.pnumber, pro.pname, COUNT(*), SUM (wo.hours)
FROM   works_on wo, project pro
WHERE  wo.pno = pro.pnumber
GROUP BY pro.pnumber, pro.pname
HAVING COUNT(*) > 2
ORDER BY pro.pnumber;

/*(18A)
For every employee who has the highest salary in his department: Find the dno, ssn, lname, and salary . Sort the results by department number.
*/
SELECT emp1.dno, emp1.ssn, emp1.lname, emp1.salary
FROM   employee emp1
WHERE  emp1.salary = (SELECT MAX(emp2.salary)
FROM   Employee emp2
WHERE  emp1.dno = emp2.dno)
ORDER BY emp1.dno; 
/*(19A)
For every employee who does not work on any project that is located in Houston: Find the ssn and lname. Sort the results by lname
*/
SELECT emp.ssn, emp.lname
FROM   employee emp
WHERE  emp.ssn NOT IN (SELECT wo.essn
FROM   works_on wo, project pro
WHERE  pro.plocation = 'Houston') AND wo.pno = pro.pnumber AND 
ORDER BY emp.lname;
/*(20A) Hint: This is a DIVISION query
For every employee who works on every project that is located in Stafford: Find the ssn and lname. Sort the results by lname
*/
-- <<< Your SQL code goes here >>>
--
SET ECHO OFF
SPOOL OFF


