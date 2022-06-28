8. 문자열에서 특정문자열을 찾아 다른 문자열로 바꿔 반환하는 함수
--단어를 통째로 변환
   : REPLACE(char, search_string [, replace_string])
   : 대체될 문자열에서 생략시 기본값은 null
   
[예제 3-17] You -> We로 통째로 변환
select replace('You are not alone', 'You', 'We') REP1,--We are not alone
       replace('You are not alone', 'not') REP2,--You are__alone
       replace('You are not alone', 'not', null) REP3--You are__alone
from dual;

9. 문자열에서 있는 특정 문자 전체를 다른 특정문자로 하나씩 1:1 대응해서 바꿔
   변환하는 함수
   --단어를 1:1로 변환
      : TRANSLATE(대상문자열, 찾는 문자열, 대체될문자열)
      
[예제 3-18] You -> We     
            Y   -> W
            o   -> e
            u   -> null
select translate('You are not alone', 'You', 'We') REP1,--We are net alene
from dual;      

--<퀴즈>
--<"너는 나를 모르는데 나는 너를 알겠느냐">
--이 문자열을 REPLACE 함수와 TRANSLATE 함수를 사용하여 다음과 같이 변경해 봅시다

--1. REPLACE 함수 사용
-> 나는 나를 모르는데 나는 나를 알겠느냐
select replace('너는 나를 모르는데 나는 너를 알겠느냐', '너', '나') 
from dual;

--2. TRANSLATE 함수 사용
-> 나는 너를 모르는데 너는 나를 알겠느냐
select translate(translate(translate('너는 나를 모르는데 나는 너를 알겠는냐', '너', 'A'), '나','너'), 'A', '나')
       
from dual;

--length 문자열의 길이, 공백까지 포함
[예제 3-20] 
select length('Every Sha-la-la-la') LEN1, --18
       length('무궁화 꽃이 피었습니다') LEN2 --12
from dual;

3.3 날짜 함수 :  날짜와 더불어 시간을 연산 대상으로 한다.
   : 송금, 출결, 회원가입날짜, 결제시간
   
1. 시스템의 현재 날짜를 반환하는 함수 -SYSDATE
다른 함수와는 달리 파라미터가 없다.

select sysdate
from dual;

날짜 +/- 숫자 : 날짜
날짜 - 날짜 : 숫자

select sysdate + 1 tomorrow,
       sysdate - 1 yesterday
from dual;

오늘날짜로부터 30일 이후의 날짜
select sysdate + 30 "30일후"
from dual;

밀리초까지 조회
select systimestamp
from dual;

2) ADD_MONTHS(date, n) :특정날짜로 부터 몇개월 전/ 후의 날짜를 반환하는 함수
 ADD_MONTHS(날짜, +/-개월수)
 
 오늘로부터 6개월 후와 3개월 전의 날짜 조회
select add_months(sysdate, +6) "6개월후",
       add_months(sysdate, -3) "3개월전"
from dual;

3) MONTHS_BETWEEN(date1, date2) : 개월수의 차이를 조회하는 함수
 : date1 > date2 이어야함
 
휴가날짜(2022/08/01)와의 개월 수 조회
select months_between(to_date('2022/08/01'), sysdate) 휴가,
       trunc(months_between(to_date('2022/08/01'), sysdate), 1) 휴가1
from dual;

여러분의 훈련기간 : 2022/04/25 ~ 2022/11/03
지난개월 수
남은개월 수
select trunc(months_between(sysdate, to_date('2022/04/25')),1) "지난개월 수",
       trunc(months_between(to_date('2022/11/03'),sysdate),1) "남은개월 수"
from dual;

4.LAST_DAY(date) : 해당날짜가 포함된 달의 마지막 일자를 반환
select last_day(sysdate) l1,
       add_months(last_day(sysdate), -3) l2,
       add_months('2022/05/31', 1) ㅇㅇ,
     --last_day(add_months(sysdate), -3)  
       add_months(last_day(sysdate), +6) l3
     --last_day(add_months(sysdate), +6)  
from dual;       

5. NEXT_DAY(date, char) : 해당 날짜 이후의 날짜 중 char(요일)로 명시된 요일에 
해당하는 첫번째 날짜 반환
char 에는 요일에 해당하는 문자
일요일, 월요일, 화요일, ...와
약어인 일, 월, 화, ...를 사용할 수 있다.

