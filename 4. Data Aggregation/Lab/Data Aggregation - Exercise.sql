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
 