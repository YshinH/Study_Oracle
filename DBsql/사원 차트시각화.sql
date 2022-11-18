--세로행을 가로로 회전: pivot
--가로행을 세로로 회전: unpivot

select 1 "01", 2 "02", 3 "03", 4 "04", 5 "05"
from dual;

--세로행
select *
from
(select 1 "01", 2 "02", 3 "03", 4 "04", 5 "05"
from dual)
unpivot (cnt for month in ("01", "02", "03", "04", "05"))
;

--가로행
select *
from
(select *
from
(select 1 "01", 2 "02", 3 "03", 4 "04", 5 "05"
from dual)
unpivot (cnt for month in ("01", "02", "03", "04", "05"))
)
pivot( sum(cnt) for month in ('01', '02', '03', '04', '05') )
;


select department_name
        , sum(decode(unit, 2001, count, 0)) y2001
        , sum(decode(unit, 2002, count, 0)) y2002
        , sum(decode(unit, 2003, count, 0)) y2003
        , sum(decode(unit, 2004, count, 0)) y2004
        , sum(decode(unit, 2005, count, 0)) y2005
        , sum(decode(unit, 2006, count, 0)) y2006
        , sum(decode(unit, 2007, count, 0)) y2007
        , sum(decode(unit, 2008, count, 0)) y2008 
        , sum(decode(unit, 2022, count, 0)) y2022 
from(
     select department_name, to_char(hire_date, 'yyyy') unit, count(employee_id) count
     from employees e inner join 
                (select rank, department_id, '(TOP'||rank ||')'||department_name department_name
                from (select dense_rank() over( order by count(employee_id) desc) rank, department_id
                      from employees
                       where to_char(hire_date, 'yyyy') between 2005 and 2008   
                      group by department_id) e left outer join departments d using(department_id)
                where rank <= 3
                order by rank) r using(department_id)
where to_char(hire_date, 'yyyy') between 2005 and 2008   
group by department_name, to_char(hire_date, 'yyyy')
) e
group by department_name
order by department_name
;

select *
from
(select department_name, to_char(hire_date, 'yyyy') unit, count(employee_id) count
     from employees e inner join 
                (select rank, department_id, '(TOP'||rank ||')'||department_name department_name
                from (select dense_rank() over( order by count(employee_id) desc) rank, department_id
                      from employees
                       where to_char(hire_date, 'yyyy') between 2005 and 2008   
                      group by department_id) e left outer join departments d using(department_id)
                where rank <= 3
                order by rank) r using(department_id)
where to_char(hire_date, 'yyyy') between 2005 and 2008   
group by department_name, to_char(hire_date, 'yyyy')
)
pivot(sum(count) for unit in ('2005' as y2005, '2006' as y2006, '2007' as y2007, '2008'as y2008) )
;


--임시 테이블을 먼저 만든 후 그걸로 검색
with emp as (   
    select department_name, to_char(hire_date, 'yyyy') unit, count(employee_id) count
     from employees e inner join 
                (select rank, department_id, '(TOP'||rank ||')'||department_name department_name
                from (select dense_rank() over( order by count(employee_id) desc) rank, department_id
                      from employees
                       where to_char(hire_date, 'yyyy') between 2005 and 2008   
                      group by department_id) e left outer join departments d using(department_id)
                where rank <= 3
                order by rank) r using(department_id)
    where to_char(hire_date, 'yyyy') between 2005 and 2008   
    group by department_name, to_char(hire_date, 'yyyy')
)
select *
from(
    select department_name, unit, count  from emp
) pivot ( sum(count) for unit in('2005' as y2005, '2006' as y2006, '2007' as y2007, '2008'as y2008) )
;


--채용인원수에 대한 순위, 부서코드를 조회
--1 shipping
--2 sales
select dense_rank() over( order by count(employee_id) desc) rank, department_id
from employees
group by department_id;



--채용인원수 상위 3위에 해당하는 부서
select rank, department_id, '(TOP'||rank ||')' || department_name department_name
from    (select dense_rank() over( order by count(employee_id) desc) rank, department_id
        from employees
        group by department_id) e left outer join departments d using(department_id)
where rank <= 3
order by rank;

