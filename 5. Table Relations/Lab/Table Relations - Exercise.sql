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
CREATE DATABASE `one-to-many`;

CREATE table manufacturers(
	manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20),
    established_on DATE
)AUTO_INCREMENT = 1;

INSERT INTO manufacturers(manufacturer_id,`name`,established_on)
VALUE
(1,'BMW','1916-03-01'),
(2,'Tesla','2003-01-01'),
(3,'Lada','1966-05-01');

CREATE TABLE models(
	model_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    manufacturer_id INT,
    CONSTRAINT fk_models_manufacturers
    FOREIGN KEY (manufacturer_id)
    REFERENCES manufacturers (manufacturer_id)
);

INSERT INTO models(model_id,`name`,manufacturer_id)
VALUE
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);

#Ex: 03. Many-To-Many Relationship
CREATE DATABASE `Many-To-Many`;

CREATE TABLE exams (
	exam_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20)
)AUTO_INCREMENT = 101;

INSERT INTO exams(name)
VALUES
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

CREATE TABLE students(
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20)
)AUTO_INCREMENT =1;
    
ALTER TABLE students AUTO_INCREMENT = 1;
INSERT INTO students(`name`)
VALUES
('Mila'),
('Toni'),
('Ron');

CREATE TABLE students_exams(
	student_id INT,
    exam_id INT,
    CONSTRAINT pk_students_exams
    PRIMARY KEY (student_id, exam_id),
    
    CONSTRAINT fk_students_exams_students
    FOREIGN KEY (student_id)
    REFERENCES students (student_id),
    
    CONSTRAINT fk_students_exams_exams
    FOREIGN KEY (exam_id)
    REFERENCES exams (exam_id)
);

INSERT INTO students_exams(student_id,exam_id)
VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);

#Ex: 04. Self-Referencing 
CREATE DATABASE teachers;

CREATE TABLE teachers(
	teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(20) NOT NULL,
    manager_id INT
)AUTO_INCREMENT = 101;

INSERT INTO teachers (name,manager_id)
VALUES
('John', NULL),
('Maya',106),
('Silvia',106),
('Ted',105),
('Mark',101),
('Greta',101);

ALTER TABLE teachers
ADD CONSTRAINT fk_teacher_manager
FOREIGN KEY (manager_id)
REFERENCES teachers (teacher_id);

#Ex: 05. Online Store Database 
CREATE DATABASE online_store;
CREATE TABLE cities(
	city_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE customers(
	customer_id INT(11) PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50),
    birthday DATE,
    city_id INT(11),
    
    CONSTRAINT fk_customers_cities
    FOREIGN KEY (city_id)
    REFERENCES cities (city_id)
);

CREATE TABLE orders(
	order_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    customer_id INT(11),
    
    CONSTRAINT fk_orders_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
);


CREATE TABLE item_types(
	item_type_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name varchar(50)
);

CREATE TABLE items (
	item_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name varchar(50),
    item_type_id INT(11),
    
    CONSTRAINT fk_items_item_types
    FOREIGN KEY (item_type_id)
    REFERENCES item_types (item_type_id)
);

CREATE TABLE order_items(
	order_id INT(11),
    item_id INT(11),
    CONSTRAINT pk_order_items
    PRIMARY KEY (order_id, item_id),
    
    CONSTRAINT fk_order_items_items
    FOREIGN KEY (item_id)
    REFERENCES items (item_id),
    
    CONSTRAINT fk_order_items_orders
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id)
);
 