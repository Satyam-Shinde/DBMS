-- Create table O_Roll
create table O_roll(rollno int primary key, student_name char(50), course char(20));

-- Insert Record into O_roll
insert into O_roll(rollno,student_name,course) values (1,"Satyam Shinde","Computer"),(2,"Abhay Jadhav","ENTC"),(3,"Sagar Shinde","Civil");

-- Show Table O_roll
select * from O_roll;


-- Create table N_Roll
create table N_roll(rollno int primary key, student char(50), course char(20));

-- Insert Record into N_roll
insert into N_roll(rollno,student,course) values (1,"Satyam Shinde","Computer"),(4,"Sourabh Randive","IT");

-- Show Table N_roll
select * from N_roll;


-- Create procedure for checking the existing record in the table
delimiter //
create procedure p1(in r1 int)
BEGIN
    DECLARE v_rollno INT;
    DECLARE v_student_name CHAR(50);
    DECLARE v_course CHAR(20);
    DECLARE exit_loop BOOLEAN DEFAULT FALSE;
    
    DECLARE c1 CURSOR FOR SELECT rollno, student_name, course FROM O_roll;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;

    OPEN c1;

    e_loop: LOOP
        FETCH c1 INTO v_rollno, v_student_name, v_course;
        IF exit_loop THEN
            LEAVE e_loop;
        END IF;

        -- Check if the record exists in N_Roll, and insert if it does not
        IF NOT EXISTS (SELECT 1 FROM N_Roll WHERE rollno = v_rollno) THEN
            INSERT INTO N_Roll (rollno, student, course)
            VALUES (v_rollno, v_student_name, v_course);
        END IF;
    END LOOP e_loop;

    CLOSE c1;
END;
//

call p1();



