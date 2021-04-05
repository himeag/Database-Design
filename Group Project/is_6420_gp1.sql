DROP TABLE IF EXISTS alltrail_member;
CREATE TABLE alltrail_member(
member_id int not null,
first_name varchar(50),
last_name varchar(50),
address varchar(200),
email varchar(50),
primary key(member_id)
);

insert into alltrail_member (member_id, first_name, last_name, email, address) 
values (1, 'Tammy', 'Carruth', 'tcarruth0@businessweek.com', '55283 Moulton Place');
insert into alltrail_member (member_id, first_name, last_name, email, address) 
values (2, 'Abbey', 'Gaither', 'agaither1@taobao.com', '0946 Corscot Parkway');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (3, 'Gaylord', 'Folli', 'gfolli2@illinois.edu', '82 Alpine Trail');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (4, 'Elizabet', 'Cayton', 'ecayton3@fc2.com', '30 Marcy Avenue');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (5, 'Brenden', 'Emson', 'bemson4@dailymotion.com', '63061 Homewood Crossing');
insert into alltrail_member (member_id, first_name, last_name, email, address) 
values (6, 'Emeline', 'Jephson', 'ejephson5@ed.gov', '4 Lake View Center');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (7, 'Skylar', 'Guihen', 'sguihen6@qq.com', '481 Hermina Center');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (8, 'Corney', 'Hendren', 'chendren7@uol.com.br', '675 Leroy Parkway');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (9, 'Charley', 'Skews', 'cskews8@booking.com', '519 Derek Terrace');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (10, 'Adelind', 'Carcas', 'acarcas9@admin.ch', '90 Darwin Avenue');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (11, 'Chev', 'Lowis', 'clowisa@ow.ly', '85867 Thackeray Street');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (12, 'Corty', 'Pleat', 'cpleatb@hp.com', '0 Memorial Court');
insert into alltrail_member (member_id, first_name, last_name, email, address)
values (13, 'Arvy', 'Dace', 'adacec@mashable.com', '2 Grayhawk Junction');
insert into alltrail_member (member_id, first_name, last_name, email, address) 
values (14, 'Anthia', 'D''Aeth', 'adaethd@lulu.com', '13111 Mifflin Junction');
insert into alltrail_member (member_id, first_name, last_name, email, address) 
values (15, 'Gordie', 'Terzza', 'gterzzae@printfriendly.com', '1 Iowa Alley');


DROP TABLE IF EXISTS trail_review;
CREATE TABLE trail_review(
review_id int not null,
review_date date,
review_text text,
no_of_stars float,
member_id int,
trail_id int,
primary key(review_id),
foreign key(member_id) references alltrail_member(member_id),
foreign key(trail_id ) references trail(trail_id )
);

insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id)
values (1, '2020-12-07', 'Nice', 3, 6, 7);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id) 
values (2, '2019-10-24', 'Awesome hike. Definitely recommend spikes. Didn''t have any and would''ve made a huge impact on the way down. Views at the top and on the way up were incredible. Snow was falling most of the hike. Clouds changed so rapidly. Do this hike!  $5 fee Otw out.', 5, 6, 3);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id)
values (3, '2021-06-05', 'Usually love this trail, but did it today at about 4pm and the snow was VERY soft. Sunk down several feet a few times. It''s not so soft that I''d recommend snowshoes, still very doable with spikes. Just go in the early morning when the sun hasn''t had time to warm the snow', 4, 1, 6);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id) 
values (4, '2021-05-22', 'not bad', 3, 4, 1);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id)
values (5, '2020-02-23', 'Beautiful, not too difficult of a trail.', 5, 4, 7);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id)
values (6, '2021-02-17', 'Actually about 5.2 miles, not 4.2. Snow- packed switchbacks the whole way. Used running spikes and it was just right. ', 5, 10, 5);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id) 
values (7, '2021-01-10', 'Crampons are highly recommend. The views from the trail at certain points were really nice. The end view isn''t spectacular but is very pleasant', 4, 2, 9);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id) 
values (8, '2020-06-06', 'Not bad', 2, 7, 6);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id) 
values (9, '2020-07-10', 'one time visit', 2, 4, 3);
insert into trail_review (review_id, review_date, review_text, no_of_stars, member_id, trail_id)
values (10, '2020-09-28', 'Very bad', 1, 4, 9);


