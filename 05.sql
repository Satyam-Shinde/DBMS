create table markstud(rollno int primary key, name char(10), totalmarks int);
insert into markstud(rollno,name,totalmarks) values (1,"Satyam",89),(2,"Akshay",87),(3,"Vishal",67),(4,"Durgesh",88),(5,"Shreyas",87),(6,"Rutik",91);
create table result(rollno int, name char(10), class char(20));
delimiter //
create procedure grade(in marks int, out class char(20))
begin
if marks <= 100 and marks>90 then set class="Distinction";
end if;
if marks <= 89 and marks>80 then set class="First Class";
end if;
if marks < 79 and marks>70 then set class="High Second Class";
end if;
if marks < 69 and marks>60 then set class="Second Class";
end if;
if marks < 59 and marks>50 then set class="Third Class";
end if;
if marks < 49 and marks>40 then set class="Pass";
end if;
if marks < 39 then set class="Fail";
end if;
end; //
create function findres(rollin int) returns int deterministic
begin
declare fmark int;
declare  grade char(10);
declare studname char(10);
select markstud.totalmarks, markstud.name into fmark,studname
from markstud where markstud.rollno=rollin;
call grade(fmark,@grade);
insert into result values(rollin, studname, @grade);
return rollin;
end; //
select findres(2); 
select * from result;


