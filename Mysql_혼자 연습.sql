-- 새로운 DB생성 jspstudy
create database jspstudy default character set utf8;

-- 내가 지금부터 jspstudy DB를 사용하겠다 - 통보
use jspstudy;

-- 테이블은 엑셀시트와 같다. board 테이블 생
create table board(
  seq     int auto_increment    primary key,
  title   varchar(200)  not null,
  nickname  varchar(30) not null,
  content   varchar(2000) not null,
  regdate   timestamp       default now(),
  cnt     int   default 0,
  userid    varchar(50)
) engine=InnoDB default character set = "utf8";


insert into board(seq, title, nickname, content, regdate, userid) 
values(1, '첫 번째 게시물', '홍길동', '첫 번째 게시물 내용.', '2021-02-05', 'hong');

insert into board(seq, title, nickname, content, regdate, userid) 
values(2, '두 번째 게시물', '홍길동', '두 번째 게시물 내용.', '2021-03-15', 'hong');

insert into board(seq, title, nickname, content, regdate, userid) 
values(3, '세 번째 게시물', '홍길동', '세 번째 게시물 내용.', '2021-03-03', 'hong');

insert into board(seq, title, nickname, content, regdate, userid) 
values(4, '네 번째 게시물', '홍길동', '네 번째 게시물 내용.', '2021-05-17', 'hong');

insert into board(seq, title, nickname, content, regdate, userid) 
values(5, '다섯 번째 게시물', '일지매', '다섯 번째 게시물 내용.', '2021-05-19', 'guest');

insert into board(seq, title, nickname, content, regdate, userid) 
values(6, '여섯 번째 게시물', '일지매', '여섯 번째 게시물 내용.', '2021-12-25', 'guest');

insert into board(title, nickname, content, regdate, userid,seq) 
select '일곱 번째 게시물', '일지매', '일곱 번째 게시물 내용.', '2021-12-25', 'guest', IFNULL(max(seq), 0)+1 from board;

select * from board;

update board set title = 'old Title' where seq = 7;

delete from board where seq = 1;


use jspstudy;

create table users(
  id varchar(50) not null primary key,
  pwd varchar(50) not null,
  name varchar(50) not null,
  email varchar(80),
  joindate timestamp default now()
)

insert into users values ('dokdo','87K','게스트', 'guest@naver.com',default)
insert into users values ('jung','1234','겨울곰', 'gom@naver.com',default)

select * from users;

use jspstudy;


create table sboard(
  seq     int auto_increment    primary key,
  title   varchar(200)  not null,
  nickname  varchar(30) not null,
  content   varchar(2000) not null,
  regdate   timestamp       default now(),
  cnt     int   default 0,
  userid    varchar(50),
  pwd   varchar(50) not null
) engine=InnoDB default character set = "utf8";


insert into sboard(title, nickname, content, regdate, userid, pwd) 
values( '첫 번째 게시물', '홍길동', '첫 번째 게시물 내용.', now(), 'hong', '0000');

insert into sboard(title, nickname, content, regdate, userid, pwd) 
values( '두 번째 게시물', '홍길동', '두 번째 게시물 내용.',now(), 'hong', '0000');

insert into sboard(title, nickname, content, regdate, userid, pwd) 
values( '세 번째 게시물', '홍길동', '세 번째 게시물 내용.', now(), 'hong', '0000');

insert into sboard(title, nickname, content, regdate, userid, pwd) 
values( '네 번째 게시물', '홍길동', '네 번째 게시물 내용.',now(), 'hong', '0000');

insert into sboard(title, nickname, content, regdate, userid, pwd) 
values( '다섯 번째 게시물', '일지매', '다섯 번째 게시물 내용.', now(), 'guest', '0000');

insert into sboard(title, nickname, content, regdate, userid, pwd) 
values('여섯 번째 게시물', '일지매', '여섯 번째 게시물 내용.', now(), 'guest', '0000');

select * from sboard;

select * from sboard limit 0, 10;

select count(*) from sboard;


update sboard set title = '22', content = '22', nickname = '22' where seq = 180


=========================================================

use firstStepSQL;

