3장. 기본 함수(단일결과행)
: 숫자함수, 문자함수, 날짜함수, 형변환함수, 일반함수
   - 함수의 유형 : 단일(결과)행 함수, 다중(결과)행 함수  ☞ 복수행 함수
   - 숫자함수 : ROUND, TRUNC, CEIL, FLOOR 
   - 문자함수 : UPPER, LOWER, TRIM, LTRIM/RTRIM, LPAD/RPAD,
               -- SUBSTR, INSTR, REPLACE, TRANSLATE 활용도 많을예정
   - 날짜함수 : SYSDATE, MONTHE_BETWEEN, ADD_MONTHS, LAST_DAY
   - 형변화함수 : TO_CHAR, TO_NUMBER, TO_DATE
   - 일반함수 : NVL, NVL2, COALESCE, DECODE, CASE~END


3.1 숫자 함수
ABS(n)
ABS 함수는 n의 절대값을 반환하는 함수이다.

<예제 3-1>
SELECT SIGN(32), SIGN(-32), SIGN(0)
FROM dual;

1)반올림 함수 : ROUND(n [, i]), ROUND(숫자, 소수이하/소수이상 자릿수)  --[]모든 프로그램에서 생략가능하다
소수이하/소수이상 자릿수 : 음수지정가능, 생략시 default 0 -> 정수로 표현
소수이하 둘째자리까지 표현 : ROUND(1234.5678, 2) -> 1234.57
소수이하/이상자리수    -3-2-1 0  1 2 3
                        1 2 3 4 .5 6 7 8 9 

select round(1234.56789, 2) r1,  --1234.57
       round(1234.56789, 1) r2,  --1234.6
       round(1234.56789, 0) r3,  --1235
       round(1234.56789)    r4,  --1235  : 정수로 표현, 일단위로 표현
       round(1234.56789, -1) r5, --1230  : -1이면 0이 1개, 십단위로 표현
       round(1234.56789, -2) r6, --1200  : -2이면 0이 2개, 백단위로 표현
       round(1234.56789, -3) r7  --1000  : -3이면 0이 3개, 천단위로 표현 
from dual;

2) 무조건 버림함수 : TRUNC(n [, i]), TRUNC(숫자, 소수이하/소수이상 자릿수)
소수이하/소수이상 자릿수 : 음수지정가능, 생략시 default 0 -> 정수로 표현
소수이하 둘째자리까지 표현 : TRUNC(1234.5678, 2) -> 1234.56
소수이하/이상자리수    -3-2-1 0  1 2 3
                        1 2 3 4 .5 6 7 8 9

select TRUNC(1234.56789, 2) t1,  --1234.56
       TRUNC(1234.56789, 1) t2,  --1234.5
       TRUNC(1234.56789, 0) t3,  --1234
       TRUNC(1234.56789)    t4,  --1234  : 정수로 표현, 일단위로 표현
       TRUNC(1234.56789, -1) t5, --1230  : -1이면 0이 1개, 십단위로 표현
       TRUNC(1234.56789, -2) t6, --1200  : -2이면 0이 2개, 백단위로 표현
       TRUNC(1234.56789, -3) t7  --1000  : -3이면 0이 3개, 천단위로 표현 
from dual;

3) 숫자보다 같거나 큰 정수를 반환하는 함수 : CEIL(n) - 무조건 올림 정수
게시판에서 페이지 나눌때(☞ 페이징처리) 페이지당 10개씩 출력시
0~1 사이에는 무수히 많은 실수
CEIL(0.9999999999999999999999999999) -- > 1
CEIL(0.0000000000000000000000000001) -- > 1
CEIL(0)                              -- > 0
CEIL(12.1)                           -- > 13

4) 숫자보다 같거나작은 정수를 반환하는 함수 : FLOOR(n) - 무조건 내림 정수
게시판에서 페이지 나눌때(☞ 페이징처리) 페이지당 10개씩 출력시
0~1 사이에는 무수히 많은 실수
FLOOR(0.9999999999999999999999999999) -- > 0
FLOOR(0.0000000000000000000000000001) -- > 0
FLOOR(0)                              -- > 0
FLOOR(12.1)                           -- > 12

