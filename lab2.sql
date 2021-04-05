
------------------------------------
-- drop in reverse order to handle dependencies
------------------------------------


drop table if exists contact_info;
drop table if exists assembly;
drop table if exists line_worker;
drop table if exists computer;
drop table if exists warranty_policy;


------------------------------------
-- warranty_policy
------------------------------------




create table warranty_policy (
policy_id 		VARCHAR (15) not null,
policy_name 	VARCHAR (50),
coverage_days	int,
primary key (policy_id))
;

insert into warranty_policy values ('1', 'first policy', 120);

select * from warranty_policy;


------------------------------------
-- computer
------------------------------------



create table computer (
serial_number 	VARCHAR (15) not null,
cpu_speed 		INT,
memory_capacity	INT,
price 			MONEY,
dvd_speed 		INT,
policy_id 		VARCHAR (15) not null,
primary key (serial_number),
foreign key (policy_id) references warranty_policy(policy_id)
);

insert into computer values ('comp123', 50, 3, 53.99, 130, '1');

select * from computer;

------------------------------------
-- line_worker
------------------------------------



create table line_worker (
employee_id 	VARCHAR (150) not null,
first_name 		VARCHAR (150),
last_name		VARCHAR (150),
birthdate 		DATE,
primary key (employee_id))
;

insert into line_worker values ('bob123', 'billy', 'bob', '04-15-1978');

select * from line_worker;

------------------------------------
-- assembly
------------------------------------



create table assembly (
employee_id 	VARCHAR (15) not null,
serial_number 	VARCHAR (15) not null,
build_hours		INT,
foreign key (employee_id) references line_worker(employee_id),
foreign key (serial_number) references computer(serial_number)
);

insert into assembly values ('bob123', 'comp123', 23);

select * from assembly;

------------------------------------
-- contact_info
------------------------------------



create table contact_info (
employee_id 	VARCHAR (15) not null,
phone_number 	VARCHAR (15) not null,
primary key (phone_number),
foreign key (employee_id) references line_worker(employee_id)
);

insert into contact_info values ('bob123', '123-4567');

select * from contact_info;


------------------------------------
-- Challenge 1 - inserting data
------------------------------------


-- warranty
insert into warranty_policy (policy_id , policy_name , coverage_days ) values ('2', 'second policy', 120);
insert into warranty_policy (policy_id , policy_name , coverage_days ) values ('3', 'third policy', 30);
insert into warranty_policy (policy_id , policy_name , coverage_days ) values ('4', 'fourth policy', 240);
insert into warranty_policy (policy_id , policy_name , coverage_days ) values ('5', 'fifth policy', 90);
select * from warranty_policy wp ;

-- computer
insert into computer (serial_number , cpu_speed , memory_capacity , price , dvd_speed , policy_id ) values ('comp124', 50, 3, 253.99, 130, '1');
insert into computer (serial_number , cpu_speed , memory_capacity , price , dvd_speed , policy_id ) values ('comp125', 150, 6, 353.99, 260, '3');
insert into computer (serial_number , cpu_speed , memory_capacity , price , dvd_speed , policy_id ) values ('comp126', 150, 6, 4353.99, 130, '4');
insert into computer (serial_number , cpu_speed , memory_capacity , price , dvd_speed , policy_id ) values ('comp127', 250, 3, 153.99, 260, '2');
select * from computer c ;

-- worker
insert into line_worker (employee_id , first_name , last_name , birthdate ) values ('jadoe', 'jane', 'doe', '04-15-1978');
insert into line_worker (employee_id , first_name , last_name , birthdate ) values ('jdab', 'june', 'dab', '04-15-1978');
insert into line_worker (employee_id , first_name , last_name , birthdate ) values ('jdoe', 'john', 'doe', '04-15-1978');
insert into line_worker (employee_id , first_name , last_name , birthdate ) values ('bboop', 'betty', 'boop', '04-15-1978');
select * from line_worker lw ;

-- assembly
insert into assembly (employee_id, serial_number, build_hours) values ('jadoe', 'comp124', 23);
insert into assembly (employee_id, serial_number, build_hours) values ('jdab', 'comp125', 23);
insert into assembly (employee_id, serial_number, build_hours) values ('jdoe', 'comp126', 23);
insert into assembly (employee_id, serial_number, build_hours) values ('bboop', 'comp127', 23);
select * from assembly;

-- contact
insert into contact_info (employee_id , phone_number ) values ('jadoe', '223-4567');
insert into contact_info (employee_id , phone_number ) values ('jdab', '323-4567');
insert into contact_info (employee_id , phone_number ) values ('jdoe', '423-4567');
insert into contact_info (employee_id , phone_number ) values ('jdoe', '523-7890');
select * from contact_info ci ;


--- Part 2-a - I changed the table name and redid the apostrophese to be quotes
insert into warranty_policy values ('p02', null, 2);
select * from warranty_policy wp;

-- Part 2-b -this will not work because policy id is required
-- insert into warranty_policy values (null, '5 year warranty',5);

-- Part 3 - The directions don't say to use the code included, so I wrote my own for practice - which means these don't line up. i changed to the id we just entered, and added another row with one i had previously which is used by another table, which is what I think this exercise is supposed to do? 
delete from warranty_policy where policy_id='p02';
-- delete from warranty_policy where policy_id='1';



------------------------------------
-- Challenge 2 
------------------------------------


-- Part 2
select a2.serial_number , lw.first_name , lw.last_name 
from line_worker lw 
join assembly a2 
	on a2.employee_id = lw.employee_id 
order by 
	a2.serial_number asc,
	lw.last_name asc;



-- Part 3
-- it doesnt say sum, but i think we're supposed to use it??? adding data to practice sum()

insert into assembly (employee_id, serial_number, build_hours) values ('jadoe', 'comp123', 7);
insert into assembly (employee_id, serial_number, build_hours) values ('jdab', 'comp123', 4);
insert into assembly (employee_id, serial_number, build_hours) values ('jdab', 'comp126', 3);
insert into assembly (employee_id, serial_number, build_hours) values ('jdab', 'comp124', 1);
insert into assembly (employee_id, serial_number, build_hours) values ('jdab', 'comp127', 10);
insert into assembly (employee_id, serial_number, build_hours) values ('jdab', 'comp125', 2);

select a.serial_number , sum(a.build_hours) as total_hours
from assembly a 
group by a.serial_number 
order by total_hours desc








