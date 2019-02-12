-- 1.	List tables in your schema and check for existence of DEPT, EMP and SALGERADE tables
SELECT * FROM TAB;

-- 2.	If these tables do NOT exists – execute the script in the embedded DemoBld.SQL file to create and populate the tables .

-- RUUNING THE SQL FILE FROM SQL PLUS TERMINAL
@/<path>/DemoBld.SQL


--  3.List all columns and all rows from DEPT
SELECT * FROM DEPT;

--  4.List all columns and all rows from EMP
SELECT * FROM EMP;

-- 5.	List all columns and all rows from SALGRADE
SELECT * FROM SALGRADE;

-- 6.	List employee number, name and salary from employee table
SELECT EMPNO, ENAME, SAL FROM EMP;

-- 7.	List employee number, name and salary from employee table where salary is > 3000
SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL>3000;

-- 8.	List employees joined after year 1981
SELECT * FROM EMP WHERE HIREDATE>'31-DEC-1981';

-- 9.	List all clerks (JOB = ‘CLERK’)
SELECT * FROM EMP WHERE JOB='CLERK';

-- 10.	List employees in the ascending order of salary
SELECT * FROM EMP ORDER BY SAL ASC;


-- 11.	List employees in ascending order of job within descending order of deptno
SELECT * FROM EMP ORDER BY DEPTNO ASC;

-- 12.	List distinct departments from employee table
SELECT DISTINCT(DEPTNO) FROM EMP;

-- 13.	List distinct jobs in each department from employee table
SELECT DISTINCT(JOB), DEPTNO FROM EMP GROUP BY JOB,DEPTNO;

-- 14.	List name, salary and annual salary in the descending order of annual salary – annual salary is a computed column – SAL * 12 
SELECT ENAME, SAL, SAL*12 AS ANNUAL_SALARY FROM EMP ORDER BY ANNUAL_SALARY DESC;

-- 15.	List employees whose salary is not in the range of 2000 and 3000
SELECT * FROM EMP WHERE SAL<2000 OR SAL>3000;

-- 16.	List name and the deptno for all employees who are NOT members of departments 10 and 20
SELECT ENAME, DEPTNO FROM EMP WHERE DEPTNO NOT IN (10,20);

-- 17.	List employees for whom COMM is not applicable
SELECT * FROM EMP WHERE COMM IS NULL;

-- 18.	List employees for whom COMM is applicable 
SELECT * FROM EMP WHERE COMM IS NOT NULL;

-- 19.	List employees in ascending order of COMM and note how NULLs are sorted
SELECT * FROM EMP ORDER BY COMM; --NULL ARE TREATED AS HIGHEST VALUE

-- 20.	List employees whose names start with ‘’SMITH’
SELECT * FROM EMP WHERE ENAME='SMITH';

-- 21.	List employees whose name contain the ‘MI’ 
SELECT * FROM EMP WHERE ENAME LIKE '%MI%';

-- 22.	List employees whose name start with an _ (underscore) char
SELECT * FROM EMP WHERE ENAME LIKE 'AN%';


-- 23.	List all employees joined between two given dates
SELECT * FROM EMP WHERE HIREDATE BETWEEN '01-JAN-1981' AND '31-DEC-1982';


--  24.	List all clerks in deptno 10
SELECT * FROM EMP WHERE JOB='CLERK' AND DEPTNO=10;

-- 25.	List total/sum, maximum, minimum, average of salary from employee table
SELECT SUM(SAL) AS TOTAL_SAL, MAX(SAL) AS MAXIMUM_SAL, MIN(SAL) AS MININMUM_SAL, AVG(SAL) AS AVERAGE_SAL FROM EMP;

-- 26.	List average and count of commission of all employees in department 10
SELECT AVG(COMM), COUNT(COMM) FROM EMP WHERE DEPTNO=10 AND COMM IS NOT NULL;

-- 27.	List department wise no of employees and total salary
SELECT COUNT(ENAME), SUM(SAL) FROM EMP GROUP BY DEPTNO;

-- 28.	List total salary Job wise within each department
SELECT SUM(SAL),JOB,DEPTNO FROM EMP GROUP BY JOB ,DEPTNO;


-- 29.	List department wise total salary for deptno 10 and 20 only
SELECT SUM(SAL), DEPTNO FROM EMP WHERE DEPTNO IN(10,20) GROUP BY DEPTNO;

-- 30.	List department wise total salary where total salary is > 6000
SELECT SUM(SAL), DEPTNO FROM EMP  GROUP BY DEPTNO HAVING SUM(SAL)>6000;

-- 31.	SELECT COUNT(*), COUNT(COMM) FROM EMP; - explain why the two counts are different
SELECT COUNT(*), COUNT(COMM) FROM EMP; 
-- COUNT(*)-> IT COUNT TOTALROW PRESENT IN TABLE.
-- COUNT(COMM)-> IT COUNT ONLY THOSE ROW FOR WHOSE COMM VALUE IS PRESENT

-- SUBQUERIES

-- 1.	List employees whose job is same as that of ‘SMITH’
SELECT * FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE ENAME='SMITH');

-- 2.	List employees who have joined after ‘ADAM’
SELECT * FROM EMP WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='ADAM');

-- 3.	List employees who salary is greater than ‘SCOTT’s salary
SELECT * FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='SCOTT');

-- 4.	List employees getting the maximum salary
SELECT * FROM EMP WHERE SAL=(SELECT MAX(SAL) FROM EMP);

-- 5.	List employees show salary is > the max salary of all employees in deptno 30
SELECT * FROM EMP WHERE SAL>(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30);

-- 6.	List all employees whose deptno and Job are same as that of employee with empno 7788.
SELECT * FROM EMP WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO=7788)
                  AND DEPTNO=(SELECT DEPTNO FROM EMP WHERE EMPNO=7788);
				  

-- 7.	List employee who are not managers
SELECT * FROM EMP WHERE JOB IN (SELECT JOB FROM EMP WHERE JOB!='MANAGER');

-- 8.	List all managers
SELECT * FROM EMP WHERE JOB= (SELECT DISTINCT(JOB) FROM EMP WHERE JOB='MANAGER');


-- 9.	List all employees who earn(salary) more than the average salary in their own department
SELECT * FROM EMP X WHERE SAL>(SELECT AVG(SAL) FROM EMP WHERE DEPTNO = X.DEPTNO);


-- 10.	List employees whose salary is greater than their manager’s salary
SELECT * FROM EMP X WHERE SAL > (SELECT SAL from EMP WHERE EMPNO=X.MGR);


-- 11.	List details of departments from DEPT table for which there are no employees in EMP table 
SELECT * FROM DEPT WHERE DEPTNO NOT IN (SELECT DISTINCT(DEPTNO) FROM EMP);