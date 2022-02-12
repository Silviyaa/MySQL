# Database Basics MySQL Exam - 17/18 Oct 2020 
CREATE DATABASE 17_18_Oct_2020;

CREATE TABLE pictures(
	id INT PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(100),
    added_on DATETIME
);

CREATE TABLE products(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40),
    best_before DATE,
    price DECIMAL(10,2),
    description TEXT,
    category_id INT,
    picture_id INT,
    
    CONSTRAINT fk_products_category
    FOREIGN KEY (category_id)
    REFERENCES categories (id),
    
    CONSTRAINT fk_products_picture
    FOREIGN KEY (picture_id)
    REFERENCES pictures(id)
);

CREATE TABLE categories(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40)
);

CREATE TABLE towns(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20)
);

CREATE TABLE addresses(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    town_id INT,
    
    CONSTRAINT fk_addresses_towns
    FOREIGN KEY (town_id)
    REFERENCES towns(id)
);

CREATE TABLE stores (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    rating FLOAT,
    has_parking TINYINT(1),
    addrees_id INT,
    
    CONSTRAINT fk_stores_addreeses
    FOREIGN KEY (addrees_id)
    REFERENCES addresses (id)
);

CREATE TABLE products_stores(
	product_id INT,
    store_id INT,
    CONSTRAINT pk_products_stores
    PRIMARY KEY (product_id,store_id),
    
    CONSTRAINT fk_products_stores_products
    FOREIGN KEY (product_id)
    REFERENCES products (id),
    
    CONSTRAINT fk_products_stores_stores
    FOREIGN KEY (store_id)REFERENCES stores (id)
);

CREATE TABLE employees(
	
);