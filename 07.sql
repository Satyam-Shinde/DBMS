
-- Create the library table
CREATE TABLE library1 (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(50),
    author VARCHAR(50),
    genre VARCHAR(30)
);

-- Insert sample data into the library table
INSERT INTO library1 (book_id, book_name, author, genre)
VALUES (1, 'DBMS Concepts', 'John Smith', 'Technology'),
       (2, 'Introduction to Algorithms', 'Thomas Cormen', 'Computer Science'),
       (3, 'Physics Basics', 'James Doe', 'Science');

-- Display initial data in the library table
SELECT * FROM library1;

-- Create the library_audit table to log changes
CREATE TABLE library_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    book_name VARCHAR(50),
    author VARCHAR(50),
    genre VARCHAR(30),
    operation_type VARCHAR(10),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create AFTER UPDATE trigger on the library table
DELIMITER //
CREATE TRIGGER after_update_library
AFTER UPDATE ON library1
FOR EACH ROW
BEGIN
    -- Insert the old record into the library_audit table
    INSERT INTO library_audit (book_id, book_name, author, genre, operation_type)
    VALUES (OLD.book_id, OLD.book_name, OLD.author, OLD.genre, 'UPDATE');
END;
//
DELIMITER ;

-- Create AFTER DELETE trigger on the library table
DELIMITER //
CREATE TRIGGER after_delete_library
AFTER DELETE ON library1
FOR EACH ROW
BEGIN
    -- Insert the old record into the library_audit table
    INSERT INTO library_audit (book_id, book_name, author, genre, operation_type)
    VALUES (OLD.book_id, OLD.book_name, OLD.author, OLD.genre, 'DELETE');
END;
//
DELIMITER ;

-- Test the triggers by updating a record
UPDATE library1
SET book_name = 'Advanced DBMS Concepts'
WHERE book_id = 1;

-- Test the triggers by deleting a record
DELETE FROM library1
WHERE book_id = 2;

-- Display the contents of the library_audit table
SELECT * FROM library_audit;
