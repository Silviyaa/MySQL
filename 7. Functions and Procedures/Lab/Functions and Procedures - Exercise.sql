#Functions and Procedures - Exercise  

#Ex: 01.Employees with Salary Above 35000 
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000 (s_salary INT)
BEGIN
	SELECT first_name, last_name
	FROM employees
	WHERE salary > s_salary
	ORDER BY first_name, last_name, employee_id;
END $$

CALL usp_get_employees_salary_above_35000(35000)

#Ex: 02.Employees with Salary Above Number
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DECIMAL(19,4))
BEGIN

	SELECT first_name, last_name
	FROM employees
	WHERE salary>=min_salary
	ORDER BY first_name, last_name, employee_id;
    
END $$

Call usp_get_employees_salary_above(45000);