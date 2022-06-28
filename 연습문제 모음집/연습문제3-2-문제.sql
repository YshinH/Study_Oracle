-----------------------------------------------------------------------------------------------
--[ 연습문제 3-2 ]                            
--01. 사원 테이블에서 이름(first_name)이 A로 시작하는 
--모든 사원의 이름과 이름의 길이를 조회(LENGTH()함수)하는 쿼리문 작성.
select length(first_name) 길이, first_name
from employees
where first_name LIKE 'A%'


--02. 80번 부서원의 이름과 급여를 조회하는 쿼리문을 작성한다.
--단, 급여는 15자 길이로 왼쪽에 $ 기호가 채워진 형태로 표시되도록 한다.
select first_name, lpad(salary,15,'$') 급여
from employees
where department_id = 80;



--03. 60번 부서, 80번 부서, 100번 부서에 소속된 사원의 
-- 사번, 성, 전화번호, 전화번호의 지역번호, 개인번호를 조회하는 쿼리문 작성
-- 단, 개인번호의 컬럼은 private_number, 지역번호의 컬럼은 local_number 라고 표시하고, 
-- 지역번호는 515.124.4169 에서 515, 
--            590.423.4568 에서 590, 
--            011.44.1344.498718 에서 011 이 지역번호라 한다.
--
-- 개인번호는 515.124.4169 에서 4169, 
--            590.423.4568 에서 4568, 
--      011.44.1344.498718 에서 498718 이 개인번호라 한다.
--                    
--부서코드가 60,80,100 인 부서에 속한 사원들의 
--사번, 성, 전화번호, 지역번호, 개인번호 조회하는 쿼리문 작성
select employee_id, last_name, phone_number, substr(phone_number,1,instr(phone_number,'.')-1) "Local Number", 
       substr(phone_number, instr(phone_number,'.',-1,1)+1) private_number
from employees
where department_id in(60,80,100);

select *
from employees;


--★★★★★★★★★★★★★★★★★결과
--                             local_number  private_number 
--박문수  515.124.4567         515           4567
--임꺽정  011.44.1344.467268   011           467268 
--홍길동  02.1234.5678         02            5678
--전우치  062.9874.5422        062           5422
--심청    0652.4523.6221       0652          6221

--04. JOBS 테이블에서 업무코드, 업무제목, 직무, 직책 조회
--직무, 직책은 업무코드에서 '_'기준으로 조회(직무_직책)
select *
from jobs;

select job_id, job_title, substr(job_id, 1, instr(job_id, '_')-1) 직무,
       substr(job_id, instr(job_id, '_')+1) 직책
from jobs;       

-----------------------------------------------------------------------------------------------




