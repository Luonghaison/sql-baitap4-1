create database quanLiSinhVien2;
use quanLiSinhVien2;
create table Class(
classid int auto_increment primary key,
className varchar (255) not null,
startdate datetime default now(),
status bit
);
create table student(
studentid int auto_increment primary key,
studentName varchar (30) not null,
address varchar (50) not null,
phone varchar (20) not null,
`status` bit,
classid int not null,
foreign key (classid) references class(classid)
);
create table subject(
subid int auto_increment primary key,
subname varchar (30) not null,
credit tinyint not null default(1) check(credit>=1),
`status` bit default(1)
);
create table mark(
markid int auto_increment primary key,
subid int unique,
foreign key (subid) references `subject`(subid),
studentid int,
foreign key(studentid) references student(studentid),
mark float default(0) check (mark between 0 and 100) ,
examtimes tinyint default(1)
);

insert into  class(classname) values
("a1"),("a2"),("a3"),("a4"),("a5"),("a6");
insert into student(studentname,address,phone,status,classid) values
("nguyen van a","ha noi",093526045,1,1),
("nguyen thi b","nghe an",093526045,1,1),
("nguyen van a2","ha noi2",000356045,0,1),
("nguyen van a3","ha noi3",093526045,1,2),
("nguyen van a4","ha noi4",093026045,0,2),
("nguyen van a5","ha noi",093526045,1,3),
("nguyen van a6","ha noi",093526045,1,3),
("nguyen van a7","ha noi",093526045,1,3);
insert into `subject`(subname,credit,status) values
("toan",5,1),
("van",10,1),
("hoa",15,1),
("lich su",6,1),
("tieng anh",20,1),
("dia",11,1);
insert into mark (subid,studentid,mark,examtimes)values
(1,2,50,10),
(2,3,60,12),
(3,4,80,12),
(4,2,100,1),
(5,4,75,2),
(6,1,60,3);

-- select sb.subname, sb.credit, max(sb.credit)
-- from `subject` sb
-- group by sb.subname,sb.credit;

select *
from `subject`
where credit = (
select max(`subject`.credit) from `subject`
);

select *
from `subject` join mark on `subject`.subid=mark.subid
where mark = (
select max(`mark`.mark) from `mark`
);

select s.studentId,s.studentName,avg(m.mark)
from student s join mark m on s.studentId=m.studentId
group by s.studentId,s.studentName
order by avg(m.mark) desc;