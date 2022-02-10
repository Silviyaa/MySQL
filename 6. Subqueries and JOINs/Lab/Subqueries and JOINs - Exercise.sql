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


