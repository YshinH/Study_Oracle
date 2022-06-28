※ 조건문 : DECODE, CASE ~ END WHEN THEN ELSE

3.6 DECODE 와 CASE

1.1 DECODE : 조건문에 해당하는 함수
   : DECODE(컬럼표현, A, 1, B, 2, 3) ☞ 컬럼표현이 A와 같다면 1, B와 같다면 2, 그것도 아니면 3을 반환
--          ￣￣￣￣￣￣  
--          (컬럼표현이 문자면 문자로 비교, 숫자면 숫자로 비교) 데이터타입비교

--예제 3-36 사번, 성, 부서코드, 급여, 보너스, 조회
보너스
부서코드가 10이면 급여의 10%,
           20이면 급여의 20%,
           30이면 급여의 30%,
           나머지면 급여의 5%
           
DESC  employees; ☜ DEPARTMENT_ID    NUMBER(4)
--<DECODE,>
select employee_id, last_name, department_id, salary
      , DECODE(department_id, 10, salary*0.1, 20
                            , salary*0.2, 30
                            , salary*0.3
                            , salary*0.05) bonus
from     employees;
      
      
--<CASE ~ END WHEN THEN ELSE>
--예제 3-37 사번, 성, 부서코드, 급여, 보너스, 조회
보너스
부서코드가 10이면 급여의 10%,
           20이면 급여의 20%,
           30이면 급여의 30%,
           나머지면 급여의 5%
           
 --CASE ~ END WHEN THEN ELSE          
select employee_id, last_name, department_id, salary
       , CASE department_id
            WHEN 10 THEN salary * 0.1
            WHEN 20 THEN salary * 0.2
            WHEN 30 THEN salary * 0.3
            ELSE salary * 0.05
         END bonus
from   employees;       

 --2. CASE ~ END WHEN 비교연산자 THEN ELSE END          
select employee_id, last_name, department_id, salary
       , CASE
            WHEN department_id = 10 THEN salary * 0.1
            WHEN department_id = 20 THEN salary * 0.2
            WHEN department_id = 30 THEN salary * 0.3
            ELSE salary * 0.05
         END bonus
from   employees;       

1.2 조건문에 해당하는 함수 : CASE ~ END, WHEN THEN ELSE
-> DECODE 보다 더 큰 개념을 가진 조건식이다.

-- ※ DECODE는 동등비교연산만 가능
-- ※ CASE END는 범위연산까지 가능

범위 비교 조건에 따라 데이터 반환할때 사용
동등비교연산
CASE  대상표현
   WHEN 비교값1 THEN 반환값1  --컴마 없음
   WHEN 비교값2 THEN 반환값2  --컴마 없음
   
   ELSE 반환값n
END ALIAS명

범위비교연산(>, <, =, !=, >=, <=)
CASE  
   WHEN 대상표현 범위비교연산자 비교값1 THEN 반환값1  --컴마 없음
   WHEN 대상표현 범위비교연산자 비교값2 THEN 반환값2  --컴마 없음
   
   ELSE 반환값n
END ALIAS명

--예제 3-38
보너스
부서코드가 10~30이면 급여의 10%
부서코드가 40~60이면 급여의 20%
부서코드가 70~100이면 급여의 30%
그외 급여의 5%로 계산

사번, 성, 부서코드, 급여, 보너스 조회
select employee_id, last_name, department_id, salary
      , CASE 
         WHEN department_id >= 10 and department_id <= 30 THEN salary * 0.1
         WHEN department_id BETWEEN 40 and 60 THEN salary * 0.2
         WHEN department_id BETWEEN 70 and 100 THEN salary * 0.3
         ELSE salary* 0.05
        END 보너스1,
        CASE 
         WHEN department_id < 10 then salary * 0.05
         WHEN department_id <= 30 THEN salary * 0.1
         WHEN department_id <= 60 THEN salary * 0.2
         WHEN department_id <= 100 THEN salary * 0.3
         ELSE salary* 0.05
        END 보너스2
from employees;        


