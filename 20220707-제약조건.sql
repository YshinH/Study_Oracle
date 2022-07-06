10장. 제약조건
무결성 제약조건(INTEGRITY CONSTRAINT) - 정확성, 정합성, 무결성을 보장하기 위해 둠
테이블에 잘못된 데이터의 입력을 막기 위해 일정한 규칙을 지정하는 것
제약 조건명은 30자까지 지정 가능

--제약조건
--NOT NULL, DEFAULT, CHECK, UNIQUE, PRIMARY KEY, FOREING KEY(여기서 DEFAUTL 는 제약조건은 아님)
--제약조건은 테이블 생성시에도 정의할 수 있고, 생성 후에도 추가/제거할 수 있음

--제약 조건 선언 : COLUMN 레벨정의방식(생성중 바로나열로 추가, 제거), 
--                 TABLE 레벨정의방식(생성중 후에 추가, 제거)

1.컬럼레벨 제약조건 기술 방법, 제약조건명기술 : 테이블약어_컬럼명약어_제약조건약어
--------------------------------------------------------------------------------
☞ 컬럼명 데이터타입 CONSTRAINT 제약조건명 제약조건----CONSTRAINT 제약조건명 무조건 써야함
CREATE TABLE 테이블명(
   컬럼명 데이터타입(크기) CONSTRAINT 제약조건명 제약조건,
   컬럼명 데이터타입(크기) CONSTRAINT 제약조건명 제약조건,
   ...
);
※ 일반적인 테이블 생성  --테스트용
--------------------------------------------------------------------------------
CREATE TABLE emp000(
   empno    NUMBER(4)      PRIMARY KEY,
   ename    VARCHAR2(15)   NOT NULL,
   job      VARCHAR2(15)   UNIQUE,
   deptno   NUMBER(2)      REFERENCES  dept(deptno),  --REFERENCES 부모테이블(참조되는 컬럼명)
   gender   CHAR(3)        CHECK(gender IN ('남', '여'))
);
--------------------------------------------------------------------------------
DESC departments;
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)  

dept 테이블 생성
CREATE TABLE dept AS --CTAS : 전체 구조복사, NOT NULL만 복사
   SELECT   department_id deptno, department_name deptname, manager_id, location_id
   FROM     departments;

구조보기
DESC dept; --departments의 구조는 복사되었지만 pk가 복사되지 않으므로 PK로 지정하는 명령문 추가
이름          널?       유형           
----------- -------- ------------ 
DEPTNO               NUMBER(4)    
DEPTNAME    NOT NULL VARCHAR2(30) 
MANAGER_ID           NUMBER(6)    
LOCATION_ID          NUMBER(4)   

--dept 테이블의 deptno를 pk를 지정하는 명령문
--CONSTRAINT를 추가해서 명령문 지정, 괄호를 미표시
--제약조건 추가
ALTER TABLE dept
ADD  CONSTRAINT dept_deptno_pk PRIMARY KEY(deptno);

DESC dept;

--제약조건 
ALTER TABLE dept
DROP  CONSTRAINT  dept_deptno_pk;

DESC  dept;

DESC emp;
  
이름         널?       유형           
---------- -------- ------------ 
ID                  NUMBER(6)    
FIRST_NAME          VARCHAR2(20) 
LAST_NAME  NOT NULL VARCHAR2(25) 
HIRE_DATE  NOT NULL DATE         
JOB_ID     NOT NULL VARCHAR2(10) 
DEPT_ID             NUMBER(4)  

1. 컬럼레벨 정의 방식으로 기술, 제약조건명 : 테이블명약어_컬럼명약어_제약조건약어
   컬럼 정의 후 바로 옆에 CONSTRAINT 제약조건명 제약조건
--              ￣￣￣￣
--------------------------------------------------------------------------------
DROP TABLE emp000;

CREATE TABLE emp000(
   empno    NUMBER(4)      CONSTRAINT emp000_empno-pk  PRIMARY KEY,
   ename    VARCHAR2(15)   CONSTRAINT emp000_ename_nn  NOT NULL   ,--제약조건이 없을때 제약조건명 : 테이블약어_컬럼명약어만 기술 : emp000_ename까지만 쓰기
                           --NOT NULL : 컬럼레벨 정의방식으로만 지정 가능
   job      VARCHAR2(15)   CONSTRAINT emp000_job_uk    UNIQUE,
   deptno   NUMBER(2)      CONSTRAINT emp000_deptno_fk  REFERENCES  dept(deptno),  --REFERENCES 부모테이블(참조되는 컬럼명)
   gender   CHAR(3)        DEFAULT '남' CONSTRAINT emp000_gender_ck CHECK(gender IN ('남', '여'))
);
--------------------------------------------------------------------------------

