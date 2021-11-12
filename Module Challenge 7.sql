-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
CREATE TABLE employees (
     emp_no INT NOT NULL,
	 birth_date DATE NOT NULL,
	 first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
	 gender VARCHAR NOT NULL,
	 hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	 emp_no INT NOT NULL,
	 dept_no VARCHAR NOT NULL,
	 from_date DATE NOT NULL,
	 to_date DATE NOT NULL
);

SELECT * FROM employees;

-- Retrieve the title, from_date, and to_date columns from the Titles table.
CREATE TABLE titles(
  	 emp_no INT NOT NULL,
	 title VARCHAR NOT NULL,
	 from_date DATE NOT NULL,
	 to_date DATE NOT NULL
);

SELECT * FROM titles;

-- Create a new table using the INTO clause.
SELECT emp_no, birth_date, first_name, last_name
INTO new_table_employees
FROM employees

SELECT * FROM new_table_employees

SELECT emp_no, title, from_date, to_date
INTO new_table_titles
FROM titles

SELECT * FROM new_table_titles

-- Join both tables on the primary key.

SELECT new_table_employees.emp_no,
	new_table_employees.first_name,
	new_table_employees.last_name,
	new_table_titles.title,
	new_table_titles.from_date,
	new_table_titles.to_date
INTO retirement_titles
FROM new_table_employees
INNER JOIN new_table_titles
ON new_table_employees.emp_no = new_table_titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no

SELECT * FROM retirement_titles

-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
--------SEE ABOVE___________


-- Use Dictinct with Orderby to remove duplicate rows
SELECT 
	retirement_titles.emp_no,
	retirement_titles.first_name,
	retirement_titles.last_name,
	string_agg(retirement_titles.title,'/') AS titles
INTO unique_titles
FROM retirement_titles
GROUP BY
	retirement_titles.emp_no,
	retirement_titles.first_name,
	retirement_titles.last_name
ORDER BY emp_no ASC;

SELECT * FROM unique_titles
-- Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.

SELECT title, COUNT(*) AS "count"
INTO retiring_titles
FROM retirement_titles
GROUP BY title

SELECT * FROM retiring_titles

SELECT DISTINCT ON (emp_no)
	employees.emp_no, employees.first_name,	employees.last_name, employees.birth_date,
	dept_emp.from_date, dept_emp.to_date,
	titles.title
INTO mentor_ready
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles ON dept_emp.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
ORDER BY emp_no ASC;

SELECT * FROM mentor_ready	
	