-------------------------------------------------------------------------------------------------
--실습 오라클 조인, ANSI JOIN(JOIN ON, JOIN USING) 까지 --INNER 조인까지만
--
--01. 사번, 성, 부서코드, 부서명, 위치코드, 도시 조회 --106

오라클 조인
select e.employee_id, e.last_name, e.department_id, d.department_name, d.location_id, 
       l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;


ANSI 조인 JOIN ON
select e.employee_id, e.last_name, e.department_id, d.department_name, d.location_id, 
       l.city
from employees e INNER JOIN departments d
on e.department_id = d.department_id
INNER JOIN locations l
on d.location_id = l.location_id;



ANSI 조인 JOIN USING
select e.employee_id, e.last_name, department_id, d.department_name, location_id, 
       l.city
from employees e INNER JOIN departments d
using(department_id)
INNER JOIN locations l
using(location_id);



--02. 사번이 110, 130, 150 인 사원들의 사번, 성, 부서명 조회 --3

오라클 조인
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id in (110, 130, 150);


ANSI 조인 JOIN ON
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e INNER JOIN departments d
on e.department_id = d.department_id
and e.employee_id in (110, 130, 150);

ANSI 조인 JOIN USING
select e.employee_id, e.last_name, department_id, d.department_name
from employees e INNER JOIN departments d
using(department_id)
where e.employee_id in (110, 130, 150);----다시풀기


--03. 사번, 성명, 관리자사번, 관리자 성명, 관리자업무코드 조회 --106, SELF JOIN

오라클 조인
select e.employee_id, e.first_name || ' ' || e.last_name 성명, e.manager_id, 
       m.first_name || ' ' || m.last_name 관리자성명, m.job_id
from  employees e, employees m
where e.manager_id = m.employee_id; 


ANSI 조인 JOIN ON
select e.employee_id, e.first_name || ' ' || e.last_name 성명, e.manager_id, 
       m.first_name || ' ' || m.last_name 관리자성명, m.job_id
from  employees e INNER JOIN employees m
on e.manager_id = m.employee_id; 



ANSI 조인 JOIN USING---- self JOIN은 USING으로 사용할수 없다!!!! 테이블 이름이 다르기 때문에
select e.employee_id, e.first_name || ' ' || e.last_name 성명, e.manager_id, 
       m.first_name || ' ' || m.last_name 관리자성명, m.job_id
from  employees e INNER JOIN employees m
using (manager_id = m.employee_id); 


--04. 성이 king 인 사원의 사번, 성명, 부서코드, 부서명 조회 --2

오라클 조인
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and lower(e.last_name) like 'king';

ANSI 조인 JOIN ON
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e INNER JOIN departments d
ON e.department_id = d.department_id
where lower(e.last_name) like 'king';


ANSI 조인 JOIN USING
select e.employee_id, e.last_name, department_id, d.department_name
from employees e INNER JOIN departments d
using(department_id)
where lower(e.last_name) like 'king';


--05. 관리자 사번이 149 번인 사원의 
--사번, 성, 부서코드, 부서명 조회 --5

오라클 조인
select e.employee_id, e.last_name, e.department_id, d.department_name,e.manager_id
from employees e, departments d
where e.department_id = d.department_id
and e.manager_id = 149;

ANSI 조인 JOIN ON
select e.employee_id, e.last_name, e.department_id, d.department_name,e.manager_id
from employees e INNER JOIN departments d
on e.department_id = d.department_id
and e.manager_id = 149;


ANSI 조인 JOIN USING
select e.employee_id, e.last_name, department_id, d.department_name,e.manager_id
from employees e INNER JOIN departments d
using (department_id)
and e.manager_id = 149;



--06. 위치코드 1400인 도시명, 부서명 조회 --1

오라클 조인
select d.department_name, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.location_id = 1400;


ANSI 조인 JOIN ON
select d.department_name, l.city
from departments d INNER JOIN locations l
ON d.location_id = l.location_id
and d.location_id = 1400;


ANSI 조인 JOIN USING

select d.department_name, l.city, location_id
from departments d INNER JOIN locations l
USING(location_id)
where location_id = 1400; -- d,l 없애기



