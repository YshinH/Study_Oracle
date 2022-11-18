--회원관리
desc member;
create table member (
  userid     varchar2(50) constraint member_userid_pk primary key/*회원아이디*/,
  name       varchar2(50) not null/*회원명*/,
  userpw     varchar2(300) not null/*비밀번호*/,
  gender     varchar2(3) default '여' not null/*성별: 남/여*/,
  email      varchar2(50) not null/*이메일*/,
  birth      date /*생년월일*/,
  phone      varchar2(13) /*전화번호*/,
  address    varchar2(300) /*주소*/,
  admin      varchar2(1) default 'N'/*관리자여부Y/N*/
);

insert into member (userid, userpw, name, email, admin)
values ('admin', 'Manager', '관리자', 'admin@hanuledu.co.kr', 'Y');
insert into member (userid, userpw, name, email, admin)
values ('admin2', 'Manager', '운영자', 'admin@hanuledu.co.kr', 'Y');
commit;


--아이디가 admin 인 회원의 존재여부 확인
select count(userid) from member
where userid='admin1';

select userid, userpw, salt, salt_pw, name from member;


select salt from member where userid='sim2022';
alter table member add
 ( social varchar2(1) );
 alter table member add
 ( salt varchar2(300), salt_pw varchar2(300) );


select userid, userpw, salt
from member;
-- userid, userpw, salt 만 사용한다
-- salt 를 사용해 암호화한 비밀번호는 userpw 이다
update member
set userpw = salt_pw;

--salt_pw 컬럼 삭제
alter table member drop column salt_pw;


-- 프로필 이미지url 추가
alter table member add ( profile varchar2(300) );










