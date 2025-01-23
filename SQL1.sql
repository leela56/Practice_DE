--1.Creating table
CREATE TABLE department(
	did VARCHAR(20),
	name VARCHAR(20) NOT NULL,
	CONSTRAINT PK_DEPT PRIMARY KEY(did)
);
INSERT INTO department VALUES
	('D1', 'Management'),
	('D2', 'IT'),
	('D3', 'HR')

--2.Creating Employee table
CREATE TABLE employees(
	empid INT,
	fname VARCHAR(20) UNIQUE,
	lname VARCHAR(20),
	join_date DATE NOT NULL,
	salary INT,
	manager INT,
	CONSTRAINT PK_ID PRIMARY KEY(eid),
	CONSTRAINT FK_DID FOREIGN KEY(department) REFERENCES department(did)
);

INSERT INTO employees VALUES
	(100, 'Jane', 'Smith', '01/07/2025', 50000, 101),
	(102, 'Sam', 'ith', '01/07/2024', 20000, 104),
	(104, 'John', 'Doe', '01/07/2023', 60000, 105),
	(105, 'Micahel', 'Jackson', '01/07/2022', 80000, 106)

--3.How to select 2nd highest salary ?

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

--4.How to get the nth Highest salary ?
SELECT salary
	FROM(SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rank from employees) AS ranked_salaries
WHERE rank = N;

--5.How do you fetch all employees whose salary is greater than the average salary ?
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

ALTER TABLE employees
ADD dob DATE
ADD hire_date DATE

--6.Calculating the age of employee based from date of birth
SELECT empid
	TIMESTAMP(YEAR, dob, CURDATE()) AS age
FROM employees;

--7.Number of years each employee has been working in the company
SELECT 
	empid, 
	hire_date,
	TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_working
FROM
	employees;

--8.Find Employees assigned to multiple projects 
SELECT employee_id, COUNT(project_id) AS project_count
FROM employee_projects
GROUP BY employee_id
HAVING COUNT(peoject_id) > 1;
--9.Average of each department
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;
--10.