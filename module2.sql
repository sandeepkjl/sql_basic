-- JOINS

-- 1.	List employee name, department number and their corresponding department name by joining EMP and DEPT tables
SELECT E.ENAME, E.DEPTNO, D.DNAME FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO;


-- 2.	List employee name and their manager name by joining EMP table to itself
SELECT X.ENAME , Y.ENAME AS MGRNAME FROM EMP X, EMP Y WHERE X.MGR = Y.EMPNO;

-- 3.	List employee name, department name and their grade by joining EMP, DEPT and SALGRADE tables
SELECT E.ENAME, D.DNAME, S.GRADE FROM EMP E, DEPT D, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND E.DEPTNO=D.DEPTNO;

-- 4.	List employees who work in ‘Research’ department by joining EMP and DEPT tables
SELECT * FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND D.DNAME='RESEARCH';


-- 5.	List all rows from EMP table and only the matchingrows from DEPT table – LEFT OUTER JOIN
SELECT * FROM EMP E LEFT OUTER JOIN DEPT D USING(DEPTNO);


-- 6.	List only matching rows from EMP table and all rows from DEPT table – RIGTH OUTER JOIN
SELECT * FROM EMP E RIGHT OUTER JOIN DEPT D USING(DEPTNO);

-- 7.	Write a query to perform full outer join between EMP and DEPT tables
SELECT * FROM EMP E ,DEPT D WHERE E.DEPTNO=D.DEPTNO;

-- 8.	List employee name, their manager name and their manager’s manager name

SELECT X.ENAME , Y.ENAME AS MANAGERNAME , Z.ENAME AS "MANAGERR'S MANAGERNAME" FROM EMP X, EMP Y, EMP Z
WHERE X.MGR = Y.EMPNO AND Y.MGR=Z.EMPNO;





-- DDL

/* 1.	Create DEPARTMENT table with the following columns with appropriate data type and width 
 a)	Deptno PK
 b)	Danme 
 c)	Location*/
CREATE TABLE DEPARTMENT(
DEPTNO NUMBER(2) PRIMARY KEY,
DNAME VARCHAR(10),
LOCATION VARCHAR2(10));
)


/*-- 2.	Create EMPLOYEE table with the following columns with appropriate data type and width 
-- a.	empno PK
-- b.	ename not null 
-- c.	designation
--  d.	sex
-- e.	basic_salary (> 0 and < 500000)  
-- f.	Date of joining 
-- g.	Deptno reference deptno of DEPARTMENT table*/
CREATE TABLE EMPLOYEE(
EMPNO NUMBER(10) PRIMARY KEY,
ENAME VARCHAR(20) NOT NULL,
DESIGNATION VARCHAR2(20),
SEX VARCHAR2(6),
BASIC_SALARY NUMBER(10,15) CHECK(BASIC_SALARY>0 AND BASIC_SALARY<500000),
DATE_OF_JOINING DATE,
DEPTNO NUMBER(2) REFERENCES DEPARTMENT(DEPTNO)
);


-- 3. Alter table EMPLOYEE add column commission
ALTER TABLE EMPLOYEE
ADD COMMISSION NUMBER(5,8);

-- 4. Alter table EMPLOYEE add constraint SEX in (‘M’, ‘F’)
ALTER TABLE EMPLOYEE
ADD CONSTRAINT SEX_CONSTRAINT CHECK(SEX IN ('M','F'));



-- 4. Create Index on ename column of EMPLOYEE table
CREATE INDEX ENAME_INDEX ON EMPLOYEE(ENAME);


-- 5. Create exact replica of EMPLOYEE table with no data
CREATE TABLE EMPLOYEE_REPLICA
AS
SELECT * FROM EMPLOYEE WHERE 1=0;

-- 6. Create new table called EX_EMP with columns empno, ename, basic_salary and populate the data from EMPLOYEE table
CREATE TABLE EX_EMP
AS
SELECT EMPNO, ENAME, BASIC_SALARY FROM EMPLOYEE;