select next_day(sysdate, '일요일') next1,
       next_day(sysdate, '일') next2,
       next_day(sysdate, 1)   next3
from dual;

3.4 형변환함수
문자화 함수 : TO_CHAR 
숫자화 함수 : TO_NUMBER
날짜화 함수 : TO_DATE
      TO_CHAR        TO_DATE
         ->           ->
숫자          문자          날짜
         <-           <-
      TO_NUMBER      TO_CHAR

1. 숫자화 함수 : TO_NUMBER, 문자 -> 숫자
명시적 형변환
select '12345'             n1,--문자
       TO_NUMBER('12345')  n2,--숫자
       12345               n3 --숫자
from   dual;       


2. 문자화 함수 : TO_CHAR(숫자 날짜)
1) 숫자 -> 문자 : TO_CHAR(대상[, 포맷형식]) ☜ 포맷생략시 단순히 문자로만 변환

 9 : 한자리 숫자, 무효숫자는 공백으로 채우짐, 자릿수가 부족하면 #으로 표시
 0 : 한자리 숫자, 무효숫자는 0으로 채워짐, 자릿수가 부족하면 #으로 표시
 , : 천단위 표시
 L : 통화기호
 
select 123456                            c1,
       to_char(123456)                   c2,
       to_char(123456,'999999')          c3,
       to_char(123456,'9999')            c4,
       to_char(123456,'999,999')         c5,
       to_char(123456,'999,999,999')     c6,
       to_char(123456,'L999,999,999')    c7,
       to_char(123456,'$999,999,999')    c8,
       TRIM(to_char(123456,'$999,999,999'))   c9,--trim함수공백제거
       to_char(123456,'FML999,999,999')    c10--FM 옵션 공백제거
from dual;

select 123456                            c1,
       to_char(123456)                   c2,
       to_char(123456,'000000')          c3,
       to_char(123456,'0000')            c4,
       to_char(123456,'000,000')         c5,
       to_char(123456,'000,000,000')     c6,
       to_char(123456,'L000,000,000')    c7,
       to_char(123456,'$000,000,000')    c8,
       TRIM(to_char(123456,'$000,000,000'))   c9,--trim함수공백제거
       to_char(123456,'FML000,000,000')    c10--FM 옵션 공백제거
from dual;

2)날짜 -> 문자 : TO_CHAR(대상[,표현형식])
표현형식
년 - YEAR : 영문으로 표시, TWENTY TWENTY-TWO
     YYYY : 년도 4자리
     YY   : 년도 2자리
     RRRR : 년도 4자리
     RR   : 년도 2자리
월 - MONTH : 월의 영문표기 모두 표시 --JANUARY, 한글 윈도우여서 변화없음 
     MON   : 3글자로 된 월의 이름    --JAN, 한글 윈도우여서 변화없음
     MM    : 월 2자리, --01, 02
일 - DD    : 일 2자리, --01, 02
요일 - DAY(한글, 월요일)
       DY(한글, 월, 화)
시 - HH : 12시간제
     H24 : 24시각제
분 - MI : 분 2자리
초 - SS : 초 2자리

select to_char(sysdate, 'YYYY-MM-DD DAY DY HH24:MI:SS') c1,
       to_char(sysdate,'YEAR_MONTH_DAY') c2,
       to_char(sysdate,'YYYY_MM_DD') c3,
       to_char(sysdate,'YY_MM_DD DY') c4             
from dual;

3.  날짜화 함수 :  TO_DATE(대상[, 표현형식])
--* TO_DAT에 의해 변환된 날짜는 '/'로만 조회됨

select '220621' d1,
       TO_DATE('220621') d2,
       TO_DATE('220621', 'YY/MM/DD') d3,
       TO_DATE('220621', 'YY-MM-DD') d4,
       TO_DATE('20220621', 'YYYY-MM-DD') d5,
       TO_DATE('2022-06-21', 'YYYY-MM-DD') d6
from dual;

--집접 입력된 날짜는 TO_CHAR로 변환이 안됨
--SYSDATE, hire_date 등 날짜가 입력되어진 컬럼은 TO_CHAR로 변환

select to_date('2022-06-21') d1
       
from dual;

