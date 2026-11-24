CREATE DATABASE employee;
use employee;
create table department(
department_id int primary key,
department_name varchar(100));
select * from department;

create table location(
location_id int primary key,
location varchar (30));
select * from location;

create table employees(
employee_id int primary key,
employee_name varchar(100),
gender enum('M','F'),
age int,
hire_date date,
designation varchar(100),
department_id int,
location_id int,
salary decimal(10,2),
foreign key (department_id) references department(department_id),
foreign key (location_id) references location(location_id));
select * from employees;
desc employees;

---  MODIFY 
alter table employees modify age int check(age >=18);

--- ADD COLUM
alter table employees add column email varchar(100);

---  RENAME 
alter table employees change hire_date joining_date date;

--- table rename

rename table department to DEPARTMENTS;
rename table location TO LOCATIONS;
desc LOCATIONS;
select * from LOCATIONS;

INSERT into locations(location_id, location)
VALUES
(1,'New Yourk'),
(2,'London'),
(3,'Mumbai'),
(4,'kereala'),
(5,'qatar');
INSERT into Departments (department_id, department_name)
VALUES
(1,'finance'),
(2,'HR'),
(3,'IT');
 INSERT into employees(employee_id,employee_name,gender, age,Joining_date, designation,department_id,location_id,salary)
 values
 (1, 'john','M',28,'2014-05-15','Financial',1,1,250000),
 (2,'sara','F',25,'2016-08-11','HR',2,2,150000),
 (3,'HARI','M',35,'2011-02-05','CARGO',3,3,325000),
 (4,'LISA','F',30,'2020-01-06','DATA ANALYSIS', 3,1,526541),
 (5, 'DEV','M',25,'2011-05-25','MANAGER',2,5,598542),
 (6,'TRILOK','M',18,'2020-07-11','IT',2,2,200000);


-- ques 01  query to retrieve distinct salaries from the Employees table.
SELECT DISTINCT salary FROM employees;
-- ques 02 ⦿ Provide aliases for the "age" and "salary" columns as "Employee_Age" and "Employee_Salary", respectively.
SELECT age as employee_age, salary as employee_salary
from employees;

--- 3. Where Clause & Operators:
SELECT *FROM employees WHERE salary >50000 AND joining_date <'2016-01-01';

--- Ques  */ 1. ORDER BY Find employees sorted by department ID in ascending order and salary in descending order. */


SELECT * from employees ORDER BY department_id ASC, Salary DESC;

--- QUES */2.   Display the first 5 employees hired in the year 2011 */

SELECT * FROM employees WHERE year(joining_date)=2011
ORDER BY joining_date LIMIT 5;

-- ques 3 Aggregate Functions

SELECT sum(e.salary) as total_finacial_salary from employees e
join departments d on e.department_id = d.department_id
where d.department_name= 'finance';

-- ques  Find the minimum age among all employees
SELECT MIN(age) as minimum_age FROM employees;

-- ques -4. GROUP BY
-- List the maximum salary for each location.
SELECT l . location, max(e.salary) as Max_salary from employees e
join locations l on e.location_id = l .location_id
group by l.location;

-- Calculate the average salary for each designation containing the word  'HR'

SELECT designation, avg(salary) as Average_salary from employees 
where designation like '%IT%'
GROUP BY designation;

-- ques  5. HAVING:
-- Find departments with less than 3 employees
SELECT d.department_name, count(e.employee_id) as employee_count 
from departments d
left join employees e on d.department_id = e.department_id
GROUP BY d.department_name
having count(e.employee_id) < 3;
--- ques Find locations with female employees whose average age is below 30

SELECT l.location, avg(e.age) as average_age
from employees e
join locations l on e.location_id=l.location_id
where e.gender ='F'
GROUP BY l.location
HAVING avg(e.AGE)<30;

 /* ques  Inner Join
 List employee names, their designations, and department names where
employees are assigned to a department */

SELECT e.employee_name,e.designation,d.department_name
from employees e 
INNER JOIN DEPARTMENTS d ON e.department_id = d.department_id;

--- LEFT JOIN
SELECT d.department_name, count(e.employee_id) as total_employees
FROM departments d
left join employees e on d. department_id = e.department_id
GROUP BY d.department_name
ORDER BY total_employees DESC;

-- RIGHT JOIN

SELECT L.location, e.employee_name
from employees e
right JOIN locations l on e.location_id =l.location_id
order by l.location;