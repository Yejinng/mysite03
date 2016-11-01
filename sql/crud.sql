-- insert
-- user
insert into users
values( user_seq.nextval, '박예진', 'fdkfjs@naver.com','1234','female');

insert into users
values( user_seq.nextval, '둘리', 'enffl@naver.com','12345','male');

insert into users
values( user_seq.nextval, '또치', 'ehcl@naver.com','123456','male');
-- guestbook
insert into guestbook
	values(guestbook_seq.nextval, '둘리','호이~','1234',sysdate);
	
insert into guestbook
	values(guestbook_seq.nextval, '또치','또또~','2345',sysdate);
	
insert into guestbook
	values(guestbook_seq.nextval, '또치','또또~','2345',sysdate);

-- delete
delete from users;
delete from board ;
delete from guestbook where no =2 and password ='1234';	

commit;

-- select<login>
select no, name from users where email='fdkfjs@naver.com' and password='1234';
select * from users;

select no, name, content, password, to_char(reg_date, 'yyyy-mm-dd hh:mi:ss')
	from guestbook order by reg_date;

-- update
update users set name = '박현진', password = '12345' where email = 'dkj@naver.com';
update board set name = '박현진', password = '12345' where email = 'dkj@naver.com';

rollback;

-- board

--view
select no, title, content from board where no = 30;
update board set hit = hit + 1 where no = 30;	 -- 조회수 늘리기

-- list
select * from board;

select count(*) from board;

select * from (select rownum as rn, no, title, hit, reg_date, name, users_no from (select a.no, a.title, a.hit, to_char(reg_date, 'yyyy-mm-dd hh:mi:ss')as reg_date, b.name, a.USERS_NO from board a, users b	where a.USERS_NO = b.NO	order by group_no desc, order_no asc)) where (3-1)*5+1 <= rn and rn <= 3*5;
	
select a.no, a.title, a.hit, to_char(reg_date, 'yyyy-mm-dd hh:mi:ss'), b.name
	from board a, users b	where a.USERS_NO = b.NO	
-- 검색인경우  and title like '%ked%' or content like'%kwd%'	
	order by group_no desc, order_no asc;
	
-- insert1 (새글)
insert into board 
	values(board_seq.nextval,'안녕','내용도 안녕',sysdate,0,nvl((select max(group_no)from board),0)+1,1,0,2);
insert into board 
	values(board_seq.nextval,'점심 뭐먹을래?','나는 짬뽕',sysdate,0,nvl((select max(group_no)from board),0)+1,1,0,2);
insert into board 
	values(board_seq.nextval,'배고파...','그만말해',sysdate,0,nvl((select max(group_no)from board),0)+1,1,0,2);

select max(group_no) from board;

-- insert2 (답글)
update board set order_no=order_no + 1
	where group_no = 2 and order_no > 1;
insert into board 											
	values(board_seq.nextval,'나두 짬뽕!!','^~^',sysdate,0,
			2, -- 부모글의 그룹
			2, -- 부모글 순서 +1
			1, -- 부모글 싶이 +1
			2);
update board set order_no=order_no + 1
	where group_no = 2 and order_no > 2;
insert into board 											
	values(board_seq.nextval,'나는 짬뽕 별루..',':(',sysdate,0,
			2, -- 부모글의 그룹
			3, -- 부모글 순서 +1
			2, -- 부모글 싶이 +1
			2);
update board set order_no=order_no + 1
	where group_no = 2 and order_no > 1;
insert into board 											
	values(board_seq.nextval,'나는 간짜장~~','힛',sysdate,0,
			2, -- 부모글의 그룹
			2, -- 부모글 순서 +1
			1, -- 부모글 싶이 +1
			2);

commit;
--이메일
select no, email, name
 from users
 where email="kicks@naver.com";

select guestbook_seq.nextval from guestbook; 
select guestbook_seq.currval from guestbook;


