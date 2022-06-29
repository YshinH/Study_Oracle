5.6 ANSI JOIN

ANSI JOIN 은 모든 DBMS에서 공통적으로 사용할 수 있는 국제 표준 JOIN 형식이다.

--INNER JOIN
INNER JOIN은 오라클의 EQUI JOIN과 같은 기능을 하는 JOIN 형식이다.
FROM 절에 INNER JOIN을 사용하고 JOIN 조건은 ON 절에 명시한다.

[예제 5-12] 사원의 사번, 이름, 부서코드, 부서명 정보를 조회한다.
select e.employee_id, e.first_name, e.department_id, d.department_name
from  employees e, departments d
where e.department_id = d.department_id(+);

ANSI JOIN ON
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e INNER JOIN departments d
on e.department_id = d.department_id;

ANSI JOIN USING
select e.employee_id, e.first_name, department_id, d.department_name
from employees e INNER JOIN departments d
using (department_id);  --컬럼명이 동일할때만 USING 사용, 테이블명 삭제

--------------------------------------------------------------------------------
오라클 조인                           | ANSI 조인
--------------------------------------------------------------------------------
5.select    컬럼명1, 컬럼명2,...      | select    컬럼명1, 컬럼명2,...
1.from     테이블명1, 테이블명2,...   | from     테이블명1 INNER JOIN 테이블명2,...
2.where     조인조건식                | ON       조인조건식
                                      | (또는)
                                      | USING    (조인컬럼명만)
                                      |
  and       일반조건식                | where    일반조건식 --ON, USING 다음에 WHERE 사용
3.group by                            | group by
4.having                              | having
6.order by                            | order by
--------------------------------------------------------------------------------

[예제 5-14] 80번 부서원의 사번, 이름, 부서코드, 부서명을 조회한다.
오라클 조인
ANSI JOIN ON
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e INNER JOIN departments d
on e.department_id = d.department_id
where e.department_id = 80;

ANSI JOIN using
select e.employee_id, e.first_name, department_id, d.department_name
from employees e INNER JOIN departments d
using (department_id)
where department_id = 80;

JOIN 에 사용하는 테이블이 3개 이상일 경우
첫 번째 JOIN의 결과에
두 번째 JOIN을 추가하는 형태로 JOIN 형식을 사용한다.

[예제 5-15] 사원의 사번, 이름, 부서코드, 부서명, 위치코드, 도시 정보를 조회환다.
--<ANSI JOIN ON>
select e.employee_id, e.first_name, e.department_id, d.department_name, d.location_id,
       l.city
from employees e INNER JOIN departments d
on e.department_id = d.department_id
inner join locations l
on d.location_id = l.location_id;

--<ANSI JOIN USING>
select e.employee_id, e.first_name, department_id, d.department_name, location_id,
       l.city
from employees e INNER JOIN departments d
using (department_id)
inner join locations l
using (location_id);


--OUTER JOIN
OUTER JOIN 은 오라클에서 기호(+)를 사용하는 OUTER JOIN과 같은 기능을 하는 JOIN 형식이다.
FROM 절에 LEFT OUTER JOIN / RIGHT OUTER JOIN 을 사용하고 JOIN 조건은 ON 절에 명시한다.

[예제 5-16] 사원의 사번, 이름, 부서코드, 부서명 정보를 조회한다.
select e.employee_id, e.first_name, d.department_id, d.department_name
from employees e LEFT OUTER JOIN departments d
on e.department_id = d.department_id;

select e.employee_id, e.first_name, department_id, d.department_name
from employees e LEFT OUTER JOIN departments d
using (department_id);

[예제 5-17]
select e.employee_id, e.first_name, d.department_id, d.department_name
from departments d RIGHT OUTER JOIN employees e
on e.department_id = d.department_id;


select e.employee_id, e.first_name, department_id, d.department_name
from departments d RIGHT OUTER JOIN employees e
using(department_id);
