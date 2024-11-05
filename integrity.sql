-- properties of an ideal databases 
-- constraints in mysql 
-- NOT NULL, UNIQUE(COMBO) , PRIMARY KEY , AUTO INCREMENT ,CHECK, DEFAULT ,FOREIGN KEY

-- LETS START WITH THE FIRST
use sipalaya;

-- DROP THE TABLE 
DROP TABLE users;

-- create the table users --> apply the NOT NULL
CREATE TABLE users (
                    user_id INTEGER NOT NULL,
                    email  VARCHAR(200),
                    name VARCHAR(200),
                    password VARCHAR(200));

SELECT * FROM users;

-- lets try to insert our values 
insert into users values(1,"sarojgiri@gmail.com",NULL,NULL);
insert into users values(2,"sumangiri@gmail.com",NULL,NULL);

-- if we try to insert the data null for the user_id and the email
insert into users values(Null,Null,'sangam','hellow_world@321');
-- this will throw an error because we violet the rules 

-- check the data if it correctly works 
SELECT * FROM users;

-- DROP THE TABLE
DROP TABLE users;

-- TRUNCATE RTHE TABLES
TRUNCATE users;

-- AUTO INCREMENT(we have to use PRIMARYKEY FOR AUTO_INC) AND THE UNIQUE 
 CREATE TABLE users (
                    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
                    email  VARCHAR(200) UNIQUE,
                    name VARCHAR(200),
                    password VARCHAR(200));

-- lets try to insert our datas 
insert into users values(NULL,"sarojgiri@gmail.com",NULL,NULL);
insert into users values(NULL,"sumangiri@gmail.com",NULL,NULL);
-- the below line will throw an error because the duplicate value is present in the email
insert into users values(NULL,"sumangiri@gmail.com",NULL,NULL);

insert into users values(10,"sumangiri@gmai.com",NULL,NULL);
-- if we privide the value it overrides tha values -- auto increment from the last values
insert into users values(NULL,"suma@gmai.com",NULL,NULL);

SELECT * FROM users;

-- TRUNCATE RTHE TABLES
TRUNCATE users;

-- DROP TABLE users;
DROP TABLE users;

-- CHECK CONSTRAINTS 
-- the age shouild be the greater than 6 and less than 30 , passowrd shouylb be max 8 length
CREATE TABLE users (
                    user_id INTEGER NOT NULL,
                    age INTEGER CHECK(age>6 AND age<30),
                    email  VARCHAR(200),
                    name VARCHAR(200),
                    password VARCHAR(200) CHECK (LENGTH(password) >= 8));

-- lets inserrt the values 
insert into users values(1,20,'sarojgiri0123@gmail.com','saroj giri','password@3211');
insert into users values(2,22,'sumangiri0123@gmail.com','suman giri','password@1123');

-- lest violet the constraints for the age and the password columns  
insert into users values(3,20,'sangam0123@gmail.com','sangam giri','pass');

SELECT * FROM users;


-- DROP TABLE users;
DROP TABLE users;

-- DEFAULT CONSTRAINTS
 CREATE TABLE users (
                    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
                    email  VARCHAR(200) UNIQUE,
                    name VARCHAR(200),
                    address varchar(200) DEFAULT 'unknown',
                    password VARCHAR(200),
                    logintime DATETIME DEFAULT CURRENT_TIMESTAMP
                    );
                    
-- LETS INSERT THE VALUES 
insert into users(email,name,password) values('sarojgiri0123@gmail.com','saroj giri','password@3211');
insert into users values(NULL,'sumangiri0123@gmail.com','suman giri','Kathmandu','password@1123',NULL);
insert into users(email,name,password,logintime) values('sumangiri10123@gmail.com','suman giri','password@1123','2024-08-31 16:23:00');

INSERT INTO users VALUES(NULL,'sarojgiri0123','sandesh',DEFAULT,'herro',DEFAULT);
SELECT * FROM users;

-- ANOTHER METHOD TO AP[PLY THE CONSTRAINTS 

CREATE TABLE users (
                    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
                    email  VARCHAR(200),
                    password varchar(200),
                    constraint users_email_password_unique UNIQUE(email,password));
                    -- two combinationa are different 
-- insert the values 
INSERT INTO users values(NULL,'SAROJ@GMAIL.COM','HELLOW');
INSERT INTO users values(NULL,'SAROJ1@GMAIL.COM','HEL1LOW');

INSERT INTO users values(NULL,'SAROJ14@GMAIL.COM','HEL1LOW2');

-- two combination are different is valid
SELECT * FROM users;

CREATE TABLE users (
                    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
                    email  VARCHAR(200),
                    phone INTEGER,
                    password varchar(200),
                    constraint users_email_password_unique UNIQUE(email,password),
                    constraint users_phone_UNIQUE UNIQUE(phone));
                    
INSERT INTO users values(NULL,'SAROJ14@G.COM',999,'HELLOW');

SELECT * FROM users;

-- to see the constraints user constraints 
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME
   
FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'sipalaya' 
    AND TABLE_NAME = 'users';

-- SHOW INDEX FROM users; different informations about the tables 

-- ndrop
ALTER TABLE users
DROP INDEX users_email_password_unique; -- drop the constraints sucessfully

ALTER TABLE users 
DROP INDEX users_phone_UNIQUE;


-- drop table users
drop table users;

CREATE TABLE users (
                    user_id  INT PRIMARY KEY AUTO_INCREMENT,
                    email  VARCHAR(200),
                    phone INTEGER,
                    age INTEGER,
                    password varchar(200),
                    constraint users_email_unique UNIQUE(email),
                    constraint users_phone_UNIQUE UNIQUE(phone),
                    constraint users_age_check CHECK(age>10 and age<40));
                    
                    
-- SEE THE DIFFERENT CONSTRAINTS
SELECT TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'sipalaya' 
    AND TABLE_NAME = 'users';

-- DROP THE TABLE
DROP TABLE users;


CREATE TABLE users (
                    user_id  INT PRIMARY KEY AUTO_INCREMENT,
                    email  VARCHAR(200) NOT NULL UNIQUE,
                    phone INTEGER NOT NULL,
                    age INTEGER UNIQUE ,
                    password varchar(200)
                    );
                    
SELECT TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME FROM
    information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'sipalaya' AND TABLE_NAME = 'users';
    
-- INSERT THE VALUES 
INSERT INTO users values(NULL,'SAROJ14@G.COM',999,232,'HELLOW12');

-- DROP THE CONSTRAINTS 
ALTER TABLE users
DROP INDEX email;

-- DROP THE  CONSTRAINTS 
ALTER TABLE users DROP INDEX age;

-- error 
ALTER TABLE users DROP INDEX user_id;


ALTER TABLE users
DROP INDEX email;

select * from users;

show index from users;


-- create the tables
CREATE TABLE users (
                    user_id  INT PRIMARY KEY AUTO_INCREMENT,
                    email  VARCHAR(200) NOT NULL ,
                    phone INTEGER UNIQUE,
                    age INTEGER DEFAULT 30 ,
                    password varchar(200) NOT NULL
                    );
                    
-- DROP THE CONSTRAINTS
ALTER TABLE users DROP INDEX email;  -- not null --error 
ALTER TABLE users DROP INDEX passowrd;  -- error 
ALTER TABLE users DROP INDEX phone;  -- no error 

-- remove the not null constraints
ALTER TABLE users
MODIFY COLUMN email VARCHAR(200) NULL;  -- alters 

-- verify the different constraints                     
SHOW CREATE TABLE users;



