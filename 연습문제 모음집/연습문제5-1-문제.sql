--[ 연습문제 5-1 ]                                                                             
--01. 이름에 소문자 v가 포함된 모든 사원의 사번, 이름, 부서명을 조회하는 쿼리문을 작성한다. --8
select e.employee_id, e.first_name, d.department_name
from  employees e, departments d
where e.department_id = d.department_id 
and first_name like '%v%';


--02. 커미션을 받는 사원의 사번, 이름, 급여, 커미션 금액, 부서명을 조회하는 쿼리문을 작성한다.
--단, 커미션 금액은 월급여에 대한 커미션 금액을 나타낸다. --35
select e.employee_id, e.first_name, e.salary, e.salary*e.commission_pct 커미션금액, d.department_name 
from employees e, departments d
where e.department_id = d.department_id
and e.commission_pct is not null;


--03. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명을 조회하는 쿼리문을 작성한다. --27
select d.department_id, d.department_name, d.location_id, l.city, c.country_id, c.country_name
from  departments d, locations l, countries c
where d.location_id = l.location_id
and l.country_id = c.country_id;


--04. 사원의 사번, 이름, 업무코드, 매니저의 사번, 매니저의 이름, 매니저의 업무코드를 조회하여   
--사원의 사번 순서로 정렬하는 쿼리문을 작성한다. --107
select e.employee_id, e.first_name, e.job_id,
       m.employee_id 매니저사번, m.first_name 매니저이름, m.job_id
from  employees e, employees m
where e.manager_id = m.employee_id(+)
ORDER by e.employee_id;


--05. 모든 사원의 사번, 이름, 부서명, 도시, 주소 정보를 조회하여 사번 순으로 정렬하는 쿼리문을 작성한다. --107
select e.employee_id, e.first_name, d.department_name, l.city, l.street_address
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
order by e.employee_id;

-----------------------------------------------------------------------------------------------
--실습
--01. 모든 사원의 사번, 성명, 업무코드, 매니저사번, 매니저성명, 매니저의 업무코드 조회하여
--사번 순으로 정렬 --107, SELF JOIN
select e.employee_id, e.first_name || ' ' || e.last_name 성명, e.job_id,
       m.employee_id 매니저아이디, m.first_name || ' ' || m.last_name 매니저성명,
       m.job_id 매니저업무코드
from  employees e, employees m 
where e.manager_id = m.employee_id(+)
order by e.employee_id;


--02. 성이 King인 사원들의 사번, 성명, 부서코드, 부서명 조회 --2
select e.employee_id, e.first_name || ' ' || e.last_name 성명, d.department_id,
       d.department_name
from employees e, departments d
where e.department_id = d.department_id
and last_name like '%King%';


--03. 위치코드가 1400 인 도시에는 어느 부서가 있나 파악하고자 한다.
--위치코드가 1400 인 도시명, 부서명 조회 --1
select l.city, d.department_name
from locations l, departments d
where l.location_id = d.location_id
and l.location_id = 1400;


--04. 위치코드 1800 인 곳에 근무하는 사원들의 
--사번, 성명, 업무코드, 급여, 부서명, 위치코드 조회 --2
select e.employee_id, e.first_name || ' ' || e.last_name 성명, e.job_id, e.salary,
       d.department_name, d.location_id
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 1800;


--05. 자신의 매니저보다 먼저 입사한 사원들의  --내입사일자 < 매니저입사일자           -----다시풀기
--사번, 성명, 입사일자, 매니저성명, 매니저 입사일자 조회 --37, SELF JOIN
select e.employee_id, e.first_name || ' ' || e.last_name 성명, e.hire_date,
       m.first_name || ' ' || m.last_name 매니저성명, m.hire_date 매니저입사날짜
from employees e, employees m
where e.manager_id = e.employee_id(+)
and e.hire_date < m.hire_date;      ---여기가 문제


--06. toronto 에 근무하는 사원들의 
--사번, 성, 업무코드, 부서코드, 부서명, 도시 조회 --2
select e.employee_id, e.last_name, e.job_id, e.department_id, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and lower(l.city) = 'toronto';


--07. 커미션을 받는 모든 사원들의 성, 부서명, 위치코드, 도시 조회 --35
select e.last_name, d.department_name, d.location_id, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and e.commission_pct is not null;


--08. 모든 사원의 사번, 이름, 매니저사번, 매니저이름 정보를 조회
--※ 매니저사번, 매니저이름이 NULL 로 조회됐을때 NULL 처리하기
-----------------------------------------------------------------------------------------------
--사번, 성,           매니저사번1, 매니저사번2, 매니저사번3,    매니저사번4,     매니저이름1, 매니저이름2,        매니저이름3   
--매니저사번이 없으면 (null)       0(NVL)       매니저없음(NVL) 매니저없음(NVL2)
--매니저이름이 없으면                                                            (null)       매니저이름없음(NVL) 매니저이름없음(NVL2)
-----------------------------------------------------------------------------------------------
select e.employee_id, e.first_name
       , m.employee_id 매니저사번1
       , NVL(m.employee_id, 0) 매니저사번2
       , NVL(to_char(m.employee_id), '매니저없음') 매니저사번3
       , NVL2(m.employee_id, to_char(m.employee_id), '매니저없음') 매니저사번4
       , m.first_name 매니저이름1
       , NVL(to_char(m.first_name), '매니저이름없음') 매니저이름2
       , NVL2(m.first_name, to_char(m.first_name),'매니저이름없음') 매니저이름3
from employees e, employees m
where e.manager_id = m.employee_id;
-----------------------------------------------------------------------------------------------






