ANSI JOIN
LEFT OUTER JOIN
RIGHT OUTER JOIN
연습문제 5-2
1. 사번이 110, 130, 150인 사원들의 사번, 이름, 부서명 조회

--오라클 조인
select e.employee_id, e.first_name, d.department_id
from employees e, departments d
where e.department_id = d.department_id(+)
and e.employee_id in (110, 130, 150);

--ANSI JOIN ON
select e.employee_id, e.first_name, d.department_id
from employees e left OUTER JOIN departments d
ON e.department_id = d.department_id
where employee_id in (110, 130, 150);

--ANSI JOIN USING
select e.employee_id, e.first_name, department_id
from employees e left Outer join departments d
using(department_id)
where employee_id in (110, 130, 150);

2. 모든 사원의 사번, 성, 부서코드, 업무코드, 업무제목 조회
사번순으로 정렬
--오라클 조인
select e.employee_id, e.last_name, e.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
ORDER BY 1;

--ANSI JOIN ON
select e.employee_id, e.last_name, e.job_id, j.job_title
from employees e left outer join jobs j
on e.job_id = j.job_id
ORDER BY 1;

--ANSI JOIN USING
select e.employee_id, e.last_name, job_id, j.job_title
from employees e left outer join jobs j
using(job_id)
ORDER BY employee_id;

실습
1.모든 사원의 사번, 성, 부서명 조회
--오라클 조인
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);
--ANSI ON
select e.employee_id, e.last_name, d.department_name
from employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;
--ANSI USING
select e.employee_id, e.last_name, d.department_name
from employees e LEFT OUTER JOIN departments d
using(department_id);





<예습>

6.서브쿼리(Sub Query)
SQL 문장 안에 존재하는 또 다른 SQL 문장을 서브쿼리라 한다.
서브쿼리는 괄호로 묶어 사용하고 서브쿼리가 포함된 쿼리문을 메인쿼리라 한다.

[예제6-1] 평균급여보다 더 적은 급여를 받는 사원의 사번, 이름, 성 정보를 조회한다.
select employee_id, first_name, last_name
from employees
where salary < (select avg(salary) from employees);

<서브쿼리의 유형>
1) 단일 행 서브쿼리 : 하나의 결과 행을 반환하는 서브쿼리
2) 다중 행 서브쿼리 : 둘 이상의 결과 행을 반환하는 서브쿼리
3) 다중 컬럼 서브쿼리 : 둘 이상의 컬럼을 반환하는 서브쿼리
4) 상호연관 서브쿼리 : 메인쿼리의 컬럼이 서브쿼리의 조건으로 사용되는 서브쿼리
5) 스칼라 서브쿼리 : select 절에 사용되는 서브쿼리
6) 인라인 뷰 : from 절에 사용되는 서브쿼리

6.1 단일 행 서브쿼리
단일 행 서브쿼리는 단일 행 연산자( =, >, >=, <, <=, <>, !=)와 함께 사용한다.
서브쿼리의 결과 행이 한 행이므로 그룹함수를 사용하는 경우가 많다.

[예제 6-2] 월급여가 가장 많은 사원의 사번, 이름, 성 정보를 조회한다.
select employee_id, first_name, last_name, salary
from employees
where salary = (select max(salary) from employees);

[예제 6-3] 사번 108번 사원의 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 조회한다.
select employee_id, first_name, salary
from employees
where salary > (select salary from employees where employee_id = 108);


