6장. 서브쿼리(Sub Query)
SQL 문장 안에 존재하는 또 다른 SQL 문장을 서브쿼리라 한다.
서브쿼리는 괄호로 묶어 사용하고 서브쿼리가 포함된 쿼리문을 메인쿼리라 한다.

--서브쿼리는 단일 행 또는 복수행 비교 연산자와 함께 사용 가능
--서브쿼리에서는 ORDER BY 구문을 사용하지 못함
--ORDER BY는 메인쿼리의 문장의 마지막에 하나만 위치할 수 있다.
--서브쿼리의 결과는 메인쿼리의 조건으로 사용
--서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계
--서브쿼리는 연산자 오른쪽에 사용
--여러번의 쿼리를 수행해야만 얻을 수 있는 결과를 하나의 중첩된 sql 문장으로 
--간편하게 구함

   <서브쿼리 사용이유>
--1. 알려지지 않은 기준을 이용한 검색을 위해

--   테이블내에서 조건을 설정하기 어려워 다른테이블에서 조건들 가져와야 할 경우
--   단일 SELECT 문으로 조건식을 만들기에는 조건이 복잡할때
--   또는 완전히 다른 테이블에서 데이터 값을 조회하여 메인 쿼리의 조건으로 사용하고자 할 경우

--2. DB접근하는 속도를 향상 시킴

--   서브쿼리가 사용가능 한 곳  /group by에선 사용못함
SELECT   절
FROM
WHERE    제일 많이 사용
HAVING
ORDER BY

INSERT   절의 VALUE 절
UPDATE   절의 SET 절 : 두번째로 많이 씀

--서브쿼리의 유형
1) 단일 행 서브쿼리 : 하나의 결과 행을 반환하는 서브쿼리
2) 다중 행 서브쿼리 : 둘 이상의 결과 행을 반환하는 서브쿼리
3) 다중 컬럼 서브쿼리 : 둘 이상의 컬럼을 반환하는 서브쿼리
3) 상호연관 서브쿼리 : 메인쿼리의 컬럼이 서브쿼리의 조건으로 사용되는 서브쿼리
5) 스칼라 서브쿼리 : SELECT 절에 사용되는 서브쿼리
6) 인라인 뷰 : FROM 절에 사용되는 서브쿼리


※ 서브쿼리의 위치에 따른 명칭
6.1. SELECT 절에서 사용하는 서브쿼리
   ○ 스칼라 서브쿼리 : SQL 에서는 단일값을 스칼라값이라 함
   Scalar : (크기)하나, Vector : 크기와 방향 
   SELECT 문에서 서브쿼리를 사용하여 하나의 컬럼처럼 사용하기 위한 목적(컬럼 표현 용도)
   조인의 대체 표현식으로 자주 사용
   
   ○ 상호연관 서브쿼리 :서브쿼리 내에서 메인 쿼리의 컬럼을 사용하는 것
   
6.2. FROM 절에서 사용하는 서브쿼리
   ○ INLINE VIEW 서브쿼리
   SELECT 절에서 결과를 FROM 절에서 하나의 테이블처럼 사용(테이블 대체 용도)
   인라인 뷰 서브쿼리에는 ORDER BY 절은 올 수 없음.
   (출력용도가 아닌 테이블처럼 사용하므로 굳이 정렬할 필요가 없음)
--   ※ 중요 : 인라인 뷰 서브쿼리에서 그룹함수는 반드시 ALIAS 지정해야 함
   왜냐하면 ALIAS 를 지정함으로써 하나의 컬럼으로 사용하기때문에

6.3. WHERE 절에서 사용하는 서브쿼리
   ○ 일반 서브쿼리 - 메인 쿼리문 안에 있는 또 다른 쿼리문(WHERE/HAVING 조건절 안에서 사용)
   * 서브쿼리의 SELECT 절의 결과를 하나의 변수 또는 상수처럼 사용
   (조건절은 서브쿼리의 결과에따라 달라짐) ☜ 단일(결과)행인지, 다중(결과)행인지, 
                                             다중컬럼인지에 따라 달라짐
                                             
