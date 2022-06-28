5장. JOIN
오라클은 관계형 데이터베이스이다.
JOIN은 여러 테이블을 연결하여 데이터를 조회하는 방법이다.

: 하나의 테이블로부터 데이터를 조회할 수 없는 경우
  여러 테이블로 부터 데이터를 조회하여
  합쳐진 테이블의 데이터를 조회하기 위해 사용

5.1 Cartesian Product
JOIN 조건을 기술하지 않았을 때는 잘못된 결과가 발생하는데 이것을 Cartesian Product라 한다.

사번, 성, 부서명 조회
select employee_id, last_name, department_name
from employees, departments;  --사원수와 부서수를 곱한것이라 절대 안씀

5.2 EQUI JOIN(inner join)
EQUI JOIN은 WHERE 절에 동등 연산자 (=)를 사용하는 JOIN 형식이다.
JOIN 조건은 같은 값을 가진 컬럼에 대해 테이블명.컬럼명 = 테이블명.컬럼명 을 사용한다.
--                                     ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

[예제 5-2] employees, departments 테이블을 사용하여 사번, 이름, 부서명 정보를 조회한다.
select employee_id, first_name, department_name
from employees, departments
where employees.department_id = departments.department_id;

--ALIAS<가독성을 높이기 위해>
select employee_id, first_name, department_name
from employees e, departments d
where e.department_id = d.department_id;


--<조인조건식> ☞ 테이블명.컬럼명 = 테이블.컬러명
                 테이블명.FK     = 테이블명.PK
                 
[예제 5-3]사원들의 사번, 성, 부서코드, 부서명 조회
select e.employee_id, e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;



[예제 5-4] employees, jobs 테이블을 사용하여
사번, 이름, 업무코드, 업무제목 정보를 조회하다.
select e.employee_id, e.first_name, e.job_id, j.job_title
from  employees e, jobs j
where e.job_id = j.job_id;

[예제 5-5] employees, departments, jobs 테이블을 사용하여
사번, 이름, 부서명, 업무제목을 조회한다.
select e.employee_id, e.first_name, d.department_name, j.job_title
from  employees e, departments d, jobs j 
where e.department_id = d.department_id
and e.job_id = j.job_id;

--<WHERE 절에 JOIN 조건과 일반 조건을 함께 사용한다.>

[예제 5-6] 사번이 101번인 사원의 사번, 이름, 부서명, 업무제목 정보를 조회한다.
select e.employee_id, e.first_name, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and e.employee_id = 101;


--------------------------------------------------------------------------------
--<2022-06-28>--

5.3 NON_EQUI JOIN
NON-EQUI JOIN 은 비교연산자(<=, >=, <, >), 범위연산자(BETWEEN), IN연산자 등의
동등 연산자(=) 이외의 연산자를 사용하는 JOIN 형식이다.
JOIN 하는 컬럼이 일치하지 않게 사용하는 JOIN 조건이므로 거의 사용하지 않는다.

5.4 OUTER JOIN 
EQUI JOIN 쿼리문은 JOIN 하는 테이블들 간에 공통으로 만족되는 값을 가진 경우의 결과를 반환
하지만 OUTER JOIN 쿼리문은 만족되는 값이 없는 경우의 결과까지 반환한다.
만족되는 값이 없는 테이블 컬럼에 (+) 기호를 표시한다.
즉, 데이터 행의 누락이 발생하지 않도록 하기 위한 조인기법
   조인조건식에서 (+) 기호를 데이터행이 부족한 조인조건쪽에 붙여준다.
--                ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

--------------------------------------------------------------------------------
사원테이블            부서테이블                        위치테이블
사번  부서코드        부서코드  부서명   위치코드     위치코드   부서위치 
100   10              10        영업부   1600         1600       광주
101   20              20        총무부   1700         1700       서울
178   null            null      null     null         null       null 
--------------------------------------------------------------------------------

[예제 5-8] 모든 사원의 사번, 이름, 급여, 부서코드, 부서명 정보를 조회한다.
Select e.employee_id, e.first_name, e.salary, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); --e는 부서코드가 없고 d도 없지만 배정을 안받은 사원에 대한 null을 표현(+)
                                            --PK에 (+)를 붙여줌
                                            
NULL 확인 방법 -> NULL 의 존재 유무, NULL의 개수 COUNT

--<e.department_id의 NULL의 갯수>
select count(*)
from employees
where department_id is null;

--<d.department_id의 NULL의 갯수> 
-->PK이므로 NULL이 존재할 수 없음
--------------------------------------------------------------------------------
OUTER JOIN ☞ LEFT/RIGHT OUTER JOIN : 기준이 되는 테이블방향으로 조인한다.
 LEFT OUTER JOIN : 왼  쪽 테이블 기준으로 NULL 포함하여 모두 출력(등호의 오른쪽에(+) 붙음)
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
RIGHT OUTER JOIN : 오른쪽 테이블 기준으로 NULL 포함하여 모두 출력(등호의 왼  쪽에(+) 붙음)
--------------------------------------------------------------------------------

02. 모든 사원의 사번, 성, 업무코드, 업무제목 조회
select   e.employee_id, e.last_name, e.job_id, j.job_title
from  employees e, jobs j
where e.job_id = j.job_id(+); --null 값이 아예 없는 쪽에 (+)를 붙여줌

03.모든 사원의 사번, 성, 부서명, 업무제목 조회
select e.employee_id, e.last_name, d.department_name, j.job_title
from employees e, departments d,jobs j
where e.department_id = d.department_id(+)
and e.job_id = j.job_id(+);

04.모든 사원의 사번, 성, 부서코드, 부서명, 위치코드, 도시조회
select e.employee_id, e.last_name, e.department_id, d.department_name, d.location_id, l.city
from  employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);
 ☞ OUTER JOIN 된 테이블은 1개만 지정할 수 있음


5.5 SELF JOIN
SELF JOIN 은 하나의 테이블을 두 번 명시하여 동일한 테이블 두 개로부터 JOIN을 통해
데이터를 조회하여 결과를 반환한다.
즉, 한테이블 내에서 두 데이터 컬럼이 연관관계가 있다.

[예제 5-10] 사원의 사번, 이름, 매니저사번, 매니저이름 정보를 조회한다.
select e.employee_id, e.first_name,
       m.employee_id 매니저아이디, m.first_name 매니저이름
from  employees e, employees m 
where e.manager_id = m.employee_id
order by e.employee_id;













