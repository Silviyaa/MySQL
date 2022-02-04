#Ex: 1.Records' Count
SELECT COUNT(*) as 'count' FROM `wizzard_deposits`;

#Ex: 02. Longest Magic Wand
SELECT MAX(`magic_wand_size`) as 'longest_magic_wand'
FROM `wizzard_deposits`;

#Ex: 03. Longest Magic Wand per Deposit Groups
SELECT `deposit_group`, max(`magic_wand_size`) as 'max_size'
FROM `wizzard_deposits` 
GROUP BY `deposit_group`
ORDER BY `max_size` ASC, `deposit_group` ASC;

#Ex: 04. Smallest Deposit Group per Magic Wand Size
SELECT `deposit_group`
FROM `wizzard_deposits` 
GROUP BY (`deposit_group`)
ORDER BY AVG(`magic_wand_size`)
LIMIT 1;

#Ex: 05. Deposits Sum
SELECT `deposit_group`, SUM(`deposit_amount`) as 'total_sum'
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `total_sum`ASC;

#Ex: 06. Deposits Sum for Ollivander Family
SELECT `deposit_group`,sum(`deposit_amount`) as 'total_sum'
FROM `wizzard_deposits`
WHERE `magic_wand_creator` LIKE 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group` ASC;

#Ex: 07. Deposits Filter
SELECT `deposit_group`,sum(`deposit_amount`) as 'total_sum'
FROM `wizzard_deposits`
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY  `total_sum` DESC;

#Ex: 08. Deposit Charge
SELECT `deposit_group`,`magic_wand_creator`,MIN(`deposit_charge`) as 'min_deposit_charge'
FROM `wizzard_deposits`
GROUP BY `deposit_group` , `magic_wand_creator` 
ORDER BY `magic_wand_creator`asc,`deposit_group`asc;

#Ex: 09. Age Groups
SELECT (
	CASE
		WHEN `age` BETWEEN 0 and 10 THEN '[0-10]'
		WHEN `age` BETWEEN 11 and 20 THEN '[11-20]'
		WHEN `age` BETWEEN 21 and 30 THEN '[21-30]'
		WHEN `age` BETWEEN 21 and 40 THEN '[31-40]'
		WHEN `age` BETWEEN 41 and 50 THEN '[41-50]'
		WHEN `age` BETWEEN 51 and 60 THEN '[51-60]'
        ELSE '[61+]'
    END
) as 'age_group' , COUNT(*) as 'wizard_count'
FROM `wizzard_deposits`
GROUP BY `age_group`;

#Ex: 10. First Letter
SELECT LEFT(`first_name`,1) as 'first_letter'
FROM `wizzard_deposits`
WHERE `deposit_group` like 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter` asc;

#Ex: 11. Average Interest
SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) as 'average_interest'
FROM wizzard_deposits
WHERE deposit_start_date >'1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC , is_deposit_expired;

#Ex: 12. Employees Minimum Salaries 
 