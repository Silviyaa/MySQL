#Ex: 14. Sort Employees Table
SELECT * from employees
ORDER BY salary DESC , first_name ASC, last_name DESC, middle_name ASC;

#Ex: 15. Create View Employees with Salaries 
CREATE VIEW `v_employees_salaries` as
select `first_name`, `last_name`, `salary`
from employees;

#Ex: 16. Create View Employees with Job Titles
CREATE VIEW `v_employees_job_titles` as
select concat_ws(' ',`first_name`, `middle_name`, `last_name`) as 'full_name',`job_title` 
from employees;

#Ex: 17. Distinct Job Titles
SELECT DISTINCT(`job_title`) 
FROM employees
ORDER BY job_title ASC;

#Ex: 18. Find First 10 Started Projects
 SELECT * FROM  projects 
 ORDER BY start_date ASC , `name`, `project_id` LIMIT 10;
 
#Ex: 19. Last 7 Hired Employees
SELECT `first_name`,last_name,hire_date
FROM employees
ORDER BY hire_date DESC LIMIT 7;

#Ex: 20. Increase Salaries
UPDATE `employees`
SET `salary` = `salary` * 1.12
WHERE `department_id` in (1,2,4,11);
SELECT `salary` from `employees`;

#Ex: 21.All Mountain Peaks 
SELECT `peak_name`
FROM `peaks` 
ORDER BY peak_name ASC;

#Ex: 22.Biggest Countries by Population  
SELECT `country_name`, `population`
FROM `countries` 
WHERE `continent_code` = 'EU'
ORDER BY population DESC , country_name LIMIT 30;

