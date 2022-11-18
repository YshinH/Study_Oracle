--방명록관리
create table board(
id         number constraint board_id_pk primary key,
title      varchar2(1000) not null,
content    varchar2(4000) not null,
writer     varchar2(50) constraint board_writer_fk references member(userid)
                                    on delete cascade, -- on delete set null
writedate  date default sysdate,
readcnt    number default 0
);

create sequence seq_board
start with 1 increment by 1 nocache;


create or replace trigger trg_board
  before insert on board
  for each row
begin
  select seq_board.nextval into :new.id from dual;
end;
/

--방명록에 대한 첨부파일정보 관리
create table board_file(
id       number constraint board_file_id_pk primary key,
board_id number not null constraint board_file_board_fk references board(id)
                                            on delete cascade,
filename varchar2(300) not null,
filepath varchar2(1000) not null
);

create sequence seq_board_file
start with 1 increment by 1 nocache;


create or replace trigger trg_board_file
  before insert on board_file
  for each row
begin
  select seq_board_file.nextval into :new.id from dual;
end;
/

select * from board_file;


select * from board;

select count(*) from board;


select * 
from (select b.*, name, row_number() over(order by b.id) no
	  from board b left outer join member m on b.writer=m.userid) b
where no between  1 and 10
order by no desc
;

select * from board_file;
select id, title from board order by id desc;


select (select count(*) from board_file f where f.board_id=b.id) filecnt, b.* 
from (select b.*, name, row_number() over(order by b.id) no
	  from board b left outer join member m on b.writer=m.userid) b
    ;

select * from board_file 
where board_id= 5;

select * from board_file 
where id in ( 3,4,5 );


insert into board ( title, content, writer )
select title, content, writer from board;

commit;

댓글관리
create table board_comment (
id        number constraint board_comment_id_pk primary key,
content   varchar2(2000) not null,
writer    varchar2(50) constraint board_comment_writer_fk references member(userid) 
                                                              on delete set null,
writedate date default sysdate,
board_id  number constraint board_comment_board_id_fk references board(id)
                                                              on delete cascade
);

create sequence seq_board_comment start with 1 increment by 1 nocache;

create or replace trigger trg_board_comment
  before insert on board_comment
  for each row
begin
  select seq_board_comment.nextval into :new.id from dual;
end;
/

alter table board_comment
add ( board_id  number constraint board_comment_board_id_fk references board(id)
                                                              on delete cascade );




select name, to_char(writedate, 'yyyy-mm-dd hh24:mi:ss') writedate, c.* 
from board_comment c left outer join member m on c.writer = m.userid 
order by id desc;