-- 7. Drop the Index created on ename column.
DROP INDEX ENAME_INDEX;





-- DML COMMAND

-- 1.	Insert at least 5 valid rows into DEPARTMENT table and commit the changes
INSERT INTO DEPARTMENT VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES(40,'OPERATION','BOSTON');
INSERT INTO DEPARTMENT VALUES(50,'HR','INDIA');
COMMIT;


-- 2.	Insert at least 15 valid rows in EMPLOYEE table and commit the changes 
INSERT INTO EMPLOYEE VALUES(7839, 'KING', 'PRESIDENT', 'M', 5000, '17-NOV-81', 10, NULL);
INSERT INTO EMPLOYEE VALUES(7698, 'BLAKE', 'MANAGER', 'M', 2850, '01-MAY-81', 30, NULL);
INSERT INTO EMPLOYEE VALUES(7782, 'CLARK', 'MANAGER', 'M', 2450, '09-JUN-81', 10, NULL);
INSERT INTO EMPLOYEE VALUES(7566, 'JONES', 'MANAGER', 'M', 2975, '02-APR-81', 20, NULL);
INSERT INTO EMPLOYEE VALUES(7654, 'MARTIN', 'SALESMAN', 'M', 1250, '28-SEP-81', 30, 1400);
INSERT INTO EMPLOYEE VALUES(7499, 'ALLEN', 'SALESMAN', 'M', 1600, '20-FEB-81', 30, 300);
INSERT INTO EMPLOYEE VALUES(7844, 'TURNER', 'SALESMAN', 'M', 1500, '08-SEP-81', 30, NULL);
INSERT INTO EMPLOYEE VALUES(7900, 'JAMES', 'CLERK', 'M', 950, '03-DEC-81', 30, NULL);
INSERT INTO EMPLOYEE VALUES(7521, 'WARD', 'SALESMAN', 'M', 1250, '22-FEB-81', 30, 500);
INSERT INTO EMPLOYEE VALUES(7902, 'FORD', 'ANALYST', 'M', 3000, '03-DEC-81', 20, NULL);
INSERT INTO EMPLOYEE VALUES(7369, 'SMITH', 'CLERK', 'M', 800, '17-DEC-81', 20, NULL);
INSERT INTO EMPLOYEE VALUES(7788, 'SCOTT', 'ANALYST', 'M', 3000, '09-DEC-82', 20, NULL);
INSERT INTO EMPLOYEE VALUES(7876, 'ADAMS', 'CLERK', 'M', 1100, '12-JAN-83', 20, NULL);
INSERT INTO EMPLOYEE VALUES(7934, 'MILLER', 'CLERK', 'M', 1300, '2-JAN-82', 10, NULL);
INSERT INTO EMPLOYEE VALUES(7596, 'CINY', 'ANALYST', 'F', 2975, '15-SEP-83', 30, 300);
COMMIT;


-- 3.	Update basic_salary by 10% for employees in deptno 10 and 20 and commit the changes 
UPDATE EMPLOYEE SET BASIC_SALARY = BASIC_SALARY+BASIC_SALARY*10/100 WHERE DEPTNO IN(10,20);
COMMIT;

-- 4.	Update basic_salary and commission by 10% and 2% for all employees for whom commission is currently applicable and commit the changes 
UPDATE EMPLOYEE SET BASIC_SALARY = BASIC_SALARY+BASIC_SALARY*10/100, COMMISSION=COMMISSION+COMMISSION*2/100
WHERE COMMISSION IS NOT NULL;
COMMIT;

-- 5.	Update the designation of given employee to MANAGER based of given employee number and commit the changes. 
UPDATE EMPLOYEE SET DESIGNATION = 'MANAGER' WHERE EMPNO=&EMPNO;
COMMIT;

-- 6.	Delete employees joined before a given year and commit changes 
DELETE FROM EMPLOYEE WHERE EXTRACT(YEAR FROM DATE_OF_JOINING)<&YEAR;
COMMIT;

-- 7.	Delete all rows from employee tables.
DELETE FROM EMPLOYEE;

