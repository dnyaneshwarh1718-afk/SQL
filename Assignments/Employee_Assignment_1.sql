create database Assignment1;
use Assignment1;
drop table if exists employees;
drop table if exists department;
drop table if exists salary_grade;

create table department(
	dep_id int,
    dep_name varchar(14),
    dep_location varchar(15),
    constraint pk_department_dep_id primary key(dep_id));
    
create table employees(
	emp_id int,
    emp_name varchar(20),
    job_name varchar(20),
    manager_id int,
    hire_date date,
    salary decimal(10,2),
    commission decimal(7,2),
    dep_id int,
    constraint fk_employees_emp_id primary key(emp_id),
    constraint fk_employees_dep_id foreign key(dep_id) references department(dep_id)
    );
    
create table salary_grade(
	grade int,
	min_salary int,
    max_salary int
);

insert into department values (1001,'FINANCE', 'SYDNEY');
insert into department values (2001,'AUDIT', 'MELBOURNE');
insert into department values (3001,'MARKETING', 'PERTH');
insert into department values (4001,'PRODUCTION', 'BRISBANE');


insert into employees values (68319, 'KAYLING', 'PRESIDENT',NULL,'1991-11-18', 6000,NULL,1001);
insert into employees values (66928, 'BLAZE', 'MANAGER',68319,'1991-05-01', 2750,NULL,3001);
insert into employees values (67832, 'CLARE', 'MANAGER',68319,'1991-06-09', 2550,NULL,1001);
insert into employees values (65646, 'JONAS', 'MANAGER',68319,'1991-04-02', 2957,NULL,2001);
insert into employees values (64989, 'ADELYN', 'SALESMAN',66928,'1991-02-20', 1700,400,3001);
insert into employees values (65271, 'WADE', 'SALESMAN',66928,'1991-02-22', 1350,600,3001);
insert into employees values (66564, 'MADDEN', 'SALESMAN',66928,'1991-09-28', 1350,1500,3001);
insert into employees values (68454, 'TUCKER', 'SALESMAN',66928,'1991-09-08', 1600,0,3001);
insert into employees values (68736, 'ADNRES', 'CLERK',67858,'1997-05-23', 1200,NULL,2001);
insert into employees values (69000, 'JULIUS', 'CLERK',66928,'1991-12-03', 1050,NULL,3001);
insert into employees values (69324, 'MARKER', 'CLERK',67832,'1992-01-23', 1400,NULL,1001);
insert into employees values (67858, 'SCARLET', 'ANALYST',65646,'1997-04-19', 3100,NULL,2001);
insert into employees values (69062, 'FRANK', 'ANALYST',65646,'1991-12-03', 3100,NULL,2001);
insert into employees values (63679, 'SANDRINE', 'CLERK',69062,'1990-12-18', 900,NULL,2001);

insert into salary_grade values (1,800,1300);
insert into salary_grade values (2,1301,1500);
insert into salary_grade values (3,1501,2100);
insert into salary_grade values (4,2101,3100);
insert into salary_grade values (5,3101,9999);

-- 1. Write a query in SQL to display all the information of the employees.
select * from employees;
  
-- 2. Write a query in SQL to find the salaries of all employees
select top 5 salary from employees

    
-- 3. Write a query in SQL to display the unique designations for the employees.
select distinct job_name from employees;

-- 4. Write a query in SQL to list the emp_name and salary is increased by 15% and expressed as no.of Dollars.    
select 
	emp_name,
    format(1.15*salary,'C') as Revised_Salary
from employees;

-- 5. Write a query in SQL to produce the output of employees name and job name as a fromat of "Employee & Job".
select concat(emp_name, '   ',job_name) as Employee_and_Job
from employees;

-- 6. Write a query in SQL to produce the output of employees as follows.  Employee JONAS (manager).
select concat(emp_name,'   (', lower(job_name),')') as Employee
from employees;

-- 7. Write a query in SQL to list the employees with Hire date in the format like February 22, 1991
select CONVERT(char,hire_date,107) as date
from employees;   

-- 8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.    
select emp_name, len(trim(emp_name)) as Length_of_Name
from employees;

-- 9. Write a query in SQL to list the emp_id,salary, and commission of all the employees.    
select emp_id, salary, commission from employees;

-- 10. Write a query in SQL to display the unique department with jobs.    
select distinct dep_id, job_name from employees;