숫자 데이터를 표현할 수 있는 함수 : ROUND, TRUNC, CEIL, FLOOR
소수점 데이터를 표현할 수 있는 함수 : ROUND, TRUNC
정수 데이터를 표현할 수 있는 함수 : CEIL, FLOOR, ROUND/TRUNC(2번째 파라미터가 0일때)

5) 나머지를 반환하는 함수 : MOD(m,n) MOD(숫자, 나눌숫자)
SELECT   MOD(17, 4)     m1,   --1
         MOD(17, -4)    m2,   --1
         MOD(-17, 4)    m3,   --(-1)
         MOD(-17, -4)   m4,   --(-1)
         MOD(17, 0)     m5    --17
FROM     dual;

                  값         젯수    몫             나머지
  17  /    4  :  17      =    4     4                1
  17  /   -4  :  17      =   -4    -4                1
 -17  /    4  : -17      =    4    -4               -1
 -17  /   -4  : -17      =   -4     4               -1
 17   /    0  :  17      =    0     54645645        17

3.2 문자 함수
1) 대/소문자 변환함수 : UPPER/LOWER(문자)

   01. 문자/날짜 데이터 표현 : '' (홑따옴표)로 묶음
성이 King 인 사원들의 사번, 성, 명 조회
select employee_id, last_name, first_name
from employees
--where last_name = 'King';
--where lower(last_name) = 'king';
where upper(last_name) = 'KING';

   02. 성에 대소문자 무관하게 z가 포함되어 있는 사원들의
사번, 성, 명 조회
select employee_id, last_name, first_name
from employees
--where last_name LIKE '%Z%'
--or    last_name LIKE '%z%';
--where upper(last_name) LIKE '%Z%'
where lower(last_name) LIKE '%z%';

2) 파라미터로 받은 문자열에서 알파벳 단어 단위로
첫글자를 대문자화, 나머지를 소문자화 하여 결과를반환하는 함수 : INITCAP

select initcap('i am a boy') CAP1,
       upper('i am a boy')    CAP2,
       lower('i am a boy')    CAP3
from dual;

select email, initcap(email) initcap,
      first_name, upper(first_name) upper, lower(first_name) lower
from  employees;

3. LPAD(char1, n [, char2]), RPAD(char1, n [, char2])
   : 대상문자열에 채울문자를 채워서 반환하는 함수
   LPAD(대상, 전체크기 [, 채울문자]), RPAD(대상문자, 전체크기 [, 채울문자])
    : 채울문자 생략시 기본값은 공백문자

select lpad('abc', 5, '?') l1,   --??abc
       lpad('abc', 5)      l2,   --__abc
       RPAD('abc', 5, '#') r1,   --abc##
       RPAD('abc', 5)      r2    --abc__      
from   dual;
      
4. 문자 데이터에서 특정문자를 제거하고 반환하는 함수
 : 제거할 문자는 한개만 지정 가능, 생략시 공백
 : --<파라미터 사이에 컴마 없음>--
 : 제거할 위치 생략시 양쪽
 
TRIM([LEADING, TRAILING, BOTH] [trim_car] [FROM] char) 
TRIM([제거할 위치] [, 제거할문자] [FROM] 대상문자)
TRIM([왼쪽, 오른쪽, 양쪽] [제거문자한개] [FROM] 대상문자)

SELECT TRIM('a' FROM 'abcdcbaaaa')         t1,  --bcdcb
       TRIM(LEADING 'a' FROM 'abcdcbaaaa') t2,  --bcdcbaaaa
       TRIM(TRAILING'a' FROM 'abcdcbaaaa') t3,  --abcdcb
       TRIM(BOTH'a' FROM 'abcdcbaaaa')     t4,  --bcdcb
       '    abcdcbaaaaa    '               t5,  --____abcdcbaaaa____
       TRIM('    abcdcbaaaa    ')          t6   --abcdcbaaaa
FROM   dual;

5. 문자 데이터에 특정문자를 제거하고 반환하는 함수
   : 제거할 문자를 여러개 지정 가능