DROP TABLE IF EXISTS trail_review_condition;
CREATE TABLE trail_review_condition(
review_id int,
condition_description text,
primary key(review_id,condition_description),
foreign key(review_id) references trail_review(review_id)
);

insert into trail_review_condition (review_id, condition_description) 
values (8, 'Good');
insert into trail_review_condition (review_id, condition_description) 
values (6, 'Bad');
insert into trail_review_condition (review_id, condition_description)
values (8, 'Very Good');
insert into trail_review_condition (review_id, condition_description)
values (10, 'The best');
insert into trail_review_condition (review_id, condition_description)
values (5, 'Awesome');
insert into trail_review_condition (review_id, condition_description)
values (10, 'Worst');
insert into trail_review_condition (review_id, condition_description)
values (1, 'Need improvement');
insert into trail_review_condition (review_id, condition_description) 
values (9, 'Not good');
insert into trail_review_condition (review_id, condition_description)
values (2, 'Good');
insert into trail_review_condition (review_id, condition_description) 
values (3, 'Great');

DROP TABLE IF EXISTS completed;
CREATE TABLE completed(
member_id int,
trail_id int,
completed_date date,
primary key (member_id,trail_id,completed_date),
foreign key(member_id) references alltrail_member(member_id),
foreign key(trail_id ) references trail(trail_id )
);

insert into completed (member_id, trail_id, completed_date) values (3, 6, '2019-09-13');
insert into completed (member_id, trail_id, completed_date) values (4, 7, '2021-07-01');
insert into completed (member_id, trail_id, completed_date) values (4, 9, '2020-01-15');
insert into completed (member_id, trail_id, completed_date) values (5, 2, '2019-09-20');
insert into completed (member_id, trail_id, completed_date) values (10, 9, '2021-03-25');
insert into completed (member_id, trail_id, completed_date) values (5, 10, '2021-08-05');
insert into completed (member_id, trail_id, completed_date) values (3, 3, '2020-03-16');
insert into completed (member_id, trail_id, completed_date) values (6, 5, '2021-04-05');
insert into completed (member_id, trail_id, completed_date) values (9, 4, '2019-08-10');
insert into completed (member_id, trail_id, completed_date) values (7, 10, '2020-12-08');


DROP TABLE IF EXISTS media;
CREATE TABLE media(
media_id int not null,
review_id int,
trail_id int,
media_type varchar(50),
file_url varchar(500),
primary key(media_id ,review_id,trail_id),
foreign key(review_id) references trail_review(review_id),
foreign key(trail_id ) references trail(trail_id)
);

--Salt Lake Overlook via Desolation Trail
insert into media (media_id, review_id, trail_id, media_type, file_url)
values (1, 3, 10, 'png', 'https://www.alltrails.com/trail/us/utah/desolation-trail-millcreek-portion');

--Rattlesnake Gulch Trail
insert into media (media_id, review_id, trail_id, media_type, file_url)
values (2, 7, 4, 'jpg', 'https://www.alltrails.com/trail/us/utah/rattlesnake-gulch-trail');

--   Grandeur Peak Trail (West Face)
insert into media (media_id, review_id, trail_id, media_type, file_url)
values (3, 4, 2, 'jpg', 'https://www.alltrails.com/trail/us/utah/grandeur-peak-trail-west-face');

--Salt Lake Overlook via Desolation Trail
insert into media (media_id, review_id, trail_id, media_type, file_url)
values (4, 9, 6, 'png', 'https://www.alltrails.com/trail/us/utah/desolation-trail-millcreek-portion');

--Thayne Canyon Loop
insert into media (media_id, review_id, trail_id, media_type, file_url) 
values (5, 8, 7, 'jpg', 'https://www.alltrails.com/trail/us/utah/heidis-favorite-loop');

--Mill Creek Pipeline Trail
insert into media (media_id, review_id, trail_id, media_type, file_url)
values (6, 1, 6, 'png', 'https://www.alltrails.com/trail/us/utah/mill-creek-pipeline-trail');

