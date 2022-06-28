-----------------------------------------------------------------------------------------------
--실습
--01. 부서코드 30, 40, 60인 부서에 속한 사원들의
--사번, 성명, 부서코드, 급여를 조회하여 성명순으로 정렬한다.
select   employee_id, first_name || ' ' || last_name, department_id, salary
from     employees
where    department_id in(30, 40, 60);



--02. 커미션을 받는 사원들의 사번, 성명, 급여, 커미션요율을 조회하여
--커미션요율이 높은 사원부터 낮은 사원순으로 정렬한다.
select   employee_id, first_name || ' ' || last_name, salary, commission_pct
from     employees
where    commission_pct IS NOT NULL
ORDER BY commission_pct desc;


--03. 성명에 대/소문자 무관하게 z 가 있는 사원들의
--사번, 성명 을 조회하여 성명순으로 정렬한다.
select   employee_id, first_name || ' ' || last_name
from     employees
where    first_name || ' ' || last_name LIKE '%Z%'
or       first_name || ' ' || last_name like '%z%';



-----------------------------------------------------------------------------------------------
--[연습문제 2-1]
--01. 사번이 200인 사원의 성명과 부서코드를 조회하는 쿼리문을 작성한다.
select   first_name || ' ' || last_name, department_id
from     employees
where    employee_id = 200;



--02. 급여가 3000에서 15000 사이에 포함되지 않는 사원의 
--사번, 성명, 급여 정보를 조회하는 쿼리문을 작성한다.
--(단, 이름은 성과 이름을 공백문자를 두어 합쳐서 조회한다. 
--예를 들어 이름이 John 이고 성이 Seo 이면  John Seo 로 조회되도록 한다.)
select   employee_id, first_name || ' ' || last_name, salary
from     employees
where    salary BETWEEN 3000 AND 15000;



--03. 부서코드 30과 60 에 소속된 사원의 
--사번, 성명, 부서코드, 급여를 조회하는데, 
--성명을 알파벳순서로 정렬하여 조회하는 쿼리문을 작성한다.
select   employee_id, first_name || ' ' || last_name, department_id, salary
from     employees
where    department_id in(30, 60)
order by first_name || ' ' || last_name asc;


--04. 급여가 3000에서 15000 사이 이면서, 부서코드 30 또는 60에 소속된 사원의 
--사번, 성명, 급여를 조회하는 쿼리문을 작성한다.
--(단, 조회되는 컬럼명을 이름은 성과 이름을 공백문자를 두어 합쳐 name 으로,
--급여는 Monthly Salary 로 조회되도록 한다.)
select   employee_id, first_name || ' ' || last_name name, salary "Monthly Salary"
from     employees
where    salary between 3000 and 15000
and      department_id in(30, 60);



--05. 소속된 부서코드가 없는 사원의 
--사번, 성명, 업무코드를 조회하는 쿼리문을 작성한다.
select employee_id, first_name, last_name, job_id
from  employees
where department_id is null;




--06. 커미션을 받는 사원의 
--사번, 성명, 급여, 커미션을 조회하는데, 
--커미션이 높은 사원부터 낮은 사원 순서로 정렬하여 조회하는 쿼리문을 작성한다. 
select employee_id, first_name|| ' ' || last_name, salary, commission_pct
from employees
where commission_pct is not null
order by commission_pct DESC;


--07. 성명에 대소문자 구분없이 문자 z 또는 Z 가 포함된 사원의 
--사번과 성명(name)을 조회하는 쿼리문을 작성한다.
select employee_id, first_name || ' ' || last_name name
from employees
where last_name LIKE '%Z%'
or    last_name LIKE '%z%';



-----------------------------------------------------------------------------------------------




