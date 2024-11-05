-- this will show The databaes 
show databases;

-- create the database
create database sipalaya;

-- we have to use the databases 
use  sipalaya;


-- create the tables 
 create table data_science(id int, name varchar(30), course varchar(30), age int);

show databases;

-- insert the data into the databases 
insert into  data_science values(1,"saroj giri",'data science',23);

-- insert the multiple values in the databases 
insert into data_science values(2,'madan pandey','data science',25),
(3,'sandesh malla','data science',27),(4,'ghanendra basnet','data science',30);

-- see the different data into the databases 
select * from data_science;

-- using the filter condition to filter the different datas 
select name,course from data_science;

-- filter fetch all the records where age is less than 27 
select * from data_science where age<27;





