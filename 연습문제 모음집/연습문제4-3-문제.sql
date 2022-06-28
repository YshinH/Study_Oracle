-----------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

--실습
--01. 우리회사 사원들의 업무형태(업무코드)별 사원 수를 파악하고자 한다.
--업무형태(업무코드), 사원수 조회
select   job_id, count(*)
from     employees
group by job_id;



--02. 부서별 급여 정보를 파악하고자 한다.
--부서코드, 급여평균 조회- 급여평균이 높은 부서부터 정렬하고
--급여평균는 반올림하여 소수 둘째자리까지 표현.

select department_id, round(avg(salary),2)
from employees
group by department_id
order by round(avg(salary),2) DESC;
--order by 2;



--03. 부서별, 업무별 급여합계를 파악하고자 한다.
--부서코드, 업무코드, 급여합계 조회
select department_id, job_id, sum(salary)
from employees     
group by department_id, job_id;


--04. 부서코드 60번 부서에 속한 사원들의 사원 수를 파악하고자 한다.
--60 번 부서에 속한 사원들의 사원 수를 조회(HAVING 절 사용)
select count(employee_id), department_id
from employees
group by department_id
having department_id = 60;


--05. 부서의 급여평균이 10000 이상인 부서를 파악하고자 한다.
--부서의 급여평균이 10000이상인 부서코드, 급여평균를 조회
--급여평균는 반올림하여 소수 둘째자리까지 표현.
select department_id, round(avg(salary), 2)
from employees
GROUP by department_id
HAVING round(avg(salary), 2) >=10000
order by 1;


--06. 각 부서별 부서코드, 부서원수, 부서급여평균 조회
select department_id, count(employee_id) cnt, round(avg(salary), 2)
from employees
where department_id is not null
group by department_id;



--07. 100번 부서에 대한 정보를 파악하고자 한다.
--100번 부서의 부서코드, 부서원수, 부서급여평균 조회
select department_id, count(*), round(avg(salary), 2)
from employees
group by department_id
having department_id = 100
order by 1;



--08. 각 부서별 정보를 파악하고자 한다.
--각 부서별 부서원수가 15명 이상인 부서에 대해 부서코드, 부서원수, 부서급여평균 조회
select department_id, count(*), round(avg(salary), 2)
from employees
group by department_id
having count(*) >= 15;


--09. 각 부서의 부서급여평균이 8000 이상인 부서에 대해
--부서코드, 부서원수, 부서급여평균 조회
select department_id, count(*), round(avg(salary), 2)
from employees
group by department_id
having round(avg(salary), 2) >= 8000;



--10. 각 부서별 최대급여를 파악하고자 한다. 
-- 각 부서의 최대급여가 10000 이상인 부서코드, 최대급여를 조회. 
select department_id, max(salary)
from employees
GROUP by department_id
having max(salary) >= 10000;



--11. 두 명 이상 있는 성이 어떤 것들이 있나 파악하고자 한다. 
--두 명 이상 있는 성과, 수를 조회
select last_name, count(last_name)
from employees
group by last_name
having count(last_name) >= 2;


--12. 년도별(오름차순)로 입사한 사원 수를 파악하고자 한다. 
--입사년도, 사원 수 조회 - 년도는 2020의 형태로 표현

--입사년도     사원수
--2001	        1
--2002	      	7
--2003	      	6
--2004	      	10
--2005	      	29
--2006	      	24
--2007	      	19
--2008	      	11
select to_char(hire_date, 'YYYY') 입사년도, COUNT(*) 사원수
from employees
group by to_char(hire_date, 'YYYY')
order by to_char(hire_date, 'YYYY') asc;



--13. 각 부서별로 정보를 파악하고자 한다.
--각 부서별 부서코드, 부서원수, 부서급여평균, 부서최고급여, 부서최저급여 조회
select department_id, COUNT(*), round(avg(salary), 2), max(salary), min(salary)
from employees
where department_id is not null
GROUP by department_id;


--14. 각 업무별로 정보를 파악하고자 한다.
--각 업무별 업무코드, 업무하는사원수, 업무급여평균, 업무최고급여, 업무최저급여 조회
select job_id, COUNT(*), round(avg(salary), 2), max(salary), min(salary)
from employees
GROUP by job_id
order by 1;



--15. 각 부서별 부서내 업무별로 부서코드, 업무코드, 사원수, 급여평균 조회
select department_id, job_id, count(*), round(avg(salary), 2)
from employees
where department_id is not null
group by department_id, job_id
order by 1;

-----------------------------------------------------------------------------------------------
--[연습문제 4-3]
--01. 사원테이블에서 똑같은 이름(first_name)이 둘 이상 있는 이름과 그 이름이 모두 몇 명인지를 
--조회하는 쿼리문을 작성한다. 
--이름별로 몇명인지를 구함
select  first_name, count(*)
from employees
group by first_name
having  count(first_name) >= 2
order by 1; 

--02. 부서번호, 각 부서별 급여총액과 급여평균를 조회하는 쿼리문을 작성한다. 
--단, 부서 급여평균이 8000 이상인 부서만 조회되도록 한다.
select department_id, sum(salary), round(avg(salary), 2)
from employees
group by department_id
having avg(salary) >= 8000
order by 1;

--03. 년도별로 입사한 사원수를 조회하는 쿼리문을 작성한다.
--단, 년도는 2014 의 형태로 표기되도록 한다.
select to_char(hire_date, 'YYYY') 입사년도, count(*)
from employees
group by to_char(hire_date, 'YYYY')
ORDER by to_char(hire_date, 'YYYY');
-----------------------------------------------------------------------------------------------