--채용인원수 상위 3위에 해당하는 부서의 월별 사원수
select department_name
        , sum(decode(unit, '01', count, 0)) m01
        , sum(decode(unit, '02', count, 0)) m02
        , sum(decode(unit, '03', count, 0)) m03
        , sum(decode(unit, '04', count, 0)) m04
        , sum(decode(unit, '05', count, 0)) m05
        , sum(decode(unit, '06', count, 0)) m06
        , sum(decode(unit, '07', count, 0)) m07
        , sum(decode(unit, '08', count, 0)) m08
        , sum(decode(unit, '09', count, 0)) m09     
        , sum(decode(unit, '10', count, 0)) m10     
        , sum(decode(unit, '11', count, 0)) m11     
        , sum(decode(unit, '12', count, 0)) m12     

from(
     select department_name, to_char(hire_date, 'mm') unit, count(employee_id) count
     from employees e inner join 
                (select rank, department_id, '(TOP'||rank ||')'||department_name department_name
                from (select dense_rank() over( order by count(employee_id) desc) rank, department_id
                      from employees
                      group by department_id) e left outer join departments d using(department_id)
                where rank <= 3
                order by rank) r using(department_id)
group by department_name, to_char(hire_date, 'mm')
) e
group by department_name
order by department_name
;




--채용인원수 상위 3위에 해당하는 부서의 년도별 사원수
select department_name, to_char(hire_date, 'yyyy') unit, count(employee_id) count
from employees e inner join 
                (select rank, department_id, '(TOP'||rank ||')' || department_name department_name
                from (select dense_rank() over( order by count(employee_id) desc) rank, department_id
                      from employees
                      where to_char(hire_date, 'yyyy') between 2005 and 2008
                      group by department_id) e left outer join departments d using(department_id)
                where rank <= 3
                order by rank) r using(department_id)
 where to_char(hire_date, 'yyyy') between 2005 and 2008                
group by department_name, to_char(hire_date, 'yyyy')
;
                2001        2002        2003        2004        2005
Finance          10          2            0         0            2             
Purchasing       0           1            1         0            2
--채용인원수 상위 3위에 해당하는 부서의 년도별 사원수(찐)
select department_name
        , sum(decode(unit, 2001, count, 0)) y2001
        , sum(decode(unit, 2002, count, 0)) y2002
        , sum(decode(unit, 2003, count, 0)) y2003
        , sum(decode(unit, 2004, count, 0)) y2004
        , sum(decode(unit, 2005, count, 0)) y2005
        , sum(decode(unit, 2006, count, 0)) y2006
        , sum(decode(unit, 2007, count, 0)) y2007
        , sum(decode(unit, 2008, count, 0)) y2008 
        , sum(decode(unit, 2022, count, 0)) y2022 
from(
     select department_name, to_char(hire_date, 'yyyy') unit, count(employee_id) count
     from employees e inner join 
                (select rank, department_id, '(TOP'||rank ||')'||department_name department_name
                from (select dense_rank() over( order by count(employee_id) desc) rank, department_id
                      from employees
                      where to_char(hire_date, 'yyyy') between 2005 and 2008
                      group by department_id) e left outer join departments d using(department_id)
                where rank <= 3
                order by rank) r using(department_id)
where to_char(hire_date, 'yyyy') between 2005 and 2008   
group by department_name, to_char(hire_date, 'yyyy')
) e
group by department_name
order by department_name
;


--년도별 채용인원수
--2001  10
--2002  5
select TO_CHAR(hire_date, 'YYYY') unit, count(employee_id) count
from employees
where to_char(hire_date, 'yyyy') between 2001 and 2005
group by TO_CHAR(hire_date, 'YYYY')
order by 1;

--월별 채용인원수
01 5
02 3
...
12 6
select TO_CHAR(hire_date, 'MM') unit, count(employee_id) count
from employees
group by TO_CHAR(hire_date, 'MM')
order by 1;




--부서별 사원수
-- 영업부 10
-- 개발부 5
select department_id, NVL(department_name, '소속없음') department_name, count(employee_id) count
from employees e left outer join departments using(department_id)
group by department_id, department_name
order by 1;

select hire_date
from employees
order by hire_date desc;