-- ※중요!! 보통 함수로 구한값과 비교할때, 다른 곳에서 구한값과 비교할때
   1)단일(결과)행 서브쿼리 : 조건절에 사용하는 서브쿼리의 결과행이 단일행인 경우
                             (조건의 결과값을 기준으로 결과가 하나)
   2)다중(결과)행 서브쿼리 : 조건절에 사용하는 서브쿼리의 결과행이 여러행인 경우
                             (조건의 결과값을 기준으로 결과가 여러개)
   3)다중컬럼     서브쿼리 : 조건절에 사용하는 서브쿼리의 결과컬럼이 여러컬럼인 경우
                             (조건의 결과값을 기준으로 컬럼이 여러개)

6.3.1. 조건절(WHERE, HAVING)에 사용하는 단일결과행 서브쿼리, 조건의 결과값을 기준으로 결과가 하나
-- 단일결과행 서브쿼리 연산자 : =, !=, <>, <, >, <=, >=

6.3.2. 조건절(WHERE, HAVING)에 사용하는 다중결과행 서브쿼리, 조건의 결과값을 기준으로 결과가 여러개
--다중 결과행 서브쿼리 연산자 : IN, NOT IN


[문제 01]급여가 우리회사 평균 급여보다 더 적은 급여를 받는 사원의 사번, 이름, 성, 급여 정보를 조회
   

Select employee_id, first_name, last_name, salary
from employees
where salary <=AVG(salary); -- Where 절에서 그룹함수 불가


select employee_id, first_name, last_name, salary --56
from employees
where salary < (select avg(salary) from employees);


[예제 6-1] 평균급여보다 더 적은 급여를 받는 사원의 사번, 이름, 성 정보를 조회한다.
select employee_id, first_name, last_name
from   employees
where  salary <(select avg(salary) from employees)
order by 1;

[예제 6-2] 월급여가 가장 많은 사원의 사번, 이름, 성 정보를 조회한다.
select employee_id, first_name, last_name
from employees
where salary = (select max(salary) from employees);

[예제 6-3] 사번 108번 사원의 급여보다 더 많은 급여를 받는 사원의 
사번, 이름, 급여를 조회한다.
select employee_id, first_name, salary
from employees
where salary > (select salary from employees where employee_id = 108);

[예제 6-4] 월급여가 가장 많은 사원의 사번, 이름, 성, 업무제목 정보를 조회한다.
select e.employee_id, e.first_name, e.last_name, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
and salary = (select  max(salary) from employees);

--6.3.2. 다중(결과행)서브쿼리
: 조건절에 사용하는 서브쿼리의 결과행이 여러행인 경우,
조건의 결과값을 기준으로 결과값이 여러개
- 연산자 : IN, NOT IN(즉 '='을 IN으로 대체한다고 생각)
비교의 대상이 2개이상은 대소비교 불가, 그래서 IN 사용
--WHERE 절에서는 그룹함수 사용 불가
하지만 WHERE 절 안에 있는 서브쿼리에는 그룹함수 사용 가능

01. 부서의 위치코드가 1700인 부서에 속한 사원들의 
사번, 성, 부서코드, 업무코드 조회
select e.employee_id, e.last_name, e.department_id, e.job_id
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 1700;

select employee_id, last_name, department_id, job_id
from employees
where department_id IN (select department_id from departments where location_id = '1700');

1.2 근무지의 국가코드가 UK(즉, country_id = UK)인 위치에 있는
부서코드, 위치코드, 부서명 조회
일반조인
select d.department_id, d.location_id, d.department_name
from departments d, locations l
where d.location_id(+) = l.location_id
and l.country_id = 'UK';

--다중결과행서브쿼리 in
select department_id, location_id, department_name
from departments 
where location_id in (select location_id from locations where country_id = 'UK');

03. 60번 부서원들과 같은 급여를 받는 사원들의
사번, 성, 급여, 부서코드 조회
--서브쿼리
select employee_id, last_name, department_id,salary
from employees
where salary in (select salary from employees where department_id = 60);

--일반쿼리
select distinct(e.employee_id), e.last_name, e.department_id, e.salary
from employees e inner join employees m
on e.salary = m.salary
where m.department_id = 60;

04. 우리회사 사원들 중 부서명이 Marketing이거나 IT에 속한 사원들의 사번, 성, 부서코드 조회

select employee_id, last_name, department_id
from employees
where department_id in (select department_id from departments 
                        where department_name in ('Marketing','IT')); 

