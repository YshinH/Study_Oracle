----SQL문 반드시 외우기
--구분          해석순서
--SELECT   절   --5      
--FROM     절   --1
--WHERE    절   --2
--GROUP BY 절   --3
--HAVING   절   --4
--ORDER BY 절   --6   마지막에 정렬

5. 사용자 정보 확인 ☞ 오라클 계정은 데이터베이스 사용자와 같은 의미로 사용
SELECT username
FROM   dba_users; --문장의 끝은 세미콜론, 
                  --주석은 '--',
                  --주석 : ctrl + shift + /
                  --실행은 블럭지정 후 
                  --ctrl + enter ☞ 질의 결과탭으로 맨위부터 출력
                  --F5,          ☞ 스크립트 출력 탭으로 결과가 보임
                  
6. HR 유저 사용하기 위해 HR 유저 계정 풀기
ALTER USER hr     --hr유저로 변경할건데
ACCOUNT UNLOCK;   --HR 유저 계정 풀기

6. 비밀번호 지정
ALTER USER hr
IDENTIFIED BY 0000;

7. hanul 계정 생성 ☞ 원래는 계정을 생성할 때 c##으로 시작하는 계정 이름을 지정하도록 바뀜
ALTER SESSION set "_ORACLE_SCRIPT"=true; ☜ 계정생성시 c##으로 시작하지 않아도 됨
CREATE USER hanul IDENTIFIED BY 0000;

GRANT connect, dba, create view, resource TO hanul; --resources 복수 아니고 resource 단수
   
dba_users 구조보기
DESC dba_users;

--------------------------------------------------------------------------------
--tblmember 테이블 생성
CREATE TABLE tblmember(
   num   NUMBER PRIMARY KEY, --unique, not null ☜ primary key --값이 있어야함
   name  VARCHAR2(10),
   age   NUMBER,
   addr  VARCHAR2(50),
   tel   VARCHAR2(20)
);

--Table TBLMEMBER이(가) 생성되었습니다.

--tblmember 구조 보기
DESC  tblmember;  == DESCRIBE tblmember;
이름   널?       유형           
---- -------- ------------ 
NUM  NOT NULL NUMBER       
NAME          VARCHAR2(10) 
AGE           NUMBER       
ADDR          VARCHAR2(50) 
TEL           VARCHAR2(20) 

--레코드 삽입
INSERT   INTO tblmember
VALUES   (1, '홍길동', 30, '광주시 서구 농성동', '010-1111-1111'); 
--문자와 날짜는 쌍따옴표가 아니라 홑따옴표에 입력해야 함
--1 행 이(가) 삽입되었습니다.
INSERT   INTO tblmember(num, name, age, addr, tel)--()생략해도됨
VALUES   (2, '김길동', 27, '광주시 서구 쌍촌동', '010-2222-2222'); 
--프라이머리키1,2,... 유일해야함

--전체 레코드 검색    
--블럭지정해서 실행해야하는 이유는 나중에 주석까지 인식할수도 있기 때문에
SELECT   *
FROM  tblmember;

SELECT   num, name, tel
FROM     tblmember;  --아직 DML만 했기때문에 메모리에만 있음 확정 단계 아님
                     --commit(TCL)로 해줘야지 작업확정
--작업확정  
COMMIT;
--커밋 완료.

--구조보기
DESC tblmember;

--tblmember 테이블에 phone 필드 추가
ALTER TABLE tblmember
ADD   phone VARCHAR2(10);  --add 추가

--구조보기
DESC tblmember;

--tblmember 테이블에 phone 필드 크기 변경  --그냥 외울것
ALTER TABLE tblmember
MODIFY   phone VARCHAR2(20);  --MODIFY 필드 크기 변경

--구조보기
DESC tblmember;

--tblmember 테이블에 phone 필드 이름을 mobilephone으로 변경
ALTER TABLE tblmember
RENAME   COLUMN   phone TO mobilephone;   --중요함 제일많아씀

--구조보기
DESC tblmember;

--tblmember 테이블에 mobilephone 필드 삭제
ALTER TABLE tblmember
DROP  COLUMN   mobilephone;

--tblmember 테이블 삭제
DROP TABLE tblmember;

--tblmember 테이블 복구
FLASHBACK TABLE tblmember TO BEFORE DROP;

--구조보기
DESC tblmember;

DML : 데이터 조작어, SELECT, INSERT, UPDATE, DELETE
반드시 TCL과 함께 사용해야 함
TCL : COMMIT, ROLLBACK, SAVEPOINT

--임의의 레코드 삽입
INSERT INTO tblmember
VALUES (3,'박길동',47,'광주시 서구 용봉동','010-3333-3333');

INSERT INTO tblmember(num, name, age)
VALUES (4,'이순신',55);

--모든 레코드 검색
SELECT   *
FROM  tblmember;

--4번 레코드 정보를 갱신(수정) : update와 delete는 반드시 WHERE 조건 지정
UPDATE tblmember
SET   addr = '광주시 광산구 신가동', tel = '010-4444-4444'  --셋팅
WHERE num = 4;--조건식  --조건안주면 모두 변경됨

--모든 레코드 검색
SELECT   *
FROM  tblmember;

--3번 레코드의 정보를 수정, 주소를 서울시 강남구 개포동으로 변경
UPDATE tblmember --UPDATE 외우기
SET   addr = '서울시 강남구 개포동'
WHERE num = 3;

--모든 레코드 검색
SELECT   *
FROM  tblmember;

--작업확정
COMMIT;

--4번레코드 삭제
DELETE   FROM  tblmember   --UPDATE, DELETE  반드시 WHERE 조건 지정
WHERE num = 4;

--모든 레코드 검색
SELECT   *
FROM  tblmember;

--모든 레코드 삭제, 조건 미지정시
DELETE   FROM  tblmember;  

--모든 레코드 검색
SELECT   *
FROM  tblmember;

--작업취소
ROLLBACK;

--모든 레코드 검색
SELECT   *
FROM  tblmember;

--검색
--번호, 이름, 주소만 출력
SELECT num, name, addr
FROM  tblmember;

--나이가 40세 이상인 회원만 출력(비교연산자)
SELECT   *
FROM  tblmember
WHERE age >= 40;

--나이가 40세 이상인 회원의 이름, 주소, 전화번호 출력(비교연산자)
SELECT   name, addr, tel
FROM     tblmember
WHERE    age >= 40;

--나이가 30~50세 사이인 회원만 출력(비교연산자)
SELECT   *
FROM     tblmember
WHERE    age >= 30
AND      age <= 50;

SELECT *
FROM tblmember
WHERE age BETWEEN 30 AND 50;  --이절로 많이 사용함

--주소에 특정 문자를 포함한 회원을 출력 ★★★★★★(LIKE 연산자)
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
--광% ☞  '광'으로 시작하는
--%광 ☞  '광'으로 끝나는
--%광% ☞ '광'을 포함하는

--주소에 서구가 포함된 레코드 출력
SELECT   *
FROM  tblmember
WHERE addr LIKE '%서구%'; --'='은 다른 프로그램에서는 대입연산자,
                          --    오라클에서는 관계연산자(equal)
--광주에 사는 사람들 출력
--주소가 광으로 시작하는 레코드
SELECT *
FROM tblmember
WHERE addr LIKE '광%';

                     
                     
                     
                     
                     