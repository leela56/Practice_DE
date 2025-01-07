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
	eid INT,
	name VARCHAR(20) UNIQUE,
	join_date DATE NOT NULL,
	salary INT,
	manager INT,
	CONSTRAINT PK_ID PRIMARY KEY(eid),
	CONSTRAINT FK_DID FOREIGN KEY(department) REFERENCES department(did)
);

INSERT INTO employees VALUES
	(100, 'Jane', '01/07/2025', 50000, 101),
	(102, 'Sam', '01/07/2024', 20000, 104),
	(104, 'John', '01/07/2023', 60000, 105),
	(105, 'Micahel', '01/07/2022', 8000, 106)

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