--07. 위치코드 1800에 근무하는 사원들의 
--사번, 성, 업무코드, 부서명, 위치코드 조회 --2

오라클 조인
select e.employee_id, e.last_name, e.job_id, d.department_name, l.location_id
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and d.location_id = 1800;



ANSI 조인 JOIN ON
select e.employee_id, e.last_name, e.job_id, d.department_name, l.location_id
from employees e INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
where d.location_id = 1800;



ANSI 조인 JOIN USING
select e.employee_id, e.last_name, e.job_id, department_id, d.department_name, location_id
from employees e INNER JOIN departments d
USING (department_id)
INNER JOIN locations l
USING (location_id)
where location_id = 1800;


--08. 성에 대소문자 무관하게 z가 있는 사원들의 
--사번, 성, 부서명 조회 --5

오라클 조인
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and lower(e.last_name) like '%z%';


ANSI 조인 JOIN ON
select e.employee_id, e.last_name, d.department_name
from employees e INNER JOIN departments d
on e.department_id = d.department_id
and lower(e.last_name) like '%z%';



ANSI 조인 JOIN USING
select e.employee_id, e.last_name, d.department_name, department_id
from employees e INNER JOIN departments d
using (department_id)
where lower(e.last_name) like '%z%';


--09. 관리자보다 먼저 입사한 사원의 
--사번, 성, 입사일자, 관리자사번, 
--관리자성, 관리자입사일자 조회 --37

오라클 조인
select e.employee_id, e.last_name, e.hire_date, e.manager_id,
       m.last_name, m.hire_date
from employees e, employees m
where e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

ANSI 조인 JOIN ON---self JOIN은 ON JOIN으로 사용가능! 테이블 이름이 달라도 됨!
select e.employee_id, e.last_name, e.hire_date, e.manager_id,
       m.last_name, m.hire_date
from employees e INNER JOIN employees m
ON e.manager_id = m.employee_id
and e.hire_date < m.hire_date; --where도 가능



ANSI 조인 JOIN USING---- self JOIN은 USING으로 사용할수 없다!!!! 테이블 이름이 다르기 때문에
select e.employee_id, e.last_name, e.hire_date, e.manager_id,
       m.last_name, m.hire_date
from employees e INNER JOIN employees m
using e.manager_id = m.employee_id
where e.hire_date < m.hire_date;


--10. 업무코드가 clerk종류의 업무형태인 사원들의 
--사번, 성, 부서명, 업무제목 조회 --45

오라클 조인
select e.employee_id, e.last_name, d.department_id, d.department_name, j.job_title
from employees e, departments d, jobs j
where d.department_id = e.department_id
and e.job_id = j.job_id
and lower(e.job_id) like '%clerk%'; 

ANSI 조인 JOIN ON
select e.employee_id, e.last_name, e.department_id, d.department_name, j.job_title
from employees e INNER JOIN departments d
on d.department_id = e.department_id
INNER JOIN jobs j
on e.job_id = j.job_id
and lower(e.job_id) like '%clerk%';


ANSI 조인 JOIN USING
select e.employee_id, e.last_name, department_id, d.department_name, job_id, j.job_title
from employees e INNER JOIN departments d
USING(department_id)
INNER JOIN jobs j
USING(job_id)
where lower(job_id) like '%clerk%';


--11. toronto 에 근무하는 
--사번, 성, 부서코드, 부서명, 도시명 조회 --2

오라클 조인
select e.employee_id, e.last_name, e.department_id, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and lower(l.city) like '%toronto%';


ANSI 조인 JOIN ON
select e.employee_id, e.last_name, e.department_id, d.department_name, l.city
from employees e INNER JOIN departments d
on e.department_id = d.department_id
INNER JOIN locations l
on d.location_id = l.location_id
and lower(l.city) like '%toronto%';  --where도 가능


ANSI 조인 JOIN USING
select e.employee_id, e.last_name, department_id, d.department_name, location_id, city
from employees e INNER JOIN departments d
USING (department_id)
INNER JOIN locations l
USING(location_id)
where lower(city) like '%toronto%'; 


-------------------------------------------------------------------------------------------------