--   ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣   
LTRIM(char1 [, char2]), RTRIM(char1 [, char2])
LTRIM(대상문자열 [, 제거할 문자나열]), RTRIM(대상문자열 [, 제거할문자나열])
 : 제거할문자열 생략시 공백문자
 
select   ltrim('abcdcba', 'a') t1,  --bcdcba
         ltrim('abcdcba', 'ba') t2, -- cdcba
         ltrim('abcdcba', 'ab')  t3,   --cdcba
         rtrim('abcdcba', 'acb') t4,    --abcd
         rtrim('abcdcba', 'adb') t5,    --abcdc
         rtrim('abcdcba', 'bc') t6,    --abcdcba
         rtrim('   abcdcba   ') t7   --    abcdcba(오른쪽 공백을 자름)
from     dual;

6. 문자열에서 --문자열의 일부를 반환(몇번째부터 몇글자)하는 함수
  SUBSTR(char, position [, length])
  SUBSTR(대상문자열, 시작위치 [, 몇글자])
  --position : 음수지정가능 ☜ 오른쪽부터
  --length : 몇글자, 생략시, 문자열의 끝까지 반환
                1   5   9   13 
select substr('You are not alone', 9, 3) STR1,     --not
       substr('You are not alone', 5)    STR2,     --are not alone
       substr('You are not alone', 0, 5) STR3,      --You a
       substr('You are not alone', -5, 3) STR4,      --alo
       substr('You are not alone', -5)    STR5      --alone
from  dual;      

7. 문자열에서 --특정 문자열이 위치한 시작위치를 반환하는 함수
INSTR(char, search_string [, position] [, _th])
INSTR(대상문자열, 찾을문자열 [, 문자열찾는시작위치] [, _몇번째에 해당하는 시작위치])
문자열 찾는 시작위치 : 음수지정가능, 
      --음수지정시 오른쪽부터 왼쪽방향으로 쭉쭉쭉 계속 진행
문자열찾는시작위치, 몇번째거 : 생략가능, 기본값 : 1
              1     7   11 14 17 20    
select instr('Every Sha-la-la-la-la','la') i1, --11   
       instr('Every Sha-la-la-la-la','la', 1, 2) i2, --14   
       instr('Every Sha-la-la-la-la','la', 12, 2) i3, --17
       instr('Every Sha-la-la-la-la','la', 12, 4) i4, --0
       instr('Every Sha-la-la-la-la','la', 12) i5, --14
       instr('Every Sha-la-la-la-la','la', -3, 2) i6, --14
       instr('Every Sha-la-la-la-la','la', -10) i6 --11
from dual;

jobs 테이블에서 업무코드, 업무제목, 직무, 직책 조회
직무와 직책은 업무코드에서 _ 를 기준으로 조회(직무_직책)
select   job_id, job_title
from     jobs;

'_'위치 찾기
select instr(job_id, '_') -- 3
from   jobs;

직무 ☜ '_' 이전까지
직책 ☜ '_' 이후부터 끝까지
SELECT  job_id, 
        SUBSTR(job_id, 1, INSTR(job_id, '_')-1) 직무, 
        SUBSTR(job_id, INSTR(job_id, '_')+1) 직책, 
        job_title
FROM    jobs;

--------------------------------------------------------------------------------
job_id, 직무, 직책, job_title
AD_PRES AD    PRES  President

--------------------------------------------------------------------------------  
자기 이메일에서 id와 서비스제공자를 조회
tlsgid666@naver.com

나의이메일                id            서비스제공자
tlsgid666@naver.com    tlsgid666          naver.com
--------------------------------------------------------------------------------  
'@' 위치 찾기
SELECT  INSTR('tlsgid666@naver.com', '@') --10
FROM    dual;

SELECT  'tlsgid666@naver.com' 나의이메일,                
        SUBSTR('tlsgid666@naver.com', 1, INSTR('tlsgid666@naver.com', '@')-1) id,            
        SUBSTR('tlsgid666@naver.com', INSTR('tlsgid666@naver.com', '@')+1) 서비스제공자
FROM    dual;
 
 --SUBSTR와 INSTR를 활용하여 조회!!!




