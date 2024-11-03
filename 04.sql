-- Create table for borrow table for library
create table lib_borrow(roll_no int primary key, dateofIssue date, NameofBook varchar(10), statuss varchar(5));

-- Description lib_borrow
desc lib_borrow;

--  Insert values into lib_borrow
insert into lib_borrow(roll_no, dateofIssue, NameofBook, statuss) values(1,'2024-01-01',"DBMS","I"),(2,'2024-02-02',"SPOS","I"),(3,'2024-03-03',"TOC","R"),(4,'2024-04-04',"CNS","I");

-- Show the Table lib_borrow
select * from lib_borrow;

-- Create table fine
create table Fine(roll_no int, s_date date, amount int(5), foreign key(roll_no) references lib_borrow(roll_no));

-- desc Fine
desc Fine;

delimiter $
create procedure calfine(in roll int)
begin
declare fine int;
declare noofDays int;
declare issuedDate int;
declare exit handler for sqlexception select 
'Create table defination';
select dateofIssue into issuedDate from lib_borrow where roll_no=roll;
select datediff(curdate(), issuedDate) into noofDays;
if noofDays > 15
and noofDays<=30 then set fine = noofDays*5;
insert into Fine values(roll,curdate(),fine);
elseif noofDays>30 then set fine=noofDays*50;
insert into Fine values(roll,curdate(),fine);
else insert into Fine values(roll, curdate(),0);
end if;
update lib_borrow set statuss="R" where roll_no=roll;
end$

delimiter ;

call calfine(1);

select * from Fine;