create table users(
	id int not null auto_increment primary key,
	name varchar(15) not null,
	email varchar(150) not null,
	age int not null,
	gender varchar(2) not null,
	address varchar(500) not null
)

insert into users(name, email, age, gender, address)
values ("이정민","jungmin5600@naver.com",29,"남자","경기도 부천시 은성로 xx번길 x xxx호");

insert into users(name, email, age, gender, address)
values ("행인4","hang4@naver.com",15,"여자","행인 아파트 x동 x");

select id, name from users;
desc users;
select name, email from users;

select * from users where age<>10 order by age desc;

select * from users where gender="남자" and age>11 order by age;

select * from users where address like "%부천%"

select * from users order by id desc limit 4

select * from users where id<=4 order by id desc limit 4

select * from users where id<=4 order by id 

select * from users limit 0,5

select * from users limit 5,5

create table product(
	id int not null auto_increment primary key,
	name varchar(50) not null,
	price int not null,
	quantity int not null
)

insert into product(name, price, quantity)
values("조립컴퓨터",500000, 21)

insert into product(name, price, quantity)
values("자바책",22000, 120);
insert into product(name, price, quantity)
values("옛날치킨",6500, 230);

select name, quantity, price * quantity as "총액" from product;

select *, quantity * price as amount  from product
where quantity * price >= 1000000

select *, quantity * price as amount  from product
where quantity * price >= 1000000
order by amount;


create table decimal_point(
	id int auto_increment primary key,
	amount decimal(10,5) not null
);

insert into decimal_point(amount)
values(2005.34);

drop table decimal_point;

delete from decimal_point;


select amount, round(amount) from decimal_point;

select amount, round(amount,0) from decimal_point;

create table unitname(
	id int auto_increment primary key,
	name varchar(20) not null,
	price int not null,
	quantity int not null,
	unit varchar(5) not null
)

insert into unitname(name,price,quantity,unit)
values("티셔츠",15000,5,"벌");

delete from unitname where id=3;

select name, concat(quantity,unit) as amount from unitname;

select name, substring(price,1,2) as substrings from unitname;

select * from unitname;

select * from users;

select id, name, char_length(name) as lengths from users;

select id, name, octet_length(name) as lengths from users;

select current_timestamp;

create table signUp(
	id int auto_increment primary key,
	name varchar(30) not null,
	email varchar(100) not null unique key,
	age int not null,
	gender varchar(2) not null,
	subscription datetime default current_timestamp
);

insert into signup(name,email,age,gender)
values("미키마우스","mikeymouce@hanmail.net",16,"여자");

select name,email, (subscription - interval 1 day) from signup;

select name,email, datediff(subscription, current_timestamp) from signup;

select name,email,subscription, timestampdiff(minute, subscription, current_timestamp) as diff from signup;


create table unitNull(
	id int auto_increment primary key,
	name varchar(10) not null,
	energy int default null
);

select * from unitNull

insert into unitnull(name)
values("마자용");

select name, energy, case when energy is null then 0 else energy end as energy_0 from unitnull;

select name, energy, coalesce(energy,0) from unitnull;

create table gender(
	id int auto_increment primary key,
	gender int not null
)

create table seat(
	id int auto_increment primary key,
	seatKind int default null
)

insert into seat(seatkind)
values(4);

insert into gender(gender)
values(1);

select gender as "성별",
case when gender=1 then "남자" 
	 when gender=2 then "여자" 
	 else "미지정" end as "성별변환" from gender;

	
select gender, case gender
when 1 then "남자"
when 2 then "여자"
else "미지정" end as "성별" from gender;



select seatkind,
case
when seatkind=1 then "퍼스트 클래스"
when seatkind=2 then "비지니스 클래스"
when seatkind=3 then "일반석"
when seatkind is null then "좌석없음"
else "좌석오류" end as "잘못된 정보" from seat;


select id, seatkind from seat;
delete from seat where id=2;

select * from unitNull

update unitnull set energy=3000 where energy=1000;

update unitnull set energy=7700 where name="장민정"

update unitnull set energy=5000;

insert into unitnull(name,energy)
values("이상해씨",1000);