22-07-01
--------------------------------------------------------------------------------
--[연습문제 6-2]. 부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호, 급여, 업무코드를
조회하는 쿼리문을 다중 컬럼 서브쿼리를 사용하여 작성한다.
select employee_id, first_name || ' ' || last_name name, department_id, salary, job_id 
from employees
where salary in (select max(salary) from employees group by department_id);

--6.4 상호연관 서브쿼리 : 메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되는 형태

메인쿼리의 값을 서브쿼리에 주고, 서브쿼리의 결과값을 받아서 메인쿼리로 반환해서 수행하는 쿼리
메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되어 메인쿼리에 독집적이지 않은 형태
메인테이블과 서브쿼리 테이블간의 JOIN 조건이 사용됨
메인 쿼리와 서브쿼리가 계속 정보를 주고 받는다는 의미
※ 메인 쿼리의 컬럼이 서브 쿼리의 조건절에 사용되는 상호연관 서브쿼리의 형태로 사용된다.(WHERE 절에서 사용)

 
--6.5. SCALA 서브쿼리 : SELECT 절에 사용, 단일결과행, 단일컬럼만 조회가능

단순한 그룹함수의 결과를 SELECT 절에서 조회하고자 할 때
SELECT 절에 서브쿼리를 사용하여 하나의 컬럼처럼 사용하기 위한 목적(표현용도)
JOIN의 대체 표현으로도 자주 사용
코드성 데이터를 조회하고자 할 때
조인 조건식이 필요할 때는 서브쿼리 안에서 WHERE 조건식 사용
 

--6.6. FROM 절에 사용하는 INLINE VIEW 서브쿼리 : SELECT 절의 결과를 FROM 절에서 하나의 테이블 처럼 사용(테이블 대체 용도)

FROM 절에 사용하는 INLINE VIEW 서브쿼리에서 그룹함수는 반드시 ALIAS 로 지정해야함
메인 쿼리에서 ALIAS 명을 컬럼명으로 사용하기 위해



--------------------------------------------------------------------------------
22-07-04

6.3 다중 컬럼 서브쿼리
서브쿼리도 메인쿼리처럼 여러 개의 컬럼을 사용할 수 있다.
다중컬럼을 pair(쌍) 의 형태로 비교한다.

01. 부서별로 가장 많은 급여를 받는 사원의 부서코드, 최대급여 조회
select department_id, max(salary)
from employees
group by department_id
order by department_id;

02. 부서별로 가장 많은 급여를 받는 사원의 부서코드, 최대급여, 이름 조회
select department_id, max(salary),first_name----XXX
from employees
group by department_id, first_name
order by department_id;

--NULL까지 포함

select   e.department_id, e.salary, e.first_name --12
from     employees e
where    (NVL(e.department_id,0), e.salary) in (select NVL(department_id, 0), max(salary) max_sal
                                         from employees
                                         group by department_id)
order by e.department_id;

03.부서별로 가장 많은 급여를 받는 사원의 사번, 성명, 부서코드, 최대급여, 업무코드
조회
select e.employee_id, e.first_name || ' ' || e.last_name name, e.salary, e.job_id, e.department_id --12
from employees e
where(NVL(e.department_id,0), e.salary) in (select NVL(department_id,0), max(salary) max_sal
                                     from employees
                                     group by department_id)
order by e.department_id;

6.5 스칼라(Scalar)서브쿼리 --단일값
스칼라 서브쿼리는 SELECT 절에 사용되는 서브쿼리 형식이다.
코드성 테이블에서 코드명(컬럼명)을 조회하거나
그룹함수의 결과 값을 조회할 때 많이 사용된다.

1) 단순한 그룹함수의 결과값을 SELECT 절에서 조회하고자 할 경우
01. 각사원의 급여수준을 조회하고자 한다.
모든 사원의 사번, 성, 급여, 회사평균급여, 회사최대급여 조회
select e.employee_id, e.last_name, e.salary, e.avg(salary), e.max(salary)
from employees e
group by e.employee_id, e.last_name, e.salary;--xx

select e.employee_id, e.last_name, e.salary,---다시 확인하자
      (select round(avg(salary),2)
      from employees) avg_sal
      (select max(salary)
      from employees) max_sal--ooo
from employees e;

