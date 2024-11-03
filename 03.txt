-- Use Database Practicals -- 
use practicals;

-- Create a Loan table -- 
create table Loan(lno int primary key, bname char(10), amount int);

-- Insert Values in Loan Table
insert into Loan(lno,bname,amount) values(1,"Pune",1000),(2,"Ahmednagar",3000),(3,"Baramati",2000),(4,"Solapur",5600),(5,"Satara",4000),(6,"Kolhapur",14000);

-- Structure of Loan table
desc Loan;

-- Values of Loan table 
select * from Loan;

-- Create Table Borrower
create table Borrower(cname char(10), lno int, foreign key(lno) references Loan(lno));

-- Insert values into Borrower 
insert into Borrower(cname,lno) values("Satyam",1),("Vishal",2),("Durgesh",4);

-- Describe table Borrower
desc Borrower;

-- Print all values from Borrower
select * from Borrower;

-- Inner Join of Loan and Borrower
select Loan.lno, bname, amount, cname
from Loan inner join Borrower
on Loan.lno = Borrower.lno;

-- Left Outer Join of Loan and Borrower
select Loan.lno, bname, amount, cname, Borrower.lno
from Loan left outer join Borrower
on Loan.lno = Borrower.lno;

-- Right Outer Join of Loan and Borrower
select Loan.lno, bname, amount, cname, Borrower.lno
from Loan right outer join Borrower
on Loan.lno = Borrower.lno;


--  Arrange the bname by Asending Order
select * from Loan order by bname;

--  Arrange the bname by Desending Order
select * from Loan order by bname desc;


-- Create View as v1 
Create view v1 as
select lno, bname
from Loan;

-- Showing the created view
select * from v1;