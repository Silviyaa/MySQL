# Database Basics MySQL Exam - 17/18 Oct 2020 
CREATE DATABASE 18_Oct_2020;

CREATE TABLE towns(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) UNIQUE NOT NULL);

CREATE TABLE addresses(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) UNICODE NOT NULL,
`town_id` INT NOT NULL,
CONSTRAINT fk_addresses_towns
FOREIGN KEY (`town_id`)
REFERENCES towns(`id`)
);

CREATE TABLE stores(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) UNICODE NOT NULL,
`rating` FLOAT NOT NULL,
`has_parking` TINYINT(1) DEFAULT 0,
`address_id` INT NOT NULL,
CONSTRAINT fk_stores_addresses
FOREIGN KEY (`address_id`)
REFERENCES addresses(`id`)
);

CREATE TABLE employees(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(15) NOT NULL,
`middle_name` CHAR(1),
`last_name` VARCHAR(20) NOT NULL,
`salary` DECIMAL(19, 2) NOT NULL DEFAULT 0,
`hire_date` DATE NOT NULL,
`manager_id` INT,
`store_id` INT NOT NULL,
CONSTRAINT fk_employees_employees
FOREIGN KEY (`manager_id`)
REFERENCES employees(`id`),
CONSTRAINT fk_employees_stores
FOREIGN KEY (`store_id`)
REFERENCES stores(`id`)
);

CREATE TABLE pictures(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`url` VARCHAR(100) NOT NULL,
`added_on` DATETIME NOT NULL
);

CREATE TABLE categories(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE products(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(40) UNIQUE NOT NULL,
`best_before` DATE,
`price` DECIMAL(10, 2) NOT NULL,
`description` TEXT,
`category_id` INT NOT NULL,
`picture_id` INT NOT NULL,
CONSTRAINT fk_products_categories
FOREIGN KEY (`category_id`)
REFERENCES categories(`id`),
CONSTRAINT fk_products_pictures
FOREIGN KEY (`picture_id`)
REFERENCES pictures(`id`)
);

CREATE TABLE products_stores(
`product_id` INT NOT NULL,
`store_id` INT NOT NULL,

CONSTRAINT pk_products_stores_products_stores
PRIMARY KEY (`product_id`, `store_id`),

CONSTRAINT fk_products_stores_products
FOREIGN KEY (`product_id`)
REFERENCES products(`id`),

CONSTRAINT fk_products_stores_stores
FOREIGN KEY (`store_id`)
REFERENCES stores(`id`)
);

#2.	Insert
insert into `products_stores`
select p.id,1
from `products` as p
where p.id in ( select p.id
from `products` as p
left join `products_stores` as ps
on p.id = ps.product_id
left join `stores` as s
on ps.store_id = s.id
where s.id is null
);

#3.	Update
update employees 
set year(hire_date) > 2003
where store_id not like 'Cardguard' and store_id not like 'Veribet'
and manager_id = 3 and salary = salary - 500 ;


