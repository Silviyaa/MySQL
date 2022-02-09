# 1.	One-To-One Relationship 
CREATE TABLE passports(
passport_id INT PRIMARY KEY AUTO_INCREMENT,
passport_number VARCHAR(20) UNIQUE
) AUTO_INCREMENT = 101;

ALTER TABLE passports AUTO_INCREMENT = 101;  -- задаване за начална стойност / ще брои от 101 / 
insert into passports (passport_number)
VALUes 
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2');

cREaTe table people(
	person_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name vARChAR(50),
	SALARY DECIMAL(10,2),
    passport_id INT UNIQUE,
    constraint fk_people_passports
    FOREIGN key (passport_id)
    REFERENCES passports (passport_id) -- REFERences - сочИ към
);

ALTER TABLE people AUTO_INCREMENT = 1;
insert into people(first_name,SALARY,passport_id)
values 
('Roberto',43300.00,102),
('Tom',56100.00,103),
('Yana',60200.00,101);

# 2.One-To-Many Relationship 

