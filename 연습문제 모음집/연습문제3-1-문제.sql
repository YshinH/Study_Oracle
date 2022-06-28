-----------------------------------------------------------------------------------------------
--[연습문제 3-1]
--01. 사원 테이블에서 부서코드가 100, 110 인 부서에 속한 사원들의
--사번, 성명, 급여, 부서코드, 15%인상된 급여 조회 - 인상된 급여는 정수로 표현
--ROUND, TRUNC, CEIL, FLOOR 함수 모두 사용
--컬럼명은 Increased Salary 로 표시한다.
select   employee_id, first_name || ' ' || last_name, salary, department_id, 
         ROUND(salary + salary*0.15,0) "Increased Salary1",
         ROUND(salary + salary*0.15)   "Increased Salary2",
         TRUNC(salary * 1.15, 0)       "Increased Salary3",
         TRUNC(salary * 1.15)          "Increased Salary4",
         CEIL(salary * 1.15)           "Increased Salary5",
         FLOOR(salary * 1.15)          "Increased Salary6"
from     employees
where    department_id in(100, 110);



----------------------------------------------------------------------------------------------
--[연습문제 3-2]
--1. 사원 테이블에서 이름(first_name)이 A로 시작하는 모든 사원의 이름과 
--이름의 길이를 조회하는 쿼리문을 작성한다.
select length(first_name) 길이, first_name
from employees
where first_name LIKE 'A%'

--2. 80번 부서원의 이름과 급여를 조회하는 쿼리문을 작성한다.
--단, 급여는 15자 길이로 왼쪽에 $기호가 채워진 형태로 표시되도록한다.
select first_name, lpad(salary,15,'$') 급여
from employees
where department_id = 80;

--3.60번 부서, 80번 부서, 100번 부서에 소속된 사원의 사번, 이름, 전화번호,
--전화번호의 지역번호를 조회하는 쿼리문을 작성한다.
--단, 지역번호의 컬럼은 Local Number 라고 표시하고, 지역번호는 515.124.4169에서
--515, 590.423.4568에서 590, 011.44.1344.498718에서 011 이 지역번호라 한다.
select employee_id, last_name, phone_number, substr(phone_number,1,instr(phone_number,'.')-1) "Local Number", 
       substr(phone_number, instr(phone_number,'.',-1)+1) private_number
from employees
where department_id in(60,80,100);







