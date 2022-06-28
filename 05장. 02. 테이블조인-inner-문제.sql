--실습
-----------------------------------------------------------------------------------------------
--01. 성에 대소문자 무관하게 z가 있는 성을 가진 사원들의
--사번, 성, 부서코드, 부서명 조회 --5개
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and lower(e.last_name) like '%z%';




--02. 커미션을 받는 사원들의 
--사번, 성, 급여, 커미션요율, 업무제목 조회 --35개
select e.employee_id, e.last_name, e.salary, e.commission_pct, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
and e.commission_pct is not null;


--03. 커미션을 받는 사원들의 
--사번, 성, 급여, 커미션금액, 부서명 조회  --34개
select e.employee_id, e.last_name, e.salary, e.commission_pct, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.commission_pct is not null;


--04. 각 부서에 대한 정보를 파악하고자 한다.
--각 부서의 부서코드, 부서명, 위치코드, 도시를 조회  --27개
--위치코드 : location_id 
--도시명   : city
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

--05. 사번, 성, 부서코드, 부서명, 근무지도시명, 주소 조회  --106개, 조인조건은 table갯수 -1 만큼 필요!!
--주소     : street_address
select e.employee_id, e.last_name, e.department_id, d.department_name, l.city, l.street_address
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;


--06. 사번, 성, 부서코드, 부서명, 업무코드, 업무제목 조회  --106개, 조인조건은 table갯수 -1 만큼 필요!!
select e.employee_id, e.last_name, e.department_id, d.department_name, e.job_id, j.job_title
from  employees e, departments d, jobs j 
where e.department_id = d.department_id
and e.job_id = j.job_id;


--07. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명, 대륙명 조회 --27개, 조인조건은 table갯수 -1 만큼 필요!!
--위치코드 : location_id 
--도시명   : city
--국가코드 : country_id
--국가명   : country_name
--대륙명   : region_name

-----------------------------------------------------------------------------------------------
select d.department_id, d.department_name, d.location_id, l.city, l.country_id, c.country_name, r.region_name
from departments d, locations l, countries c, regions r
where d.location_id = l.location_id   -- 이 방법이 더 기억하기 쉬움 걸고 걸고 걺.
and l.country_id = c.country_id
and c.region_id = r.region_id
order by 1;
--where l.country_id = c.country_id
--and c.region_id = r.region_id
--and l.location_id = d.location_id;










