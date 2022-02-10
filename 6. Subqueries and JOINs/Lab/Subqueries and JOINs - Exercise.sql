#Subqueries and JOINs - Exercise 

#Ex: 1.	Employee Address
SELECT e.employee_id, e.job_title,	a.address_id, a.address_text
FROM employees as e
join addresses as a
USING(address_id)
# ON e.address_id = a.address_id
GROUP BY employee_id , address_text
ORDER BY address_id ASC
LIMIT 5;

#Ex: 02. Addresses with Towns 
SELECT e.first_name, e.last_name, t.name,a.address_text
FROM employees as e
JOIN addresses as a
ON e.address_id = a.address_id
JOIN towns as t
on a.town_id = t.town_id
ORDER BY first_name ASC, last_name ASC
LIMIT 5;

