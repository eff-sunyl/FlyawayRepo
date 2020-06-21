#Login table
create table login
(
name varchar(30) not null,
gender varchar(10) not null,
createdate timestamp default current_timestamp,
username varchar(40) not null unique,
contact int unsigned not null,
password varchar(20) not null,
email varchar(30) not null
);

insert into login (name,gender,username,contact,password,email,role) values("admin", "Male", "admin",9703802507,"admin","ratboddu@gmail.com","admin");

insert into login (name,gender,username,contact,password,email,role) values(?, ?, ?,?,?,?,?)

select username from login where username=? and password=?
##
Stored procedure in mysql:
DELIMITER $$
CREATE PROCEDURE  PRODUCT_PROC (
	IN pid int,
    OUT pname varchar(50),
    INOUT pprice decimal(10,2)
)
BEGIN

	declare tempPrice decimal(10,2);
    
    -- Select data
	select name,price into pname,tempPrice from product where id = pid;
    
    -- Update new price
    update product set price=pprice where  id = pid;
    
    -- Return old price
    set pprice= tempPrice;
    
END$$
DELIMITER ;

Stored procedure for flyaway:
Insert login--

DELIMITER // ;
CREATE PROCEDURE insert_login(IN p_name varchar(30),IN p_gender varchar(10), IN p_username varchar(40), IN p_contact varchar(10), IN p_password varchar(20),IN p_email varchar(30),p_role varchar(10))
BEGIN
insert into login(name,gender,username,contact,password,email,role) values (p_name,p_gender, p_username,p_contact,p_password,p_email,p_role);
END //


CALL insert_login("anil","Male","aneil","7123456789","aniel4you","aniel@gmail.com","user")//
CALL insert_login(?,?,?,?,?,?,?")
###
create table passenger
(
p_name varchar(30) not null,
p_sex varchar(10) not null,
user_name varchar(40) not null,
p_age int unsigned not null,
p_id int auto_increment not null primary key,
foreign key (user_name) references login(username)
);
###
create table master_s_d
(
source varchar(30) not null,
destination varchar(40) not null,
sd_id int auto_increment not null primary key
);
###
create table carrier
(
cid int not null primary key,
c_name varchar(30) not null
);
###
create table flights
(
m_sd_id int not null,
foreign key (m_sd_id) references master_s_d(sd_id),
c_id int not null,
foreign key (c_id) references carrier(cid),
fprice double(10,2) not null,
arrival_time_to_destination varchar(10),
departure_from_source_time varchar(10),
available varchar(20) not null,
f_id int not null primary key
);
###
alter table carrier add fid int not null;
##
alter table carrier
add foreign key (fid) references flights(f_id);
###
To disable / enable foreign key check
SET foreign_key_checks=0/1;
##

select master_s_d.source,master_s_d.destination,carrier.c_name,flights.fprice,flights.arrival_time_to_destination,flights.departure_from_source_time,flights.available,flights.f_id,flights.c_id,flights.m_sd_id from flights,master_s_d,carrier where flights.m_sd_id=sd_id and flights.c_id=carrier.cid and master_s_d.source="Bangalore" and master_s_d.destination="Hyderabad";
##
select master_s_d.source,master_s_d.destination,carrier.c_name as airlines,flights.fprice,flights.arrival_time_to_destination as arrival,flights.departure_from_source_time as departure,flights.available,flights.f_id from flights,master_s_d,carrier where flights.m_sd_id=sd_id and flights.c_id=carrier.cid and flights.f_id=10000;

select master_s_d.source,master_s_d.destination,carrier.c_name as airlines,flights.fprice,flights.arrival_time_to_destination as arrival,flights.departure_from_source_time as departure,flights.available,flights.f_id from flights,master_s_d,carrier where flights.m_sd_id=sd_id and flights.c_id=carrier.cid and flights.f_id=?;

##
Procedure to insert passenger
insert_passenger

DELIMITER // ;
CREATE PROCEDURE insert_passenger(IN name varchar(30),IN sex varchar(10), IN username varchar(40), IN age INT)
BEGIN
insert into passenger(p_name,p_sex,user_name,p_age) values (name,sex,username,age);
END //
#
CREATE TABLE tickets (flight_id int NOT NULL, u_name varchar(40) NOT NULL, date_of_travel date NOT NULL, date_of_booking timestamp DEFAULT CURRENT_TIMESTAMP, tid int NOT NULL AUTO_INCREMENT, passenger_id int NOT NULL AUTO_INCREMENT, payment_status varchar(20) NOT NULL, PRIMARY KEY (tid), FOREIGN KEY (flight_id) REFERENCES flights (f_id) , FOREIGN KEY (u_name) REFERENCES login (username) , INDEX flight_id (flight_id), INDEX u_name (u_name), INDEX passenger_id (passenger_id)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
###
create table tickets (
flight_id int NOT NULL,
u_name varchar(40) NOT NULL, 
date_of_travel varchar(30) NOT NULL, 
date_of_booking timestamp DEFAULT CURRENT_TIMESTAMP,
tid int NOT NULL AUTO_INCREMENT,
p_age int unsigned not null,
p_name varchar(30) not null,
p_sex varchar(10) not null,
payment_status varchar(20) NOT NULL, 
PRIMARY KEY (tid), 
FOREIGN KEY (flight_id) REFERENCES flights (f_id),
FOREIGN KEY (u_name) REFERENCES login (username)
);
##
Procedure to insert passenger
insert_passenger

DELIMITER // ;
CREATE PROCEDURE insert_tickets(IN fid varchar(30),IN username varchar(40),IN dot varchar(10), IN age INT,IN name varchar(30),IN sex varchar(10), IN payment varchar(20))
BEGIN
insert into tickets(flight_id, u_name, date_of_travel, p_age, p_name, p_sex, payment_status) values (fid,username,dot,age,name,sex,payment);
END //

INSERT INTO tickets (flight_id, u_name, date_of_travel, p_age, p_name, p_sex, payment_status) VALUES (0, '', '', '', 0, 0, '', '', '');


latest insert_tickets procedure:
DELIMITER // ;
create procedure insert_tickets (IN p1 INT, IN p2 varchar(40), IN p3 varchar(30),IN p4 INT,IN p5 varchar(30),IN p6 varchar(10), IN p7 varchar(20),OUT p8 INT)
BEGIN
insert into tickets(flight_id, u_name, date_of_travel, p_age, p_name, p_sex, payment_status) values (p1,p2,p3,p4,p5,p6,p7);
set p8 = LAST_INSERT_ID();
END //





