4장. 그룹함수

※ 그룹함수의 종류
1. COUNT       : 입력되는 데이터의 총갯수를 출력
2. SUM         : 입력되는 데이터의 합계를 출력
3. AVG         : 입력되는 데이터의 평균을 출력
4. MAX         : 입력되는 데이터의 최대값을 출력
5. MIN         : 입력되는 데이터의 최소값을 출력

6. ROLLUP      : 입력되는 데이터의 소계 및 총계값을 출력
7. CUBE        : 입력되는 데이터의 소계 및 총계값을 출력(아래에 요약 추가)

8. RANK        : 주어진 컬럼 값의 그룹에서 값의 순위를 계산한 후 순위를 출력
                1, 2, 2, 4
9. DENSE_RANK  : 주어진 컬럼 값의 그룹에서 값의 순위를 계산한 후 순위를 출력
                 동일한 순위를 하나의 건수로 취급하므로 연속된 순위를 보여줌
                1, 2, 2, 3
DENSE : 밀접한

  쿼리문 해석순서                                          ALIAS 사용가능
5 SELECT   필드명1, 필드명2,...                               O
1 FROM     테이블명                                           O
2 WHERE    조건절(일반 조건만, 그룹함수 조건사용 불가)        X
3 GROUP BY 그룹지을 필드명                                    X
4 HAVING   조건절(일반조건, 그룹함수 조건 모두 사용가능)      X
6 ORDER BY 정렬시킬필드명, 필드번호, ALIAS 명                 O

DISTINCT : SELECT 바로 다음에 쓰여 중복을 제거한 결과를 보여줌

부서를 파악
select distinct department_id  --107, DISTINCT : 중복제거
from employees
--ORDER BY department_id ASC; --NULL이 마지막으로 조회
--ORDER BY department_id DESC;  --NULL이 첫번째로 조회

ORDER BY department_id ASC NULLS first; --NULL이 첫번째로 조회
--ORDER BY department_id DESC NULLS last; --NULL이 마지막으로 조회


select department_id --27
from departments;

--------------------------------------------------------------------------------
--<2022년 6월 24일 금요일>

4.2 그룹함수 : 여러 행으로부터 하나의 결과값을 반환
COUNT(컬럼명) ☞ NULL 제외, COUNT(*) ☞ NULL까지 포함

01. 우리회사 사원의 수를 조회
select count(employee_id) 사원수 --107
from employees;

select count(department_id) 부서수106
from employees;

select count(*) 부서수107
from employees;

02. 우리 회사 부서배치 받은 사원의 수를 조회

select count(department_id) 부서배치받은사원수--106, COUNT(필드명)
from employees;

select count(*) 부서배치받은사원수--106, COUNT(필드명)
from employees
where department_id IS NOT NULL;

03. 우리회사부서 조회
select distinct department_id
from  employees
WHERE  department_id IS NOT NULL;

04. 우리회사 매니저인 사원들 조회
select distinct manager_id
from  employees
WHERE  manager_id IS NOT NULL;

05. 우리회사 부서 수 조회
select count(distinct department_id) 부서수
from employees;

06. clerk 종류의 업무를 하는 사원수
select count(*) 사원수
from employees
where lower(job_id) like '%clerk%';

--<SUM : 숫자데이터 컬럼의 전체 합계를 계산하여 그 결과를 반환>
01.우리회사 한달 급여 합계 조회
select --sum(salary) sum_sal
      to_char(sum(salary), 'FM$999,999,999') sum_sal
from employees;


--<MAX 와 MIN>
MAX 함수는 데이터 컬럼에서 가장 큰 값을 반환하고,
MIN 함수는 가장 작은 값을 반환하다.
MAX,MIN 함수에는 모든 데이터유형을 사용할 수 있다.

1. 사원급여 중 최대급여/최저급여
select max(salary) max_sal, min(salary) min_sal
from employees;

2. 사원입사일 중 가장 먼저/나중에 입사한 날짜
select min(hire_date) min_hire, max(hire_date) max_hire
from employees;

