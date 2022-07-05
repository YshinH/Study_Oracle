-----------------------------------------------------------------------------------------------
[연습문제 6-4]

01. 급여가 적은 상위 5명 사원의 
순위, 사번, 이름, 급여를 조회하는 쿼리문을 
ROWNUM 과 DENSE_RANK()를 사용한 인라인뷰 서브 쿼리를 사용하여 작성

급여 하위 5명의 순위, 사번, 이름, 급여 조회

--ROWNUM
급여오름차순 테이블
select rownum, e.*
from (SELECT employee_id, first_name, salary
from employees order by salary asc) e
where rownum <=5;

--DENSE_RANK()
SELECT e.* 
FROM  (SELECT DENSE_RANK() OVER(ORDER BY salary ASC) rank,
       employee_id, first_name, salary
       from employees) e
where e.rank <=5;


-----------------------------------------------위와 같은것
급여 하위 5명의 순위, 사번, 이름, 급여 조회

1. ROWNUM 사용
select rownum, e.*
from (select employee_id, first_name, salary
      from employees order by salary asc) e
where rownum <= 5;

2. DENSE_RANK()사용
SELECT e.* 
FROM  (SELECT DENSE_RANK() OVER(ORDER BY salary ASC) rank,
       employee_id, first_name, salary
       from employees) e
where e.rank <=5;



02. 부서별로 가장 급여를 많이 받는 사원의 
사번, 이름, 부서코드, 급여, 업무코드를 조회하는 쿼리문 
인라인 뷰 서브 쿼리를 사용하여 작성
다중컬럼 서브쿼리를 사용하여 작성

--1. 인라인뷰 서브쿼리  가짜로 설정한 테이블
select e.employee_id, e.first_name, e.department_id, e.salary, e.job_id
from employees e, (select max(salary) max_sal, department_id
                  from employees group by department_id) m
where e.salary = m.max_sal
and NVL(e.department_id,0) = NVL(m.department_id,0)
order by e.department_id;


--2. 다중컬럼 서브쿼리
select e.employee_id, e.first_name, e.department_id, e.salary, e.job_id
from employees e
where (NVL(e.department_id,0), e.salary) in (select NVL(department_id,0), max(salary) max_sal
                                             from employees group by department_id)
order by e.department_id;                                      



-----------------------------------------------------------------------------------------------