02. 모든 사원의 사번, 성, 부서코드, 업무코드, 업무제목 조회
(스칼라 서브쿼리로 업무제목 구하기)
일반쿼리
select e.employee_id, e.last_name, e.department_id, e.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id(+);

스칼라서브쿼리
select e.employee_id, e.last_name, e.department_id, e.job_id,
      (select j.job_title
      from jobs j
      where e.job_id = j.job_id(+)) job_title
from employees e;

03.각 부서에 대해 부서코드, 부서명, 도시를 조회
(도시를 스칼라서브쿼리로 구하기)
일반쿼리
select d.department_id, d.department_name, l.city
from departments d, locations l
where d.location_id = l.location_id;


스칼라서브쿼리
select d.department_id, d.department_name,
      (select l.city 
       from locations l
       where l.location_id = d.location_id) city
from departments d;

04. 모든 부서별 부서코드, 부서평균 급여 조회
일반쿼리
select department_id, round(avg(salary),2)
from employees
group by department_id;

스칼라서브쿼리
select e.department_id, 
      (select round(avg(salary))
      from employees s
      where s.department_id = e.department_id
      GROUP BY department_id) avg_sal
from employees e;

6.6 인라인 뷰(Inline View)
인라인 뷰는 FROM 절에 사용되는 서브쿼리 형식이다.
쿼리가 실행될 때 생성되었다가 사라지는 임시성 뷰라 할 수 있다.
메인쿼리에 독립적이고 WHERE 절에서 메인쿼리의 테이블과 JOIN 을 통해 관계를 맺는다.
FROM 절에 사용하는 인라인뷰 서브쿼리에서 그룹함수는 반드시 ALIAS 지정해야 함
메인쿼리에서 ALIAS 명을 컬럼명으로 사용하기 위해

1. 우리회사 사원들의 급여 정보를 관리하는 테이블이 있다.
우리회사 최대급여, 최소급여 평균급여를 조회
SELECT MAX(salary) max_sal, MIN(salary) min_sal, ROUND(AVG(salary),2) avg_sal
FROM employees e;

1. 우리회사 사원들의 급여 정보를 관리하는 테이블이 있다.
사번, 성, 급여, 우리회사 최대급여, 최소급여 평균급여를 조회
select e.employee_id, e.last_name, e.salary,
       MAX(salary) max_sal, MIN(salary) min_sal, ROUND(AVG(salary), 2) avg_sal
from employees e
group by e.employee_id, e.last_name, e.salary;---XXX
      
스칼라서브쿼리
SELECT e.employee_id, e.last_name, e.salary,
      (select MAX(salary) from employees) max_sal,
      (select MIN(salary) from employees) min_sal,
      (select ROUND(AVG(salary),2) from employees) avg_sal
FROM employees e;

--인라인뷰로 가는 과정 //테이블 만들어서 사용하는게 인라인뷰
우리회사 최대급여, 최소급여, 평균급여
select MAX(salary) max_sal, MIN(salary) min_sal, ROUND(AVG(salary), 2) avg_sal
from employees eㅣ -- 결과가 하나 나왔지만 그래도 테이블

SELECT e.employee_id, e.last_name, e.salary, m.max_sal, m.min_sal, m.avg_sal
FROM employees e, (select MAX(salary) max_sal, MIN(salary) min_sal, 
                   ROUND(AVG(salary), 2) avg_sal
                   from employees) m;

03. 각부서별로 가장 많은 급여를 받는 사원들의 사번, 성, 부서코드, 급여 조회
--다중컬럼 서브쿼리
select e.employee_id, e.last_name, e.department_id, e.salary
from employees e
where (NVL(e.department_id, 0), e.salary) in
      (select NVL(department_id, 0), max(salary) max_sal
       from employees
       group by department_id)
order by e.department_id;

--인라인뷰 서브쿼리
select e.employee_id, e.last_name, e.department_id, e.salary
from employees e,
    (select max(salary) max_sal, department_id 
     from employees group by department_id) m
where e.salary = m.max_sal
and e.department_id = m.department_id
order by department_id; 

[예제 6-24] 급여가 회사 평균급여 이상이고 최대급여 이하인 사원의
사번, 이름, 급여, 회사평균급여, 회사최대급여를 조회한다.
--스칼라서브쿼리
select e.employee_id, e.first_name, 
      (select round(avg(salary)) from employees ) avg_sal,
      (select max(salary) from employees ) max_sal
