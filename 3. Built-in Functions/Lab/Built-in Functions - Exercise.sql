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
WHERE `department_id` IN (3,10) and `hire_date` BETWEEN(year(1995 and 2005))
ORDER BY `employee_id`;
   
   
   