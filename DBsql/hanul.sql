select userid, userpw, salt, name from member;
desc member
;
select writer, title, content from notice;

select *
from (select rownum no, n.*
      from (select n.*, name from notice n left outer join member m on n.writer=m.userid
            order by root, step desc) n
      order by no desc) n  
where no between 373 and 382; 


select *
from (select row_number() over(order by root, step desc) no, n.*, name 
      from notice n left outer join member m on n.writer=m.userid) n
where no between 373 and 382      
order by no desc      
;            


select * from member;
