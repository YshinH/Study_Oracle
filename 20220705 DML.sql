8장.  DML

DML(Data Manipulation Language)은 데이터를 조작하는 명령문이다.
SELECT, INSERT, UPDATE, DELETE 의 4가지 형태가 있다. 
INSERT, UPDATE, DELETE 만을 DML로 분류하기도 한다.
DML은 TCL(Transaction Control Language)과 함께 사용한다.

8.1 데이터 삽입 INSERT
테이블에 데이터를 삽입 저장하는 기본형식은 다음과 같다.
INSERT INTO table명 [ (column1, column2,...) ]

▪ 테이블에 데이터를 저장할 컬럼 목록과 일대일 대응이 되도록 저장 값 목록을 
  VALUES 절에 나열한다. 저장하지 않은 컬럼 값은 자동으로 NULL 이 저장된다.
  날짜 데이터는 날짜포맷 형식을 사용해서 저장할 수 있다.

DESC departments;
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4) 

INSERT INTO departments
VALUES  (300, '영업부', NULL, NULL); --☞ NULL -> NULL, 'NULL' -> NULL이라는 문자

INSERT INTO departments
VALUES  (310, '개발부', NULL, ''); -- '' -> NULL

INSERT INTO departments
VALUES  (320, '총무부', DEFAULT, DEFAULT); -- DEFAULT -> NULL

SELECT * FROM departments;

INSERT INTO departments(department_id) -- 테이블이름이 notnull이기에 이름도 넣어줘야함
VALUSE (330);                          -- XXX

DESC departments;

이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4) 

INSERT INTO departments
VALUES  (300, '영업부', NULL, NULL); --☞ NULL -> NULL, 'NULL' -> NULL이라는 문자

INSERT INTO departments
VALUES  (310, '개발부', NULL, ''); --'' -> NULL

INSERT INTO departments
VALUES  (320, '총무부', DEFAULT, DEFAULT); --DEFAULT -> NULL

SELECT * FROM departments;

INSERT INTO departments(department_id) --XXX
VALUES (330);

DESC  departments;

SELECT * FROM departments;

DESC  employees;
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)
--                         -                      -         -       -     
INSERT INTO employees(employee_id, first_name, last_name, email, hire_date,
                      job_id, salary, department_id)
--                       - 
VALUES(301, '길동','홍', 'GILDONG', '10/10/10', 'MK_REP',3000,300);

--------------------------------------------------------------------------------
SELECT  * FROM  departments;

-----------------------★< ITAS ☞ 테스트용으로 사용 >----------------------------
INSERT INTO 테이블명  --AS 없음
  조회쿼리문(SELECT 문); --☜ ITAS
01. 

DESC  departments;

INSERT INTO departments --ITAS, AS없음
  SELECT  department_id+1, department_name, manager_id, location_id
  FROM    departments;
  
SELECT * FROM departments;
--------------------------------------------------------------------------------
★ CTAS(Create Table As Select) ☞ 테스트용으로 사용, 
NOT NULL 값만 복사(PK는 복사되지 않음)

CREATE TABLE emp AS
  SELECT  employee_id id, first_name, last_name, hire_date, job_id, department_id, dept_id
  FROm    employees;

DESC  employees;
DESC  emp;

CREATE TABLE sample AS 
  SELECT  employee_id id, first_name, last_name, hire_date, job_id, department_id dept_id
  FROm    employees
  WHERE   1=2; --엉터리 조건, 조건이 일치하지 않음
  --구조가 복사된 데이터가 없는 빈 테이블 생성
  
테이블 삭제
DROP TABLE sample;

테이블 복구
FLASHBACK TABLE sample TO BEFORE DROP;


employees 테이블의 10번, 20번 부서원들의 정보를 복사하여
emp테이블의 데이터행에 삽입저장한다.

SELECT *FROM emp;
DELETE FROM emp;

desc employees;
desc emp;

INSERT INTO emp(id, first_name, last_name, hire_date, job_id, dept_id)
       SELECT employee_id,first_name, last_name, hire_date, job_id, department_id
       FROM employees where department_id in (10,20);




8.2 변경저장 : UPDATE --반드시 조건절 지정
UPDATE table명
SET column = value
WHERE 조건;

01. emp 테이블에서 id가 202인 사원의 dept_id를 30으로 job_id를 programmenr로 변경저장
SELECT * FROM emp WHERE id = 202; --20, MK_REP

UPDATE emp
SET      dept_id = 30, job_id ='programmer'
WHERE    id = 202;

SELECT * FROM emp WHERE id = 202; --30, programmer

02.emp 테이블에서 id가 202인 사원의 dept_id를 NULL로 변경
UPDATE emp
SET    dept_id = ''
WHERE   id = 202;

SELECT * FROM emp WHERE id = 202; --null, programmer

04.서브쿼리로 데이터 행 변경

UPDATE 문의 서브쿼리는 SET 절과 WHERE 절에 사용할 수 있다.
emp 테이블의 부서배치 받지 않은 사원들의 부서코드를
employees테이블의 job_id AD_PRES 인 사원의 부서코드로 변경

UPDATE   emp
SET      dept_id = (empoyees 테이블의 job_id AD_PRES 인 사원의 부서코드로 변경)
WHERE    emp 테이블의 부서배치 받지 않은 사원들의 부서코드

UPDATE   emp
SET      dept_id = (select department_id
                    from   employees
                    where  job_id = 'AD_PRES')
WHERE    dept_id is null;

select * from emp where job_id = 'AD_PRES';--XXX

05. employees 테이블에 새로운 사원정보를 삽입저장하자.
300번으로 사번을 지정하고 급여는 60번 부서의 평균급여로 저장
employee_id, first_name, last_name, email, hire_date, job_id, salary
300,길동, 홍, hong@naver.com, 오늘날짜, IT_PROG, 60번 부서의 평균급여

INSERT INTO employees(employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES(300, '길동', '홍', 'hong@naver.com', sysdate, 'IT_PROG',(SELECT AVG(salary) FROM employees where department_id = 60));

desc employees;

06. employees 테이블의
300번 사원의 급여를 우리회사 최고급여, 전화번호는 062.1234.5678로 변경

UPDATE employees
SET    salary = (select max(salary) from employees),
       phone_number = '062.1234.5678'
where  employee_id = 300;

select * from employees where employee_id = 300;


8.3 데이터 행 삭제 : DELETE --반드시 조건절 기술
DELETE FROM 테이블명
WHERE 조건절;

01. employees 테이블에서 300번 사원코드 삭제
SELECT * FROM employees;

DELETE FROM employees
WHERE employee_id = 300;

02. departments 테이블에서
300번 부서 삭제
DELETE FROM departments
WHERE department_id = 300;

자식 레코드가 발견되었습니다 -- 자식삭제 -> 나 삭제

DELETE FROM employees
WHERE department_id = 300;

DELETE FROM departments
WHERE department_id = 321;

select * from employees;
select * from departments;

DELETE FROM employees
WHERE department_id = 311;

DELETE FROM departments
WHERE department_id = 311;

DELETE FROM employees
WHERE department_id = 1;

DELETE FROM departments
WHERE department_id = 281;


commit;







--------------------------------------------------------------------------------





