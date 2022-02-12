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
DELETE FROM clients 
WHERE id not in (SELECT client_id FROM courses ) and
char_length(full_name) > 3;

# 05. Cars 
select make	, model,`condition`
FROM cars
ORDER BY id;

# 06. Drivers and Cars 
select d.first_name, d.last_name ,c.make, c.model ,c.mileage
FROM cars as c
JOIN cars_drivers as cd
ON cd.car_id = c.id
JOIN drivers as d
on d.id=cd.driver_id
where mileage is not null
order by mileage desc, first_name asc;

#07. Number of courses
select c.id, make, mileage,
count(cr.id) as `count_of_courses`,
round(avg(cr.bill), 2) as `avg_bill`
from cars as c
left join courses as cr
on c.id = cr.car_id
group by c.id
having `count_of_courses` != 2
order by `count_of_courses` desc, c.id;

# 08. Regular clients 
select full_name,
count(cr.id) as `count_of_cars`,
sum(cr.bill) as `total_sum`
from clients as cl
join courses as cr
on cl.id = cr.client_id
join cars as c
on c.id = cr.car_id
group by cl.id
having substring(full_name, 2, 1) = 'a'
and `count_of_cars` > 1
order by full_name;

# 09. Full info for courses 
select ad.`name`, 
   (case 
		when hour(cr.`start`) between 6 and 20 then 'Day'
		else 'Night' 
	end) as `day_time`,
cr.bill, cl.full_name, c.make, c.model, cat.`name`
from courses as cr
join addresses as ad
on cr.from_address_id = ad.id
join cars as c
on cr.car_id = c.id
join clients as cl
on cr.client_id = cl.id
join categories as cat
on c.category_id = cat.id
order by cr.id;

#10. Find all courses by client’s phone number
DELIMITER $$
CREATE FUNCTION udf_courses_by_client (phone_num VARCHAR (20)) 
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN( 
			SELECT count(co.id) as `count`
			from clients as cl
			JOIN courses as co
			ON cl.id = co.client_id
			GROUP BY phone_number
			having phone_number = phone_num
    
    );
END $$

SELECT udf_courses_by_client ('(803) 6386812') as `count`; 
SELECT udf_courses_by_client ('(831) 1391236') as `count`;

# 11. Full info for address
DELIMITER $$
CREATE PROCEDURE udp_courses_by_address(address_name VARCHAR(100))
BEGIN
SELECT a.name,cl.full_name,
(case 
	WHEN co.bill <=20 THEN 'Low'
    WHEN co.bill <= 30 THEN 'Medium'
    ELSE 'High'
end) as level_of_vill,
car.make,car.`condition`,ca.name
FROM addresses as a
JOIN courses as co
ON a.id = co.from_address_id
JOIN clients as cl
ON cl.id = co.client_id
JOIN cars as car
On car.id = co.car_id
JOIN categories as ca
ON car.category_id = ca.id
WHERE a.name = address_name
ORDER BY car.make, cl.full_name;

END $$

CALL udp_courses_by_address('66 Thompson Drive');



