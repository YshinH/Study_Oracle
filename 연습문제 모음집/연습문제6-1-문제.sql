------------------------------------------------------------------------
[연습문제 6-1]
01. 우리회사에서 가장 적은 급여를 받는 사원의 
사번, 성, 업무코드, 부서코드, 부서명, 급여 조회 --1
서브쿼리
select e.employee_id, e.last_name, e.job_id, e.department_id, d.department_name, e.salary
from employees e, departments d
where e.department_id = d.department_id(+)
and salary = (select min(salary) from employees);

02. 부서명이 Marketing 인 부서에 속한 사원들의 
사번, 성명, 부서코드, 업무코드 조회 --2
일반쿼리
select e.employee_id, e.first_name || ' ' || last_name, e.department_id, e.job_id
from employees e, departments d
where e.department_id = d.department_id--(+)없어도 됨 이미 부서가 지정됨
and department_name = 'Marketing';

서브쿼리
--1번째 방법
select employee_id, first_name || ' ' || last_name, department_id, job_id
from employees
where department_id = (select department_id from departments where department_name = 'Marketing');

--2번째 방법
select e.employee_id, e.first_name || ' ' || last_name, e.department_id, e.job_id
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = (select department_id from departments where department_name = 'Marketing');


03. 우리회사 사장님보다 먼저 입사한 사원들의 
사번, 성명, 입사일자 조회 --10
사장은 그를 관리하는 매니저가 없는 사원을 말한다
일반쿼리
select employee_id, first_name || ' ' || last_name, hire_date
from employees
where manager_id is null; --03/06/17

select employee_id, first_name || ' ' || last_name, hire_date
from employees
where hire_date < '03/06/17';

--선생님 답
select e.employee_id, e.first_name || ' ' || e.last_name, e.hire_date
from employees e, employees m
--where e.manager_id = m.employee_id(+) --단순히 날짜만 필요하므로 조인조건식 필요없음
--where 내입사일자 < 사장님입사일자
--and   사장님 = 매니저가 없는 사원
where e.hire_date < m.hire_date
and   m.manager_id is null;

서브쿼리
select employee_id, first_name || ' ' || last_name, hire_date
from employees
where hire_date < (select hire_date from employees where manager_id is null);


------------------------------------------------------------------------