--Bonneville Shoreline Trail: Olympus Cove to Hughes Canyon
insert into media (media_id, review_id, trail_id, media_type, file_url) 
values (7, 9, 2, 'jpg', 'https://www.alltrails.com/trail/us/utah/bonneville-shoreline-trail-olympus-cove-to-hughes-canyon');

--Rattlesnake Gulch Trail
insert into media (media_id, review_id, trail_id, media_type, file_url)
values (8, 6, 4, 'png', 'https://www.alltrails.com/trail/us/utah/rattlesnake-gulch-trail');

--Mill Creek Pipeline Trail
insert into media (media_id, review_id, trail_id, media_type, file_url) 
values (9, 4, 7, 'jpg', 'https://www.alltrails.com/trail/us/utah/mill-creek-pipeline-trail');

--Mount Olympus Pipeline Trail
insert into media (media_id, review_id, trail_id, media_type, file_url) 
values (10, 6, 7, 'png', 'https://www.alltrails.com/trail/us/utah/mount-olympus-pipeline-trail');

select * from alltrail_member am 
select * from trail_review tr 
select * from completed c 
select * from trail_review_condition trc 
select * from media m 

--member completed trail details
select * 
from alltrail_member t 
inner join completed c 
on t.member_id =c.member_id 

--member reviewed trail info
select * 
from alltrail_member am 
inner join trail_review tr 
on am.member_id = tr.member_id 
inner join trail t 
on tr.trail_id =t.trail_id 

--media associated with trail
select * 
from trail t 
inner join media m 
on t.trail_id = m.trail_id 

--reviews with media attached
select * 
from trail t 
inner join trail_review tr  
on t.trail_id = tr.trail_id
inner join media m 
on m.review_id =tr.review_id 






















----------------below is only for testing 
--this is just for testing only
DROP TABLE IF EXISTS trail;
CREATE TABLE trail(
	trail_id int not null,
	trail_name varchar(50),
	description varchar(200),
	created_date date,
	length_miles int,
	route_type varchar(20),
	difficulty varchar(20),
	avg_rating varchar(20),
	elevation_gain varchar(20),
	primary key(trail_id)
)


--create table trail (
--	trail_id INT,
--	trail_name VARCHAR(50),
--	description VARCHAR(50),
--	created_date DATE,
--	length_miles INT,
--	route_type VARCHAR(20),
--	difficulty VARCHAR(20),
--	avg_rating VARCHAR(20),
--	elevation_gain VARCHAR(20)
--);
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (1, 'San Diego', 'CA', '9/8/2020', 62, '90.239.157.113', '227.206.173.26', '155.103.135.172', '250.189.5.229');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (2, 'Tulsa', 'OK', '8/5/2020', 9, '242.252.171.69', '85.169.84.33', '146.86.13.26', '103.16.128.229');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (3, 'Raleigh', 'NC', '6/17/2020', 48, '30.41.80.191', '27.165.0.51', '178.84.20.242', '81.154.181.191');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (4, 'San Francisco', 'CA', '6/15/2020', 52, '94.99.57.121', '188.203.78.158', '92.111.231.39', '207.119.186.243');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (5, 'Washington', 'DC', '9/4/2020', 48, '198.93.193.75', '179.187.105.54', '105.182.188.206', '107.249.56.153');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (6, 'Portsmouth', 'VA', '12/19/2020', 10, '162.188.14.18', '130.103.240.146', '42.201.204.125', '178.17.11.38');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (7, 'Chico', 'CA', '7/12/2020', 65, '72.181.80.126', '39.231.97.212', '211.93.127.124', '149.123.50.159');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (8, 'Homestead', 'FL', '4/7/2020', 77, '140.113.182.146', '177.22.40.11', '54.51.214.191', '108.68.192.62');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (9, 'Roanoke', 'VA', '1/22/2021', 75, '151.98.162.197', '124.158.106.159', '75.198.109.165', '66.127.251.108');
insert into trail (trail_id, trail_name, description, created_date, length_miles, route_type, difficulty, avg_rating, elevation_gain) values (10, 'Colorado Springs', 'CO', '2/9/2021', 93, '102.175.63.143', '178.191.195.127', '122.102.248.24', '114.231.207.216');


---