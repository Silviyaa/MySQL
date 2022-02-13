# 13 February 2022
CREATE DATABASE 13_feb_2022;
CREATE TABLE brands(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) UNIQUE NOT NULL
);
 
CREATE TABLE categories(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) UNIQUE NOT NULL
);
 
CREATE TABLE reviews(
id INT PRIMARY KEY AUTO_INCREMENT,
content TEXT,
rating DECIMAL(10,2) NOT NULL,
picture_url VARCHAR(80) NOT NULL,
published_at DATETIME NOT NULL
);
 
CREATE TABLE products(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40)  NOT NULL,
price DECIMAL(19,2) NOT NULL,
quantity_in_stock INT,
description TEXT,
brand_id INT NOT NULL,
category_id INT NOT NULL,
review_id INT,
CONSTRAINT fk_products_brands
FOREIGN KEY (brand_id)
REFERENCES brands(id),
CONSTRAINT fk_products_categories
FOREIGN KEY (category_id)
REFERENCES categories(id),
CONSTRAINT fk_products_reviews
FOREIGN KEY (review_id)
REFERENCES reviews(id)
);
 
CREATE TABLE customers(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20)  NOT NULL,
last_name VARCHAR(20)  NOT NULL,
phone VARCHAR(30) UNIQUE NOT NULL,
address VARCHAR(60) NOT NULL,
discount_card BIT NOT NULL DEFAULT 0
);
 
CREATE TABLE orders(
id INT PRIMARY KEY AUTO_INCREMENT,
order_datetime DATETIME NOT NULL,
customer_id INT NOT NULL,
CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(id)
);
 
CREATE TABLE orders_products(
order_id INT,
product_id INT,
CONSTRAINT fk_orders_products_orders
FOREIGN KEY (order_id)
REFERENCES orders(id),
CONSTRAINT fk_orders_products_products
FOREIGN KEY (product_id)
REFERENCES products(id)
);


# 02. Insert
INSERT INTO reviews(content,picture_url ,published_at,rating) 
SELECT LEFT(p.`description`,15),reverse(p.name),'2020-10-10',p.price / 8
FROM products as p
WHERE id>=5;

# 03. Update
UPDATE products
SET quantity_in_stock = quantity_in_stock-5
WHERE quantity_in_stock >= 60 and quantity_in_stock <=70;

# 04.DELETE
delete
from customers
where id not in (select customer_id from orders);


# 05.Categories
SELECT * FROM categories
order by name desc;

# 06.	Quantity
SELECT  id, brand_id, name, quantity_in_stock 
FROM products
WHERE price >1000 and quantity_in_stock <30
order by quantity_in_stock asc, id;

# 07.	Review
SELECT id, content, rating, picture_url, published_at 
FROM reviews
WHERE content LIKE 'My%' AND length(content)>61
order by rating desc; 

# 08.	First customers
SELECT concat_ws(" ", first_name, last_name) as full_name, address, order_datetime 
FROM customers as cus
join orders as orr 
on orr.customer_id = cus.id
where year(order_datetime) <= 2018
order by full_name desc;

# 09.	Best categories
SELECT count(c.id) as items_count, c.name, sum(quantity_in_stock) as total_quantity 
from products as p
Join categories as c 
on p.category_id =c.id
group by category_id
order by items_count desc, total_quantity asc limit 5; 

#10.	Extract client cards count
DELIMITER $$
CREATE FUNCTION udf_customer_products_count(name VARCHAR(30)) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
RETURN (
	SELECT count(p.id) from customers as c
	join orders as o on o.customer_id= c.id
	join orders_products as op on o.id = op.order_id
	join products as p on op.product_id = p.id
	group by first_name
	having c.first_name = name
);
END $$
SELECT c.first_name,c.last_name, udf_customer_products_count('Shirley') as `total_products` FROM customers c
WHERE c.first_name = 'Shirley';

DELIMITER $$
CREATE PROCEDURE udp_reduce_price(category_name VARCHAR(50))
BEGIN
UPDATE products p
    join categories c on p.category_id = c.id
	join reviews r on p.review_id = r.id
    SET price = round(price * 0.70, 2)
    WHERE c.name = category_name
	and r.rating < 4;
END $$
delimiter ;
CALL udp_reduce_price ('Auto and GPS');
UPDATE products p
    join categories c on p.category_id = c.id
	join reviews r on p.review_id = r.id
    SET price = round(price * 0.70, 2)
    WHERE c.name = category_name
	and r.rating < 4;
;
CALL udp_reduce_price ('Auto and GPS');



