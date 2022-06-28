-----------------------------------------------------------------------------------------------
--[연습문제 3-3]
--01. 사원테이블에서 30번 부서의 사번, 성명, 급여, 근무개월수, 근무년수를 조회
--단, 근무개월수는 오늘 날짜를 기준으로 날짜함수를 사용
MONTHS_BETWEEN(date1, date2) : 개월수의 차이를 조회하는 함수

select employee_id, first_name || ' ' || last_name, salary, 
       trunc(months_between(sysdate, hire_date)) 근무개월,
       trunc(months_between(sysdate, hire_date)/12) 근무년수
from employees
where department_id = 30;



--02. 급여가 12000 이상인 사원들의 
--사번, 성명, 급여를 조회하여 급여순으로 정렬한다.
--급여는 공백없이(TRIM, FM) 천단위 기호(,)를 사용하여 표현한다.
--     ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
select employee_id, first_name || ' ' || last_name name, 
       to_char(salary, 'FM999,999,999') 급여1,
       TRIM(to_char(salary,'999,999,999')) 급여2
from employees
where salary > 12000
order by salary;

--03. 2005년 전(2004년까지)에 입사한 사원들의 
--사번, 성명, 입사일자, 입사일의 요일(DAY, DY) 을 조회하여 
--최근에 입사(DESC)한 사원순으로 정렬한다.
select employee_id, first_name || ' ' || last_name name, hire_date, 
      to_char(to_date(hire_date), 'DAY') 요일1,
      to_char(hire_date, 'DY') 요일2
from employees
where hire_date <'2005/01/01'
order by hire_date desc;



-----------------------------------------------------------------------------------------------


