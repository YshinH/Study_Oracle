9장.  DDL -> CADTR, 데이터 정의어
CREATE
ALTER
DROP
TRUNCATE
RENAME

9.1  데이터타입
데이터 타입은 문자형, 숫자형, 날짜형으로 구분한다.

▎문자형 데이터
문자형 데이터타입은 CHARACTER에서 나온 약자로 CHAR형 데이터라 한다.

▪ CHAR(n) 타입은 지정된 숫자만큼의 문자열을 갖는 고정형이다.
▪ VARCHAR2(n) 타입은 데이터가 입력된 만큼의 문자열을 갖는 가변형이다. 
담겨질 데이터의 길이 편차가 있으면 VARCHAR2를 사용한다.

▎숫자형 데이터
숫자형 데이터타입은 NUMBER 타입이다.

▪ NUMBER(n) 는 정수형 숫자 데이터의 형태이다.
▪ NUMBER(p, s) 는 소수형 숫자 데이터의 형태이다. 
  p는 전체 숫자의 길이를 나타내고, s는 소숫점 이하 숫자의 길이를 나타낸다.

▎날짜형 데이터
날짜형 데이터타입은 DATE 타입이다. 날짜와 시각 정보를 갖는다. (toDate)

DDL(Data Definition Language)은 데이터베이스 객체를 조작하는 명령문이다.
CREATE, ALTER, DROP, TRUNCATE, RENAME 의 5가지 패턴을 갖고 있다.
DDL 은 자동 COMMIT 이 이루어진다.

9.2  테이블 생성 CREATE TABLE

▪ 테이블명 및 컬럼명 명명 규칙--오라클은 한 글자에 3byte / 일반 글자는 2byte
  1) 반드시 문자로 시작한다.
  2) 숫자도 사용할 수 있다.
  3) 최대 30바이트까지 가능하다.
  4) 오라클 예약어를 사용할 수 없다.

테이블을 생성하는 기본 형식은 다음과 같다.
CREATE TABLE 테이블명 (
컬럼명1  데이터타입(크기),
컬럼명2  데이터타입(크기), 
... );


▪ 테이블명 뒤에 데이터타입과 함께 나열한 컬럼들을 괄호로 묶어 생성한다.

CREATE TABLE temp(
   id       NUMBER(4) PRIMARY KEY,--primary key (not null)
   name     VARCHAR2(30)
);

INSERT INTO temp
VALUES  (100, '홍길동');


INSERT INTO temp
VALUES   (101, '이순신');

작업확정
COMMIT;

02. temp 테이블에서 id가 101번의 name '홍명보'로 변경한다.
UPDATE   temp
SET      name = '홍명보'
WHERE    id = 101;

COMMIT;

9.2. 테이블 구조 변경 ALTER TABLE  --------테이블 짤때 잘짜야함/ add잘 안씀/ modify를 많이씀
-----------------------------------------회사에서 권한 잘 안줌
ALTER TABLE은 테이블의 구조를 변경(컬럼 추가, 컬럼 변경, 컬럼 삭제)하는
명령문이다.

 1) 컬럼 추가 --ADD
    ALTER TABLE 테이블명
    ADD (컬럼명1 데이터타입(크기), 컬럼명2 데이터타입(크기)...);
    
temp 테이블에 숫자 8자리를 담을 salary 컬럼을 추가하자
ALTER TABLE temp
ADD (salary NUMBER(8));
--ADD salary NUMBER(8); 가로 안써도됨?
desc temp;

101번의 salary를 3000으로 변경
select * from temp;

update temp
set   salary = 3000
where id = 101;

select *
from  temp;

 2) 데이터타입 크기 변경 MODIFY
ALTER TABLE 테이블명
MODIFY(컬럼명 데이터타입(크기)

temp테이블의 salary 컬럼의 크기를 숫자 10으로 변경
desc temp;

alter table temp
modify(salary number(10));

desc temp;

 3) 컬럼 삭제 DROP
ALTER TABLE 테이블명
DROP COLUMN 컬럼명;

temp 테이블의 salary 컬럼 삭제
alter table temp
drop column salary;

 4) 컬럼명 변경
ALTER TABLE 테이블명
RENAME COLUMN 기존컬럼명 TO 새컬럼명;

temp 테이블의 id를 temp_id로 변경
alter table temp
rename column id to temp_id;

desc temp;

commit;
--------------------------------------------------------------------------------
--2022-07-06 이어서

9.3 테이블 삭제 -- DROP
DROP TABLE 테이블명;

휴지통 비우기
--PURGE RECYCLEBIN;

9.4. 데이터행 삭제 --TRUNCATE : 조건절 사용 불가
TRUNCATE 테이블명 --구조만 남기도 데이터행 모두 삭제




























