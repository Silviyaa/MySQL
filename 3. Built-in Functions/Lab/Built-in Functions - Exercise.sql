#Ex: 1.	Find Names of All Employees by First Name
 SELECT `first_name`, `last_name`
 from employees
 WHERE `first_name` like 'Sa%'
 ORDER BY `employee_id`;