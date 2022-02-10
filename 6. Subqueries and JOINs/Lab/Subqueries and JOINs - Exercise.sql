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

#Ex: 03. Sales Employee 
SELECT e.employee_id, e.first_name, e.last_name, d.`name`
FROM employees as e
JOIN departments as d
on e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;

#Ex: 04. Employee Departments
SELECT e.employee_id, e.first_name, e.salary, d.name
FROM employees as e
JOIN departments as d
USING(department_id)
WHERE salary > round((15000),2)
ORDER BY department_id DESC
limit 5;

#Ex: 05. Employees Without Project
SELECT e.employee_id, e.first_name
FROM employees as e
LEFT JOIN employees_projects as ep
on e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

#Ex:  06. Employees Hired After
SELECT  e.first_name, e.last_name, e.hire_date, d.name
FROM employees as e
JOIN departments as d
USING(department_id)
where e.hire_date > 1990-01-01 and d.name IN ('Sales','Finance')
ORDER BY e.hire_date asc;

#Ex: 07. Employees with Project 
SELECT  e.employee_id,e.first_name, p.name
FROM employees as e
JOIN employees_projects as ep
USING(employee_id)
JOIN projects as p
USING(project_id)
WHERE DATE(p.start_date) > '2002-08-13' and p.end_date IS NULL
ORDER BY e.first_name ASC , p.name ASC
LIMIT 5;

#Ex: 08. Employee 24
SELECT e.employee_id,e.first_name, if(year(p.start_date) > 2004,NULL,p.name) as p_name
FROM employees as e
JOIN employees_projects as ep
USING(employee_id)
JOIN projects as p
USING(project_id)
WHERE e.employee_id = 24 
ORDER BY p_name;

#Ex: 09. Employee Manager

#Ex:  10. Employee Summary
SELECT e.employee_id, 
concat_ws(' ',e.first_name, e.last_name) as employee_name ,
concat_ws(' ',m.first_name, m.last_name) as manager_name,
d.name
FROM employees as e
join employees as m
on e.manager_id = m.employee_id
join departments as d
on e.department_id = d.department_id
ORDER BY employee_id