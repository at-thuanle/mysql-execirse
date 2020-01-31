use mysql_exercise_basic;
create table blog(
id int(11) not null primary key,
category_id int(11) not null,
user_id int(11),
title varchar(255),
`view` int(11),
is_active  tinyint(1) not null,
content text,
created_at timestamp DEFAULT CURRENT_TIMESTAMP,
updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);

create table category(
id int(11) not null primary key,
title varchar(255),
description varchar(255)
);

create table comment(
id int(11) not null primary key,
target_table varchar(20),
target_id int(11),
user_id int(11) not null,
`comment` text,
created_at timestamp DEFAULT CURRENT_TIMESTAMP,
updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);

create table follow(
id int(11) not null primary key,
from_user_id int(11) not null,
to_user_id int(11) not null,
created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

create table news(
id int(11) not null primary key,
category_id int(11) not null,
title varchar(255),
`view` int(11),
is_active tinyint(1),
content text,
created_at timestamp DEFAULT CURRENT_TIMESTAMP,
updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);

create table `user`(
id int(11) not null primary key,
full_name varchar(255),
email varchar(255),
rank tinyint(4),
is_active tinyint(1),
created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

/* 
create table tutorials_tbl(
   tutorial_id INT NOT NULL AUTO_INCREMENT,
   tutorial_title VARCHAR(100) NOT NULL,
   tutorial_author VARCHAR(40) NOT NULL,
   submission_date DATE,
   PRIMARY KEY ( tutorial_id )
);

CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID)
);
*/