2. 테이블레벨 정의 방식 : CONSTRAINT 제약조건명 제약 조건
복합키 지정을 할때는 반드시 테이블레벨 정의 방식으로 제약조건을 지정해야 한다.
제약조건을 추가할때도 테이블 레벨로 제약조건을 지정해야 한다.

CREATE TABLE 테이블명(
   컬럼명 데이터타입(크기),
   컬럼명 데이터타입(크기),
   ...,
   
   제약조건을 마지막에 추가 : CONSTRAINT 제약조건명 제약조건
--￣￣￣￣￣￣￣￣￣￣￣￣
);

테이블 레벨 정의 방식

CREATE TABLE emp000(
   empno    NUMBER(4),
   ename    VARCHAR2(15) CONSTRAINT emp000_ename_nn  NOT NULL, --not null은 컬럼레벨정의방식밖에 안됨
   job      VARCHAR2(15),   
   deptno   NUMBER(2),      
   gender   CHAR(3) DEFAULT '남',
   
   CONSTRAINT  emp000_empno_pk   PRIMARY KEY(empno),         
   CONSTRAINT  emp000_job_uk   UNIQUE(job),         
   CONSTRAINT  emp000_deptno_fk   FOREIGN KEY(empno) REFERENCES dept(deptno),         
   CONSTRAINT  emp000_gender_ck   CHECK(gender IN ('남', '여'))
   
);

CREATE TABLE emp001(
   empno    NUMBER(4),
   ename    VARCHAR2(15), 
   job      VARCHAR2(15),   
   deptno   NUMBER(2),      
   gender   CHAR(3)
);



※ 제약조건 추가 / 제거

○ 제약 조건 추가 : 구조 변경
ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 제약조건
NOT NULL 만 MODIFY 명령문으로 지정하여 제약조건명 변경이 다름
ALTER TABLE 테이블명
MODIFY(컬럼명 [NOT] NULL)
DEFAULT 는 제약조건이 아니므로 제약조건명을 지정할 수 없음

○ NOT NULL/NULL---제약조건명은 추가로 만들지 못함!!!! 중요!!!!!!!!!!!!!!!!!
ALTER TABLE 테이블명
MODIFY (컬럼명 데이터타입(크기) [NOT] NULL);
제약조건명이 없네요??--RNAME CONSTAINT 로 바꾸면 됨


○ 제약 조건 제거 : 구조 변경
ALTER TABLE 테이블명
DROP CONSTRAINT 제약조건명 제약조건

PK 생성
ALTER TABLE emp001
ADD CONSTRAINT emp001_empno_pk PRIMARY KEY(empno);

PK 삭제
ALTER TABLE emp001
DROP CONSTRAINT emp001_empno_pk;

--( 한번에 봐야함
NOT NULL 추가
ALTER TABLE emp001
ADD CONSTRAINT emp001_ename_nn NOT NULL(ename); --XXX

ALTER TABLE emp001 -- OOO -- not null만 제약조건없이 추가
MODIFY (ename NOT NULL);

그래서 제약조건명을 찾아서 RENAME CONSTRAINT 로 변경
SYS_C008369

ALTER TABLE emp001
RENAME CONSTRAINT SYS_C008369 TO emp001 emp001_ename_nn;  --- 다시해봐야함  )

3. UNIQUE 추가
ALTER TABLE emp001
ADD CONSTRAINT emp001_job_uk UNIQUE(job);

4. FOREIGN KEY 추가
ALTER TABLE emp001
ADD CONSTRAINT emp001_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno);

5. DEFAULT 추가 : 테이블생성시에 컬럼레벨 정의방식으로 생성
추가로 생성시 NOT NULL 과 마찬가지로 제약조건명을 지정할 수 없음
   제약조건이 아니므로 제약조건명을 지정할 수 없음
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
ALTER TABLE emp001 -- OOO -- not null만 제약조건없이 추가
--MODIFY (gender DEFAULT '남'); --OOO 가로 넣어도 되고 안해도 됨
MODIFY gender DEFAULT '남';    ---OOO

6. CHECK 제약 조건 추가
ALTER TABLE emp001
ADD CONSTRAINT emp001_gender_ck CHECK(gender IN ('남', '여'));











