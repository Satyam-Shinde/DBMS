CREATE TABLE library1 (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(50),
    author VARCHAR(50),
    genre VARCHAR(30)
);
INSERT INTO library1 (book_id, book_name, author, genre)
VALUES (1, 'DBMS Concepts', 'John Smith', 'Technology'),
       (2, 'Introduction to Algorithms', 'Thomas Cormen', 'Computer Science'),
       (3, 'Physics Basics', 'James Doe', 'Science');
SELECT * FROM library1;
CREATE TABLE library_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    book_name VARCHAR(50),
    author VARCHAR(50),
    genre VARCHAR(30),
    operation_type VARCHAR(10),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //
CREATE TRIGGER after_update_library
AFTER UPDATE ON library1
FOR EACH ROW
BEGIN
    INSERT INTO library_audit (book_id, book_name, author, genre, operation_type)
    VALUES (OLD.book_id, OLD.book_name, OLD.author, OLD.genre, 'UPDATE');
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER after_delete_library
AFTER DELETE ON library1
FOR EACH ROW
BEGIN
    INSERT INTO library_audit (book_id, book_name, author, genre, operation_type)
    VALUES (OLD.book_id, OLD.book_name, OLD.author, OLD.genre, 'DELETE');
END;
//
DELIMITER ;
UPDATE library1
SET book_name = 'Advanced DBMS Concepts'
WHERE book_id = 1;
DELETE FROM library1
WHERE book_id = 2;
SELECT * FROM library_audit;
