--오라클 조인-
select rownum NO, e.EMPLOYEE_ID 사번, e.FIRST_NAME || ' ' || e.LAST_NAME 이름, e.EMAIL 이메일, NVL(TO_CHAR(e.DEPARTMENT_ID), '정보없음') 부서번호, e.PHONE_NUMBER 휴대전화, 
       NVL(d.DEPARTMENT_NAME, '정보없음') 부서명, c.COUNTRY_NAME || ' ' || l.STATE_PROVINCE || ' ' || l.CITY || ' ' || l.STREET_ADDRESS || ' ' || l.POSTAL_CODE 전체주소,
       NVL(TO_CHAR((select max(salary) from employees s where s.department_id = e.department_id group by s.department_id)), '정보없음') 부서최대급여,
       NVL(TO_CHAR((select min(salary) from employees s where s.department_id = e.department_id group by s.department_id)), '정보없음') 부서최소급여,
       NVL(TO_CHAR((select round(avg(salary)) from employees s where s.department_id = e.department_id group by s.department_id)), '정보없음') 부서평균급여 
from employees e, departments d, countries c, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and l.country_id = c.country_id(+);

--ANSI 조인--
SELECT ROWNUM NO, e.EMPLOYEE_ID 사번, e.FIRST_NAME || ' ' || e.LAST_NAME 이름, e.EMAIL 이메일, NVL(TO_CHAR(e.DEPARTMENT_ID), '정보없음') 부서번호, e.PHONE_NUMBER 휴대전화, 
       NVL(d.DEPARTMENT_NAME, '정보없음') 부서명, c.COUNTRY_NAME || ' ' || l.STATE_PROVINCE || ' ' || l.CITY || ' ' || l.STREET_ADDRESS || ' ' || l.POSTAL_CODE 전체주소,
       NVL(TO_CHAR((select max(salary) from employees s where s.department_id = e.department_id group by s.department_id)), '정보없음') 부서최대급여,
       NVL(TO_CHAR((select min(salary) from employees s where s.department_id = e.department_id group by s.department_id)), '정보없음') 부서최소급여,
       NVL(TO_CHAR((select round(avg(salary)) from employees s where s.department_id = e.department_id group by s.department_id)), '정보없음') 부서평균급여 
FROM EMPLOYEES e LEFT OUTER JOIN DEPARTMENTS d
ON e.department_id = d.department_id
LEFT OUTER JOIN LOCATIONS l
ON d.location_id = l.location_id
LEFT OUTER JOIN COUNTRIES c
ON l.country_id = c.country_id;

