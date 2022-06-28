▎LIKE 조건 연산자
컬럼값들 중에 특정 패턴에 속하는 값을 조회하고자 할 때 LIKE 연산자를 사용한다.
%는 여러 개의 문자열을 나타낸다.
_는 하나의 문자를 나타낸다.

컬럼표현 LIKE 검색문자 + %
성명 LIKE '홍%' ☞ 홍으로 시작하는 모든 것
성명 LIKE '%홍' ☞ 홍으로 끝  나는 모든 것
성명 LIKE '%홍%' ☞ 홍을  포함하는 모든 것

[예제 2-28] 이름이 K로 시작되는 사원들의 사번, 성명, 급여, 전화번호 정보를 조회한다.
SELECT  employee_id emp_id, first_name || ' ' || last_name name,
        salary, phone_number phone
FROM    employees
WHERE   first_name LIKE 'K%';

[예제 2-29] 성이 s로 끝나는 사원의 사번, 성명, 급여, 전화번호 정보를 조회한다.
SELECT  employee_id emp_id, first_name || ' ' || last_name name,
        salary, phone_number phone
FROM    employees
WHERE   last_name LIKE '%s';

[예제 2-30] 이름에 b가 들어가 있는 사원의 사번, 성명, 급여, 전화번호 정보를 조회한다.
SELECT  employee_id emp_id, first_name || ' ' || last_name name,
        salary, phone_number phone
FROM    employees
WHERE   first_name LIKE '%b%';

[예제 2-31] 이메일의 세 번째 문자가 B인 사원의 사번, 성명, 급여, 이메일 정보를 조회한다.
세 번째 문자가 B ☞ __B% ☞ 세번째 문자가 B로 시작하는
SELECT  employee_id, first_name || ' ' || last_name name, salary, email
FROM    employees
WHERE   email LIKE '__B%'; --☞ 세번째 글자가 B인, B앞에 2글자 있는걸로 시작하는

[예제 2-33] 전화번호가 6으로 시작되지 않는 사원의 사번, 성명, 급여, 전화번호 정보를 조회한다.
SELECT  employee_id emp_id, first_name || ' ' || last_name name,
        salary, phone_number phone
FROM    employees
WHERE   phone_number NOT LIKE '6%';
--WHERE   NOT phone_number LIKE '6%';

[예제 2-34] JOB_ID에 _A 가 들어간 사원의 사번, 성명, 급여, 업무코드 정보를 조회한다.
SELECT  employee_id, first_name || ' ' || last_name name, salary, job_id
FROM    employees
WHERE   job_id LIKE '%_A%'; --☞ A앞에 1글자 있는, '_' ☞ 한글자
--------------------------------------------------------------------------------
LIKE 연산자와 함께 사용된 %, _, 를 문자 자체로 인식시키려면
%, _ 앞에 기호문자(\)를 붙이고 옵션을 지정(ESCAPE) 한다. 
--------------------------------------------------------------------------------
SELECT  employee_id, first_name || ' ' || last_name name, salary, job_id --7
FROM    employees
WHERE   job_id LIKE '%\_A%' ESCAPE '\'; --☞ A앞에 1글자 있는, '_' ☞ 한글자



▎NULL 조건 처리
○ NULL ☞ 데이터값이 없는 형태의 표현, 비교불가, 연산불가
--                                    ￣￣￣￣￣￣￣￣￣
** 컬럼표현 IS NULL, ** 컬럼표현 IS NOT NULL, --옳은표현
** 컬럼표현 = NULL , ** 컬럼표현 != NULL,     --틀린표현

SELECT  * --23
FROM    locations;

SELECT  * --17
FROM    locations
WHERE   state_province LIKE '%'; --% : 모든 것, NULL제외

SELECT  * --17
FROM    locations
WHERE   state_province IS NOT NULL; --% : 모든 것, NULL제외

SELECT  location_id, street_address, city, state_province
FROM    locations;

01. 부서배치 받지 않은(department_id IS NULL) 사원들의 
사번, 성, 부서코드, 업무코드, 급여 조회
SELECT  employee_id, last_name, department_id, job_id, salary
FROM    employees
WHERE   department_id IS NULL; --부서배치 받지 않는

02. 커미션을 받는(commission_pct IS NOT NULL) 사원들의
사번, 성, 부서코드, 커미션요율 조회
SELECT  employee_id, last_name, department_id, commission_pct
FROM    employees
WHERE   commission_pct IS NOT NULL; --커미션을 받는

2.4 데이터 정렬

데이터의 결과를 일정한 순서로 정렬하고자 할 때 ORDER BY 절을 사용한다.
오름차순 정렬은 ASC를 사용하고 내림차순 정렬은 DESC를 사용하며 ASC가 기본값이다.
ORDER BY 절은 SELECT문의 가장 마지막에 위치한다.

[예제 2-40] 80번 부서의 사원의 
사번, 이름, 성, 급여, 부서코드 정보에 대해 
이름을 오름차순으로 정렬한다.
SELECT  employee_id 사번, first_name 이름, last_name 성, salary 급여, department_id 부서
FROM    employees
WHERE   department_id = 80
--GROUP BY
--HAVING
--ORDER BY  first_name ASC;  --ORDER BY + 컬럼표현(컬럼명)
--ORDER BY  3 ASC;           --ORDER BY + 컬럼위치(순서번호)
ORDER BY  이름 ASC;        --ORDER BY + ALIAS명
--------------------------------------------------------------------------------
절      항목                               ALIAS
--------------------------------------------------------------------------------
SELECT  필드명                             O  
FROM    테이블명                           O 
WHERE   조건절(일반조건만)                 X 
GROUP BY 그룹지을필명                      X
HAVING  조건절(일반조건, 그룹함수조건)     X
ORDER BY 정렬필드명                        O
--------------------------------------------------------------------------------

[예제 2-42] 60번 부서 사원의 사번, 성, 급여, 연봉을 연봉으로 오름차순으로 정렬한다.
SELECT  employee_id, last_name, salary, salary*12 연봉
FROM    employees
WHERE   department_id = 60
ORDER BY 연봉; --ALIAS
ORDER BY 4;    --컬럼순서
ORDER BY salary*12; --컬럼표현


[예제 2-43] 사원테이블에서 사번, 성, 급여, 부서코드를 조회하는데 
부서는 오름차순, 월급여는 내림차순 정렬하여 사원정보를 조회한다.
SELECT  employee_id, last_name, salary, department_id
FROM    employees
ORDER BY department_id ASC, salary DESC;

 