3. 사원성 중 가장먼저/나중에 나오는 성
select min(last_name) min_name, max(last_name) max_name
from employees;

--<AVG : 숫자만 가능>
AVG 함수는 숫자데이터 컬럼의 평균값을 계산하여 그 결과를 반환한다.

1. 우리회사 사원들의 급여평균 조회
급여평균은 소수이하 2째자리까지 반올림해서 표현
select round(avg(salary),2) avg_sal
from employees;

4.3 GROUP BY 절 : 특정기준을 두어 기준으로 그룹을 짓고, 그룹별로 하나의 결과를 조회

1. 우리회사 사원들의 사번, 성, 부서코드, 급여를 조회하여 부서코드 순으로 조회
select employee_id, last_name, department_id, salary
from employees
order by department_id;

2.부서코드 50번 부서에 속한 사원들의
부서코드, 업무코드, 급여평균
select department_id, job_id, avg(salary)
from employees
where department_id = 50
group by department_id, job_id;

select  목록에
        그룹함수를 사용한 표현(COUNT, MAX, MIN, AVG, SUM)과
        그룹함수를 사용하지 않은 표현(일반컬럼)이 함께 있다면
반드시 그룹함수를 사용하지 않은 표현(일반컬럼)에 대해서
--                                   ￣￣￣￣￣￣￣￣￣
GROUP BY 절에 기준으로 명시해야한다.
--￣￣￣￣￣￣￣￣￣￣￣￣￣        

4. 우리회사 각 부서별 급여평균을 조회하고자 한다.
각 부서별 부서코드, 급여 평균을 조회
select department_id, round(avg(salary), 2)
from employees
group by department_id;


4.4 HAVING 절
HAVING 절을 사용하여 그룹을 제한하다.
WHERE 절에서 사용하는 조건을 HAVING 절에 사용할 수도 있으나,
그룹함수가 포함되 조건은 HAVING 절에서만 사용할 수 있다.
SELECT
FROM
WHERE    : 조건절(일반조건만 가능)
GROUP BY : 그룹지을 필드명
HAVING   : 조건절(일반조건 + 그룹함수 조건) 반드시 GROUP BY 절 명시된 후 사용가능
ORDER BY

1. 80번 부서의 부서와 급여평균 조회
SELECT   department_id, Round(avg(salary), 2)
FROM     employees
WHERE    department_id = 80
group by department_id;

SELECT   department_id, Round(avg(salary), 2)
FROM     employees
group by department_id
HAVING    department_id = 80;

2. 각 부서별로 소속된 사원의 수가 5명 이하인 부서와 그 수를 조회
select   department_id, count(*)
from     employees
where    department_id is not null
group by department_id
having   count(*) <= 5
ORDER by 1;

--------------------------------------------------------------------------------
< 6월 27일 월요일>

4.5 ROLLUP 과 CUBE
--< ROLLUP >
GROUP BY  절에 ROLLUP 함수를 사용하여 GROUP BY  구문에 의한 결과와 함께
단계별, 소계, 총계 정보를 구할 수 있다.

[예제 4-13] 부서별 사원수와 급여합계, 총계를 조회한다.
select department_id, sum(salary), count(*)
from employees
where department_id is not null
group by rollup(department_id) --총계까지 조회
order by department_id;

[예제 4-14] 부서 내 업무별 사원수와 급여합계, 부서별 소계, 총계를 조회한다.
select count(*) 사원수, sum(salary) 급여합계, department_id, job_id
from employees
where department_id is not null
group by rollup(department_id, job_id)
order by department_id, job_id;



-- < CUBE >
GROUP BY 절에 CUBE 함수를 사용하여 GROUP BY 구문에 의한 결과와
  모든 경우의 조합에 대한 소계, 총계 정보를 구할 수 있다.
--￣￣￣￣￣￣￣￣
[예제 4-15] 부서 내 업무별 사원수와 급여합계, 부서별 소계, 업무별 소계, 총계를 조회한다.
select department_id, job_id, count(*), sum(salary)
from employees
group by cube(department_id, job_id)
order by department_id;
