PS C:\WINDOWS\system32> docker exec -it my_postgres psql -U admin -d mydb
psql (18.0 (Debian 18.0-1.pgdg13+3))
Type "help" for help.
-- : Check current tables
mydb=# \dt
Did not find any tables.

-- Task 1: Create table1 and table2 with primary key
mydb=# CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name TEXT UNIQUE
);
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INT,
    salary NUMERIC
);
CREATE TABLE
CREATE TABLE
mydb=# \dt
            List of tables
 Schema |    Name     | Type  | Owner
--------+-------------+-------+-------
 public | departments | table | admin
 public | employees   | table | admin
(2 rows)

-- Task 2: Add foreign key constraint
mydb=# ALTER TABLE employees
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);
ALTER TABLE

-- 3. Create Index on Salary Column
mydb=# CREATE INDEX idx_salary
ON employees(salary);
CREATE INDEX
-- 4. Insert Data into Tables
mydb=# INSERT INTO departments (dept_name) VALUES
('HR'),
('Finance'),
('IT'),
('Marketing');
INSERT 0 4
mydb=# INSERT INTO employees (emp_name, dept_id, salary) VALUES
('Nikhil', 1, 50000),
('Alice', 2, 60000),
('Bob', 3, 55000),
('Charlie', 3, 70000),
('David', 4, 65000),
('Eve', 2, 62000);
INSERT 0 6
-- 5. Queries
mydb=# SELECT * FROM departments;
SELECT * FROM employees;
 dept_id | dept_name
---------+-----------
       1 | HR
       2 | Finance
       3 | IT
       4 | Marketing
(4 rows)

 emp_id | emp_name | dept_id | salary
--------+----------+---------+--------
      1 | Nikhil   |       1 |  50000
      2 | Alice    |       2 |  60000
      3 | Bob      |       3 |  55000
      4 | Charlie  |       3 |  70000
      5 | David    |       4 |  65000
      6 | Eve      |       2 |  62000
(6 rows)
-- 6. SELECT with WHERE, NOT IN, LIKE, ORDER BY
mydb=# SELECT emp_name, salary
FROM employees
WHERE salary > 55000
AND dept_id NOT IN (1,4)
AND emp_name LIKE 'A%'
ORDER BY salary DESC;
 emp_name | salary
----------+--------
 Alice    |  60000
(1 row)
-- 
mydb=# SELECT dept_id, COUNT(emp_id) AS num_employees, SUM(salary) AS total_salary
FROM employees
GROUP BY dept_id
HAVING COUNT(emp_id) > 1;
 dept_id | num_employees | total_salary
---------+---------------+--------------
       3 |             2 |       125000
       2 |             2 |       122000
(2 rows)

-- 7. JOINs
mydb=# SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;
 emp_name | salary | dept_name
----------+--------+-----------
 Nikhil   |  50000 | HR
 Alice    |  60000 | Finance
 Bob      |  55000 | IT
 Charlie  |  70000 | IT
 David    |  65000 | Marketing
 Eve      |  62000 | Finance
(6 rows)
-- 7. LEFT JOIN
mydb=# SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
 emp_name | salary | dept_name
----------+--------+-----------
 Nikhil   |  50000 | HR
 Alice    |  60000 | Finance
 Bob      |  55000 | IT
 Charlie  |  70000 | IT
 David    |  65000 | Marketing
 Eve      |  62000 | Finance
(6 rows)
-- 8. Transactions
mydb=# INSERT INTO employees (emp_name, dept_id, salary) VALUES ('Frank', 1, 58000);
INSERT INTO employees (emp_name, dept_id, salary) VALUES ('Grace', 2, 61000);
COMMIT;
INSERT 0 1
INSERT 0 1
WARNING:  there is no transaction in progress
COMMIT;

-- Update salaries and commit
mydb=# UPDATE employees SET salary = 63000 WHERE emp_name='Alice';
COMMIT;
UPDATE 1
WARNING:  there is no transaction in progress
COMMIT;

-- Insert new employee and rollback
mydb=# INSERT INTO employees (emp_name, dept_id, salary) VALUES ('Hannah', 3, 72000);
INSERT 0 1

-- Rollback the last insert
mydb=# ROLLBACK;
WARNING:  there is no transaction in progress
ROLLBACK

-- Verify rollback
mydb=# UPDATE employees SET salary = 56000 WHERE emp_name='Bob';
COMMIT;
UPDATE 1
WARNING:  there is no transaction in progress
COMMIT;
-- Final data check
mydb=# SELECT * FROM employees;
SELECT * FROM departments;
 emp_id | emp_name | dept_id | salary
--------+----------+---------+--------
      1 | Nikhil   |       1 |  50000
      4 | Charlie  |       3 |  70000
      5 | David    |       4 |  65000
      6 | Eve      |       2 |  62000
      7 | Frank    |       1 |  58000
      8 | Grace    |       2 |  61000
      2 | Alice    |       2 |  63000
      9 | Hannah   |       3 |  72000
      3 | Bob      |       3 |  56000
(9 rows)

 dept_id | dept_name
---------+-----------
       1 | HR
       2 | Finance
       3 | IT
       4 | Marketing
(4 rows)