-- 8.	Query employee table
SELECT * FROM EMPLOYEE;

-- 9.	ROLLBACK
ROLLBACK;

-- 10.	Query employee table
SELECT * FROM EMPLOYEE;

-- 11.	Delete all rows from employee tables permanently using appropriate DDL command 
TRUNCATE TABLE EMPLOYEE;





-- Procedure and Functions:


/* 1.	Create a procedure named DISP_EMP_DETAILS with 3 parameters  one [ie. iEmpNo ] is an “IN” mode and other two are [ie. sGrade and sSalary]  “OUT” mode parameters. The procedure should retrieve the Grade (this is column of SALGRADE table) and Salary for the specified employee number [ie. iEmpNo ] by joining EMP and SALGRADE table and assign the retrieved values to the “OUT” mode parameters. 
 Note.:
It should display an appropriate error message if the specified employee number 
does not exist in “Employee” table.
Call the created procedure using Bind variable and print the details.
*/

CREATE OR REPLACE PROCEDURE DISP_EMP_DETAILS(iEMPNO IN NUMBER, sGRADE OUT NUMBER, sSALARY OUT NUMBER)
IS
BEGIN
SELECT S.GRADE, E.SAL INTO sGRADE, sSALARY FROM SALGRADE S, EMP E
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND E.EMPNO=iEMPNO;

EXCEPTION
WHEN NO_DATA_FOUND THEN 
      DBMS_OUTPUT.PUT_LINE('No such Employee!');
WHEN others THEN 
      DBMS_OUTPUT.PUT_LINE('Error!'); 

END;
/

-- DECLARING BIND VARIABLE
VARIABLE GRADE NUMBER;
VARIABLE SALARY NUMBER;

-- CALLING CERATED PROCESDURE
EXECUTE DISP_EMP_DETAILS(&ENTER_EMPLOYEE_NUMBER,:GRADE,:SALARY);

-- PRINTING DATAILS;
PRINT :GRADE :SALARY;




/* 

2.	Create a procedure named DISPLAY_RECORDS which accepts the P_JOB as a parameter and display all the employees (empno, sal, deptno, job) from the “EMP” table matching the given P_JOB in the following format :-

EmployeeNumber	Salary		DepartmentNumber    Job 

 XXXXXXXX		99,999			  99	CLERK
XXXXXXXX		  9,999			  12  	CLERK 
Note.:
It should display an appropriate error message if there are no employees with the given JOB 


*/

CREATE OR REPLACE PROCEDURE DISPLAY_RECORDS(P_JOB IN VARCHAR)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE('EmployeeNumber' || '    ' ||'SALARY'||'    '||'DepartmentNumber' || '    '||'JOB');
FOR EMPRECORD IN (SELECT EMPNO, SAL, DEPTNO, JOB FROM EMP WHERE JOB=P_JOB)
LOOP
DBMS_OUTPUT.PUT_LINE(EMPRECORD.EMPNO ||'             '|| EMPRECORD.SAL||'     ' ||EMPRECORD.DEPTNO || '              '|| EMPRECORD.JOB);
END LOOP;

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO EMPLOYEE WITH THE GIVEN JOB EXISTS');

END;
/

-- EXECUTE PROCEDURE
EXECUTE DISPLAY_RECORDS(&ENTER_JOB);


/*

3.	Create a function named GET_EMP_ANNSAL which accepts employee Number as 
a parameter and Returns Annual Salary of the given employee from EMP table if the record exist otherwise returns -1  ( formula to computer ANNUAL_SALARY = SAL * 12) 


*/


CREATE OR REPLACE FUNCTION GET_EMP_ANNSAL(E_EMPNO IN NUMBER)
RETURN NUMBER
IS
ANNUAL_SALARY NUMBER;
BEGIN
SELECT SAL*12 INTO ANNUAL_SALARY FROM EMP WHERE EMPNO=E_EMPNO;
RETURN ANNUAL_SALARY;

EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN -1;

END;
/
