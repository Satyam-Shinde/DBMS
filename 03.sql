create database practicals;
use practicals;
create table Loan(lno int primary key, bname char(10), amount int);
insert into Loan(lno,bname,amount) values(1,"Pune",1000),(2,"Ahmednagar",3000),(3,"Baramati",2000),(4,"Solapur",5600),(5,"Satara",4000),(6,"Kolhapur",14000);
desc Loan;
select * from Loan;
create table Borrower(cname char(10), lno int, foreign key(lno) references Loan(lno));
insert into Borrower(cname,lno) values("Satyam",1),("Vishal",2),("Durgesh",4);
desc Borrower;
select * from Borrower;
select Loan.lno, bname, amount, cname
from Loan inner join Borrower
on Loan.lno = Borrower.lno;
select Loan.lno, bname, amount, cname, Borrower.lno
from Loan left outer join Borrower
on Loan.lno = Borrower.lno;
select Loan.lno, bname, amount, cname, Borrower.lno
from Loan right outer join Borrower
on Loan.lno = Borrower.lno;
select * from Loan order by bname;
select * from Loan order by bname desc;
Create view v1 as
select lno, bname
from Loan;
select * from v1;