create table lib_borrow(roll_no int primary key, dateofIssue date, NameofBook varchar(10), statuss varchar(5));
desc lib_borrow;
insert into lib_borrow(roll_no, dateofIssue, NameofBook, statuss) values(1,'2024-01-01',"DBMS","I"),(2,'2024-02-02',"SPOS","I"),(3,'2024-03-03',"TOC","R"),(4,'2024-04-04',"CNS","I");
select * from lib_borrow;
create table Fine(roll_no int, s_date date, amount int, foreign key(roll_no) references lib_borrow(roll_no));
desc Fine;
delimiter $
create procedure calfine(in roll int)
begin
    declare fine int default 0;
    declare noofDays int;
    declare issuedDate date;
    declare exit handler for sqlexception
    begin
        select 'An SQL exception occurred';
    end;
    select dateofIssue into issuedDate from lib_borrow where roll_no = roll;
    select datediff(curdate(), issuedDate) into noofDays;
    if noofDays > 15 and noofDays <= 30 then
        set fine = noofDays * 5;
        insert into Fine values(roll, curdate(), fine);
    elseif noofDays > 30 then
        set fine = noofDays * 50;
        insert into Fine values(roll, curdate(), fine);
    else
        insert into Fine values(roll, curdate(), 0);
    end if;
    update lib_borrow set statuss = 'R' where roll_no = roll;
end$
delimiter ;
call calfine(1);
select * from Fine;