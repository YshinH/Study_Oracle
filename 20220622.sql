3.5 NULL 관련 함수

일반함수 : NULL 이 계산되었을 경우 결과 값이 NULL로 변경되어 버림

1. NVL(NULL VALUE) : 대상, NULL일때 반환표현
-- ------------------￣￣￣￣￣￣￣￣￣￣￣
--데이터 유형은 서로 같아야한다.
2. NVL2(대상, NULL이 아닐때 반환표현, NULL일때 반환표현)
-- -----￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
--데이터 유형은 서로 같아야한다.
[예제 3-31]
커미션 금액이 1000 미만인 사원의 
사번, 이름, 급여, 커미션율, 커미션금액을 조회한다.--NVL함수사용
커미션 금액 = 급여 * 커미션요율

select employee_id, first_name, salary, NVL(commission_pct,0) 상여율,
      salary * NVL(commission_pct,0) "커미션 금액"
FROM  employees
where salary * NVL(commission_pct,0) < 1000;

조회된 NULL값을 치환하는 함수 NVL, NVL2(Null VaLue)
NVL(컬럼,0) → 값이 NULL이 아니면(값이 있으면) 컬럼값으로 처리, NULL이면 0으로 처리

NVL2(컬럼, 컬럼값이 NULL이 아닐때 반환표현, 컬럼값이 NULL일때 반환표현)
--   ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

[예제 3-33]
커미션 금액이 1000 미만인 사원의 
사번, 이름, 급여, 커미션율, 커미션금액을 조회한다. -- NVL2사용
커미션 금액 = 급여 * 커미션요율

select employee_id, first_name, salary, NVL2(commission_pct,commission_pct,0) 커미션요율,
      salary * NVL2(commission_pct,commission_pct,0) 커미션금액
FROM  employees
where salary * NVL2(commission_pct,commission_pct,0) < 1000;

--예제 3-33
salary와 커미션금액을 합한 급여가 총급여이므로 커미션을 받지 않으면 salary가 총급여가 된다.
select employee_id, first_name, salary, NVL(commission_pct,0), NVL2(commission_pct,salary + commission_pct,salary) "total_salary"
from employees;


--사번, 성, 급여, 커미션요율, 커미션급액, 총급여 조회
총급여 = 급여 + 상여금
상여금 = 급여 * 상여율

1. NVL
select employee_id, last_name, salary, NVL(commission_pct,0) 상여율,
      salary * NVL(commission_pct,0) 상여금, 
      salary + NVL(salary * commission_pct,0) 총급여
from  employees;

2.NVL2
select employee_id, last_name, salary, NVL2(commission_pct,commission_pct,0) 상여율,
      salary * NVL2(commission_pct,commission_pct,0) 상여금, 
      salary + NVL2(salary * commission_pct, salary * commission_pct, 0) 총급여
from  employees;

--예제 3-34
모든 사원의 사번, 이름, 급여, 커미션급액, 총급여를 조회한다.
select employee_id, first_name, salary, NVL(commission_pct * salary,0) 커미션금액,
       NVL2(commission_pct,salary + commission_pct * salary, salary) 총급여
from   employees;

--3장 그림파일
select employee_id 사번, Last_name 성, salary 급여, 
       NVL(commission_pct, 0) "커미션요율(NVL)",
       NVL(to_char(commission_pct, '0.99'), '커미션요율없음') "커미션요율표시(NVL)",
       NVL2(to_char(commission_pct), to_char(commission_pct, '0.99'),'커미션요율없음') "커미션요율표시(NVL2)",
       salary * NVL(commission_pct,0) "커미션금액(NVL)", 
       salary * NVL2(commission_pct, commission_pct,0) "커미션금액(NVL2)",
       salary + NVL(commission_pct*salary,0) "총급여(NVL)", 
       salary + NVL2(commission_pct*salary,commission_pct*salary,0) "총급여(NVL2)"
from employees;

3. COALESCE(exp1, exp2, exp3,...)
COALESCE 함수는 파라미터 목록에서 첫 번째로 NULL이 아닌 파라미터를 반환
 : 합치다, 유착하다, 합체하다.
----------------------------------------------------------------------
name        cellular       home        office
----------------------------------------------------------------------
홍길동   010-1111-1111                062-555-5555 
심청                    062-222-2222  062-333-3333
전우치                  062-444-4444
홍길순
---------------------------------------------------------------------
select name  이름, coalesce(cellular, home, office) 연락처
from   테이블
---------------------------------------------------------------------
이름     연락처
홍길동   010-1111-1111
심청     062-222-2222
전우치   062-444-4444
홍길순   null
--------------------------------------------------------------------












