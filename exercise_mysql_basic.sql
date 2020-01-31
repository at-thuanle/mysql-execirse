use mysql_exercise_basic;
-- select * from blog;
-- select * from user;
-- select * from follow;
-- select * from comment;
-- select * from category;
-- select * from news;

/* ex1: Tạo database như hình trên (sau khi tạo thì import database, sẽ gửi
sau) 
File database struct and data: struct_data.sql;
File query create table : create-table.sql;
File query create foreign key: alter-table.sql;

/* ex2: Thêm 1 dòng dữ liệu trong bất kỳ table nào
*/
-- table blog
INSERT INTO blog(id,category_id, user_id, title, view, is_active, content) 
VALUES (45,2,11,'Delectus veritatis consequuntur ut dolore perferendis.',
53,1,'Natus dolorum fugit aut. Ut ad eos iusto omnis qui.');
-- select * from blog where id = 45;

/* ex3: Xoá và sửa 1 dòng dữ liệu trong bất kỳ table nào
*/
-- edit any record;
-- table blog;
select * from blog where id = 45;

update blog
set
	content = 'Natus dolorum fugit aut. Delectus veritatis consequuntur'
where
	id = 45;

-- remove any record
-- table blog
delete from blog where id=44;
select * from blog;

/* ex4: Select 10 blog mới nhất đã active
*/
select * from blog where is_active = 1 order by created_at desc limit 10;

/* ex5: Lấy 5 blog từ blog thứ 10
*/
select * from blog limit 5 offset 10;

/* ex6: Set is_active = 0 của user có id = 3 trong bảng user
*/
update user
	set is_active = 0
	where id = 3;
    
-- select * from user where id = 3

/* ex7: Xoá tất cả comment của user = 2 trong blog = 5 
*/
select * from mysql_exercise_basic.comment where target_table = 'blog' and target_id = 5 and user_id = 2; 
delete from `comment` where target_table = 'blog' and target_id = 5 and user_id = 2;

/* ex8: Lấy 3 blog bất kỳ (random)
*/
select * from blog order by rand() limit 3;

/* ex9: Lấy số lượng comment của các blog
*/
-- lấy số lượng cmt của tất cả các blog;
select count(*) as 'Number of blog comments' from comment where target_table = 'blog';

-- lấy số lượng cmt của mỗi blog;
select target_id, count(*) as 'Number of blog comments' from comment
where target_table = 'blog' group by target_id;

/* ex10: Lấy Category có tồn tại blog hoặc news đã active (không được lặp lại
category)
*/
select distinct category_id from blog join category
where blog.category_id = category.id
union
select distinct category_id from news join category
where news.category_id = category.id and news.is_active = 1;

/* ex11: Lấy tổng lượt view của từng category thông qua blog và news
*/
select category_id, sum(total) from
(select category_id, sum(view) as total from blog group by category_id
union
select category_id, sum(view) as total from news group by category_id) as ex11 group by category_id;

/* ex12: Lấy blog được tạo bởi user mà user này không có bất kỳ comment ở
blog
*/
select distinct id, user_id, title from blog where
user_id not in (select user_id from comment where target_table = 'blog');

/* ex13: Lấy 5 blog mới nhất và số lượng comment cho từng blog
*/
-- lấy ra 5 blog mới nhất; 1
select id from blog order by updated_at DESC limit 5;
-- lấy ra số lượng view cho từng blog bên bảng comment; 2
select target_id, count(*) as soluong_view from comment where target_table = 'blog' group by target_id;

-- left join câu truy vấn 2 và 1;
select count(comment), comment.target_id from (select id from blog order by updated_at desc limit 5) as blog_newest left join comment on blog_newest.id = comment.target_id group by comment.target_id;

/* ex14: Lấy 3 User comment đầu tiên trong 5 blogs mới nhất
*/

select comment.user_id ,comment.target_id from (select id from blog order by updated_at DESC limit 5)
as blog_newest left join comment on blog_newest.id = comment.target_id where target_table = 'blog';

/* ex15: Update rank user = 2 khi tổng số lượng comment của user > 20
*/

update `user` set rank = 2 where id in (select user_id as id from 
(select user_id, count(*) as sum_cmt from comment group by user_id having sum_cmt > 20) as count_cmt);

/* ex16: Xoá comment mà nội dung comment có từ "fuck" hoặc "phức"
*/

delete from comment WHERE `comment` like "%fuck%" or `comment` like "fuck%" or `comment` like "%fuck" or
`comment` like "%phức%" or `comment` like "phức%" or `comment` like "%phức";

