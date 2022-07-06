11. 뷰 : 가상의 테이블
실제로 데이터가 존재하는 객체는 아니다.
테이블의 데이터를 뷰를 통해 접근한다.

1. 보안 - 접근 제한
2. 복잡한 쿼리문을 단순 쿼리문으로 사용

뷰를 사용하면 테이블처럼 사용가능하며 SELECT 절에서만 쿼리 가능
INSERT, UPDATE DELETE 가 불가능

뷰 생성
CREATE OR REPLACE VIEW  뷰명 AS ---☜CVAS
SELECT 쿼리문

CTAS 
CREATE TABLE 테이블명 AS
 SELECT 쿼리문
 
ITAS
INTSERT INTO 테이블명 --AS없음
 SELECT 쿼리문

CREATE OR REPLACE VIEW vu_60 AS
   SELECT employee_id, first_name, department_id, email
   FROM employees
   where department_id = 60;

SELECT *
FROM vu_60;

DROP VIEW 뷰명
DROP VIEW vu_60;

※ 연속된 일련번호(중복되지 않은 것)을 만들어주는 기능을 가진 객체
: SQUENCE

시퀀스 생성  ------------------------------------------------------게시판에 사용
CREATE SEQUENCE 시퀀스명
START WITH 시작숫자
INCREMENT BY 증감숫자


SELECT *
FROM   emp;

DROP TABLE emp;

CREATE TABLE emp(
   id    NUMBER(4)     CONSTRAINT emp_id_pk  PRIMARY KEY,
   name  VARCHAR2(30)    CONSTRAINT emp_name_nn  NOT NULL
);


emp시퀀스 생성
CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1;

현재의 SEQUENCE 값 확인
SELECT emp_seq.CURRVAL FROM dual;   --한번도 실행하지 않아 에러 발생

시퀀스 접근 : CURRVAL, NEXTVAL
SELECT emp_seq.NEXTVAL FROM dual; --반드시 실행해야 함

현재의 SEQUENCE 값 확인
SELECT emp_seq.CURRVAL FROM dual;   --한번 실행하여 현재값 출력

emp 테이블의 PK 인 id 에 시퀀스를 적용하여 데이터행을 삽입하자
INSERT INTO emp (id, name)
VALUES (emp_seq.CURRVAL, '이순신');

INSERT INTO emp (id, name)
VALUES (emp_seq.NEXTVAL, '유관순');

SELECT *
FROM  emp;

시퀀스 삭제
DROP SEQUENCE 시퀀스명;

DROP SEQUENCE emp_seq;
--------------------------------------------------------------------------------끝


CREATE TABLE emp1(
   id    NUMBER(4)     CONSTRAINT emp_id_pk  PRIMARY KEY,
   name  VARCHAR2(30)    CONSTRAINT emp_name_nn  NOT NULL
);



