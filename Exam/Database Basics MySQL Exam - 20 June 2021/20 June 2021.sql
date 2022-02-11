#20 June 2021

CREATE DATABASE 20_JUNE_2021;

CREATE TABLE clients(
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50),
    phone_number VARCHAR(20)
);

CREATE TABLE addresses(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE categories(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10)
);

CREATE TABLE cars(
	id INT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(20),
    model VARCHAR(20),
    year INT,
    mileage INT,
    `condition` CHAR(1),
    category_id INT,
    
    CONSTRAINT fk_cars_categories
    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);

CREATE TABLE couriers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    from_address_id INT,
    start datetime,
    car_id INT,
    client_id INT,
    bill DECIMAL(10,2),
    
    CONSTRAINT fk_couriers_addresses
    FOREIGN KEY (from_address_id)
    REFERENCES addresses(id),
    
    CONSTRAINT fk_couriers_clients
    FOREIGN KEY (client_id )
    REFERENCES clients(id),
    
	CONSTRAINT fk_couriers_cars
    FOREIGN KEY (car_id )
    REFERENCES cars(id)
);

CREATE TABLE drivers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    age INT,
    rating FLOAT
);

CREATE TABLE cars_drivers(
	car_id INT,
    driver_id INT,
    
    CONSTRAINT pk_cars_drivers
    PRIMARY KEY (car_id,driver_id),
    
    CONSTRAINT fk_cars_drivers_cars
    FOREIGN KEY (car_id)
    REFERENCES cars (id),
    
    CONSTRAINT fk_cars_drivers_drivers
    FOREIGN KEY (driver_id)
    REFERENCES drivers (id)
);

# 02. Insert
INSERT INTO clients (full_name,phone_number)
SELECT concat_ws(' ',  d.first_name, d.last_name) as full_name,
concat('(088) 9999', d.id * 2)
FROM drivers as d
WHERE d.id BETWEEN 10 and 20;

# 03. Update
UPDATE cars 
SET `condition` = 'C'
WHERE mileage >= 800000 or mileage is null and year <= 2010 and make not like 'Mercedes-Benz';
# WHERE mileage >= 800000 or mileage is null and year <= 2010 and make != 'Mercedes-Benz';

# 04.Delete 