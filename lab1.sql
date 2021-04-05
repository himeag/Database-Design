drop table if exists employee
;
create table employee (
first_name 		VARCHAR (15) not null,
middle_initial 	CHAR (1),
last_name 		VARCHAR (15) not null,
SSN 			CHAR (9) not null,
DOB 			DATE,
address 		VARCHAR (30),
gender 			CHAR (1),
salary 			MONEY,
SSN_supervisor 	CHAR (9), 
department_id 	smallint not null,
primary key (SSN))

;

alter table employee alter column ssn type integer using (SSN::INTEGER);

alter table employee alter column SSN type CHAR(9);

INSERT INTO employee VALUES ('Doug', 'E', 'Gilbert', 123456780,
'1960-06-09', '300 South 200 West', 'M', 81200.05, NULL, 1)
;
INSERT INTO employee VALUES ('Amy', 'C', 'Elyot', 123456789,
'1973-03-26', '100 Main St.', 'F', 80000.00, NULL, 1)
;
INSERT INTO employee (first_name, last_name, SSN,
SSN_supervisor, department_id) VALUES ('Richard', 'Smith',
987654321, 123456789, 1)
;
INSERT INTO employee (first_name, last_name, SSN, department_id) 
VALUES ('George', 'Haman', 123456783, 2);


SELECT * FROM employee;



create table department (
department_name VARCHAR(30) not null,
department_id smallint not null,
SSN_manager int,
manager_start_date VARCHAR(30)

);

select * from department d 


INSERT INTO department VALUES ('R and D', 1, 123456789, '2014-07-14');
INSERT INTO department VALUES ('Finance', 2, 123456783, '2016-02-07');
INSERT INTO department (department_id, department_name, SSN_manager, manager_start_date) VALUES (3, 'Marketing', 123456788, '2012-04-21');
INSERT INTO department (department_id, department_name) VALUES (4, 'Human Resources');

select  e.first_name, e.last_name, d.department_name
from department d
left join employee e on e.department_id = d.department_id 