-- 11. Write a query in SQL to list the employees who does not belong to department 2001.    
select * from employees
where dep_id <> 2001;

-- 12. Write a query in SQL to list the employees who joined before 1991 
select * from Employees
where hire_date < '1991-01-01';

-- 13. Write a query in SQL to display the average salaries of all the employees who works as ANALYST.   
select  job_name, round(Avg(salary),2) as Avg_Salary from employees
where job_name = 'ANALYST'
group by  job_name;

-- 14. Write a query in SQL to display the details of the employee BLAZE.    
select * from Employees
where emp_name = 'BLAZE';

-- 15. Write a query in SQL to display all the details of the employees whose commission is more than their salary. 
select * from Employees
where commission > salary;

-- 16. Write a query in SQL to list the employees whose salary is more than 3000 after giving 25% increment.    
select *  from Employees
where (1.25*salary) > 3000;

-- 17. Write a query in SQL to list the name of the employees, those having six characters to their name. 
select * from employees
where len(trim(emp_name)) = 6;

-- 18. Write a query in SQL to list the employees who joined in the month January.   
select * from employees
where month(hire_date) = (1);

-- 19. Write a query in SQL to list the name of employees and their manager separated by the string 'works for'.   
SELECT 
    CONCAT(e.emp_name, ' Works for ', m.emp_name) AS Employee_Manager_Relationship
FROM employees e
JOIN employees m 
    ON e.manager_id = m.emp_id;

-- 20. Write a query in SQL to list all the employees whose designation is CLERK.    
select * from Employees
where job_name = 'CLERK';

-- 21. Write a query in SQL to list the employees whose experience is more than 27 years.   
select *, datediff(year,hire_date, GETDATE())as Experience from employees
where datediff(year, hire_date, getdate()) > 27;

-- 22. Write a query in SQL to list the employees whose salaries are less than 3500 
select * from employees
where salary < 3500;

-- 23. Write a query in SQL to list the name, job_name, and salary of any employee whose designation is ANALYST.    
select emp_name, job_name, salary from employees
where job_name = 'ANALYST';

-- 24. Write a query in SQL to list the employees who have joined in the year 1991. 
select * from employees
where year(hire_date) = '1991';

-- 25. Write a query in SQL to list the name, id, hire_date, and salary of all the employees joined before 1 apr 91.    
select emp_name, emp_id, hire_date, salary
from employees
where hire_date < '1991-04-01';

-- 26. Write a query in SQL to list the employee name, and job_name who are not working under a manager.    
 select emp_name, job_name
 from employees
 where manager_id is null;
 
 -- 27. Write a query in SQL to list all the employees joined on 1st may 91 
 select *from employees
 where hire_date = '1991-05-01';
 
 -- 28. Write a query in SQL to list the id, name, salary, and experiences of all the employees working for the manger 68319. 
 select emp_id, emp_name, salary, datediff(year,hire_date, getdate()) as Experience
 from employees
 where manager_id = 68319;

 -- 29. Write a query in SQL to list the id, name, salary, and experience of all the employees who earn more than 100 as daily salary.    
 select emp_id, emp_name, salary, datediff(year,hire_date, getdate()) as Experience
 from employees
 where (salary/30) > 100

 -- 30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period. 
 select emp_name, hire_date
 from employees
 where DATEADD (month, 96, hire_date)> '1991-12-31'

 -- 31. Write a query in SQL to list those employees whose salary is an odd value.    
 select * from Employees
 where salary % 2 = 1;

 -- 32. Write a query in SQL to list those employees whose salary contain only 3 digits. 
 select * from Employees
where len(FORMAT(salary, '#####')) = 3

-- 33. Write a query in SQL to list the employees who joined in the month of APRIL.    
select * from employees
where FORMAT (hire_date,'MMM') ='APR'

select * from employees
where MONTH(hire_date) = 04

select * from employees
where FORMAT (hire_date, 'MMM') Like'APR%'

 -- 34. Write a query in SQL to list the employees those who joined in company before 19th of the month.    
 select *from employees
 where day(hire_date) < '19'


 -- 35. List the employees who are SALESMAN and gathered an experience which month portion is more than 10.    
 select * from employees
 where job_name = 'SALESMAN'
 and DATEDIFF (month, hire_date, getdate()) >10

 -- 36. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.    
 select * from employees
 select * from department

 select * from employees
 where year(hire_date) = '1991'
 and dep_id = 3001
 or dep_id = 1001 
