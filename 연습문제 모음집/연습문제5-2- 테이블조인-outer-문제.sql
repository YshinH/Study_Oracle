--실습
-----------------------------------------------------------------------------------------------
--01. 관리자 사번이 149인 사원들의 
--사번, 성, 부서코드, 부서명을 조회 --6
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.manager_id = 149;


--02. 성에 대소문자 무관하게 a 가 있는 성을 가진 사원들의 
--사번, 성, 부서명 조회 --56
select e.employee_id, e.last_name, d.department_name
from  employees e, departments d
where e.department_id = d.department_id(+)
and lower(last_name) like '%a%';


--03. 커미션을 받는 사원들의 사번, 성, 부서명, 도시명 조회 --35
select e.employee_id, e.last_name, d.department_name, l.city
from  employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and e.commission_pct is not null;


-----------------------------------------------------------------------------------------------
--SELECT 절에 사용한 ALIAS 명이나 SELECT 절에서의 위치는 
--ORDER BY 절에서만 사용 할 수 있다.
--: WHERE 절, GROUP BY 절, HAVING 절에서는 
--  SELECT 목록의 컬럼 ALIAS 나 컬럼의 위치를 사용할 수 없다.
-----------------------------------------------------------------------------------------------

--04. 부서별 사원들의 정보를 파악하고자 한다.
--부서코드가 60 번 이하인 부서에 대해 부서의 평균급여가 5000 이상인 부서만 
--부서코드, 사원 수, 급여합계, 급여평균, 최대급여, 최저급여, 
--최근입사일자, 최초입사일자 조회 --3
select department_id, count(*), sum(salary) 합계, round(avg(salary), 2) 평균, max(salary) 최대, min(salary) 최저,
      max(hire_date), min(hire_date)
from  employees
where department_id <= 60
GROUP by department_id
having round(avg(salary), 2) >= 5000
order by department_id;

--<참고>
SELECT  e.department_id, COUNT(*) 사원수, 
        SUM(salary) 급여합계,
        ROUND(AVG(salary), 2) 급여평균,
        MAX(salary) 최대급여,
        MIN(salary) 최저급여, 
        MAX(hire_date) 최근입사일자, 
        MIN(hire_date) 최초입사일자
FROM    employees e
GROUP BY e.department_id
HAVING  e.department_id <= 60
AND     ROUND(AVG(salary), 2) >= 5000
ORDER BY e.department_id;


--05. 업무형태(job_id)별로 사원들의 정보를 파악하고자 한다.
--업무형태별로 사원 수가 10명이상인 업무형태에 대해
--업무코드, 업무별사원수, 업무별평균급여, 업무별최대급여, 업무별최소급여, 
--업무별최근입사일자, 업무별최초입사일자 조회 --3
select job_id, count(employee_id), round(avg(salary),2), max(salary), min(salary),
       max(hire_date), min(hire_date)
from employees
group by job_id
HAVING count(*) >= 10
order by job_id;

-----------------------------------------------------------------------------------------------