from employees e
where salary between (select round(avg(salary)) from employees )
             and (select max(salary) from employees );


--인라인뷰 서브쿼리
SELECT employee_id, first_name, salary, avg_sal, max_sal
from employees,
     (select round(avg(salary)) avg_sal, max(salary) max_sal
     from employees) 
where salary between avg_sal and max_sal;

--선생님답
SELECT e.employee_id, e.first_name, e.salary, m.avg_sal, m.max_sal
from employees e,
     (select round(avg(salary)) avg_sal, max(salary) max_sal
     from employees) m
where e.salary between m.avg_sal and m.max_sal;

04. 각 부서별로 가장 많은 급여를 받는 사원들의 
   사번, 성, 부서코드, 급여 조회
--다중컬럼 서브쿼리  12
select e.employee_id, e.last_name, e.department_id, e.salary
from employees e
where (e.NVL(department_id,0), e.salary) in 
      (select NVL(department_id,0), max(salary) max_sal from employees group by department_id)
order by e.department_id;

--인라인 뷰 서브쿼리  12
select e.employee_id, e.last_name, e.department_id, e.salary, m.max_sal
from employees e, (select department_id, max(salary) max_sal 
                   from employees group by department_id) m
where salary = m.max_sal
and   NVL(e.department_id,0) = NVL(m.department_id,0)
order by department_id; 


7. 몇개의 데이터행만 조회해보자-------------------------------------------------------------------게시판 사용시 많이 사용
: ROWNUM - 테이블 존재하는 컬럼이지만 가짜 컬럼으로 사용(PSEUDO COLUMN)
  쿼리문의 결과(조회 후, 즉, SELECT 절의 결과)로 나온 각 행에 대한 순서값(중요!!!)
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

서브쿼리에서 먼저 정렬(ORDER BY) 후 메인쿼리에서 순번 매기기(ROWNUM)
--ROWNUM과 인라인뷰의 특성을 사용하여 페이징 처리 하는 기법을 수행

우리회사 사원들의
사번, 성, 급여 조회
SELECT  employee_id, last_name, salary -- 107 
from employees;

--ROWNUM 추가
SELECT ROWNUM, employee_id, last_name, salary -- 107
from employees;

--급여를 많이 받는 순으로 정렬
우리회사 사원들의 
사번, 성, 급여 조회
select rownum, employee_id, last_name, salary -- 107 ----2
from employees    ----1
order by salary desc;----3

우리회사 사원들의 사번순으로 정렬하여 10번까지
사번, 성, 급여 조회
select rownum, employee_id, last_name, salary
from employees
where rownum <= 10
order by salary desc;

--인라인뷰로 해봄--
SELECT ROWNUM, e.*
--FROM   (급여내림차순으로 정렬된 테이블)
FROM  (SELECT employee_id, last_name, salary from employees
       order by salary desc) e
WHERE  ROWNUM <= 10;

<입사일자가 빠른 10명에 대해 사번, 성, 입사일자 조회>
select rownum, e.*
from (select employee_id, last_name, hire_date from employees
      order by hire_date ASC) e
WHERE ROWNUM <= 10;   

---<등수 구하기>
RANK() OVER(ORDER BY 순위결정기준 컬럼)           ☞ 1, 2, 2, 4
DENSE_RANK() OVER(ORDER BY 순위결정기준 컬럼)     ☞ 1, 2, 2, 3

입사일자가 빠른 사원 10명에 대해
사번, 성, 입사일자 조회

입사일자 수 오름차순
--SELECT 등수
SELECT  RANK() OVER(ORDER BY hire_date ASC) rank,
         employee_id, last_name, hire_date
FROM employees
ORDER BY hire_date ASC;

--방식1. 10까지만 표시
SELECT RANK() OVER(ORDER BY hire_date ASC) rank,---XXX
         employee_id, last_name, hire_date
FROM employees
WHERE  ROWNUM <= 10  --10개중에서 1~10까지 등수
ORDER BY hire_date ASC;

--방식2. 10까지만 표시
SELECT e.*
FROM  (SELECT RANK() OVER(ORDER BY hire_date ASC) rank,---OOO
               employee_id, last_name, hire_date
      FROM employees
      ORDER BY hire_date ASC) e
WHERE e.RANK <=10;

