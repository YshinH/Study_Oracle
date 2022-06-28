-----------------------------------------------------------------------------------------------
--실습
--01. 성에 대소문자 무관하게 z가 포함된 성을 가진 사원들이 모두 몇명인지 파악하고자 한다.
--성에 대소문자 무관하게 z가 포함된 성을 가진 사원들의 수를 조회하시오. --5
select count(*) 
from  employees
--where last_name like '%z%' 
--or last_name like '%Z%';
where lower(last_name) like '%z%'

--02. 우리회사 사원들 최고급여와 최저급여 간 급여차를 파악하고자 한다.
--우리회사 최고급여와 최저급여의 급여차를 조회하시오. --21900
select (Max(salary)-min(salary)) 급여차
from employees;

--03. 우리회사에 매니저로 있는 사원들의 수를 파악하고자 한다.
--우리회사 매니저인 사원들의 수를 조회하시오. --18
select count(DISTINCT manager_id)
from employees;

--04. 우리회사 account 업무를 하는 사원들의 급여평균를 조회하시오.
--소수이하 2자리까지 구하시오. --7983.33
select round(avg(salary), 2) 급여평균
from employees
where lower(job_id) like '%account%';

--05. 우리회사 사원들의 사번, 성, 부서코드, 급여 조회하여 부서코드 순으로 정렬한다.
select employee_id, last_name, department_id, salary 
from employees
order by department_id;


--06. 부서코드 50번 부서의 급여평균를 조회, 소수이하 2자리 --3475.56
select round(avg(salary), 2) 급여평균
from employees
where department_id = 50;

-----------------------------------------------------------------------------------------------
--[연습문제 4-2]
--01. 우리회사 사원들 중 커미션을 받는 사원들이 모두 몇명인지 파악하고자 한다.
--커미션을 받는 사원의 수를 조회 --35
select COUNT(*)
from employees
where commission_pct is not null;




--02. 우리회사 사원들 중 가장 먼저/나중에 입사한 사원의 입사일자 조회 --01/01/13	08/04/21
select min(hire_date), max(hire_date)
from employees;




--03. 우리회사 부서코드 90번인 부서에 속한 사원들의 급여평균 조회, 소수이하 2자리 --19333.33
select round(avg(salary), 2) 급여평균
from employees
WHERE department_id = 90;


-----------------------------------------------------------------------------------------------