/* ex17: Select 10 blog mới nhất được tạo bởi các user active
*/

select * from blog where user_id in (select id from user where is_active = 1) order by updated_at DESC limit 10;

/* ex18: Lấy số lượng Blog active của user có id là 1,2,4
*/

select user_id, count(*) as quantity_blog_active from blog where user_id = 1 and is_active = 1 or user_id = 2 and is_active = 1 or user_id = 3 and is_active = 1 group by user_id;

/* ex19: Lấy 5 blog và 5 news của 1 category bất kỳ
*/

-- select id from category where id = (FLOOR(RAND()*(3-1+1))+1);
-- (FLOOR(RAND()*(3-1+1))+1) lấy ra ngẫu nhiên số từ 1 đến 3 (giá trị nguyên);

select blog.id as blog_id, blog.title as blog_title, blog.content as blog_content,
news.id as news_id, news.title as news_title, news.content as news_content
from blog join news 
where blog.category_id = news.category_id limit 5;


/* ex20: Lấy blog và news có lượt view nhiều nhất
*/

(select id as blog_id, view, title from blog order by view DESC limit 1)
union all
(select id as news_id, view, null from news order by view DESC limit 1);

/* ex21: Lấy blog được tạo trong 3 ngày gần nhất
*/

select * from blog where datediff(current_timestamp(), created_at) <= 3;

/* ex22: Lấy danh sách user đã comment trong 2 blog mới nhất
*/

select * from user join 
(select * from comment where target_table = 'blog' order by updated_at DESC limit 2) 
as blog_cmt_newest on user.id = blog_cmt_newest.user_id;

/* ex23: Lấy 2 blog, 2 news mà user có id = 1 đã comment
*/

(select target_id as blog_id, id from comment where user_id = 1 and target_table = 'blog' limit 2)
union all
(select target_id as news_id, null from comment where user_id = 1 and target_table = 'news' limit 2);

/* ex24: Lấy 1 blog và 1 news có số lượng comment nhiều nhất
*/

(select target_id, count(target_id), target_table from comment
where target_table = 'blog' group by target_id order by count(target_id) desc limit 1)
union all
(select target_id, count(target_id), null from comment
where target_table = 'news' group by target_id order by count(target_id) desc limit 1);

/* ex25: Lấy 5 blog và 5 news mới nhất đã active
*/

(select id, title, content, 'blog' from blog where is_active = 1 limit 5)
union all
(select id, title, content, 'news' from news where is_active = 1 limit 5);

/* ex26: Lấy nội dung comment trong blog và news của user id =1
*/

(select comment, 'blog' from comment where target_table = 'blog' and user_id = 1)
union all
(select comment, 'news' from comment where target_table = 'news' and user_id = 1);

/* ex27: Blog của user đang được user có id = 1 follow
*/

select * from blog where user_id in (select to_user_id from follow where from_user_id = 1);

/* ex28: Lấy số lượng user đang follow user = 1
*/

select count(*) as soluong from follow where to_user_id = 1;

/* ex30: Lấy 1 comment(id_comment, comment) mới nhất và thông tin user
của user đang được follow bởi user 1
*/

select id, comment from comment where user_id 
in (select to_user_id from follow where from_user_id = 1)
order by updated_at desc limit 1;


/* ex31: Hiển thị một chuổi "PHP Team " + ngày giờ hiện tại (Ex: PHP Team
2017-06-21 13:06:37)
*/

select concat('PHP Team ', '- ', current_timestamp()) as PHP;

/* ex32: Tìm có tên(user.full_name) "Khiêu" và các thông tin trên blog của
user này như: (blog.title, blog.view), title category(category) của blog này.
*/

select user.full_name, blog.title as blog_title, blog.view, category.title as category_title from blog, user, category where
blog.user_id = user.id and blog.category_id = category.id
and blog.user_id in (select id from user where full_name REGEXP '[[:<:]]Khiêu[[:>:]]');

/* ex33: Liệt kê email user các user có tên(user.full_name) có chứa ký tự "Khi"
theo danh sách như output bên dưới
*/

select group_concat(email) as email_user from user where full_name like "%Khi%";

/* ex34: Tính điểm cho user có email là minh82@example.com trong bảng
comment. Cách tính điểm:
Trong bảng comment với taget_table = "blog" tính 1 điểm,
taget_table = "news" tính 2 điểm.
PhamThePhuc
*/

select user.email,sum(case comment.target_table when 'blog' then 1 else 2 end)
as DIEM from user, comment where user.id = comment.user_id and user.email = 'minh82@example.com';
