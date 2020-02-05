use mysql_exercise_basic;
alter table blog
add constraint FK_BlogCategory
foreign key (category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE cascade,
add constraint FK_BlogUser
foreign key (user_id) REFERENCES `user`(id) on update cascade on delete cascade;

alter table news
add constraint FK_NewsCategory
foreign key (category_id) references category(id) on update cascade on delete cascade;

alter table `comment`
add constraint FK_CommentUser
foreign key (user_id) references `user`(id) on update cascade on delete cascade;

alter table follow
add constraint FK_FollowUserFrom
foreign key (from_user_id) references `user`(id)  on update cascade on delete cascade,
add constraint FK_FollowUserTo
foreign key (to_user_id) references `user`(id) on update cascade on delete cascade;

-- after create table and create foreign key for my database I'll import data by CLI with:
-- mysql -u root -p mysql_exercise_basic < /home/lengocthuan/AST-WINTER-IT-PHP/mysql/only_data.sql
-- database name : mysql_exercise_basic
-- path to sql file data:  /home/lengocthuan/AST-WINTER-IT-PHP/mysql/only_data.sql
