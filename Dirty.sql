DROP DATABASE IF EXISTS college_demo;
CREATE DATABASE college_demo;

USE college_demo;

SELECT @transaction_isolation;
    
CREATE TABLE department(
     dept_id INT PRIMARY KEY,
     dept_name VARCHAR(50) UNIQUE NOT NULL
     );

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(15),
    dept_id INT,
    cgpa DECIMAL(3, 2),
    transaction_id VARCHAR(36), 
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE INDEX idx_student_dept ON student(dept_id);


CREATE TABLE course (
     course_id INT PRIMARY KEY,
     course_name VARCHAR(50) NOT NULL,
     dept_id INT,
     FOREIGN KEY (dept_id) REFERENCES department(dept_id)
     );

CREATE TABLE enrollment (
     roll_no INT,
     course_id INT,
     semester INT CHECK (semester BETWEEN 1 and 8),
     grade CHAR(2),
     PRIMARY KEY (roll_no, course_id, semester),
     FOREIGN KEY (roll_no) REFERENCES student(roll_no),
     FOREIGN KEY (course_id) REFERENCES course(course_id)
     );

INSERT INTO department Values(1, 'Artificial intelligence'), (2, 'Electrical');




      INSERT INTO student VALUES (101, 'Chaitanya', 'chaitanya@mail.com', '123456789012', 1, 8.50, 'TXN1001');
      INSERT INTO student VALUES (102, 'Manaswi', 'manaswi@mail.com', '987654321098', 2, 9.10, 'TXN1002');

       INSERT INTO course Values(701, 'DBMS', 1 ),(702, 'Circuits', 2);

       INSERT INTO enrollment Values (101, 701, 3, 'A');
       INSERT INTO enrollment Values (101, 702, 3, 'A'); -- same student, different course; allowed

SELECT * FROM department;
       SELECT * FROM course;
       SELECT * FROM enrollment;
       SELECT * FROM student;

-- (Session A)
START TRANSACTION;

UPDATE student 
SET cgpa = 9.6
WHERE roll_no = 101;

-- (Session B) 
SELECT * FROM student;
SELECT * FROM enrollment WHERE roll_no = 101;

SELECT * FROM student;

explain select* from student where dept_id=1 ;