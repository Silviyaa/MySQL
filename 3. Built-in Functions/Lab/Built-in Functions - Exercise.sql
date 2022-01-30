#Ex: 1.	Find Names of All Employees by First Name
 SELECT `first_name`, `last_name`
 from employees
 WHERE `first_name` like 'Sa%'
 ORDER BY `employee_id`;
 
#Ex: 02. Find Names of All Employees by Last Name 
 SELECT `first_name`, `last_name`
 from employees
 WHERE `last_name` like '%ei%'
 ORDER BY `employee_id`;
 
#Ex: 03. Find First Names of All Employess
SELECT `first_name`
from employees
WHERE `department_id` IN (3,10) and year(`hire_date`) BETWEEN 1995 and 2005
ORDER BY `employee_id`;

#Ex: 04. Find All Employees Except Engineers
SELECT `first_name`, `last_name`
from employees
WHERE `job_title` NOT LIKE '%engineer%'
ORDER BY `employee_id`;

#Ex: 05. Find Towns with Name Length
SELECT `name`
FROM `towns`
WHERE char_length(`name`) IN (5,6)
ORDER BY `name` ASC;

#Ex: 06. Find Towns Starting With
SELECT `town_id`,`name`
FROM `towns`
WHERE LEFT( `name`,1) IN ('M','K','B','E')
ORDER BY `name` ASC;

#Ex: 07. Find Towns Not Starting With
 SELECT `town_id`,`name`
FROM `towns`
WHERE LEFT( `name`,1) NOT IN ('R','B','D')
ORDER BY `name` ASC;
   

#Ex: 08. Create View Employees Hired After
CREATE VIEW v_employees_hired_after_2000 as
SELECT `first_name`,`last_name`
FROM employees
WHERE year(hire_date) > 2000;

#Ex: 09.Length of Last Name
SELECT `first_name`,`last_name`
FROM employees
WHERE char_length(`last_name`) in (5);

#Ex: 10.Countries Holding 'A' 3 or More Times 
SELECT `country_name`,`iso_code`
from countries
WHERE `country_name` LIKE '%A%A%A%' 
ORDER BY iso_code ASC;

#Ex: 11.Mix of Peak and River Names 
SELECT `peak_name`,`river_name`,
LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`,2))) as 'mix'
from `peaks`,`rivers`
WHERE right(lower(`peak_name`),1 ) = left(lower(`river_name`),1 )
ORDER BY mix;

#Ex: 12. Games From 2011 and 2012 Year
SELECT `name`, date_format(`start`,'%Y-%m-%d') as 'start'
from games
WHERE year(`start`) BETWEEN 2011 and 2012
ORDER BY `start`, `name`
limit 50;

#Ex: 13. User Email Providers
SELECT `user_name`,substring(`email`, locate('@',`email`)+1) AS 'email_provider'
from users
ORDER BY `email_provider`, `user_name`; 

#Ex: 14. Get Users with IP Address Like Pattern
SELECT `user_name`,`ip_address`
from `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

#Ex: 15. Show All Games with Duration
 