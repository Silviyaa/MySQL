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

#Ex: 03.Town Names Starting With
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (town_name VARCHAR(50))
BEGIN
	SELECT `name`
	FROM towns
	WHERE name LIKE concat(town_name,'%')
	ORDER BY name;
END $$

CALL usp_get_towns_starting_with('b')

#Ex: 04. Employees from Town
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT e.first_name, e.last_name
	FROM employees as e
    JOIN addresses as a
    ON e.address_id = a.address_id
    JOIN towns as t
    on t.town_id = a.town_id
	WHERE t.name LIKE concat(town_name,'%')
	ORDER BY e.first_name, e.last_name;
END $$

CALL usp_get_employees_from_town('Sofia')

#Ex: 05. Salary Level Function
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(e_salary DECIMAL)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	RETURN(
		CASE
			WHEN e_salary < 30000 THEN 'Low'
			WHEN e_salary BETWEEN 30000 and 50000 THEN 'Average'
			WHEN e_salary > 50000 THEN 'High'
		END
    );
END $$
DELIMITER ;

SELECT ufn_get_salary_level(1000);

#Ex: 06.Employees by Salary Level 
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level (s_level VARCHAR(10))
BEGIN
	SELECT first_name,last_name
	from employees
    WHERE ufn_get_salary_level(salary) = s_level
	ORDER BY first_name DESC, last_name DESC;
END $$

CALL usp_get_employees_by_salary_level ('Hight')

#Ex: 10. Future Value Function
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19,4), interest DOUBLE, years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	RETURN( sum * POW(1+interest,years) );
END$$
DELIMITER ;

SELECT ufn_calculate_future_value(1000,0.5,5)

#Ex: 11. Calculating Interest
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acc_id INT, interest DOUBLE)
BEGIN
	SELECT a.id, ah.first_name, ah.last_name, a.balance,
	ufn_calculate_future_value(a.balance,interest,5) as 'balance_in_5_years'
	FROM accounts as a
	JOIN account_holders as ah
	on a.account_holder_id = ah.id
    WHERE a.id = acc_id;
END$$

call usp_calculate_future_value_for_account(1,0.1)