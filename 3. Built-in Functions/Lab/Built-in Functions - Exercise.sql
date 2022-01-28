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

#Ex: 09.	Length of Last Name

 

